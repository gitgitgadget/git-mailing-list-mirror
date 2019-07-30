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
	by dcvr.yhbt.net (Postfix) with ESMTP id 274131F462
	for <e@80x24.org>; Tue, 30 Jul 2019 19:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfG3Tfk (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 15:35:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53838 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfG3Tfb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 15:35:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so58300485wmj.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8XkXzA9ZfvUy5yeF3341NXAaeUjfPJdRYWgQlX/0pP8=;
        b=YRsg6/sq1DqSnljjXjc4EmylemiPwv7OD8Vm/jMHX8aDnKumzxw/cD8aoaLzssF+BM
         SWRBrB0I9EB/rQeW3VtPPShxt4278uDmZZFij1epV6S06guCrMT9OuzBK3gy1NPa0lPl
         v3Ynixz5Tlu4/qkFYWIzCkx+uxnqTGEApXIY1qrgvqOYoQPLtKKBHYYqT7XdauhdSP6G
         BIkUkKS475apvT4xW5vugkVOqDz4CuwWfGZAwrH4Ef5cqv2Y/572xMydUwUyC1i5hbQG
         K4EtjcDVWA8zn3wq5Q/hPyGen8GIiaJjE7IiU02w9bkrvHiUy7iLfW4SaLFdpEyCpku7
         vMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8XkXzA9ZfvUy5yeF3341NXAaeUjfPJdRYWgQlX/0pP8=;
        b=OevdEsDIfokXZ3skPKPZkbaIhAgeM2jsB/CMHPS8FpanWEJmNiNsZ9dv1ERUDec0nH
         yR9lnIERyXSIh13RpXD53JWydt9M/2AwW77ILSsJTgC0Pjqz6MDWKtL7vdKQyU3rIAAj
         m5tnw7gjOzDhnQaEkQVcfVlkTWaXcgtP6+QIgH/99IoD07PQn0axI21u68alE2uSanpO
         6Eybq5R628cdrDAMRH79t4zcSkrE7Zf9tQGZnfZr6tQ9O+CN/0zOziQDvB7p909jHHDG
         ngFPH2vHile/Gw9I5n5VaDH19ZMppFf8QMWKizIRECw8TLPdZDXoS6W61bN7EbFWu0VU
         XwVw==
X-Gm-Message-State: APjAAAWztDjSYEj5Eo1Eci8t9ijdMOCCYb05TSwXJJb4HEkhSSM3GC/v
        1NkpNRdI/XVYhjilQMrh6vrHFMHS
X-Google-Smtp-Source: APXvYqzz891tlxummZya8+D7uc8iVzzCsR8/apme8Dj5OatMOhRWgwh5yzF0Go4oxI7AHiaTNFlN6g==
X-Received: by 2002:a1c:b146:: with SMTP id a67mr103883079wmf.124.1564515328475;
        Tue, 30 Jul 2019 12:35:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm49919357wma.32.2019.07.30.12.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:35:28 -0700 (PDT)
Date:   Tue, 30 Jul 2019 12:35:28 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Jul 2019 19:35:22 GMT
Message-Id: <b0a2d0e18800da01ab1b17faca34eb011fb36128.1564515324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v3.git.gitgitgadget@gmail.com>
References: <pull.292.v2.git.gitgitgadget@gmail.com>
        <pull.292.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/5] repo-settings: parse core.untrackedCache
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
 repo-settings.c        | 22 +++++++++++++++++++++-
 repository.h           |  8 ++++++++
 5 files changed, 42 insertions(+), 37 deletions(-)

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
index fc05f4fbc4..9ed83e6e54 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -7,6 +7,7 @@
 void prepare_repo_settings(struct repository *r)
 {
 	int value;
+	char *strval;
 
 	if (r->settings.initialized)
 		return;
@@ -21,12 +22,31 @@ void prepare_repo_settings(struct repository *r)
 
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
+
+	/* Hack for test programs like test-dump-untracked-cache */
+	if (ignore_untracked_cache_config)
+		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
+	else
+		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
+
 }
diff --git a/repository.h b/repository.h
index 2bb2bc3eea..e7a72e2341 100644
--- a/repository.h
+++ b/repository.h
@@ -12,6 +12,13 @@ struct pathspec;
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
 
@@ -19,6 +26,7 @@ struct repo_settings {
 	int gc_write_commit_graph;
 
 	int index_version;
+	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
 };
-- 
gitgitgadget

