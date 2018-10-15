Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9588C1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeJOR7W (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:59:22 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40111 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJOR7V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:59:21 -0400
Received: by mail-pl1-f177.google.com with SMTP id 1-v6so9066219plv.7
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=qF6OLnoAWzxdKIW4zYidSI0LKATt0JQ7Pprvo/95nvY=;
        b=ottL5zmIJMSHEgR7FUrFphBlQu3L4LlOr6x6klg/6irOOVuWq8ZXuvsWO9BfN1EpL2
         p51kvoPVsL8Vl1YPbCgOWbBJJ0np5wRsAiwKySdbmJ9qKrx9NBU47Um6raWhH09nJgcc
         CSorpDaJ4o/ORKDDZDgI2dk1HsPb4Ggg/tsXVL2o8xHo6r3pkCm8iyO5Op8Qr07vG7g7
         5HXKNIS637wdxYDGqMBraFdTETCAMs/GbjReAbGQtT541UsjmM1ov+yuNZi0RpLCXMNe
         V60vUw29CC88uHcWwOXiUcb+IEDC978LoOJa/VANxOUj+JR44Axr8RACvwVt2AL0SZrt
         Vr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qF6OLnoAWzxdKIW4zYidSI0LKATt0JQ7Pprvo/95nvY=;
        b=Kw32AfvB5kkVqiu+EajpRHznpYS8bvxtFduCdlyIO7jexQX3/6muglxCqRNhXLHk8Z
         +g/4aujXrIH2z6Dlg/LsqoKxzuuWZfDoonnEmiPfPctuHuvSpoWNFUfwerLGH3pofV5r
         57mhi3h9ol6nSkEaSEAfNFy0v+kGKW3p9Yeo5O4/TROcBAdP0x1A8Lyx6HOx1XgfTNGK
         986+dfqP2vXzh2/Wk6qETUEYl3YtUZNiViIQPi5MExBrIHkXiopv3PjNLXZWtD3PM4wz
         ukNJhx2vEW76lDuqQkBk0t5gWIlGcfLf+361VTcxshiI91cht/fZ46NIQa4+Z9WCcXg2
         PXLw==
X-Gm-Message-State: ABuFfogbn/3M5tiTpUOh7woTkmWpHVQs6/4uguwNtOXdmKn5eBloJjay
        1Z3rFtBMDnBmY5dBxYjMDOQBRVS6
X-Google-Smtp-Source: ACcGV62l3CXipS6wMJp1XSsKFL1IO+TJdMdvpe4xWKhMT4LHuLBiVkHwTrh4gOlGLqcOML7dlTTQVA==
X-Received: by 2002:a17:902:33c3:: with SMTP id b61-v6mr16747148plc.52.1539598485907;
        Mon, 15 Oct 2018 03:14:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id u69-v6sm19325726pfk.68.2018.10.15.03.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:14:45 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:14:45 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:14:39 GMT
Message-Id: <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.46.git.gitgitgadget@gmail.com>
References: <pull.46.git.gitgitgadget@gmail.com>
From:   "Brendan Forster via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] http: add support for disabling SSL revocation checks in
 cURL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brendan Forster <github@brendanforster.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brendan Forster <github@brendanforster.com>

This adds support for a new http.schannelCheckRevoke config value.

This config value is only used if http.sslBackend is set to "schannel",
which forces cURL to use the Windows Certificate Store when validating
server certificates associated with a remote server.

This config value should only be set to "false" if you are in an
environment where revocation checks are blocked by the network, with
no alternative options.

This is only supported in cURL 7.44 or later.

Note: an earlier iteration tried to use the config setting
http.schannel.checkRevoke, but the http.* config settings can be limited
to specific URLs via http.<url>.* (which would mistake `schannel` for a
URL).

Helped by Agustín Martín Barbero.

Signed-off-by: Brendan Forster <github@brendanforster.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  8 ++++++++
 http.c                   | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7d38f0bf1a..d569ebd49e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1989,6 +1989,14 @@ http.sslBackend::
 	This option is ignored if cURL lacks support for choosing the SSL
 	backend at runtime.
 
+http.schannelCheckRevoke::
+	Used to enforce or disable certificate revocation checks in cURL
+	when http.sslBackend is set to "schannel". Defaults to `true` if
+	unset. Only necessary to disable this if Git consistently errors
+	and the message is about checking the revocation status of a
+	certificate. This option is ignored if cURL lacks support for
+	setting the relevant SSL option at runtime.
+
 http.pinnedpubkey::
 	Public key of the https service. It may either be the filename of
 	a PEM or DER encoded public key file or a string starting with
diff --git a/http.c b/http.c
index 7fb37a061b..8998056b60 100644
--- a/http.c
+++ b/http.c
@@ -157,6 +157,8 @@ static char *cached_accept_language;
 
 static char *http_ssl_backend;
 
+static int http_schannel_check_revoke = 1;
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -310,6 +312,11 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.schannelcheckrevoke", var)) {
+		http_schannel_check_revoke = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp("http.minsessions", var)) {
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
@@ -811,6 +818,16 @@ static CURL *get_curl_handle(void)
 	}
 #endif
 
+	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
+	    !http_schannel_check_revoke) {
+#if LIBCURL_VERSION_NUM >= 0x072c00
+		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
+#else
+		warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
+			"your curl version is too old (>= 7.44.0)");
+#endif
+	}
+
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
 
-- 
gitgitgadget

