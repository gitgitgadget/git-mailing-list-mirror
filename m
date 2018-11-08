Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344441F453
	for <e@80x24.org>; Thu,  8 Nov 2018 06:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeKHPr7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:47:59 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:35618 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeKHPr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 10:47:56 -0500
Received: by mail-pl1-f174.google.com with SMTP id n4-v6so9043518plp.2
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 22:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pwaq1k7tbXYZJbON+5QUf3xRvroHi6fk057jEUhtDRQ=;
        b=Fvg6/5Vmw9oaP1uyVmnS+CS4jORm0/hapmsEAmeIpTiekps37clo+5Mf5S3MVVtVbR
         m8w6/Lr+aJvcX+YujM8f4NbnLEFxpE9BLeadHzE0VSLikosI40CdxW1iZbK0210Bc1C7
         w8XqXBue2dOaUc3H+REMWQAr9lXolZezdVZTPRBeJUGA1SpCVVGgIEMCyYBm5JgWEeI8
         n9Zc3gwj4m0Z7Junxa9GhqzYdQ01UL3kbm7ZYr/DhlWuiVDcUUciJ14g8LhuPO6GCpIK
         zeOPrZve1hm8w/z7wtUy5gXcat3E2E5TaGXFtgG8bOieuG3jisP248sNDKwtocDSEEtN
         pcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pwaq1k7tbXYZJbON+5QUf3xRvroHi6fk057jEUhtDRQ=;
        b=N7yLD7u9aPlugecHy5OOWXuKlmxr1vXbGDSvJ9DG4CJlKZKYBP+M8LDGLdSGlAtEKn
         cyQwQaoBPozDPM7Eu6iR3RX0/NIHEYJTQz+47m47L4lZjJq3C89J8h2tMur/X7nZdIFQ
         74Eu8yjQlFhZTNQL9GOXxoT7pvnEWNdZwItXSbHuSFGq2+KcV6wHVvEiohJusjORmDH4
         t90esiD9ZVfFUq7lXxrzka92751feBvbESVWhO/+FriJs11Q00vJm6s67eRrpB9+CHlC
         F51RhzglH17+jLGbq+2MwBKAKIzZRbfuhk2CdYmAJO5Q5H8utn4v2QrWCYuhHrVorKvj
         UMgA==
X-Gm-Message-State: AGRZ1gLppK0LRxl42IXlSofm9xPbuWahU5qPh1nNJvOsqFVb3OegTtF8
        X0m1CH3sJtC253kJMuJ3kZnSMZ0H
X-Google-Smtp-Source: AJdET5fdOv1G+G6kCgEdHVgf2Ie/Fz0BHze0bfl6XWOC6FBYrzbcUa2XQV6vhRlF78eUkvNtq+51zQ==
X-Received: by 2002:a17:902:20c5:: with SMTP id v5-v6mr3355385plg.156.1541657644617;
        Wed, 07 Nov 2018 22:14:04 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id s22-v6sm4488631pfi.15.2018.11.07.22.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:14:03 -0800 (PST)
Date:   Wed, 07 Nov 2018 22:14:03 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 06:13:57 GMT
Message-Id: <4f5a935c4355794effb23c979dcbaf77ed33da26.1541657640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v4.git.gitgitgadget@gmail.com>
References: <pull.69.v3.git.gitgitgadget@gmail.com>
        <pull.69.v4.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 1/4] http: add support selecting http version
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

