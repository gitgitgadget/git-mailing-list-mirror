Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27EE61F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJZD1z (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:27:55 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:33900 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZD1z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:27:55 -0400
Received: by mail-pg1-f173.google.com with SMTP id g12-v6so4447535pgs.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nOdxaeudnKNwtPoQE8r6Sc1f+V5iPYGDky2EMO71Uj4=;
        b=gN3dqPJ9vJuIupKV7MxOKNHDhppvxrBNH1cjbB6IqeVtIe/m9x/Y8kbj9JE++ikzAW
         SE4jn2GFmekDdirpME2H0Bu/vg2R2N0CyzATIxOKZx9UmYyim6a4F4lXS9C4HW8EpLyd
         C8HZ78psldjd+ZAaySHMVpbnOqk3Xs39eMN8OTlKtc9NJu6FLhNELt06AP1cE5cBvWis
         HVKZUxZa0Wzs74cJ65/3y0MixLu30UcUvYaswXtUFDWIj7XSQWOYASDSSXRoXFo4fwR8
         NW+dFUWBhZh87UwKD/a3PmwRYmjgj9cfn5+s0FQXnPodT4P8YqNm6wq3Ffql1vWpWPqM
         ImfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nOdxaeudnKNwtPoQE8r6Sc1f+V5iPYGDky2EMO71Uj4=;
        b=P1PqSgsJFXm51lbPjWTsxDJ9nhOFJ/xBRTZuTe5FHlxjUJqgzHmPjrNcPZYBpjMkWW
         H6zLyyrryvizXBh4AKHAalShlP2yf6WnOIS+gOix6zfQo3LJ0xzFsKsvToFZW11HXi2e
         dsv47MLJUZNcRKZhrhRhbXFhuqBAdlHN4aNrEcz1NQm5C/obgT+kX7zJuOipOIJ/UTRs
         PjeYoYEQ6j+jQCu9fORFw+cmh9LXifIvHeVYWCV77IzpXtr+O6NaRxb+skL+FobWkKsi
         YF4K8ZFhLQpnmZO8HhmALmcvx22k9MFeQYeaJKaWyDqXDCnSSr7DKdmUIc5gTgdOqSt5
         TcPg==
X-Gm-Message-State: AGRZ1gLePCG2snUnx/TO2buMQaCEHEPFCpxqk3YHbb5ltEPL+ziX9LRw
        f3VCLChrF+z5cMrov7AwdZIK/wHp
X-Google-Smtp-Source: AJdET5fXrCsjwDeLRKCWTCuwbr84bn2RmzOauGvVuxohigq76sU1NdogkXQAnDqdj5LreRBAUMYHqA==
X-Received: by 2002:a63:1412:: with SMTP id u18mr325338pgl.247.1540493637309;
        Thu, 25 Oct 2018 11:53:57 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id b29-v6sm16676575pfj.183.2018.10.25.11.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:53:56 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:53:56 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Oct 2018 18:53:50 GMT
Message-Id: <a5f937a36d454d6d99bb64d4be3c389cf996826a.1540493630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.46.v2.git.gitgitgadget@gmail.com>
References: <pull.46.git.gitgitgadget@gmail.com>
        <pull.46.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/3] http: when using Secure Channel, ignore sslCAInfo by
 default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of cURL v7.60.0, the Secure Channel backend can use the certificate
bundle provided via `http.sslCAInfo`, but that would override the
Windows Certificate Store. Since this is not desirable by default, let's
tell Git to not ask cURL to use that bundle by default when the `schannel`
backend was configured via `http.sslBackend`, unless
`http.schannelUseSSLCAInfo` overrides this behavior.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  8 ++++++++
 http.c                   | 19 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d569ebd49..1f6a6a4a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1997,6 +1997,14 @@ http.schannelCheckRevoke::
 	certificate. This option is ignored if cURL lacks support for
 	setting the relevant SSL option at runtime.
 
+http.schannelUseSSLCAInfo::
+	As of cURL v7.60.0, the Secure Channel backend can use the
+	certificate bundle provided via `http.sslCAInfo`, but that would
+	override the Windows Certificate Store. Since this is not desirable
+	by default, Git will tell cURL not to use that bundle by default
+	when the `schannel` backend was configured via `http.sslBackend`,
+	unless `http.schannelUseSSLCAInfo` overrides this behavior.
+
 http.pinnedpubkey::
 	Public key of the https service. It may either be the filename of
 	a PEM or DER encoded public key file or a string starting with
diff --git a/http.c b/http.c
index 65daa9bfa..28009ca73 100644
--- a/http.c
+++ b/http.c
@@ -158,6 +158,12 @@ static char *cached_accept_language;
 static char *http_ssl_backend;
 
 static int http_schannel_check_revoke = 1;
+/*
+ * With the backend being set to `schannel`, setting sslCAinfo would override
+ * the Certificate Store in cURL v7.60.0 and later, which is not what we want
+ * by default.
+ */
+static int http_schannel_use_ssl_cainfo;
 
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
@@ -317,6 +323,11 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.schannelusesslcainfo", var)) {
+		http_schannel_use_ssl_cainfo = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp("http.minsessions", var)) {
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
@@ -869,7 +880,13 @@ static CURL *get_curl_handle(void)
 	if (ssl_pinnedkey != NULL)
 		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
 #endif
-	if (ssl_cainfo != NULL)
+	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
+	    !http_schannel_use_ssl_cainfo) {
+		curl_easy_setopt(result, CURLOPT_CAINFO, NULL);
+#if LIBCURL_VERSION_NUM >= 0x073400
+		curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, NULL);
+#endif
+	} else if (ssl_cainfo != NULL)
 		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
 
 	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
-- 
gitgitgadget
