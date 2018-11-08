Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C871F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeKHO2j (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:28:39 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:44500 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbeKHO2j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 09:28:39 -0500
Received: by mail-pf1-f181.google.com with SMTP id j13-v6so8741747pff.11
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 20:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pwaq1k7tbXYZJbON+5QUf3xRvroHi6fk057jEUhtDRQ=;
        b=paIwGKoLC0d2GWcrSx958VCEl8HDzEkI7VdmdrV1/2Fe8oFbWBdU9hEXeH5sVxClN7
         giiwGvH/SOeQTp3xJPyqs061cuL3u0S5PF/5m3JuMWN/WvkMcJ8FasSgBXgR+XHYfQMx
         NoAZxm8XH5ivpzd8phw0P9ZWmWYfqPNvBCdl/gXQM1/ul1ccJINCCsUzBrHAIIVeMho1
         oV5k5tMtXKQRKfH3++RW+1E98KfCWYB+AEYtm6JjN7pZAhjgknX6dfq8Gu8gSRVWMG6M
         Gq6vpKFAnyRQEQECJzL7sJQKSjVDGGeflwEVIGK7hKuk0wN6/DGykdHQtU8NEIfQgs5G
         HUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pwaq1k7tbXYZJbON+5QUf3xRvroHi6fk057jEUhtDRQ=;
        b=rKTqBbrSfsBv9MO6QWdcEpagXKKsC5in4Dsqh4QwKIHYBL8VLkW01vJCJqYh+f6Lxt
         Sfhd1ugx3ExTjpDzysoVRJDwfSHmu8EJsSzvogBFZLHHqFHdpcU23r/oRlfDC3b8T3EW
         jNjF7r5mzxVQ+m5e8o/5DvswhesQ+ocLVKYutTD8Y0T1QKZZZR9lljA3dnRjslNHSYUm
         SYm2I22q4aFuzCbCe9OVJngoBjjBd7Y2xNdT3gb9QsWnXNjQGLGr6CuWPPz6qhJTTEpg
         QANVyR42CxbbXTSrPb+ea9dNdgm7YziotGvOsDL3o4TtInTw+uPwtqSQz/KH81GV3JYs
         MrAg==
X-Gm-Message-State: AGRZ1gLZjrdMbJ622URf3CXa2Q3eR98HDj2AXPhcti4lBtuPpShZwu9e
        ip1el7n5xz+i+g1EPwiQD4FogX51
X-Google-Smtp-Source: AJdET5cK1Hse44dOzx1RNk3P6RmGOuiPC/FmWhyZGrpce7gArYN+PsFJgEA8OXdxCO6gHDLU0QZtHw==
X-Received: by 2002:a65:42c2:: with SMTP id l2-v6mr2532940pgp.139.1541652899820;
        Wed, 07 Nov 2018 20:54:59 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id q195sm2329266pgq.7.2018.11.07.20.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 20:54:59 -0800 (PST)
Date:   Wed, 07 Nov 2018 20:54:59 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 04:54:52 GMT
Message-Id: <4f5a935c4355794effb23c979dcbaf77ed33da26.1541652896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v3.git.gitgitgadget@gmail.com>
References: <pull.69.v2.git.gitgitgadget@gmail.com>
        <pull.69.v3.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/4] http: add support selecting http version
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
 http.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/http.c b/http.c
index 3dc8c560d6..99cb04faba 100644
--- a/http.c
+++ b/http.c
@@ -48,6 +48,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
+static int curl_http_version = 11;
 static const char *ssl_cert;
 static const char *ssl_cipherlist;
 static const char *ssl_version;
@@ -284,6 +285,10 @@ static void process_curl_messages(void)
 
 static int http_options(const char *var, const char *value, void *cb)
 {
+	if (!strcmp("http.version",var)) {
+		curl_http_version=git_config_int(var,value);
+		return 0;
+	}
 	if (!strcmp("http.sslverify", var)) {
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
@@ -806,6 +811,13 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
+#if LIBCURL_VERSION_NUM >= 0x073100
+	if(curl_http_version == 20){
+		/* CURL Enable HTTP2*/
+		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2);
+     }
+#endif
+
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
-- 
gitgitgadget

