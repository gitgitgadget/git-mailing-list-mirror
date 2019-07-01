Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F861F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfGAO3O (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:29:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33771 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfGAO3N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:29:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so23915786edq.0
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=okTxm3376l84beovuYB6XiL2jlqvSbhc4E8hABk1kXk=;
        b=bHAGZpn+ovIGZNblgdkGFMJ0DTXLatrwJkhrQFTsLc0fZmaOP2s85ecdWJ+vWa+x7N
         BRU/23oXWlb1WwqkTynmuoJaFsqsT4vFzgOod8L6qN0ybVsu2xzUUFImXne3DnEgK+T/
         TlXTgYKZdWJfAZDrjuPevNPW31XbJfDBr5pj96KGzSGNyXEAFfXt2srC6kUQaPuKbxQk
         uJ5Xy+D+7UXmExydtaKSR2GhbpOVCvyTw0bKoh5QzRVQ6H6oqvuaS8Z0N2tYiF/8Yjoq
         jbebp/VJRZ1OjTuwcZ7a0VMoSKyMk1zzxID0hGWKg+CsGmlc+koxPOOfwQjc8vOKX7uW
         dvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=okTxm3376l84beovuYB6XiL2jlqvSbhc4E8hABk1kXk=;
        b=Gvc7VWYWGutoAh+PLOGXraTaWU8t72zV+abSQTu6RuIkexgKq5RWxIUThPg9DgrRwJ
         Xwsh+ptTZxjWgyWIvX2ac9Cp8IwvfHXoepHbe8vpJTJoLCfLFrcmdJsO1o5v/wll/W9H
         TnLareEVXPwVW8iPUIPiktkmlLbIhHC1pUtBm8yie0tPuWbJIsV/kwroMIdiLyltyO3J
         yzl8k9VhzRp6NrkplgE1vGlzIPWTSNcQ3C97OZiSEpH1WRd5S79Ag759daVwvvYwCA59
         mC/4Ih6IzgGny/hqD8ztczgUc8LZWJ1ceN38C8Mjy4jIFdkxnJj9uu8mbCtJDdHEZXyZ
         jU0Q==
X-Gm-Message-State: APjAAAWcci0bnoHszMdCoSrcck+nDhCrWvrvNbovOKBX8RHBF6+LPsuR
        4ZwcAJFo+GZXdfU2N1lT6sCYc+dC
X-Google-Smtp-Source: APXvYqz9o8gQVEqH3PjyAzwK3SSQ7zM7okwiD1B72ABKv/8S+455ZHDfqvDTl8lYNRguDc0D5mWDrg==
X-Received: by 2002:a50:8ba6:: with SMTP id m35mr29513246edm.199.1561991351135;
        Mon, 01 Jul 2019 07:29:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18sm3787100ede.65.2019.07.01.07.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:29:10 -0700 (PDT)
Date:   Mon, 01 Jul 2019 07:29:10 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 14:29:06 GMT
Message-Id: <4fe896e423b698ef60b208c613252b4847b6cd0a.1561991348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.v3.git.gitgitgadget@gmail.com>
References: <pull.254.v2.git.gitgitgadget@gmail.com>
        <pull.254.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/3] repo-settings: use index.version=4 by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a repo is large, it likely has many paths in its working directory.
This means the index could be compressed using version 4. Set this as
a default when core.featureAdoptionRate is at least three.

Since the index version is written to a file, this is an excellent
opportunity to test that the config settings are working correctly
with the different precedence rules. Adapt a test from t1600-index.sh
to verify the version is set properly with different values of
index.version config, core.featureAdoptionRate, and GIT_INDEX_VERSION.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt  |  3 +++
 Documentation/config/index.txt |  2 ++
 read-cache.c                   | 12 +++++++-----
 repo-settings.c                |  6 ++++++
 repo-settings.h                |  1 +
 t/t1600-index.sh               | 34 +++++++++++++++++++++++++++++-----
 6 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index bfe647c76f..865252aba9 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -621,3 +621,6 @@ The settings do not modify the user-facing output of porcelain commands.
 +
 * `gc.writeCommitGraph=true` eneables writing commit-graph files during
 `git gc`.
++
+* `index.version=4` uses prefix-compression to reduce the size of the
+.git/index file.
diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index f181503041..98a88c30be 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -24,3 +24,5 @@ index.threads::
 index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
+	If `core.featureAdoptionRate` is at least three, then the
+	default value is 4.
diff --git a/read-cache.c b/read-cache.c
index 22e7b9944e..7fab8ff748 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "repo-settings.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1599,16 +1600,17 @@ struct cache_entry *refresh_cache_entry(struct index_state *istate,
 
 #define INDEX_FORMAT_DEFAULT 3
 
-static unsigned int get_index_format_default(void)
+static unsigned int get_index_format_default(struct repository *r)
 {
 	char *envversion = getenv("GIT_INDEX_VERSION");
 	char *endp;
-	int value;
 	unsigned int version = INDEX_FORMAT_DEFAULT;
 
 	if (!envversion) {
-		if (!git_config_get_int("index.version", &value))
-			version = value;
+		prepare_repo_settings(r);
+
+		if (r->settings->index_version >= 0)
+			version = r->settings->index_version;
 		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
 			warning(_("index.version set, but the value is invalid.\n"
 				  "Using version %i"), INDEX_FORMAT_DEFAULT);
@@ -2765,7 +2767,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	}
 
 	if (!istate->version) {
-		istate->version = get_index_format_default();
+		istate->version = get_index_format_default(the_repository);
 		if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0))
 			init_split_index(istate);
 	}
diff --git a/repo-settings.c b/repo-settings.c
index f7fc2a1959..5753153a84 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -14,6 +14,7 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		if (rate >= 3) {
 			UPDATE_DEFAULT(rs->core_commit_graph, 1);
 			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
+			UPDATE_DEFAULT(rs->index_version, 4);
 		}
 		return 0;
 	}
@@ -25,6 +26,10 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		rs->gc_write_commit_graph = git_config_bool(key, value);
 		return 0;
 	}
+	if (!strcmp(key, "index.version")) {
+		rs->index_version = git_config_int(key, value);
+		return 0;
+	}
 
 	return 1;
 }
@@ -39,6 +44,7 @@ void prepare_repo_settings(struct repository *r)
 	/* Defaults */
 	r->settings->core_commit_graph = -1;
 	r->settings->gc_write_commit_graph = -1;
+	r->settings->index_version = -1;
 
 	repo_config(r, git_repo_config, r->settings);
 }
diff --git a/repo-settings.h b/repo-settings.h
index 7d44627bf0..b752dfe8b4 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -4,6 +4,7 @@
 struct repo_settings {
 	int core_commit_graph;
 	int gc_write_commit_graph;
+	int index_version;
 };
 
 struct repository;
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 42962ed7d4..74f56e2769 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -59,17 +59,41 @@ test_expect_success 'out of bounds index.version issues warning' '
 	)
 '
 
-test_expect_success 'GIT_INDEX_VERSION takes precedence over config' '
+test_index_version () {
+	INDEX_VERSION_CONFIG=$1 &&
+	REPO_ADOPTION_RATE=$2 &&
+	ENV_VAR_VERSION=$3
+	EXPECTED_OUTPUT_VERSION=$4 &&
 	(
 		rm -f .git/index &&
-		GIT_INDEX_VERSION=4 &&
-		export GIT_INDEX_VERSION &&
-		git config --add index.version 2 &&
+		rm -f .git/config &&
+		if test "$INDEX_VERSION_CONFIG" -ne 0
+		then
+			git config --add index.version $INDEX_VERSION_CONFIG
+		fi &&
+		if test "$REPO_ADOPTION_RATE" -ne 0
+		then
+			git config --add core.featureAdoptionRate $REPO_ADOPTION_RATE
+		fi &&
+		if test "$ENV_VAR_VERSION" -ne 0
+		then
+			GIT_INDEX_VERSION=$ENV_VAR_VERSION &&
+			export GIT_INDEX_VERSION
+		else
+			unset GIT_INDEX_VERSION
+		fi &&
 		git add a 2>&1 &&
-		echo 4 >expect &&
+		echo $EXPECTED_OUTPUT_VERSION >expect &&
 		test-tool index-version <.git/index >actual &&
 		test_cmp expect actual
 	)
+}
+
+test_expect_success 'index version config precedence' '
+	test_index_version 2 0 4 4 &&
+	test_index_version 2 3 0 2 &&
+	test_index_version 0 3 0 4 &&
+	test_index_version 0 3 2 2
 '
 
 test_done
-- 
gitgitgadget

