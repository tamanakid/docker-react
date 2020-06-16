# Production Dockerfile - Multi-step Build Process


# 'as' keyword is used to tag the phase
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build



# A second "FROM" statement divides the blocks
FROM nginx

# the --from=<phase> flag is used to copy elements from another phase
# where at old phase container (/app/build) and where will it be placed in current place (/usr/share/nginx/html)
COPY --from=builder /app/build /usr/share/nginx/html

## View nginx configuration at docker hub

# Not necessary to specify default startup command: nginx's base image default startup command will start up nginx automatically