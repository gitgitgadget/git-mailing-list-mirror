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
	by dcvr.yhbt.net (Postfix) with ESMTP id 725531F461
	for <e@80x24.org>; Mon, 22 Jul 2019 17:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfGVRy0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 13:54:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36459 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbfGVRyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 13:54:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so40412107wrs.3
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cAGj2SILeukP1zWnHYfnE/NiEH9e5YIRIFumRegH+qE=;
        b=CxzD/FiiT2eSjfkJru6E9KF13DRD8raq7pv38PQMa6j/07+MB6wgRDhwvvMzsNby5q
         B5S+bqwNm+giz2IegAefwO2faFdFW+D9pymV6SpvrvVo1Toi7FjKeyLwV10dzOG/y5TH
         oRDlGQh6/N+viLUbhKmEXjlqxhfsTTCOcxnQS+G+82nzGU5uvyxsy+EgoTykLY8uw/GV
         zoWEy/zxiT13UGsYYSCUcvI4IYq26/nXZei4Ua8PTtlopnQpJkWJ+kElFL7T7tp5OdGg
         HQYmiW0NslxG1Kmg5nSfikUsotOifM0K7242JRU6UmtVe4qYum+3i4e2VB30MJDPcJXw
         Yp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cAGj2SILeukP1zWnHYfnE/NiEH9e5YIRIFumRegH+qE=;
        b=dMhC/WPTKEdqwn43U+fcead6XNN/6msYVpovQqBSR37C9GM8ko5W0XZM+x1xjxoEWW
         UqnjkwSatBqOj2JMqmelUUqFbL+TmcNWsjsF4pwgOHNQqIdmF3+C7UvOMEVpuOXRnOfb
         TVX+dpzJUXJR/RY90BVRDRLKxDpK0UQX6jxyymJsGNNL5zUhdVl8DuQFBf5ekIsyPt3u
         dApStSROF/FTGDEeLfvC6qxiup2m0Ean2+xc+4R8x7sNnI5OAnYi5rlLAgZmq3c5m2rp
         XoIJrxZYpf89Cy7RkdInxkGZ2QgceB8qDskdGb0KgQLt73NXC2C/1ss5jps/nVI1K/Hj
         UOJw==
X-Gm-Message-State: APjAAAUXE231RNnmQF7ZDpIOVnUwVC9+OExVQHI3BIOr35CgHUDsmE4E
        p5Q5PYZbeHAkI+PrrmCmWP4Oqrbv
X-Google-Smtp-Source: APXvYqzMtZ+36UL10ijLkVPCp/kaQ15u25AfUcBWS5KsDiN+Q2nzvvRUG9ET3Xb5g21cZbz7jMj8EQ==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr75575674wrn.37.1563818063733;
        Mon, 22 Jul 2019 10:54:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f204sm59164089wme.18.2019.07.22.10.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 10:54:23 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:54:23 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Jul 2019 17:54:17 GMT
Message-Id: <47ae3e7d4d765a00d14e8892db88a8936d56591b.1563818059.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.git.gitgitgadget@gmail.com>
References: <pull.292.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/5] repo-settings: parse core.untrackedCache
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
options into bitflags CORE_UNTRACKED_CACHE_KEEP and
CORE_UNTRACKED_CACHE_WRITE. This allows the use of "-1" as a
default value. After parsing the config options, if the value is
unset we can initialize it to CORE_UNTRACKED_CACHE_KEEP.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c |  7 +++++--
 config.c               | 24 ------------------------
 read-cache.c           | 19 +++++++++----------
 repo-settings.c        | 21 +++++++++++++++++++++
 repo-settings.h        |  4 ++++
 5 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index dff2f4b837..6c26bbae80 100644
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
+		if (r->settings->core_untracked_cache & CORE_UNTRACKED_CACHE_WRITE)
 			warning(_("core.untrackedCache is set to true; "
 				  "remove or change it, if you really want to "
 				  "disable the untracked cache"));
@@ -1196,7 +1199,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		return !test_if_untracked_cache_is_supported();
 	case UC_ENABLE:
 	case UC_FORCE:
-		if (git_config_get_untracked_cache() == 0)
+		if (r->settings->core_untracked_cache == 0)
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
index ee1aaa8917..e67e6f6e3e 100644
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
+	if (!(r->settings->core_untracked_cache & CORE_UNTRACKED_CACHE_KEEP)) {
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
+	if (r->settings->core_untracked_cache & CORE_UNTRACKED_CACHE_WRITE)
+		add_untracked_cache(istate);
 }
 
 static void tweak_split_index(struct index_state *istate)
diff --git a/repo-settings.c b/repo-settings.c
index f328602fd7..807c5a29d6 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -30,6 +30,20 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		rs->index_version = git_config_int(key, value);
 		return 0;
 	}
+	if (!strcmp(key, "core.untrackedcache")) {
+		int bool_value = git_parse_maybe_bool(value);
+		if (bool_value == 0)
+			rs->core_untracked_cache = 0;
+		else if (bool_value == 1)
+			rs->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP |
+						   CORE_UNTRACKED_CACHE_WRITE;
+		else if (!strcasecmp(value, "keep"))
+			rs->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP;
+		else
+			error(_("unknown core.untrackedCache value '%s'; "
+				"using 'keep' default value"), value);
+		return 0;
+	}
 
 	return 1;
 }
@@ -46,6 +60,13 @@ void prepare_repo_settings(struct repository *r)
 	r->settings->gc_write_commit_graph = -1;
 	r->settings->pack_use_sparse = -1;
 	r->settings->index_version = -1;
+	r->settings->core_untracked_cache = -1;
 
 	repo_config(r, git_repo_config, r->settings);
+
+	/* Hack for test programs like test-dump-untracked-cache */
+	if (ignore_untracked_cache_config)
+		r->settings->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP;
+	else
+		UPDATE_DEFAULT(r->settings->core_untracked_cache, CORE_UNTRACKED_CACHE_KEEP);
 }
diff --git a/repo-settings.h b/repo-settings.h
index 1151c2193a..bac9b87d49 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -1,11 +1,15 @@
 #ifndef REPO_SETTINGS_H
 #define REPO_SETTINGS_H
 
+#define CORE_UNTRACKED_CACHE_WRITE (1 << 0)
+#define CORE_UNTRACKED_CACHE_KEEP (1 << 1)
+
 struct repo_settings {
 	int core_commit_graph;
 	int gc_write_commit_graph;
 	int pack_use_sparse;
 	int index_version;
+	int core_untracked_cache;
 };
 
 struct repository;
-- 
gitgitgadget

