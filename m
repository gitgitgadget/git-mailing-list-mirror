Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 858F01F453
	for <e@80x24.org>; Wed,  7 Nov 2018 13:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeKGXEW (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 18:04:22 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:38125 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeKGXEV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 18:04:21 -0500
Received: by mail-pf1-f170.google.com with SMTP id b11-v6so7714980pfi.5
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 05:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pwaq1k7tbXYZJbON+5QUf3xRvroHi6fk057jEUhtDRQ=;
        b=Vv+zQ8BVYRXZi3nDrErc/X+UFLhSJsJ5Nps77ORk/SGZT7mXEzDD8WSg5jfwMdDjdO
         u2JXbmjOBumATZSrL/0GIjSyKOIyLJEVlplZhZXr5TyQ401TjiK7RavR+NpuncI9YpU2
         bvqWttpZiJz3ORSPSYPRpnWQ5Tm92zTFJb4cJR1lPaWJCS9VZYH5nZBwHu0bTHXth1Pu
         +fMSD5ycZx3EMOTTaEXo6BDjXAEmwJB8AShEN5dN4hpyid54tQt6UnwMDXmyjvcPZe6s
         La1KmlzT4g7Dvjkw7eGZUkfJUSzzXQHbz+xfGdN0lf0x0bR3lpuLKn27L/KQxMJhrqfr
         zJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pwaq1k7tbXYZJbON+5QUf3xRvroHi6fk057jEUhtDRQ=;
        b=onCXrwNZ1o+vnCz0UmWnKnUYNCt8MWlPpuVX5MLi0iYaZG8lNVBLorfROVOm8e0mxY
         OjvlkSluMLhqQdwwIiSdtlQsqhI1n+H9o+/rpRSLXIZ54nKrEAhDzG5x9J7jOhTB3ZdB
         iQ3BSVwKuEDiFWJ/nzwGaXqtFH8xCiCgo+uik5SgKf+M/nEPfMgSfDAxlS42ChEHq5Xp
         /7SJYLWbvuIYgvv52bi1I4WkajVbZpoUIRc4M++vomMvGWCb2GPcOB3E1VyYgKm2Hfqs
         quMWP606FNDCjnlX31kGBwr6drcK0/eAYxjCjRghdY06tnuHbbAZ6RtZUbT4AjQjaJ81
         sTXg==
X-Gm-Message-State: AGRZ1gKSnn+4L4ak+uqzD5CYXhded4qwduZHA/P26LJQWKTTfWevLDx2
        Qz6aS9xCXtZd6wGhOkSmTlxzj17b1r8=
X-Google-Smtp-Source: AJdET5e6XK67TT1jMBBufL7jhGD7Jb9C5QY+b7ojl6h/3R6F6IbgP4Z4G8iI5R0d3sJGTRhn1wqwBA==
X-Received: by 2002:a62:2643:: with SMTP id m64-v6mr254060pfm.74.1541597636837;
        Wed, 07 Nov 2018 05:33:56 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id l129-v6sm758000pfc.155.2018.11.07.05.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 05:33:56 -0800 (PST)
Date:   Wed, 07 Nov 2018 05:33:56 -0800 (PST)
X-Google-Original-Date: Wed, 07 Nov 2018 13:33:52 GMT
Message-Id: <4f5a935c4355794effb23c979dcbaf77ed33da26.1541597633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.git.gitgitgadget@gmail.com>
References: <pull.69.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] http: add support selecting http version
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
