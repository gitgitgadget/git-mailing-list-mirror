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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF151F461
	for <e@80x24.org>; Tue,  3 Sep 2019 02:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfICCWF (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 22:22:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32984 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfICCWE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 22:22:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so15671309wrr.0
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 19:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hfqy+ghZ4SK62xybNYVsMEybfPqz6iR5gD31uWfh2Jo=;
        b=AaRTTm56/roSPk6LmOzfk+ibeF0NtG71p0TeRmgiJkjGArYkXoZQier7mHFlpFTh+X
         xJqhiaCznDUYX14ynvTbOouF/W98d0+AkItC0nH4yT71PTC+3b1NS5ARJEtHKK059s0L
         8Lz/0SUPy+UKM/qWHvr9XQoAE7X+CgLrQxzwhNb3lr10vD7R+BQoq8I2Qc5hGjGJPGFo
         KYcR0crD/UX3/Su8m2jqiwvuR0gGl4pyx0HLCkAnoqyvKYblZ8Gl/RjavxbZtFTxlwPe
         B0bK7+xoMACC2idk+gmTqcs29pwixB9VwvdrHsEotU9MjEpRjJV5zS7UAlPNEIgoXWpZ
         ojxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hfqy+ghZ4SK62xybNYVsMEybfPqz6iR5gD31uWfh2Jo=;
        b=uHIGPTExW7gHL/QpgWpur4czZx3Scr6Tg+qY3vnude7gk/zH4DF/tQEUVwbSYwa3H7
         NJC7OopqndcTkr9wuDxZvicEQH0bfXsunvkBwTIn2o3Flu/R0THXUc1Pf6OAUeVjVz1+
         IJSW0APQ0l2LwVAhsAJ3XfRF8+C+Jc88QDcj9LIUwAR5/WP6LVyC+DAcGjbtQPXekpUp
         7+22Rmh786cwLXC2d6w/SGSFalHkc0zeAIQAHtH9bJzEKaMdnybuJ478s1XREfZXC7pP
         JrGqEYibT6H9nyw1QMRc74El85ugeE+zaY1NjhFXIaEaNyX9xL2WOWw4SQNOWvcy0rZh
         3rig==
X-Gm-Message-State: APjAAAVGeDi+tKxMzWNmNK7AB+5cAAOb3MT1kGooldVINatsME5ovm37
        iu3Oo9Yv2U4cDE2ZHJftEx7I/VwE
X-Google-Smtp-Source: APXvYqyABTm1zZNFvdn1tr+bA4TbHUz4WGFpyFNyR13GJES5Pcu0QhibJ3wjgrV5znXTd92cdzDPlA==
X-Received: by 2002:adf:db47:: with SMTP id f7mr14530769wrj.1.1567477322612;
        Mon, 02 Sep 2019 19:22:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h32sm21095807wrh.62.2019.09.02.19.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 19:22:02 -0700 (PDT)
Date:   Mon, 02 Sep 2019 19:22:02 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Sep 2019 02:22:00 GMT
Message-Id: <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.328.git.gitgitgadget@gmail.com>
References: <pull.328.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, garimasigit@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph feature is now on by default, and is being
written during 'git gc' by default. Typically, Git only writes
a commit-graph when a 'git gc --auto' command passes the gc.auto
setting to actualy do work. This means that a commit-graph will
typically fall behind the commits that are being used every day.

To stay updated with the latest commits, add a step to 'git
fetch' to write a commit-graph after fetching new objects. The
fetch.writeCommitGraph config setting enables writing a split
commit-graph, so on average the cost of writing this file is
very small. Occasionally, the commit-graph chain will collapse
to a single level, and this could be slow for very large repos.

For additional use, adjust the default to be true when
feature.experimental is enabled.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/feature.txt |  8 ++++++++
 Documentation/config/fetch.txt   | 10 ++++++++++
 builtin/fetch.c                  | 15 +++++++++++++++
 repo-settings.c                  |  4 ++++
 repository.h                     |  1 +
 t/t5510-fetch.sh                 | 13 +++++++++++++
 6 files changed, 51 insertions(+)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index 545522f306..875f8c8a66 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -17,6 +17,14 @@ which can improve `git push` performance in repos with many files.
 +
 * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
 skipping more commits at a time, reducing the number of round trips.
++
+* `fetch.writeCommitGraph=true` writes a commit-graph after every `git fetch`
+command that downloads a pack-file from a remote. Using the `--split` option,
+most executions will create a very small commit-graph file on top of the
+existing commit-graph file(s). Occasionally, these files will merge and the
+write may take longer. Having an updated commit-graph file helps performance
+of many Git commands, including `git merge-base`, `git push -f`, and
+`git log --graph`.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index d402110638..e8cb20547c 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -69,3 +69,13 @@ fetch.showForcedUpdates::
 	Set to false to enable `--no-show-forced-updates` in
 	linkgit:git-fetch[1] and linkgit:git-pull[1] commands.
 	Defaults to true.
+
+fetch.writeCommitGraph::
+	Set to true to write a commit-graph after every `git fetch` command
+	that downloads a pack-file from a remote. Using the `--split` option,
+	most executions will create a very small commit-graph file on top of
+	the existing commit-graph file(s). Occasionally, these files will
+	merge and the write may take longer. Having an updated commit-graph
+	file helps performance of many Git commands, including `git merge-base`,
+	`git push -f`, and `git log --graph`. Defaults to false, unless
+	`feature.experimental` is true.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 53ce99d2bb..d36a403859 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -23,6 +23,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
+#include "commit-graph.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -1715,6 +1716,20 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	string_list_clear(&list, 0);
 
+	prepare_repo_settings(the_repository);
+	if (the_repository->settings.fetch_write_commit_graph) {
+		int commit_graph_flags = COMMIT_GRAPH_SPLIT;
+		struct split_commit_graph_opts split_opts;
+		memset(&split_opts, 0, sizeof(struct split_commit_graph_opts));
+
+		if (progress)
+			commit_graph_flags |= COMMIT_GRAPH_PROGRESS;
+
+		write_commit_graph_reachable(get_object_directory(),
+					     commit_graph_flags,
+					     &split_opts);
+	}
+
 	close_object_store(the_repository->objects);
 
 	if (enable_auto_gc) {
diff --git a/repo-settings.c b/repo-settings.c
index 3779b85c17..05546db98e 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -49,10 +49,14 @@ void prepare_repo_settings(struct repository *r)
 		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
 	}
+	if (!repo_config_get_bool(r, "fetch.writecommitgraph", &value))
+		r->settings.fetch_write_commit_graph = value;
 	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
 		UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
 		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
+		UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);
 	}
+	UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 0);
 
 	/* Hack for test programs like test-dump-untracked-cache */
 	if (ignore_untracked_cache_config)
diff --git a/repository.h b/repository.h
index 4da275e73f..fe0b5f5dc6 100644
--- a/repository.h
+++ b/repository.h
@@ -30,6 +30,7 @@ struct repo_settings {
 
 	int core_commit_graph;
 	int gc_write_commit_graph;
+	int fetch_write_commit_graph;
 
 	int index_version;
 	enum untracked_cache_setting core_untracked_cache;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 139f7106f7..91ede622f0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -570,6 +570,19 @@ test_expect_success 'LHS of refspec follows ref disambiguation rules' '
 	)
 '
 
+test_expect_success 'fetch.writeCommitGraph' '
+	git clone three write &&
+	(
+		cd three &&
+		test_commit new
+	) &&
+	(
+		cd write &&
+		git -c fetch.writeCommitGraph fetch origin &&
+		test_path_is_file .git/objects/info/commit-graphs/commit-graph-chain
+	)
+'
+
 # configured prune tests
 
 set_config_tristate () {
-- 
gitgitgadget
