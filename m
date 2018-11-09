Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23F561F453
	for <e@80x24.org>; Fri,  9 Nov 2018 03:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeKINW4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 08:22:56 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:43531 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbeKINW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 08:22:56 -0500
Received: by mail-pf1-f178.google.com with SMTP id g7-v6so283895pfo.10
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 19:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eXj2gJylSNRGgdigE8TbA57phjokIi5Tt86squtrsJk=;
        b=YW1znFcmHNpNEBWWWvmgAFSUGf9Zdyj7ectshM/km5CnD18OgoUB+dDsdxr4xhwgVh
         ASbXzPHVIj3A5OW4CR1FbY5ckU08SyowqEehurUUgXwj4QXQyviFroWHolIh1XGkJZ3w
         f/1LAJsRAueVIQiYaAetSxvirYV3mRxmQWF3IwpVEi+7ak1a14t/LsqxT6MXFOM2AXkR
         rvAbmGuzfaR3AI9M3o3c4KVeim/Q2jMboOQKw3Lasg/hTkSAhjP7KJT1T/LLTMRc2pvj
         z4HKGCUPYzwq9IE7Ugx1/LETqb8iT5pwp94wz7VUL24TQ/LUl5YejH1FTglVF8+Y2ow2
         VBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eXj2gJylSNRGgdigE8TbA57phjokIi5Tt86squtrsJk=;
        b=W0q1UPDcldlBh2wgF9sXlNOGXN8ZCGDGG+m8PzJArpDZQ6N1c/cZ584HCOD20HIQ4d
         3L37GBXrnCfslOz4ZRqyHLFPEHQ+jG1GfwB8Z0wAXVDahisXYZeWOjUoJpTp3k/Du/aM
         i1BqCNmj7v2fhwye0H8FZMXTctfLgORHfLAJUVdtJb2bUBE/vyijM7g0esM0K3zDXky3
         SLIOB0uykgRW+lhJGcpZRxxjtmMkgDlPSNnFqcq+IpuuJOMeY3ELrSMXDHvH3iEUpNxV
         n2PiKoe3PigusFNGaDUjQWsagmXVuv/tosaQHmC+kRyL0PCW/If4u1UXx38IwOin1R2M
         LWew==
X-Gm-Message-State: AGRZ1gLhK9nA+0LxZDY/jXfP6pNfAyq425HaUGleJ/ytGz5TdKlei0m1
        RWhLg0TtmQ5XBh4WnwCqIATM/uJI
X-Google-Smtp-Source: AJdET5f/P9bSRox1KXbL9Z21d01h6Hz74h7lhOboiG4mMHH7yztlzFvC2N96in2kM1MOB7INQdYO+w==
X-Received: by 2002:a62:31c2:: with SMTP id x185-v6mr7368139pfx.39.1541735055295;
        Thu, 08 Nov 2018 19:44:15 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id p11-v6sm5423079pfn.53.2018.11.08.19.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 19:44:14 -0800 (PST)
Date:   Thu, 08 Nov 2018 19:44:14 -0800 (PST)
X-Google-Original-Date: Fri, 09 Nov 2018 03:44:11 GMT
Message-Id: <71f8b71b346f132d0dc9a23c9a7f2ca2cb91966f.1541735051.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v8.git.gitgitgadget@gmail.com>
References: <pull.69.v7.git.gitgitgadget@gmail.com>
        <pull.69.v8.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v8 1/1] http: add support selecting http version
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

Usually we don't need to set libcurl to choose which version of the
HTTP protocol to use to communicate with a server.
But different versions of libcurl, the default value is not the same.

CURL >= 7.62.0: CURL_HTTP_VERSION_2TLS
CURL < 7.62: CURL_HTTP_VERSION_1_1

In order to give users the freedom to control the HTTP version,
we need to add a setting to choose which HTTP version to use.

Signed-off-by: Force Charlie <charlieio@outlook.com>
---
 Documentation/config.txt |  9 +++++++++
 http.c                   | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 41a9ff2b6a..f397942128 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1935,6 +1935,15 @@ http.saveCookies::
 	If set, store cookies received during requests to the file specified by
 	http.cookieFile. Has no effect if http.cookieFile is unset.
 
+http.version::
+	Use the specified HTTP protocol version when communicating with a server.
+	If you want to force the default. The available and default version depend
+	on libcurl. Actually the possible values of
+	this option are:
+
+	- HTTP/2
+	- HTTP/1.1
+
 http.sslVersion::
 	The SSL version to use when negotiating an SSL connection, if you
 	want to force the default.  The available and default version
diff --git a/http.c b/http.c
index 3dc8c560d6..bc3274804e 100644
--- a/http.c
+++ b/http.c
@@ -48,6 +48,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
+static const char *curl_http_version = NULL;
 static const char *ssl_cert;
 static const char *ssl_cipherlist;
 static const char *ssl_version;
@@ -284,6 +285,9 @@ static void process_curl_messages(void)
 
 static int http_options(const char *var, const char *value, void *cb)
 {
+	if (!strcmp("http.version", var)) {
+		return git_config_string(&curl_http_version, var, value);
+	}
 	if (!strcmp("http.sslverify", var)) {
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
@@ -789,6 +793,31 @@ static long get_curl_allowed_protocols(int from_user)
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
+	warning("unknown value given to http.version: '%s'", version_string);
+	return -1; /* not found */
+}
+
+#endif
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -806,6 +835,16 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
+#if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
+    if (curl_http_version) {
+		long opt;
+		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
+			/* Set request use http version */
+			curl_easy_setopt(result, CURLOPT_HTTP_VERSION, opt);
+		}
+    }
+#endif
+
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
-- 
gitgitgadget
