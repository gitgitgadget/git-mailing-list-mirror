Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A430920248
	for <e@80x24.org>; Wed, 27 Feb 2019 08:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfB0InR (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 03:43:17 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:36435 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfB0InQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 03:43:16 -0500
Received: by mail-ed1-f45.google.com with SMTP id g9so13187387eds.3
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 00:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MwHfyiCC9wZTfTelNMZ6lrFPbL5oNmG+sMVQ+xuG4zw=;
        b=iXgKffpDcPJbk61OlNojnBLsagfKvAIztkBXxTeEtg/zSyrgPXs2nG+WHtApACd13+
         /afRhvaHFIpVg3HoPzuDNOYMyfLxQhRbjLBdI63hbMv2qyK1kIFYqk4VGYtggSTXrZZZ
         LXzqJY+KntXRQc+Vt7OYKUomciutyd32XVVBE0m1kq8+Y4/Fe/YFwNQRn0l/4JZ2GsBF
         0KPttS9ZyAcUtCoI0wLt8pRDLCY79OPwg94v1zdLmBBMh3G0Tto4ykLHoHHQJ/Z+GGoe
         zmm1UNlNzZBpuqGOweCVm+7i3s9lDxK32EOU2kax+nMFlgcAMDnZwEC5pG/OLbT33ZqG
         zpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MwHfyiCC9wZTfTelNMZ6lrFPbL5oNmG+sMVQ+xuG4zw=;
        b=gv+IuvBcZGiH1TJWNhcMVeNLOrPnuwCAlikuvToHKA54QDDde/Pj4MOsUM6dRTsGo9
         XGKDfVEcf8SLUPhndsSBMNB9YQVL8CtLo0JNa60Rfis9uqNUIFl5TE5yBoHO7C5LRSqA
         4/m/kVoXeZqKjG0CyXF/ptxmqOd3WFedYF+jhAqv3htLwzNlNsIu2RCSMw8UiDObvhdn
         H9Z64CprVL3Po/L5xjDim0ArHxpoCHV5HasU+uc947wEsOcNUABMH/YFP+X4mddKeXHF
         bQspvaz/qZhP+5ADyUtklmmcEaONolq6S34o8C4w33PuufzkH2id7KBFlMI3hxJ0LEUA
         KQdA==
X-Gm-Message-State: AHQUAuZgxxqmjDb51qeJOJNlhZRRvv/k0PHfwKqn+XJW8sK4qy2aQmSn
        M9N+O0hnpztFY/fcLfmGHaeKx04T
X-Google-Smtp-Source: AHgI3IaxxD+zQ+li2/wOWRROV82KGLgLL7Nb759ahze98MmIyFc9EQyh8vgLNsK2ew3wgHAzHWSi6A==
X-Received: by 2002:a50:8bb0:: with SMTP id m45mr1500edm.198.1551256994202;
        Wed, 27 Feb 2019 00:43:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g20sm2619065ejk.72.2019.02.27.00.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 00:43:13 -0800 (PST)
Date:   Wed, 27 Feb 2019 00:43:13 -0800 (PST)
X-Google-Original-Date: Wed, 27 Feb 2019 08:43:12 GMT
Message-Id: <1a5a1447f437c99cfcaac01a506093c3697a52b6.1551256992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.144.git.gitgitgadget@gmail.com>
References: <pull.144.git.gitgitgadget@gmail.com>
From:   "Tanushree Tumane via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: remove obsolete IPv6-related code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

To support IPv6, Git provided fall back functions for Windows versions
that did not support IPv6. However, as Git dropped support for Windows
XP and prior, those functions are not needed anymore.

Remove those fallbacks by reverting fe3b2b7b827c (Enable support for
IPv6 on MinGW, 2009-11-24) and using the functions directly (without
'ipv6_' prefix).

Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 178 +------------------------------------------------
 compat/mingw.h |   8 ---
 2 files changed, 3 insertions(+), 183 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8141f77189..80b6b288a1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1705,142 +1705,10 @@ int mingw_putenv(const char *namevalue)
 	return result ? 0 : -1;
 }
 
-/*
- * Note, this isn't a complete replacement for getaddrinfo. It assumes
- * that service contains a numerical port, or that it is null. It
- * does a simple search using gethostbyname, and returns one IPv4 host
- * if one was found.
- */
-static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
-				   const struct addrinfo *hints,
-				   struct addrinfo **res)
-{
-	struct hostent *h = NULL;
-	struct addrinfo *ai;
-	struct sockaddr_in *sin;
-
-	if (node) {
-		h = gethostbyname(node);
-		if (!h)
-			return WSAGetLastError();
-	}
-
-	ai = xmalloc(sizeof(struct addrinfo));
-	*res = ai;
-	ai->ai_flags = 0;
-	ai->ai_family = AF_INET;
-	ai->ai_socktype = hints ? hints->ai_socktype : 0;
-	switch (ai->ai_socktype) {
-	case SOCK_STREAM:
-		ai->ai_protocol = IPPROTO_TCP;
-		break;
-	case SOCK_DGRAM:
-		ai->ai_protocol = IPPROTO_UDP;
-		break;
-	default:
-		ai->ai_protocol = 0;
-		break;
-	}
-	ai->ai_addrlen = sizeof(struct sockaddr_in);
-	if (hints && (hints->ai_flags & AI_CANONNAME))
-		ai->ai_canonname = h ? xstrdup(h->h_name) : NULL;
-	else
-		ai->ai_canonname = NULL;
-
-	sin = xcalloc(1, ai->ai_addrlen);
-	sin->sin_family = AF_INET;
-	/* Note: getaddrinfo is supposed to allow service to be a string,
-	 * which should be looked up using getservbyname. This is
-	 * currently not implemented */
-	if (service)
-		sin->sin_port = htons(atoi(service));
-	if (h)
-		sin->sin_addr = *(struct in_addr *)h->h_addr;
-	else if (hints && (hints->ai_flags & AI_PASSIVE))
-		sin->sin_addr.s_addr = INADDR_ANY;
-	else
-		sin->sin_addr.s_addr = INADDR_LOOPBACK;
-	ai->ai_addr = (struct sockaddr *)sin;
-	ai->ai_next = NULL;
-	return 0;
-}
-
-static void WSAAPI freeaddrinfo_stub(struct addrinfo *res)
-{
-	free(res->ai_canonname);
-	free(res->ai_addr);
-	free(res);
-}
-
-static int WSAAPI getnameinfo_stub(const struct sockaddr *sa, socklen_t salen,
-				   char *host, DWORD hostlen,
-				   char *serv, DWORD servlen, int flags)
-{
-	const struct sockaddr_in *sin = (const struct sockaddr_in *)sa;
-	if (sa->sa_family != AF_INET)
-		return EAI_FAMILY;
-	if (!host && !serv)
-		return EAI_NONAME;
-
-	if (host && hostlen > 0) {
-		struct hostent *ent = NULL;
-		if (!(flags & NI_NUMERICHOST))
-			ent = gethostbyaddr((const char *)&sin->sin_addr,
-					    sizeof(sin->sin_addr), AF_INET);
-
-		if (ent)
-			snprintf(host, hostlen, "%s", ent->h_name);
-		else if (flags & NI_NAMEREQD)
-			return EAI_NONAME;
-		else
-			snprintf(host, hostlen, "%s", inet_ntoa(sin->sin_addr));
-	}
-
-	if (serv && servlen > 0) {
-		struct servent *ent = NULL;
-		if (!(flags & NI_NUMERICSERV))
-			ent = getservbyport(sin->sin_port,
-					    flags & NI_DGRAM ? "udp" : "tcp");
-
-		if (ent)
-			snprintf(serv, servlen, "%s", ent->s_name);
-		else
-			snprintf(serv, servlen, "%d", ntohs(sin->sin_port));
-	}
-
-	return 0;
-}
-
-static HMODULE ipv6_dll = NULL;
-static void (WSAAPI *ipv6_freeaddrinfo)(struct addrinfo *res);
-static int (WSAAPI *ipv6_getaddrinfo)(const char *node, const char *service,
-				      const struct addrinfo *hints,
-				      struct addrinfo **res);
-static int (WSAAPI *ipv6_getnameinfo)(const struct sockaddr *sa, socklen_t salen,
-				      char *host, DWORD hostlen,
-				      char *serv, DWORD servlen, int flags);
-/*
- * gai_strerror is an inline function in the ws2tcpip.h header, so we
- * don't need to try to load that one dynamically.
- */
-
-static void socket_cleanup(void)
-{
-	WSACleanup();
-	if (ipv6_dll)
-		FreeLibrary(ipv6_dll);
-	ipv6_dll = NULL;
-	ipv6_freeaddrinfo = freeaddrinfo_stub;
-	ipv6_getaddrinfo = getaddrinfo_stub;
-	ipv6_getnameinfo = getnameinfo_stub;
-}
-
 static void ensure_socket_initialization(void)
 {
 	WSADATA wsa;
 	static int initialized = 0;
-	const char *libraries[] = { "ws2_32.dll", "wship6.dll", NULL };
-	const char **name;
 
 	if (initialized)
 		return;
@@ -1849,35 +1717,7 @@ static void ensure_socket_initialization(void)
 		die("unable to initialize winsock subsystem, error %d",
 			WSAGetLastError());
 
-	for (name = libraries; *name; name++) {
-		ipv6_dll = LoadLibraryExA(*name, NULL,
-					  LOAD_LIBRARY_SEARCH_SYSTEM32);
-		if (!ipv6_dll)
-			continue;
-
-		ipv6_freeaddrinfo = (void (WSAAPI *)(struct addrinfo *))
-			GetProcAddress(ipv6_dll, "freeaddrinfo");
-		ipv6_getaddrinfo = (int (WSAAPI *)(const char *, const char *,
-						   const struct addrinfo *,
-						   struct addrinfo **))
-			GetProcAddress(ipv6_dll, "getaddrinfo");
-		ipv6_getnameinfo = (int (WSAAPI *)(const struct sockaddr *,
-						   socklen_t, char *, DWORD,
-						   char *, DWORD, int))
-			GetProcAddress(ipv6_dll, "getnameinfo");
-		if (!ipv6_freeaddrinfo || !ipv6_getaddrinfo || !ipv6_getnameinfo) {
-			FreeLibrary(ipv6_dll);
-			ipv6_dll = NULL;
-		} else
-			break;
-	}
-	if (!ipv6_freeaddrinfo || !ipv6_getaddrinfo || !ipv6_getnameinfo) {
-		ipv6_freeaddrinfo = freeaddrinfo_stub;
-		ipv6_getaddrinfo = getaddrinfo_stub;
-		ipv6_getnameinfo = getnameinfo_stub;
-	}
-
-	atexit(socket_cleanup);
+	atexit((void(*)(void)) WSACleanup);
 	initialized = 1;
 }
 
@@ -1895,24 +1735,12 @@ struct hostent *mingw_gethostbyname(const char *host)
 	return gethostbyname(host);
 }
 
-void mingw_freeaddrinfo(struct addrinfo *res)
-{
-	ipv6_freeaddrinfo(res);
-}
-
+#undef getaddrinfo
 int mingw_getaddrinfo(const char *node, const char *service,
 		      const struct addrinfo *hints, struct addrinfo **res)
 {
 	ensure_socket_initialization();
-	return ipv6_getaddrinfo(node, service, hints, res);
-}
-
-int mingw_getnameinfo(const struct sockaddr *sa, socklen_t salen,
-		      char *host, DWORD hostlen, char *serv, DWORD servlen,
-		      int flags)
-{
-	ensure_socket_initialization();
-	return ipv6_getnameinfo(sa, salen, host, hostlen, serv, servlen, flags);
+	return getaddrinfo(node, service, hints, res);
 }
 
 int mingw_socket(int domain, int type, int protocol)
diff --git a/compat/mingw.h b/compat/mingw.h
index 30d9fb3e36..e883b40c7d 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -296,18 +296,10 @@ int mingw_gethostname(char *host, int namelen);
 struct hostent *mingw_gethostbyname(const char *host);
 #define gethostbyname mingw_gethostbyname
 
-void mingw_freeaddrinfo(struct addrinfo *res);
-#define freeaddrinfo mingw_freeaddrinfo
-
 int mingw_getaddrinfo(const char *node, const char *service,
 		      const struct addrinfo *hints, struct addrinfo **res);
 #define getaddrinfo mingw_getaddrinfo
 
-int mingw_getnameinfo(const struct sockaddr *sa, socklen_t salen,
-		      char *host, DWORD hostlen, char *serv, DWORD servlen,
-		      int flags);
-#define getnameinfo mingw_getnameinfo
-
 int mingw_socket(int domain, int type, int protocol);
 #define socket mingw_socket
 
-- 
gitgitgadget
