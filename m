Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86ECE1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 06:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeKHPsB (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:48:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38433 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbeKHPsA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 10:48:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id p4-v6so6651729plo.5
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 22:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JnXd8/N+iLE/BmW5Y4QyW8SELbG7EamjSilcrlX0z+U=;
        b=eh07nuujFOMIwmy8RAoUMSnI8eT+tbQt4wsXsN0JRyYDh3i66NmBOdJVBWFhNRHFES
         5AsOWeKzEm7pOXc0ACSsVVQIL9pApr6irmYhlCB432jdf4SdlizZxTnowaWBn7/YxYNX
         2n500bWH9aYEPMPYu20x41tC82lllBJnyE4unj23TRmqgT9BXzuaOGbOdjQv1pdPFJI8
         JXnV8EIHz+o/Xm0gYBsDOZiUMb6bsnDdwcNggw3JO8PYUYc65a4cP9cb3CvtAzJvR+0n
         69DtROEZxhiRWyNgxw8Z/pth7SJI9uCHmewekCvmwSblkDT/CMChNzEi6NAFDfbDqasj
         s++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JnXd8/N+iLE/BmW5Y4QyW8SELbG7EamjSilcrlX0z+U=;
        b=Qr7+Mbs7QFsp6HzkIeuS9Xhr15ntKKzBuWhOalghEWjvwEWFrYtLciLCfAhfFW6HNP
         C/77lLrAJdWX1HJL5kFnz6Oog8lDAx18nZX/xX+fI7d/6bbjeFQvp+VA5gdJliCcQHhV
         noVPGufqzi4bB9d/CFyKf4Ma4yibq9rjdNmMps9scvh/1e56dM07q+jItWIKMrYgbRaL
         hVrFLWNxBQTz7NuJKYrZIe3xcw6JCc6Gh0vL8F9On2tF9M4TmNI4vUB1mxe09gQwEM+q
         LCtLf1kfxpv4ROeMj/BN/0INl07Z7+lrHCCmbJCwZjtrmX8euqSN59EyndqR8WfsM8DC
         B/hQ==
X-Gm-Message-State: AGRZ1gJSFla6SMwvqoEzU16SdTkG79yevrJeFQe/LnDe4zLs3A/xmxe9
        CLAWzitdnoyXY9axVARgD0l/NgV4
X-Google-Smtp-Source: AJdET5cIZBw0Lsp0oXB5QKaLrnooU8XPP/eJEwhoWQWLEUj6yNqSalv0De5ENxqxy3TOgtg3CdcHGA==
X-Received: by 2002:a17:902:166:: with SMTP id 93-v6mr3254270plb.68.1541657648202;
        Wed, 07 Nov 2018 22:14:08 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id c127-v6sm2736923pfa.31.2018.11.07.22.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:14:07 -0800 (PST)
Date:   Wed, 07 Nov 2018 22:14:07 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 06:14:00 GMT
Message-Id: <0a7794722be9322dbf696e486d4ff6da7da5bc8b.1541657640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v4.git.gitgitgadget@gmail.com>
References: <pull.69.v3.git.gitgitgadget@gmail.com>
        <pull.69.v4.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 4/4] http: change http.version value type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Force Charlie <charlieio@outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Force Charlie <charlieio@outlook.com>

Signed-off-by: Force Charlie <charlieio@outlook.com>
---
 http.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/http.c b/http.c
index 86e454cff5..d6f3c4ee80 100644
--- a/http.c
+++ b/http.c
@@ -48,7 +48,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
-static int curl_http_version = 0;
+static const char *curl_http_version = NULL;
 static const char *ssl_cert;
 static const char *ssl_cipherlist;
 static const char *ssl_version;
@@ -286,8 +286,7 @@ static void process_curl_messages(void)
 static int http_options(const char *var, const char *value, void *cb)
 {
 	if (!strcmp("http.version",var)) {
-		curl_http_version=git_config_int(var,value);
-		return 0;
+		return git_config_string(&curl_http_version, var, value);
 	}
 	if (!strcmp("http.sslverify", var)) {
 		curl_ssl_verify = git_config_bool(var, value);
@@ -794,6 +793,30 @@ static long get_curl_allowed_protocols(int from_user)
 }
 #endif
 
+#if LIBCURL_VERSION_NUM >=0x072f00
+static int get_curl_http_version_opt(const char *version_string, long *opt)
+{
+	int i;
+	static struct {
+		const char *name;
+		long opt_token;
+	} choice[] = {
+		{ "HTTP/1.1", CURL_HTTP_VERSION_1_1 },
+		{ "HTTP/2", CURL_HTTP_VERSION_2 }
+	};
+
+	for (i = 0; i < ARRAY_SIZE(choice); i++) {
+		if (!strcmp(version_string, choice[i].name)) {
+			*opt = choice[i].opt_token;
+			return 0;
+		}
+	}
+
+	return -1; /* not found */
+}
+
+#endif
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -812,12 +835,12 @@ static CURL *get_curl_handle(void)
 	}
 
 #if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
-    // curl_http_version 0 is default.
-    if (curl_http_version == 20) {
-		/* Enable HTTP2*/
-		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2TLS);
-    } else if (curl_http_version == 11) {
-		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_1_1);
+    if (curl_http_version) {
+		long opt;
+		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
+			/* Set request use http version */
+			curl_easy_setopt(result, CURLOPT_HTTP_VERSION,opt);
+		}
     }
 #endif
 
-- 
gitgitgadget
