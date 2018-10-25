Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B1DB1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeJZD1x (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:27:53 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:46293 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZD1w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:27:52 -0400
Received: by mail-pf1-f170.google.com with SMTP id r64-v6so4623235pfb.13
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jI1AnpdYVGwpxp1YSFuWp/Hny8L1TUKS2h7FYvXT7nE=;
        b=uxp5/L5GwLU4KOTUl0NrMfjPhlEcfdjZ3lCnluseINUwCxuGCnX0hPegAPobQITJkZ
         HeMOvAtuyMlT7RN1RzdFcMiJH1E3/jVsTn7SKixvd8GuP+g8aWfwm4T3Yt2jwtfbZc+z
         5vowJvjs9aGPyngk6T+sn8Kj0kqCLJWK1FurEhJQD0ZAjhHdNsLog6cTZOnEI2HZuOMC
         4TrFyipzW549NaDY0H8/LGwWtgXwizjcIHNodJPpDvHCofsU7mC1p7fakgO2/FIoJE6b
         Wbu0bekkcLn+aQ2dxy5QwZMCF+9SW13lhsWKR64xUjYvCb9t0UXoHcOdyxDb4tWzWnnF
         OnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jI1AnpdYVGwpxp1YSFuWp/Hny8L1TUKS2h7FYvXT7nE=;
        b=HCT1jdolYWqsayFbHgQMD+THORVle+88WBq/OoRSS+XgmIX4mGOmvt+2wl5mbdHVCR
         XqqZyl7UfaebxS1pwUd5h3BSUFWdqPkHBLBg2utrasiFURLtcl68TeTFUGMbS2QnNB5p
         QetbB+ugU8TmP0Z6bXVAi5cegd+ThdY7EA/3d86Z8Nv5+OWubuRcAKnFKEkWtLpuZrYx
         j/oYVnZqXS4F3t1TkUA1vsqqRsW2NARiuTHpjsB1PZmXdnfbPHsC+XaxgITz9xZ2iZFd
         W/x+EPhhBhIIGAjf+V8flzcgz5XOqbXNr/NdSAzxPmmeT6HehYbX+r8sjZmQZDiABRzF
         +rjA==
X-Gm-Message-State: AGRZ1gKAhMeYOyxqg4qrdtU+U5MmS6gAnepNzV/BFVyhM/4Irf2HXXBx
        0Qs5B+khtlLBkiflynlHPxDwPT/o
X-Google-Smtp-Source: AJdET5eyU6LBBfpET5o+XnyChxTzv+Rw/lnnksdbvhq11meiIL/xl/kFAEy0hTO5itPWv2uafC+dlQ==
X-Received: by 2002:a63:c044:: with SMTP id z4-v6mr349851pgi.274.1540493634426;
        Thu, 25 Oct 2018 11:53:54 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id z11-v6sm11503383pfg.85.2018.10.25.11.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:53:53 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:53:53 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Oct 2018 18:53:48 GMT
Message-Id: <85bd0fb27fcf7615b3f927344fd77ea49b9f5dcb.1540493630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.46.v2.git.gitgitgadget@gmail.com>
References: <pull.46.git.gitgitgadget@gmail.com>
        <pull.46.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] http: add support for selecting SSL backends at
 runtime
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

As of version 7.56.0, curl supports being compiled with multiple SSL
backends.

This patch adds the Git side of that feature: by setting http.sslBackend
to "openssl" or "schannel", Git for Windows can now choose the SSL
backend at runtime.

This comes in handy on Windows because Secure Channel ("schannel") is
the native solution, accessing the Windows Credential Store, thereby
allowing for enterprise-wide management of certificates. For historical
reasons, Git for Windows needs to support OpenSSL still, as it has
previously been the only supported SSL backend in Git for Windows for
almost a decade.

The patch has been carried in Git for Windows for over a year, and is
considered mature.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  5 +++++
 http.c                   | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 154683321..7d38f0bf1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1984,6 +1984,11 @@ http.sslCAPath::
 	with when fetching or pushing over HTTPS. Can be overridden
 	by the `GIT_SSL_CAPATH` environment variable.
 
+http.sslBackend::
+	Name of the SSL backend to use (e.g. "openssl" or "schannel").
+	This option is ignored if cURL lacks support for choosing the SSL
+	backend at runtime.
+
 http.pinnedpubkey::
 	Public key of the https service. It may either be the filename of
 	a PEM or DER encoded public key file or a string starting with
diff --git a/http.c b/http.c
index 98ff12258..7fb37a061 100644
--- a/http.c
+++ b/http.c
@@ -155,6 +155,8 @@ static struct active_request_slot *active_queue_head;
 
 static char *cached_accept_language;
 
+static char *http_ssl_backend;
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -302,6 +304,12 @@ static int http_options(const char *var, const char *value, void *cb)
 		curl_ssl_try = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp("http.sslbackend", var)) {
+		free(http_ssl_backend);
+		http_ssl_backend = xstrdup_or_null(value);
+		return 0;
+	}
+
 	if (!strcmp("http.minsessions", var)) {
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
@@ -995,6 +1003,33 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	git_config(urlmatch_config_entry, &config);
 	free(normalized_url);
 
+#if LIBCURL_VERSION_NUM >= 0x073800
+	if (http_ssl_backend) {
+		const curl_ssl_backend **backends;
+		struct strbuf buf = STRBUF_INIT;
+		int i;
+
+		switch (curl_global_sslset(-1, http_ssl_backend, &backends)) {
+		case CURLSSLSET_UNKNOWN_BACKEND:
+			strbuf_addf(&buf, _("Unsupported SSL backend '%s'. "
+					    "Supported SSL backends:"),
+					    http_ssl_backend);
+			for (i = 0; backends[i]; i++)
+				strbuf_addf(&buf, "\n\t%s", backends[i]->name);
+			die("%s", buf.buf);
+		case CURLSSLSET_NO_BACKENDS:
+			die(_("Could not set SSL backend to '%s': "
+			      "cURL was built without SSL backends"),
+			    http_ssl_backend);
+		case CURLSSLSET_TOO_LATE:
+			die(_("Could not set SSL backend to '%s': already set"),
+			    http_ssl_backend);
+		case CURLSSLSET_OK:
+			break; /* Okay! */
+		}
+	}
+#endif
+
 	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
 		die("curl_global_init failed");
 
-- 
gitgitgadget

