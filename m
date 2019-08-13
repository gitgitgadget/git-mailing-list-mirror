Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B76D1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 18:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfHMSht (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 14:37:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37720 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbfHMShs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 14:37:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so6753989wrt.4
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QeuzYHSGpnBo+Fj/lZBkb3AnNGXJv/NfFEjJb6c9ROA=;
        b=QU3iEAezVMbCycLV0058A/095owzw7mk96KQKS36nQqLMeiq2LQK4kVAQHTj7VbE7I
         WqxxKBytVpZN9ATg/BKfuLST3fTGwO/nPw9dPay5mQiu3l7INHMvrpBo0JaByiylOf/B
         vgayLZm4XeHfljQdBDuxmdnVRc4v2VE34m1k5yIK/SVUTI4QRHbFJz6P+CheWFpKeyUq
         PmK7lGAWSYnZjSyZZARpGoogGT4byVkObLq+O3nAhaPDIaW0QnwAWAtXQuDydCudLskl
         /fUvztbXDRQY5YhNZapNOnxJs14BN9K4JsaqBblOHa0/DQcWALVO5rJ1XQ/U4U+Tnkx4
         6HBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QeuzYHSGpnBo+Fj/lZBkb3AnNGXJv/NfFEjJb6c9ROA=;
        b=Kk5ZudgmfqJIyybZ1+BKh7QRMkGZangW5e4yuuOUY9mdg9AgEzMyLH2qt6qwhUDNbh
         295HxszPQzErBh4ckvzloQcA+B0AVY+Za5jy7tScnBZMsfw1Puogv8VEQZ/77XBY7ub9
         cWkiKIjkyY4TfDMIRaY0CdgqNfjsOoG9vB2Ht+wBycarKryNl5DNVQsaUFKIe5+Y49JK
         8NKiJ5leVTLQ2plsuei5X+SL3FlltUJrIppsRhSLsfXrv2CS8oVh8pRsgy5vqJhGgOSq
         61wpzil5pAc8IT/0ZNzE09otqfa2vskyPAQhTPW3t0tx1i8Q6qgrsMEXEPJc1RuB2Li3
         DmjQ==
X-Gm-Message-State: APjAAAXdtxA6ofGmglp79xW28pLURVwX+I7XBHyAQjowNoHXRXRLeA6B
        tXtraMVF9Hfffs2pnHTHSB4nZlsX
X-Google-Smtp-Source: APXvYqxC17mBNob/vhYCp307L7CVSlLrPUBUOu8c1OsE/6ZTuFJC3cQvntZNFgQLsj/oDwVJ5Gk5/Q==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr46556296wro.337.1565721466933;
        Tue, 13 Aug 2019 11:37:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18sm136480263wrw.36.2019.08.13.11.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 11:37:46 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:37:46 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 18:37:39 GMT
Message-Id: <ec0abffd8b8d929599fbacde18a7e98f49a4c63b.1565721461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v4.git.gitgitgadget@gmail.com>
References: <pull.292.v3.git.gitgitgadget@gmail.com>
        <pull.292.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 4/6] repo-settings: parse core.untrackedCache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The core.untrackedCache config setting is slightly complicated,
so clarify its use and centralize its parsing into the repo
settings.

The default value is "keep" (returned as -1), which persists the
untracked cache if it exists.

If the value is set as "false" (returned as 0), then remove the
untracked cache if it exists.

If the value is set as "true" (returned as 1), then write the
untracked cache and persist it.

Instead of relying on magic values of -1, 0, and 1, split these
options into an enum. This allows the use of "-1" as a
default value. After parsing the config options, if the value is
unset we can initialize it to UNTRACKED_CACHE_KEEP.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c |  6 ++++--
 config.c               | 24 ------------------------
 read-cache.c           | 19 +++++++++----------
 repo-settings.c        | 19 +++++++++++++++++++
 repository.h           |  8 ++++++++
 5 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index dff2f4b837..49302d98c5 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -966,6 +966,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
+	struct repository *r = the_repository;
 	struct option options[] = {
 		OPT_BIT('q', NULL, &refresh_args.flags,
 			N_("continue refresh even when index needs update"),
@@ -1180,11 +1181,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		remove_split_index(&the_index);
 	}
 
+	prepare_repo_settings(r);
 	switch (untracked_cache) {
 	case UC_UNSPECIFIED:
 		break;
 	case UC_DISABLE:
-		if (git_config_get_untracked_cache() == 1)
+		if (r->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE)
 			warning(_("core.untrackedCache is set to true; "
 				  "remove or change it, if you really want to "
 				  "disable the untracked cache"));
@@ -1196,7 +1198,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		return !test_if_untracked_cache_is_supported();
 	case UC_ENABLE:
 	case UC_FORCE:
-		if (git_config_get_untracked_cache() == 0)
+		if (r->settings.core_untracked_cache == UNTRACKED_CACHE_REMOVE)
 			warning(_("core.untrackedCache is set to false; "
 				  "remove or change it, if you really want to "
 				  "enable the untracked cache"));
diff --git a/config.c b/config.c
index faa57e436c..3241dbc54d 100644
--- a/config.c
+++ b/config.c
@@ -2277,30 +2277,6 @@ int git_config_get_expiry_in_days(const char *key, timestamp_t *expiry, timestam
 	return -1; /* thing exists but cannot be parsed */
 }
 
-int git_config_get_untracked_cache(void)
-{
-	int val = -1;
-	const char *v;
-
-	/* Hack for test programs like test-dump-untracked-cache */
-	if (ignore_untracked_cache_config)
-		return -1;
-
-	if (!git_config_get_maybe_bool("core.untrackedcache", &val))
-		return val;
-
-	if (!git_config_get_value("core.untrackedcache", &v)) {
-		if (!strcasecmp(v, "keep"))
-			return -1;
-
-		error(_("unknown core.untrackedCache value '%s'; "
-			"using 'keep' default value"), v);
-		return -1;
-	}
-
-	return -1; /* default value */
-}
-
 int git_config_get_split_index(void)
 {
 	int val;
diff --git a/read-cache.c b/read-cache.c
index 59dbebc15d..7a07286164 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1845,18 +1845,17 @@ static void check_ce_order(struct index_state *istate)
 
 static void tweak_untracked_cache(struct index_state *istate)
 {
-	switch (git_config_get_untracked_cache()) {
-	case -1: /* keep: do nothing */
-		break;
-	case 0: /* false */
+	struct repository *r = the_repository;
+
+	prepare_repo_settings(r);
+
+	if (r->settings.core_untracked_cache  == UNTRACKED_CACHE_REMOVE) {
 		remove_untracked_cache(istate);
-		break;
-	case 1: /* true */
-		add_untracked_cache(istate);
-		break;
-	default: /* unknown value: do nothing */
-		break;
+		return;
 	}
+
+	if (r->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE)
+		add_untracked_cache(istate);
 }
 
 static void tweak_split_index(struct index_state *istate)
diff --git a/repo-settings.c b/repo-settings.c
index d00b675687..abbc6566f8 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -7,6 +7,7 @@
 void prepare_repo_settings(struct repository *r)
 {
 	int value;
+	char *strval;
 
 	if (r->settings.initialized)
 		return;
@@ -23,7 +24,25 @@ void prepare_repo_settings(struct repository *r)
 
 	if (!repo_config_get_bool(r, "index.version", &value))
 		r->settings.index_version = value;
+	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
+		if (value == 0)
+			r->settings.core_untracked_cache = UNTRACKED_CACHE_REMOVE;
+		else
+			r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
+	} else if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
+		if (!strcasecmp(strval, "keep"))
+			r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
+
+		free(strval);
+	}
+
 
 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
 		r->settings.pack_use_sparse = value;
+
+	/* Hack for test programs like test-dump-untracked-cache */
+	if (ignore_untracked_cache_config)
+		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
+	else
+		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
 }
diff --git a/repository.h b/repository.h
index cc285ad327..cf7ff0778c 100644
--- a/repository.h
+++ b/repository.h
@@ -11,6 +11,13 @@ struct pathspec;
 struct raw_object_store;
 struct submodule_cache;
 
+enum untracked_cache_setting {
+	UNTRACKED_CACHE_UNSET = -1,
+	UNTRACKED_CACHE_REMOVE = 0,
+	UNTRACKED_CACHE_KEEP = 1,
+	UNTRACKED_CACHE_WRITE = 2
+};
+
 struct repo_settings {
 	int initialized;
 
@@ -18,6 +25,7 @@ struct repo_settings {
 	int gc_write_commit_graph;
 
 	int index_version;
+	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
 };
-- 
gitgitgadget

