Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A69F1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeKHO2m (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:28:42 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:39951 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeKHO2l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 09:28:41 -0500
Received: by mail-pf1-f175.google.com with SMTP id x2-v6so4665515pfm.7
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 20:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yADFirXFZr6zO2b5q2BzJvz1g09fhbkE5G6ro00Rza8=;
        b=gjQTD9UXYctBuGHOT2FbMjrwilGDxecYXvsMqtfbowi4aIM0O1hSCZXMYeDKdw8d1Z
         8J6/mOPOJn7/MkNUwOF+XSdHEGdQtvbGaDU/wqFx2obRX8tPlyyMViTdA0ix3aKFKlM9
         4yd7wwYqiSL2zrCkAMoN6aEfwrH/cNAFsXiOQszhHwXuAS7JsmAT943RhjCkDWo+Eau5
         Cpdnvzz/EuNqz81QYZmI/KH42/nC5yClm6FUc8ZrU+fz+Rbx8kEuyBzZq6tNhiShEREr
         oGcwp47dyfPodxIjiWLF33Q1zeFHDvBGo+g2JrqCVRqkZTh6mn5Acspjkw3Q35j/osAW
         TjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yADFirXFZr6zO2b5q2BzJvz1g09fhbkE5G6ro00Rza8=;
        b=aN7M7l2c67vvGvHWO7zCM+LNcF7PdqgTsPi5Fhdjt/fqz69ENvY9iNuYHiZOGto8QX
         5/vyejvDAaDhj29Ycwzi89K/qdRhtUmLUDogDAPMLS+UpyaPE6XVo+/4c0LcOID16BZB
         qP396ShRLSHxYrEfdTSbVrUUvT+F23wYAuiBgFKd3g3EzW+Tytz39CADy60QRVh6jolJ
         9Ev6N3PYBuQf6D1rvWQRLtxYLXCMM4leSwv2bbU6SzFBoNtI2Xq8OMfIYFzWk05SvDTx
         MsZHXTj4bJ298Ehw1f/eEnTujXlO1FAXgyJ61n17vdYJiDeWl/lECuUhRKNJwN1yfdyQ
         7daw==
X-Gm-Message-State: AGRZ1gKAidmYNvJVjb+Sbsl+fPzD/Y8RWAGvZoxt+jHK1kgRgiO1x4qQ
        fWNt7Mv9rIG7FdpNR3rOcewH5qB+
X-Google-Smtp-Source: AJdET5c4oXT5Xedg+DgUxWXUlTKyCThCnFEoepiEyKyFa65WpCcRbqW9F6h6TUYYi8kk1bLGNPnp7Q==
X-Received: by 2002:a63:a552:: with SMTP id r18mr2652680pgu.176.1541652903517;
        Wed, 07 Nov 2018 20:55:03 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id p6-v6sm2772391pfg.30.2018.11.07.20.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 20:55:02 -0800 (PST)
Date:   Wed, 07 Nov 2018 20:55:02 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 04:54:55 GMT
Message-Id: <ef975b60930601f295d1dc6149e63551da211bf0.1541652896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v3.git.gitgitgadget@gmail.com>
References: <pull.69.v2.git.gitgitgadget@gmail.com>
        <pull.69.v3.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 4/4] http: change http.version value type
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
 http.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/http.c b/http.c
index 86e454cff5..0ad797caea 100644
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
@@ -812,12 +835,10 @@ static CURL *get_curl_handle(void)
 	}
 
 #if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
-    // curl_http_version 0 is default.
-    if (curl_http_version == 20) {
-		/* Enable HTTP2*/
-		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2TLS);
-    } else if (curl_http_version == 11) {
-		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_1_1);
+    long opt=-1;
+    if (curl_http_version &&!get_curl_http_version_opt(curl_http_version, &opt)) {
+		/* Set request use http version */
+		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,opt);
     }
 #endif
 
-- 
gitgitgadget
