Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5941F462
	for <e@80x24.org>; Thu, 25 Jul 2019 02:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbfGYCXW (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 22:23:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35721 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387955AbfGYCXT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 22:23:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so43215478wmg.0
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 19:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aGy3SlCJoVzMvuvx6qmq2C8aGYmxu6frNL3a/vFmo7c=;
        b=nF5pl4ISGEWvgmvV9/ZDIgLeNjOLjgSaHUoI9GVTEZDIlftPVJ725VKcLVNeRIgsC5
         7qzLqnq7Av/aKIHKAOKn8AvMJFGvhVhnmx+ieyVYtrKs4SN+NnL8l5OdQh16yMLlgztd
         eyU0cmQXj8mVVmp86EalYZQcBimJCXBOyIuIdiKZsAsEbTX77XYpe5qI0XUvqKWEDfO+
         CimQ4z6gMW1K+8LcGX35e6dU/GprzBIOpzuiT44Jq96cOwSfXKC5KxcRYqphRbAbY9p6
         hu3OylJcONpax3y92DybpL2sTcL6LIRl1k6RMOgB3fWvg1q20NIOyIdA2aPtdl2Y4wwN
         RpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aGy3SlCJoVzMvuvx6qmq2C8aGYmxu6frNL3a/vFmo7c=;
        b=YB4C0UHzlGYBRrQpY4162blAee9dMkVrbe6HeAeD4Qn4ETkCIQQyJWzsVmDO7fvWVY
         Vd2Z8EMk4vtG8c5RtQW46tYW+j+YUecWEGszhPTABnq6LOIWWt6lhMameFaSGZZq7ln9
         sE04lh9VqqwMVL8ZkhJVUPZ3tLW1Zme1a00JcLbth6bKrZSbimD7/0j60J1Z5u/mgHlI
         uX8vtwmqsDZLTIP1KWaAun1trfa/QLScAdwzIGapAPsRf6LGWG5DVsl643MYC/fMGTtJ
         pDIfIe8aVBf/+BcnD0r4JyGhmnzcx97EwKVjiCvG0FIv5f7zmK7+piZJ4PDoeRuHTCJp
         herg==
X-Gm-Message-State: APjAAAXvWfs81tyvktOtfQqK/PEkBPfar0AWErid5DiPjRBIqKyUnPoZ
        konzs36awISjG2MyQmp98Wp5bfEj
X-Google-Smtp-Source: APXvYqyCP2nQBgDp9w1kDe7/RhboK/xCk2kBquxW0dSIDV5odN+1eVfTbofnk/fMsg5Bfr79Gc0RWg==
X-Received: by 2002:a1c:968c:: with SMTP id y134mr75207094wmd.75.1564021397015;
        Wed, 24 Jul 2019 19:23:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l25sm36626502wme.13.2019.07.24.19.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 19:23:16 -0700 (PDT)
Date:   Wed, 24 Jul 2019 19:23:16 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 02:23:10 GMT
Message-Id: <49be7a73454b13b04270531eece87a2c6f6d3189.1564021393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v2.git.gitgitgadget@gmail.com>
References: <pull.292.git.gitgitgadget@gmail.com>
        <pull.292.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/5] repo-settings: parse core.untrackedCache
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
 builtin/update-index.c |  7 +++++--
 config.c               | 24 ------------------------
 read-cache.c           | 19 +++++++++----------
 repo-settings.c        | 21 ++++++++++++++++++++-
 repo-settings.h        |  8 ++++++++
 5 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index dff2f4b837..5ced51c1ee 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -18,6 +18,7 @@
 #include "dir.h"
 #include "split-index.h"
 #include "fsmonitor.h"
+#include "repo-settings.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -966,6 +967,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
+	struct repository *r = the_repository;
 	struct option options[] = {
 		OPT_BIT('q', NULL, &refresh_args.flags,
 			N_("continue refresh even when index needs update"),
@@ -1180,11 +1182,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
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
@@ -1196,7 +1199,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
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
index bda665a25a..3761b9a171 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1846,18 +1846,17 @@ static void check_ce_order(struct index_state *istate)
 
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
index 3face7d8b9..65b980403c 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -8,6 +8,7 @@
 void prepare_repo_settings(struct repository *r)
 {
 	int value;
+	char *strval;
 
 	if (r->settings_initialized)
 		return;
@@ -22,14 +23,32 @@ void prepare_repo_settings(struct repository *r)
 
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
-
+	
 	if (!repo_config_get_bool(r, "feature.manycommits", &value) && value) {
 		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
 		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
 	}
 
+	/* Hack for test programs like test-dump-untracked-cache */
+	if (ignore_untracked_cache_config)
+		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
+	else
+		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
+
 	r->settings_initialized = 1;
 }
diff --git a/repo-settings.h b/repo-settings.h
index 89fb0159bf..e9b028e1a9 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -1,11 +1,19 @@
 #ifndef REPO_SETTINGS_H
 #define REPO_SETTINGS_H
 
+enum untracked_cache_setting {
+	UNTRACKED_CACHE_UNSET = -1,
+	UNTRACKED_CACHE_REMOVE = 0,
+	UNTRACKED_CACHE_KEEP = 1,
+	UNTRACKED_CACHE_WRITE = 2
+};
+
 struct repo_settings {
 	int core_commit_graph;
 	int gc_write_commit_graph;
 
 	int index_version;
+	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
 };
-- 
gitgitgadget

