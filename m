Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147211F453
	for <e@80x24.org>; Thu,  8 Nov 2018 06:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeKHPr7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:47:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeKHPr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 10:47:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id u13-v6so8837721pfm.4
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 22:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TEACPUbf9LKilUsENgqE1AsKA4VNCAyaGbrfWRTpqTs=;
        b=GJMEpHMRfwf8LNulTr6BxNiuG+mukHpEiiJop7ipIe0qgKNtC0yyOvZgnjAlt2jvNT
         HuRhSBRhoXqC1SsTq+K9/SlMHHvAsTy+GdRwQAfVfRrNFbgzvKtrHPZIioFaKzg3HR3+
         gAG/raj4TX1H+ty5F/w6nbz3D0/j/N8HpmdX3sQefxI2QTqKzWgFgn4wXPfgLPR3AcW8
         fKxDvarlA2bLAqSCHWmhSZMEcJPwQ8zQBdaGaCXNZT1RJxM04lAdANC2HEAMs9Vy9Lt5
         2n7G0SyQFjudqpMgP8Y4F6x1A237wADIRLmWSctFsVUit3Y/Uqf7dr0UcWV+Jt/iBfbK
         IlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TEACPUbf9LKilUsENgqE1AsKA4VNCAyaGbrfWRTpqTs=;
        b=RUxTPOSmydPJ3Igj2jLy0ntYud4wi2xRBPDbTJX++mKBtbsLmOnItAQF4CmZm4HgV2
         dOVS00vWflJoqr0wplQQlaBfq3WEphwIH+9Y9YmuVTVKotWnKcGsuxE+X0yj/+3t0fAw
         PZfBmwR2MVkLDT9IPC2zX3bBTKkoz3RPOOruFFG6N2XL+XVwf7wwIVSKsDYRu0RQn+89
         2G9oiXj9NDUaPR8RM3cLXOa2G9xg70wIYSwHVdoYrQW5wU14bg3D5vhXOpv+84ZDP693
         WQsebX4rQ/TzrpZfdQRLJW6gTi5723E26kjDjx0XT1gP9wKwNLgZ5mHJ9B3OMHQ6oEr7
         otqg==
X-Gm-Message-State: AGRZ1gJgfww33bdDS4mgc8bIuriHgyE2xnz5AcQBxbIzOzIJutT+/GIg
        g/o0zOMPVon7XGTj0HG427aGXZJp
X-Google-Smtp-Source: AJdET5fK9hhEcZZ/FhHpPxUJwI14RX7zTvH4jEkgM0jovJw2CK25NUPeCUjJzZgnNHlhZlcUzWEaXg==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr2805570pgq.189.1541657645808;
        Wed, 07 Nov 2018 22:14:05 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id c7-v6sm2972248pfh.25.2018.11.07.22.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:14:05 -0800 (PST)
Date:   Wed, 07 Nov 2018 22:14:05 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 06:13:58 GMT
Message-Id: <06e9685d2bcef99d6635bd928845156b1580062f.1541657640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v4.git.gitgitgadget@gmail.com>
References: <pull.69.v3.git.gitgitgadget@gmail.com>
        <pull.69.v4.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 2/4] support force use http 1.1
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
 http.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 99cb04faba..b2ec31aef5 100644
--- a/http.c
+++ b/http.c
@@ -48,7 +48,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
-static int curl_http_version = 11;
+static int curl_http_version = 0;
 static const char *ssl_cert;
 static const char *ssl_cipherlist;
 static const char *ssl_version;
@@ -811,11 +811,14 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x073100
-	if(curl_http_version == 20){
-		/* CURL Enable HTTP2*/
-		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2);
-     }
+#if LIBCURL_VERSION_NUM >= 0x074700
+    // curl_http_version 0 is default.
+    if (curl_http_version == 20) {
+		/* Enable HTTP2 when request TLS*/
+		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2TLS);
+    } else if (curl_http_version == 11) {
+		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_1_1);
+    }
 #endif
 
 #if LIBCURL_VERSION_NUM >= 0x070907
-- 
gitgitgadget

