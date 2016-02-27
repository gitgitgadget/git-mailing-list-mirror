From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/22] http.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:01 +0700
Message-ID: <1456555333-5853-11-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:43:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYau-0003Mk-MQ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbcB0GnI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:43:08 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33997 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbcB0GnG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:43:06 -0500
Received: by mail-pa0-f50.google.com with SMTP id fy10so62462034pac.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xgo3FfChdgrvUIv5mr35cgYBZ4/ULlxnxU0kCM0DA2s=;
        b=YexV6++S5hvp6zyVbTw5kNf6+icQTSBTMY1gpuHk7IfcS6wvoR8b7Lbe1w4xVyNStL
         a8vWJc333BE4Dz4OufA2rZmfJ3L+i6iLWPtWwBVqG+MWqG2QzLjoDEfrL3b4Diqf2QCC
         AxZsSoYpXT7aRu9GB1xmK+b99UDjO7aoZ7Xy+NouQsqMxIgMhDwmDanfrTUY7ZxkEHu9
         prvX87ysaY8g+SuuvZIFNeVBqdh5Pp+ztJ50seUo+dbDr0U7I8Pxxp2wNjH0LPMeSNAb
         bxxEI2kworo5wU2BRFy5ebr6LJQEJNuJWzfyXl3cahQmC5GbtnK3snPtHWGPfmnpx3iB
         uaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xgo3FfChdgrvUIv5mr35cgYBZ4/ULlxnxU0kCM0DA2s=;
        b=G44mwhHRKSX3LYpX7+gB7oR6CNyzDtDxZYJnrwgEBEp8EBPgHSzbyodO4BL/582leh
         MNHkzCOp78z44P8mbPcWTHQD40o9RzgH8EtROKmkXa01dYXKfaDCZjgoVnYIjMO39Ole
         0XfgxVEinpYyapmtQ5giISxRUxcKKz3P6UbPtcWL8eSQTJjHN7QKphyd2WCS0AvlJkhE
         9YdwwzvjuiwSlegQuC70ysKPDHTCsHz/v79jCj2o79288zGyDf0MdAeohAfj2DRnMAIn
         phdHLjZ8XVfprdUqCJf4u/zlD/g+6iciYCUHAKYxvdrqmap83rxAP4RMiGxuJRykw+tz
         nbVA==
X-Gm-Message-State: AD7BkJKFYrtSWp2uGTPx86YrWMmAOC6tKvFYJyG9pWjEf9KkaNMfdslA+Whlm6oAsjqlSw==
X-Received: by 10.66.102.37 with SMTP id fl5mr7711368pab.32.1456555385996;
        Fri, 26 Feb 2016 22:43:05 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id d81sm23459915pfj.77.2016.02.26.22.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:43:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:43:38 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287671>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 http.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/http.c b/http.c
index 1d5e3bb..d56cb52 100644
--- a/http.c
+++ b/http.c
@@ -404,7 +404,7 @@ static void init_curl_proxy_auth(CURL *result)
 			}
 		}
 		if (i =3D=3D ARRAY_SIZE(proxy_authmethods)) {
-			warning("unsupported proxy authentication method %s: using anyauth"=
,
+			warning(_("unsupported proxy authentication method %s: using anyaut=
h"),
 					http_proxy_authmethod);
 			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 		}
@@ -445,7 +445,7 @@ static int sockopt_callback(void *client, curl_sock=
et_t fd, curlsocktype type)
=20
 	rc =3D setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, (void *)&ka, len);
 	if (rc < 0)
-		warning("unable to set SO_KEEPALIVE on socket %s",
+		warning(_("unable to set SO_KEEPALIVE on socket %s"),
 			strerror(errno));
=20
 	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
@@ -469,7 +469,7 @@ static CURL *get_curl_handle(void)
 	long allowed_protocols =3D 0;
=20
 	if (!result)
-		die("curl_easy_init failed");
+		die(_("curl_easy_init failed"));
=20
 	if (!curl_ssl_verify) {
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
@@ -503,7 +503,7 @@ static CURL *get_curl_handle(void)
 			}
 		}
 		if (i =3D=3D ARRAY_SIZE(sslversions))
-			warning("unsupported ssl version %s: using default",
+			warning(_("unsupported ssl version %s: using default"),
 				ssl_version);
 	}
=20
@@ -558,8 +558,8 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
 #else
 	if (transport_restrict_protocols())
-		warning("protocol restrictions not applied to curl redirects because=
\n"
-			"your curl version is too old (>=3D 7.19.4)");
+		warning(_("protocol restrictions not applied to curl redirects becau=
se\n"
+			  "your curl version is too old (>=3D 7.19.4)"));
 #endif
=20
 	if (getenv("GIT_CURL_VERBOSE"))
@@ -659,7 +659,7 @@ void http_init(struct remote *remote, const char *u=
rl, int proactive_auth)
 	free(normalized_url);
=20
 	if (curl_global_init(CURL_GLOBAL_ALL) !=3D CURLE_OK)
-		die("curl_global_init failed");
+		die(_("curl_global_init failed"));
=20
 	http_proactive_auth =3D proactive_auth;
=20
@@ -681,7 +681,7 @@ void http_init(struct remote *remote, const char *u=
rl, int proactive_auth)
=20
 	curlm =3D curl_multi_init();
 	if (!curlm)
-		die("curl_multi_init failed");
+		die(_("curl_multi_init failed"));
 #endif
=20
 	if (getenv("GIT_SSL_NO_VERIFY"))
@@ -1544,7 +1544,7 @@ static int http_get_file(const char *url, const c=
har *filename,
 	strbuf_addf(&tmpfile, "%s.temp", filename);
 	result =3D fopen(tmpfile.buf, "a");
 	if (!result) {
-		error("Unable to open local file %s", tmpfile.buf);
+		error(_("Unable to open local file %s"), tmpfile.buf);
 		ret =3D HTTP_ERROR;
 		goto cleanup;
 	}
@@ -1601,7 +1601,7 @@ static char *fetch_pack_index(unsigned char *sha1=
, const char *base_url)
 	tmp =3D strbuf_detach(&buf, NULL);
=20
 	if (http_get_file(url, tmp, NULL) !=3D HTTP_OK) {
-		error("Unable to get pack index %s", url);
+		error(_("Unable to get pack index %s"), url);
 		free(tmp);
 		tmp =3D NULL;
 	}
@@ -1778,7 +1778,7 @@ struct http_pack_request *new_http_pack_request(
 		sha1_pack_name(target->sha1));
 	preq->packfile =3D fopen(preq->tmpfile, "a");
 	if (!preq->packfile) {
-		error("Unable to open local file %s for pack",
+		error(_("Unable to open local file %s for pack"),
 		      preq->tmpfile);
 		goto abort;
 	}
@@ -1866,7 +1866,7 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
 	unlink_or_warn(freq->tmpfile);
=20
 	if (freq->localfile !=3D -1)
-		error("fd leakage in start: %d", freq->localfile);
+		error(_("fd leakage in start: %d"), freq->localfile);
 	freq->localfile =3D open(freq->tmpfile,
 			       O_WRONLY | O_CREAT | O_EXCL, 0666);
 	/*
@@ -1885,7 +1885,7 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
 	}
=20
 	if (freq->localfile < 0) {
-		error("Couldn't create temporary file %s: %s",
+		error(_("Couldn't create temporary file %s: %s"),
 		      freq->tmpfile, strerror(errno));
 		goto abort;
 	}
@@ -1931,7 +1931,7 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
 			prev_posn =3D 0;
 			lseek(freq->localfile, 0, SEEK_SET);
 			if (ftruncate(freq->localfile, 0) < 0) {
-				error("Couldn't truncate temporary file %s: %s",
+				error(_("Couldn't truncate temporary file %s: %s"),
 					  freq->tmpfile, strerror(errno));
 				goto abort;
 			}
@@ -1985,7 +1985,7 @@ int finish_http_object_request(struct http_object=
_request *freq)
 	process_http_object_request(freq);
=20
 	if (freq->http_code =3D=3D 416) {
-		warning("requested range invalid; we may already have all the data."=
);
+		warning(_("requested range invalid; we may already have all the data=
=2E"));
 	} else if (freq->curl_result !=3D CURLE_OK) {
 		if (stat(freq->tmpfile, &st) =3D=3D 0)
 			if (st.st_size =3D=3D 0)
--=20
2.8.0.rc0.205.g7ec8cf1
