Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C1C1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 01:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeKHLIH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 06:08:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33150 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeKHLIG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 06:08:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id q5-v6so8120551pgv.0
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 17:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TEACPUbf9LKilUsENgqE1AsKA4VNCAyaGbrfWRTpqTs=;
        b=QogUoR8apdAw66FBg1n5p/IKcPlY+nMRPTI7xa+9ziBkndJy43fXkINeXhRImqvZH1
         9j6n1Q3lSA4A/2JFkWVhR5a5SRjaqbVjSIvabJWijn9d52pw7o3wwvMTTJnRU4b9jm8U
         UBbWruZ87ZODC2oOQ1Us3i3N/UJoJSUiW5trbeaxQNOJqYJELpeb8KRnRD1p8bvZukZH
         JT5NBUj4RvX2Qgy+c0KXCJflDYty/HjSCxz52323vf63cuVIRUb3cA74i9yVp9rgVyzu
         wO5VQJMZnWWFO5uejpIr0vfltfs7z6BVRrbXawn5y/cfWMGyjNi47OIoPEWunDzRrhDS
         IMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TEACPUbf9LKilUsENgqE1AsKA4VNCAyaGbrfWRTpqTs=;
        b=jw1bAnENzKUB5z4Cc3Y4lmznbip9MnBmS2LRj3u7uPJDOfCG6CXBSy+vkbp1+tM3pu
         yyww0s5gsSGrBGfSD6i5Rd61cfWA4Cdr/UcB7eczAA1meMr+p5K467KnqXG6AXjE4P9r
         r6wGnLUvSXjXlxdfSuCYHoamgHIY7aOR2kt7rnCqqgzLUVGZ0Wjo9gttLZnWyq7NeclM
         LS5cHdF9BbEVDY9jI3MRanPP78TnFtNwX20pu4y8Zwe0saBlfxkZH5AHlIZCdoZmyE5p
         3YVzR+OClCRCsW/k5TJ2oW+ffg5bkiVYbAyUcWSz3ZmpHPh+jmDFBWwC+bGqKMcB4C55
         tzTA==
X-Gm-Message-State: AGRZ1gJylbVBpDLHUPaRsLwzaqyOZP8SEEnBM7XXWUWPp3mwokxdTsNN
        IZz61xoz6JnWk/NwdjgIazoetAh+
X-Google-Smtp-Source: AJdET5cCnphauElDxqT315k0/aq9VzdZJfYF0arCmSoPzfl6BVVbiTpRBngcVevEhrNFI37zzjQ1gQ==
X-Received: by 2002:a63:8043:: with SMTP id j64mr2230606pgd.405.1541640905250;
        Wed, 07 Nov 2018 17:35:05 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id x194-v6sm3276547pfd.32.2018.11.07.17.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 17:35:04 -0800 (PST)
Date:   Wed, 07 Nov 2018 17:35:04 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 01:34:59 GMT
Message-Id: <06e9685d2bcef99d6635bd928845156b1580062f.1541640900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v2.git.gitgitgadget@gmail.com>
References: <pull.69.git.gitgitgadget@gmail.com>
        <pull.69.v2.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] support force use http 1.1
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

