FROM node:21-slim AS builder

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . ./
ENV PUBLIC_API_BASE_URL="undefined"
RUN npm run build

FROM node:21-slim

WORKDIR /app
COPY --from=builder /app .

ENV HOST=0.0.0.0
EXPOSE 4173
CMD ["npm","run", "preview","--", "--host", "0.0.0.0"]