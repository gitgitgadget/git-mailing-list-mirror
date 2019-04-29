Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A241E1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 22:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfD2W6D (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 18:58:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:58365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbfD2W6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 18:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556578677;
        bh=ymbMyMYMqTeIfinsSCS5uxQTjZNA5TIKrWpMpNbTBOI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AmrJD1+o97Fwc/xg2NVAhvHrz1cHzNpdkMxBV+BjbUp23UJnRaydFesVyaldfSPVr
         KefsE+csDpUhqK4/ZgMFu50bbAdTJCGm1bM+rYLVEKmYfYuw19QGkCMa9MAV87wh3A
         sDVabYD+SRcfBsJvnDu9TrTP5tVvOKU9ErmwGbok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQhyf-1hDNu40Ewf-00U2aG; Tue, 30
 Apr 2019 00:57:57 +0200
Date:   Mon, 29 Apr 2019 18:58:00 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Tanushree Tumane via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 1/1] mingw: remove obsolete IPv6-related code
In-Reply-To: <1a5a1447f437c99cfcaac01a506093c3697a52b6.1551256992.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904291853550.45@tvgsbejvaqbjf.bet>
References: <pull.144.git.gitgitgadget@gmail.com> <1a5a1447f437c99cfcaac01a506093c3697a52b6.1551256992.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/RVfxwvvKd3DoNJTqMnADkpNuq/R9E9LlfTmPTufZz8hzIrQBvX
 hUboKQBdv8SCJ6Te6DXuKNRBZV9CLsW2Uf3RSxSKKFkm8uQ69qKERuUiWq3HiWUSzKKedqy
 +efalgtbQ0mrpaeB3L6z/XFmfTGgRXvigBMtcXlPpKPQemkZ8HEnWdXt998jwA8am2F9x6p
 t/gcQ1V9lnnQ8QEzfEfnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FC/dBIt0F7M=:pnsPq7QnyVIHHMDj+WsOoI
 HWDYcc3BUEFwsbAk2DIeSK90l5suV0xF+wHBzVzc0HGKGWdtN9ciJqWkYRqxTPsJ+7bT4oUPD
 etmpBbOnyhq/etYaFOX5RDc8rxqD3Q+gQwRVDZOALWjgSPNtdZv+gsdJZM8zNV6vspz799//G
 wW3PvyB+Yu1Cwe3IqrWxTW88wHZ1E+LFUlBW6X8UY6OQ3j8kOVHSU4QYaivng3hfqMzWqZI+3
 P+ErAmU79TYCu6KZp6f3Rlygpqvcp7iDjwp18pS7MlAGSaXLR6FLhRDGQvgRnuqPs9mSMyldP
 8oSK7liddktqREOVeHcReMOLa/lQU9hYx/pwfquPZiSzpqCIeIbDT4yypiPfl8/vfB7K+rGVZ
 hwEvGKrNJBfB0gvmDTV9S2IgfWrPjCvPI6qud9sGM6ylSUMRtArtgEPcN2Wjp++DDZZxhWmD9
 TPoI2XtZQhUpFzi+eLouSeq3/H3iJ8slsipSbWvx71QrFKZlTddqrhBm0/xWx1VMjqmbwZ0K0
 eKM/luCqY8viu8TbVM9yfSK8d1Ven/hPYst48YlMbB0YVJWGGkJ7VVGecoS4pGmNGJlyZmReu
 oJQeqbpwk6KhQfqho7x7JjmW0CMVz76AmWY8asRhBNBF+7ryqHDatLTPQilBkmwha8TG7aDYx
 rtVtikiS38quQT/CUhqzu7HVICjTEUlHA67FgtiGjmYd6spRM8DaZo6LWT1dWHUw9CFBn47UE
 fWFgBghA/N1/Sm4gOWzvdHtp8GATNCoikWiSiJoIL3z6cmD7WebipoKs1ssmzw3AJuoEGy1AT
 GCDLHeuHp5hwsm7eKYEKgO3KRaAmUjbfEH/25xc8FxEEbtvC50BS2rF5jKTiYIE1SgQrvkOJV
 7r7+9tux2oqdZV5IF7zoliy92p0Jq8v3pwP0RGT5nYGqmxe+sFDKf5d9xy0UZd0TQI6CQJ67v
 ZmGcQTcSKJA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

it looks as if this patch was not yet picked up? This is a
straight-forward code removal in favor of dropping Windows XP support
(which we officially did, quite some time ago).

Is there anything you want me to do to get this at least into `pu`?

Ciao,
Dscho

On Wed, 27 Feb 2019, Tanushree Tumane via GitGitGadget wrote:

> From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> To support IPv6, Git provided fall back functions for Windows versions
> that did not support IPv6. However, as Git dropped support for Windows
> XP and prior, those functions are not needed anymore.
>
> Remove those fallbacks by reverting fe3b2b7b827c (Enable support for
> IPv6 on MinGW, 2009-11-24) and using the functions directly (without
> 'ipv6_' prefix).
>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 178 +------------------------------------------------
>  compat/mingw.h |   8 ---
>  2 files changed, 3 insertions(+), 183 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 8141f77189..80b6b288a1 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1705,142 +1705,10 @@ int mingw_putenv(const char *namevalue)
>  	return result ? 0 : -1;
>  }
>
> -/*
> - * Note, this isn't a complete replacement for getaddrinfo. It assumes
> - * that service contains a numerical port, or that it is null. It
> - * does a simple search using gethostbyname, and returns one IPv4 host
> - * if one was found.
> - */
> -static int WSAAPI getaddrinfo_stub(const char *node, const char *servic=
e,
> -				   const struct addrinfo *hints,
> -				   struct addrinfo **res)
> -{
> -	struct hostent *h =3D NULL;
> -	struct addrinfo *ai;
> -	struct sockaddr_in *sin;
> -
> -	if (node) {
> -		h =3D gethostbyname(node);
> -		if (!h)
> -			return WSAGetLastError();
> -	}
> -
> -	ai =3D xmalloc(sizeof(struct addrinfo));
> -	*res =3D ai;
> -	ai->ai_flags =3D 0;
> -	ai->ai_family =3D AF_INET;
> -	ai->ai_socktype =3D hints ? hints->ai_socktype : 0;
> -	switch (ai->ai_socktype) {
> -	case SOCK_STREAM:
> -		ai->ai_protocol =3D IPPROTO_TCP;
> -		break;
> -	case SOCK_DGRAM:
> -		ai->ai_protocol =3D IPPROTO_UDP;
> -		break;
> -	default:
> -		ai->ai_protocol =3D 0;
> -		break;
> -	}
> -	ai->ai_addrlen =3D sizeof(struct sockaddr_in);
> -	if (hints && (hints->ai_flags & AI_CANONNAME))
> -		ai->ai_canonname =3D h ? xstrdup(h->h_name) : NULL;
> -	else
> -		ai->ai_canonname =3D NULL;
> -
> -	sin =3D xcalloc(1, ai->ai_addrlen);
> -	sin->sin_family =3D AF_INET;
> -	/* Note: getaddrinfo is supposed to allow service to be a string,
> -	 * which should be looked up using getservbyname. This is
> -	 * currently not implemented */
> -	if (service)
> -		sin->sin_port =3D htons(atoi(service));
> -	if (h)
> -		sin->sin_addr =3D *(struct in_addr *)h->h_addr;
> -	else if (hints && (hints->ai_flags & AI_PASSIVE))
> -		sin->sin_addr.s_addr =3D INADDR_ANY;
> -	else
> -		sin->sin_addr.s_addr =3D INADDR_LOOPBACK;
> -	ai->ai_addr =3D (struct sockaddr *)sin;
> -	ai->ai_next =3D NULL;
> -	return 0;
> -}
> -
> -static void WSAAPI freeaddrinfo_stub(struct addrinfo *res)
> -{
> -	free(res->ai_canonname);
> -	free(res->ai_addr);
> -	free(res);
> -}
> -
> -static int WSAAPI getnameinfo_stub(const struct sockaddr *sa, socklen_t=
 salen,
> -				   char *host, DWORD hostlen,
> -				   char *serv, DWORD servlen, int flags)
> -{
> -	const struct sockaddr_in *sin =3D (const struct sockaddr_in *)sa;
> -	if (sa->sa_family !=3D AF_INET)
> -		return EAI_FAMILY;
> -	if (!host && !serv)
> -		return EAI_NONAME;
> -
> -	if (host && hostlen > 0) {
> -		struct hostent *ent =3D NULL;
> -		if (!(flags & NI_NUMERICHOST))
> -			ent =3D gethostbyaddr((const char *)&sin->sin_addr,
> -					    sizeof(sin->sin_addr), AF_INET);
> -
> -		if (ent)
> -			snprintf(host, hostlen, "%s", ent->h_name);
> -		else if (flags & NI_NAMEREQD)
> -			return EAI_NONAME;
> -		else
> -			snprintf(host, hostlen, "%s", inet_ntoa(sin->sin_addr));
> -	}
> -
> -	if (serv && servlen > 0) {
> -		struct servent *ent =3D NULL;
> -		if (!(flags & NI_NUMERICSERV))
> -			ent =3D getservbyport(sin->sin_port,
> -					    flags & NI_DGRAM ? "udp" : "tcp");
> -
> -		if (ent)
> -			snprintf(serv, servlen, "%s", ent->s_name);
> -		else
> -			snprintf(serv, servlen, "%d", ntohs(sin->sin_port));
> -	}
> -
> -	return 0;
> -}
> -
> -static HMODULE ipv6_dll =3D NULL;
> -static void (WSAAPI *ipv6_freeaddrinfo)(struct addrinfo *res);
> -static int (WSAAPI *ipv6_getaddrinfo)(const char *node, const char *ser=
vice,
> -				      const struct addrinfo *hints,
> -				      struct addrinfo **res);
> -static int (WSAAPI *ipv6_getnameinfo)(const struct sockaddr *sa, sockle=
n_t salen,
> -				      char *host, DWORD hostlen,
> -				      char *serv, DWORD servlen, int flags);
> -/*
> - * gai_strerror is an inline function in the ws2tcpip.h header, so we
> - * don't need to try to load that one dynamically.
> - */
> -
> -static void socket_cleanup(void)
> -{
> -	WSACleanup();
> -	if (ipv6_dll)
> -		FreeLibrary(ipv6_dll);
> -	ipv6_dll =3D NULL;
> -	ipv6_freeaddrinfo =3D freeaddrinfo_stub;
> -	ipv6_getaddrinfo =3D getaddrinfo_stub;
> -	ipv6_getnameinfo =3D getnameinfo_stub;
> -}
> -
>  static void ensure_socket_initialization(void)
>  {
>  	WSADATA wsa;
>  	static int initialized =3D 0;
> -	const char *libraries[] =3D { "ws2_32.dll", "wship6.dll", NULL };
> -	const char **name;
>
>  	if (initialized)
>  		return;
> @@ -1849,35 +1717,7 @@ static void ensure_socket_initialization(void)
>  		die("unable to initialize winsock subsystem, error %d",
>  			WSAGetLastError());
>
> -	for (name =3D libraries; *name; name++) {
> -		ipv6_dll =3D LoadLibraryExA(*name, NULL,
> -					  LOAD_LIBRARY_SEARCH_SYSTEM32);
> -		if (!ipv6_dll)
> -			continue;
> -
> -		ipv6_freeaddrinfo =3D (void (WSAAPI *)(struct addrinfo *))
> -			GetProcAddress(ipv6_dll, "freeaddrinfo");
> -		ipv6_getaddrinfo =3D (int (WSAAPI *)(const char *, const char *,
> -						   const struct addrinfo *,
> -						   struct addrinfo **))
> -			GetProcAddress(ipv6_dll, "getaddrinfo");
> -		ipv6_getnameinfo =3D (int (WSAAPI *)(const struct sockaddr *,
> -						   socklen_t, char *, DWORD,
> -						   char *, DWORD, int))
> -			GetProcAddress(ipv6_dll, "getnameinfo");
> -		if (!ipv6_freeaddrinfo || !ipv6_getaddrinfo || !ipv6_getnameinfo) {
> -			FreeLibrary(ipv6_dll);
> -			ipv6_dll =3D NULL;
> -		} else
> -			break;
> -	}
> -	if (!ipv6_freeaddrinfo || !ipv6_getaddrinfo || !ipv6_getnameinfo) {
> -		ipv6_freeaddrinfo =3D freeaddrinfo_stub;
> -		ipv6_getaddrinfo =3D getaddrinfo_stub;
> -		ipv6_getnameinfo =3D getnameinfo_stub;
> -	}
> -
> -	atexit(socket_cleanup);
> +	atexit((void(*)(void)) WSACleanup);
>  	initialized =3D 1;
>  }
>
> @@ -1895,24 +1735,12 @@ struct hostent *mingw_gethostbyname(const char *=
host)
>  	return gethostbyname(host);
>  }
>
> -void mingw_freeaddrinfo(struct addrinfo *res)
> -{
> -	ipv6_freeaddrinfo(res);
> -}
> -
> +#undef getaddrinfo
>  int mingw_getaddrinfo(const char *node, const char *service,
>  		      const struct addrinfo *hints, struct addrinfo **res)
>  {
>  	ensure_socket_initialization();
> -	return ipv6_getaddrinfo(node, service, hints, res);
> -}
> -
> -int mingw_getnameinfo(const struct sockaddr *sa, socklen_t salen,
> -		      char *host, DWORD hostlen, char *serv, DWORD servlen,
> -		      int flags)
> -{
> -	ensure_socket_initialization();
> -	return ipv6_getnameinfo(sa, salen, host, hostlen, serv, servlen, flags=
);
> +	return getaddrinfo(node, service, hints, res);
>  }
>
>  int mingw_socket(int domain, int type, int protocol)
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 30d9fb3e36..e883b40c7d 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -296,18 +296,10 @@ int mingw_gethostname(char *host, int namelen);
>  struct hostent *mingw_gethostbyname(const char *host);
>  #define gethostbyname mingw_gethostbyname
>
> -void mingw_freeaddrinfo(struct addrinfo *res);
> -#define freeaddrinfo mingw_freeaddrinfo
> -
>  int mingw_getaddrinfo(const char *node, const char *service,
>  		      const struct addrinfo *hints, struct addrinfo **res);
>  #define getaddrinfo mingw_getaddrinfo
>
> -int mingw_getnameinfo(const struct sockaddr *sa, socklen_t salen,
> -		      char *host, DWORD hostlen, char *serv, DWORD servlen,
> -		      int flags);
> -#define getnameinfo mingw_getnameinfo
> -
>  int mingw_socket(int domain, int type, int protocol);
>  #define socket mingw_socket
>
> --
> gitgitgadget
>
>
