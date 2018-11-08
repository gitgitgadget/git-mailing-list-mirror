Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1711F453
	for <e@80x24.org>; Thu,  8 Nov 2018 01:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeKHLIF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 06:08:05 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:34930 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeKHLIF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 06:08:05 -0500
Received: by mail-pf1-f178.google.com with SMTP id v9-v6so6227005pff.2
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 17:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pwaq1k7tbXYZJbON+5QUf3xRvroHi6fk057jEUhtDRQ=;
        b=b4ZY3sXuJs0zI6qt38PiVZ2g1A/qI9wCIYWq2P8qey11Sq0lIEzdS3s9JSAKous3Zh
         Wo6Coc2GSqA4rB5yHtIoVgXO5DEhVI5lIpT4zWHvQKpTLHRpXR5LxPkAYyUBMI8cFTnQ
         3lJStWkWi97QfGndHY+dMXQaeArYCyXZ+9gt66WhSQN+wIPeyPCehKD/F3IdeSeqVvNq
         MWFUWKgbmAgNugt5NPvHEaHknA08S9NEqBA5itwnisMs0T6ViQLoyUdRErt9ZN38R4Ia
         WNCitBUBPv9hIwX1OyXlujlvWAOvMq9GXB+kOkUZ+r8z7Anq81t9CtEbQHQsJM84ofCw
         j43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pwaq1k7tbXYZJbON+5QUf3xRvroHi6fk057jEUhtDRQ=;
        b=Ie5R39L7RLbRxDYb/MgPSz3N1jUfQCRVMsklzEET2XynT9gtmFQMVlKHM+gy888hJj
         fdHbVirO1/g3HFJ5H4uxILBL2xzE8Eu02LJBvVRvwHNDV7femZ5tdfEfIt4qOoOgwZed
         ++tTs8oaVUbQArLKgcp0PT3ulE6JPpK5lOMbn6FUXjv2YkAaWNjovfrXAxriDPKYyMm1
         iMUA5NVLoIMKuI6M0/eIScRB7X1lSMnSnOmRwn076eVEtAmGu5tderx7X3Y4SkmyXlcv
         tppO0wphMsV3/wz+3alVFtW5zEa0t/TzlGbUE+Uk4Meu+MZ+F9RyCD8X3lGP1l9H96pQ
         c5vg==
X-Gm-Message-State: AGRZ1gIhjBNcacT0cCesRkB37SsyAef/lOyQ5aHYQjAW1zKk8cDB8ssP
        UXmNs2QkOnV5S+qoDLva0lIIOwrT
X-Google-Smtp-Source: AJdET5cAJC1Fk2ssfk4gF0BlPilF29qdVt3zVI1ui5FiCNGwNrmj9ZkSnTw3iQbuJaAvOj+l29hBVQ==
X-Received: by 2002:a63:d441:: with SMTP id i1-v6mr2190056pgj.31.1541640904073;
        Wed, 07 Nov 2018 17:35:04 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id s186-v6sm3309198pfs.164.2018.11.07.17.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 17:35:03 -0800 (PST)
Date:   Wed, 07 Nov 2018 17:35:03 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 01:34:58 GMT
Message-Id: <4f5a935c4355794effb23c979dcbaf77ed33da26.1541640900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v2.git.gitgitgadget@gmail.com>
References: <pull.69.git.gitgitgadget@gmail.com>
        <pull.69.v2.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] http: add support selecting http version
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

