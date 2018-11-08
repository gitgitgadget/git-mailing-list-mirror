Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0FE81F454
	for <e@80x24.org>; Thu,  8 Nov 2018 06:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeKHPwg (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:52:36 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46525 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeKHPwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 10:52:36 -0500
Received: by mail-pl1-f180.google.com with SMTP id c13-v6so9031100plz.13
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 22:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xJ6ea0UxQ/IYBKeIXT1aigV1aFv9KbEJHLrryeQHnB8=;
        b=PnIHTJc+4AAIaV+QMPMX4jhR88poBuFuvBnYHCg9kQDjjJoqWJGbXcFmeQSNrOworb
         Mqq4k3bBi2JoxjcMFwVUs9YIYhoDlljALsPke1USeYPrrypnN9/ylUWeNSBcofDxWwC4
         87e21XIo2DAn0OKYXLl8AQDGWl6MpGq01gT5fl+D5NLsZ/pm7MCBkXGccyQt4neAIyDl
         xzep+qTLdK4k+E2jFv19uFXWZiumxEtCIJtRshCMlCiF74VNhnbdAyCEFYwWil4M1oTt
         YsGvk1rOu1269ZN+HczThNNiG2qZOgAE/Vl3PrrCf3YH1xlvpHGeFOOWla6Ui5rdPuun
         XRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xJ6ea0UxQ/IYBKeIXT1aigV1aFv9KbEJHLrryeQHnB8=;
        b=V/zzS3rFJyp+uHs7gRZfpfp4/zs/AD0Zsw9wsdxE3AhA5AXgS2efd4vRGwPGKSU1r5
         BM1HJBaXtWAlc5mDkiSE0zZmDbVR9N6gZFmNqfNsOraRs7Bb5gmiBw7W8Qb+9G0PEKw/
         TQKqkgdQqeuf4mrk5FodiuX4y4Y7cAHDPm9IRSe5DxASieJxAdRjnJx9mt6ujsEMC2RN
         9yqe++v9kPw4fcM1+p8E4x+kLZTCPzLRTtRDcM77zSIzISngl7Ou8rQuBTLena0YnXUj
         6L3BmWElHVBXidS9EbwAs/igur4fc+848ubclob6eNfe7e+kSX6mzy/BqdiePeS/R4Fz
         r2vA==
X-Gm-Message-State: AGRZ1gJsnj88NfsEv6NXuKFmAjDc6MQBcpyPlJjjUAEJOm2CsE++5SEN
        1b1iEj8dWMlcM9RCwMopRTNUN+9b
X-Google-Smtp-Source: AJdET5esW3dug3gci4JMe5ceRaUc8dLZBf7Siiss+eMzCJXRIQKa2qe/8Y3Nzt4SSWZHdXvF9to5Pg==
X-Received: by 2002:a17:902:b486:: with SMTP id y6-v6mr3337269plr.263.1541657922632;
        Wed, 07 Nov 2018 22:18:42 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id n189-v6sm2676080pfn.163.2018.11.07.22.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:18:42 -0800 (PST)
Date:   Wed, 07 Nov 2018 22:18:42 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 06:18:39 GMT
Message-Id: <cdd93048ba42b0baf085c8da4f8fc8937546bef9.1541657919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v5.git.gitgitgadget@gmail.com>
References: <pull.69.v4.git.gitgitgadget@gmail.com>
        <pull.69.v5.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 1/1] http: add support selecting http version
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
 http.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

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
