Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637FC1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 12:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeH2Qpw (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 12:45:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39507 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeH2Qpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 12:45:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id g20-v6so2281847pgv.6
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=giSu3TItuWNpLcrj5dJWjXod5ttMQ5QowmWcAarlMMs=;
        b=HwyUT1EOuPd7nHgUubYd1MT+l9f9SCtZTlXGH+4J7xYBJZFEAmTW4CPrUKtA2ZCFJc
         9euuxnJy2Tgndvt79S3RIZZZMkqETzHO5YCbgStMcgwGggT/pXmdOMBoOWvwAjIKnXsn
         qjVNF/hxe6/X2hbFuKSm4HwfAt7H2bD/kbxzzHeAZAweALLLPZKoQs78jhGamtzf36LS
         wvsc9Wo/4G4DBxvBqmXTE9wgv6cTHeYqY05x0uyIXWuqlo1JqG2cLsLa/HsT6WCHirjn
         HvpZ3XRknwvKFeDDowU6K2cXaIzUcW47jNWLgQUGxbvrA/R4CxtQW6kaJOmXhsmP3SNM
         JCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=giSu3TItuWNpLcrj5dJWjXod5ttMQ5QowmWcAarlMMs=;
        b=lmi4gXo3eCwuBK9fih7hIPRTvF9a0BJgS1p3Ax33xAa6tbnpF8KMec55WCBdqtfycn
         ++fYjkYMtKDzIYtaOk/ypiOmH+CH01crUDt4sicsJ9AUZdvhqc1CIFUzJaFH7NbWMAqJ
         y51f9XOLBKDETjEoikMOxOekv4fQiE63gMyh5QAnygZvt2n+QVzvh0Uu8IxQT1hdZ6rK
         7T8/zcbyiyBqRg2xy2BVy8Wt+5+O9oMP66k3iycEo8nLggOF4NsXKuV+iUQBiklbhzP0
         TijYeZXbXQwSaIjKvame3RvcBbtKhwjYMNBVUcZrEt5PitQksYN8YYVvi9uIpoJ9v+0s
         VaYQ==
X-Gm-Message-State: APzg51BKMh2yvOd2DQa3DCDLdZ+SdkJjbE8AHkXhpXJuYTDiErfRFwVx
        OxZSKBstU6r1p9rEUADw4RqogN5q
X-Google-Smtp-Source: ANB0VdajKOIipKWBOgNVolbpi7ZqW0/pAzBJY8+nDHANRp3bLAagWmd5Du8MDePs0Lnd91V8ErN7dQ==
X-Received: by 2002:a62:8acd:: with SMTP id o74-v6mr5864770pfk.12.1535546944866;
        Wed, 29 Aug 2018 05:49:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id d9-v6sm12079543pfb.86.2018.08.29.05.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:49:04 -0700 (PDT)
Date:   Wed, 29 Aug 2018 05:49:04 -0700 (PDT)
X-Google-Original-Date: Wed, 29 Aug 2018 12:49:00 GMT
Message-Id: <4ff6695c7e9bea7f6033f5e124d940f189e290ac.1535546941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.26.v2.git.gitgitgadget@gmail.com>
References: <pull.26.git.gitgitgadget@gmail.com>
        <pull.26.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] commit-graph: define GIT_TEST_COMMIT_GRAPH
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph feature is tested in isolation by
t5318-commit-graph.sh and t6600-test-reach.sh, but there are many
more interesting scenarios involving commit walks. Many of these
scenarios are covered by the existing test suite, but we need to
maintain coverage when the optional commit-graph structure is not
present.

To allow running the full test suite with the commit-graph present,
add a new test environment variable, GIT_TEST_COMMIT_GRAPH. Similar
to GIT_TEST_SPLIT_INDEX, this variable makes every Git command try
to load the commit-graph when parsing commits, and writes the
commit-graph file after every 'git commit' command.

There are a few tests that rely on commits not existing in
pack-files to trigger important events, so manually set
GIT_TEST_COMMIT_GRAPH to false for the necessary commands.

There is one test in t6024-recursive-merge.sh that relies on the
merge-base algorithm picking one of two ambiguous merge-bases, and
the commit-graph feature changes which merge-base is picked.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c                    | 4 ++++
 commit-graph.c                      | 5 +++--
 commit-graph.h                      | 2 ++
 t/README                            | 4 ++++
 t/t0410-partial-clone.sh            | 2 +-
 t/t5307-pack-missing-commit.sh      | 4 ++--
 t/t6011-rev-list-with-bad-commit.sh | 7 +++----
 t/t6024-recursive-merge.sh          | 6 +++---
 8 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 158e3f843a..a25e652102 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -33,6 +33,7 @@
 #include "sequencer.h"
 #include "mailmap.h"
 #include "help.h"
+#include "commit-graph.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -1651,6 +1652,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		     "new_index file. Check that disk is not full and quota is\n"
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
 
+	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
+		write_commit_graph_reachable(get_object_directory(), 0);
+
 	rerere(0);
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
diff --git a/commit-graph.c b/commit-graph.c
index 4bd1a4abbf..5cae83fe03 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -237,8 +237,9 @@ static int prepare_commit_graph(struct repository *r)
 		return !!r->objects->commit_graph;
 	r->objects->commit_graph_attempted = 1;
 
-	if (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
-	    !config_value)
+	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
+	    (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
+	    !config_value))
 		/*
 		 * This repository is not configured to use commit graphs, so
 		 * do not load one. (But report commit_graph_attempted anyway
diff --git a/commit-graph.h b/commit-graph.h
index 13d736cdde..cf9141f356 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -5,6 +5,8 @@
 #include "repository.h"
 #include "string-list.h"
 
+#define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
+
 struct commit;
 
 char *get_commit_graph_filename(const char *obj_dir);
diff --git a/t/README b/t/README
index 8373a27fea..2b90c433f5 100644
--- a/t/README
+++ b/t/README
@@ -315,6 +315,10 @@ packs on demand. This normally only happens when the object size is
 over 2GB. This variable forces the code path on any object larger than
 <n> bytes.
 
+GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
+be written after every 'git commit' command, and overrides the
+'core.commitGraph' setting to true.
+
 Naming Tests
 ------------
 
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 4984ca583d..73d5284a91 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -181,7 +181,7 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
-	git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
+	GIT_TEST_COMMIT_GRAPH=0 git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
 	grep $(git -C repo rev-parse bar) out &&
 	! grep $FOO out
 '
diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit.sh
index ae52a1882d..dacb440b27 100755
--- a/t/t5307-pack-missing-commit.sh
+++ b/t/t5307-pack-missing-commit.sh
@@ -24,11 +24,11 @@ test_expect_success 'check corruption' '
 '
 
 test_expect_success 'rev-list notices corruption (1)' '
-	test_must_fail git rev-list HEAD
+	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git rev-list HEAD
 '
 
 test_expect_success 'rev-list notices corruption (2)' '
-	test_must_fail git rev-list --objects HEAD
+	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git rev-list --objects HEAD
 '
 
 test_expect_success 'pack-objects notices corruption' '
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index e51eb41f4b..545b461e51 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -41,10 +41,9 @@ test_expect_success 'corrupt second commit object' \
    test_must_fail git fsck --full
    '
 
-test_expect_success 'rev-list should fail' \
-   '
-   test_must_fail git rev-list --all > /dev/null
-   '
+test_expect_success 'rev-list should fail' '
+	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git rev-list --all > /dev/null
+'
 
 test_expect_success 'git repack _MUST_ fail' \
    '
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 3f59e58dfb..27c7de90ce 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -60,9 +60,9 @@ git update-index a1 &&
 GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
 '
 
-test_expect_success "combined merge conflicts" "
-	test_must_fail git merge -m final G
-"
+test_expect_success 'combined merge conflicts' '
+	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git merge -m final G
+'
 
 cat > expect << EOF
 <<<<<<< HEAD
-- 
gitgitgadget
