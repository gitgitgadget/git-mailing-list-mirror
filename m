Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5191F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeJZD1y (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:27:54 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41483 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZD1y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:27:54 -0400
Received: by mail-pf1-f174.google.com with SMTP id a19-v6so4630514pfo.8
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=U5iHL9HeFoSTkyisBXV0RqD6bayM8KH+EV1ZubOM1vk=;
        b=fsCt9iFlCx121uePFKSna6mc1e7o8LLAkEwkawdDZBoonk7UQsnnDXXAQa2TYZ/OFS
         BeNSx4VRjbw6sHwme98VI3B6a+934ku8W9exlE/JnfD5zB9lkUnneZ8BRZ8TNJn4OvSO
         ULHKhtNmOGIkU98Px0zk4GchN1AU1fKB/9uBWFCp14qu0H5iP/UdoeCdizCkUzhd3QFo
         qh5ymLFU5IcQizcQ8ZfCgUYK3xBdsQHKOGXRI3dRPGvWzqESYEcQInLmJu8sNr3IdTOj
         ZUPwVeAF7a/6OSM9m1NTgl8WSz33HgmvCaTpEKVgVecbbjRkkNJXjUULyb5Zr+NlCC7i
         PcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U5iHL9HeFoSTkyisBXV0RqD6bayM8KH+EV1ZubOM1vk=;
        b=QxZevql2lRQrbS9QngX7LSJ4zNb7cZYX1PfASQq04OKro/Qa3bW/SmZjtu2+gA6+49
         ewjdI1EIIpNVqqrzMScMi+RBP7eHhvgvUw9Iz/x7Ru9q4R2FzZqWFBcMXL9/AT/WeQRF
         PuzGmGib056p2TClw1V2+lsZxjhkF6UygzxTh7nm54TKTROswJfIJbhActM56/1N6xrX
         RCmsLbVV8ffyVGf0vwU3m55nTX3Yod3uIsgqk0On2IPPAnIif5lskp+HaD3fbTRzFQEP
         4FdnSUVuZsmraz/1EWXlopNQmaYDWL+WIsAgiTKKg1lJxGEvSKvQ67Vd3ExRys0zmbq6
         kkYw==
X-Gm-Message-State: AGRZ1gJvqPwrW+6A4UaMr0d06QFPyWi04pZDglG+cFkb+ZA20YgKmHYo
        mxX6aEN1tPcr6feOgbpC7sZy1fm7
X-Google-Smtp-Source: AJdET5fF0xhqTnhZYtQliTMa8J8fxEpg7Bgwl84lGkmMXAz3Xdj6WUysHLaSUEG7r5GNVQWbfTS3ww==
X-Received: by 2002:a62:968a:: with SMTP id s10-v6mr353834pfk.191.1540493635810;
        Thu, 25 Oct 2018 11:53:55 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id z15-v6sm9924988pfn.170.2018.10.25.11.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:53:55 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:53:55 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Oct 2018 18:53:49 GMT
Message-Id: <951383695d9c9a30a11fcf3dc6a268e604d10f3a.1540493630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.46.v2.git.gitgitgadget@gmail.com>
References: <pull.46.git.gitgitgadget@gmail.com>
        <pull.46.v2.git.gitgitgadget@gmail.com>
From:   "Brendan Forster via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] http: add support for disabling SSL revocation checks
 in cURL
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

Note: originally, we wanted to call the config setting
`http.schannel.checkRevoke`. This, however, does not work: the `http.*`
config settings can be limited to specific URLs via `http.<url>.*`
(and this feature would mistake `schannel` for a URL).

Helped by Agustín Martín Barbero.

Signed-off-by: Brendan Forster <github@brendanforster.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  8 ++++++++
 http.c                   | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7d38f0bf1..d569ebd49 100644
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
index 7fb37a061..65daa9bfa 100644
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
+			"your curl version is too old (< 7.44.0)");
+#endif
+	}
+
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
 
-- 
gitgitgadget

