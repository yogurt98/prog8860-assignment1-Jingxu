# Step 1: Use an official node image as a base
FROM node:18-alpine AS build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the project files
COPY . .

# Step 6: Build the React app
RUN npm run build

# Step 7: Use an official nginx image as the base for the production build
FROM nginx:alpine AS production

# Step 8: Copy the build output from the build step to the nginx HTML directory
COPY --from=build /app/dist /usr/share/nginx/html

# Step 9: Expose port 80
EXPOSE 80

# Step 10: Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
