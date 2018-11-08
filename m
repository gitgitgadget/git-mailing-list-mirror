Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC261F453
	for <e@80x24.org>; Thu,  8 Nov 2018 07:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeKHQeM (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 11:34:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34775 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeKHQeL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 11:34:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id f12-v6so7909584plo.1
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 23:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1i+mJfEPd1zWOnCvpb6Vd14KLzghEgkT8fP2k0Ez2cU=;
        b=MOxMAXy7oP8wtO0qTChVRaidupVQMn1EGEUThXuJMqhtnN5UpkeFlkrJGO65cgzNyB
         BuxpL63CS1SRxDX5OmF3MyNt4zZenXtdTCtJthGpR7hf5ACJAKiU/g3fCxKOOpTAvRaC
         cBOHRkYzUO6jfYzTKL18O1gjETBzQrMC+LcnDXFSzXLNbAEV+Gv352Mdi6GlHBuaHrK9
         13liTfqvTPVwEtIYbDaSdjsB6YanbizvbDnZRgyHd+FLu1gUOZsdNDR+KRDVVYl/EIYI
         pAFMwVcwsO+/D97Ghjx8XF1yClbHZIjMLQM4HhPX6cgFNT3aJD3T/W4kicLzrUxVJQMU
         RsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1i+mJfEPd1zWOnCvpb6Vd14KLzghEgkT8fP2k0Ez2cU=;
        b=i7n76RijQx1/52NuNQt1QU9eA4CKvUdLpiCGdYLXWSDNvvsI3SPIlYnPeJ58k+lB9/
         ld0XbJMAt9EntriCYSzmPcoipfmrpdv96wJdlIio14wPcki0/dI2CqPqpgPTa2Lr/4gN
         JpJKQFDQJ7qoEozohdHxJ52FtxxLVa1VlsPaQmrT9O9jiD4jPAny3BxkXiUV/b7g4xoz
         B86hG3VHb6fsmDqpNdc1IZhfO27Ch8KE8ew/XFd28gHMTb/xJVfsAGaQH2rrX0W+nACH
         EyDEi2bqiZ0D1Vq7OI0chZIfc8fODRcX4pVKQiOwmRnkMr4RCavauuX+9qj90BMBtbve
         mB1g==
X-Gm-Message-State: AGRZ1gJ7FKp8mQdYTP02A16+Xrt12ZDsGO6ok9E9ulpESAHkLExVexJf
        n24D0xvNHY9cKIszlbDiCimU4uiR
X-Google-Smtp-Source: AJdET5ftq5uSdergMzdfuxKB89cgef6oReSqj5KEVUnUDiXjrDUhT/wnLqLUNnntmgoGliVpkWn9aA==
X-Received: by 2002:a17:902:bb06:: with SMTP id l6-v6mr3400606pls.58.1541660408739;
        Wed, 07 Nov 2018 23:00:08 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id u9-v6sm2618812pfm.175.2018.11.07.23.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 23:00:08 -0800 (PST)
Date:   Wed, 07 Nov 2018 23:00:08 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 07:00:04 GMT
Message-Id: <93fda67198441c159bfcf1dfa467ad76f3ecba76.1541660405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v6.git.gitgitgadget@gmail.com>
References: <pull.69.v5.git.gitgitgadget@gmail.com>
        <pull.69.v6.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 1/1] http: add support selecting http version
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
 http.c                   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

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
index 3dc8c560d6..d6f3c4ee80 100644
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
+	if (!strcmp("http.version",var)) {
+		return git_config_string(&curl_http_version, var, value);
+	}
 	if (!strcmp("http.sslverify", var)) {
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
@@ -789,6 +793,30 @@ static long get_curl_allowed_protocols(int from_user)
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
@@ -806,6 +834,16 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
+#if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
+    if (curl_http_version) {
+		long opt;
+		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
+			/* Set request use http version */
+			curl_easy_setopt(result, CURLOPT_HTTP_VERSION,opt);
+		}
+    }
+#endif
+
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
-- 
gitgitgadget
