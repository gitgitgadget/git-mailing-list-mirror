Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94431F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbfFGSib (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46484 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731848AbfFGSia (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id h10so4290855edi.13
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hJCfoiqNpXoktswGUiw8XTcxbNGP7WGt3EcsUOiq/rU=;
        b=gizchxluB10HTuKfGR/UaglZXYAu8QmSOIVUPItqKEHEsIQWQF+Ft5pcqdahEFnjiD
         9D/1vsRzuQNpkxp7yKdMN7e+AFx2i1tuNIZchuH9b5TuSvlSM7ZDWuEV0Nr5qW6YMr21
         2XB5NfgL3CKbmM9OtlVa+vUTM5mOhA03lF0GyT5paPm+wXSMlDj16PYNYYvxQXqDXanl
         Krv1LdasSz0wdj3sQpMG74urzUsxDUUW8ReHEbfJ6bY60VUyrde1XXx8ZeK/nKMDWqDZ
         qXFxTDpHSanf5DRUf5TC8PVvL03wXSWZ2GYVIrAVu3wIUbfsi/V7CZGqJf2R9SQ+NDWR
         Ouug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hJCfoiqNpXoktswGUiw8XTcxbNGP7WGt3EcsUOiq/rU=;
        b=SfsR27ktw5S3skrmuYUyc2Ulzj/yeAzdkmsErTrt7Ev3joJlRHRn9oCneSsYh+mh3+
         U4vz5mRn6CnBNFRfy9qhi2W+d75vR/1Fr0q1HBKLlUNDkOTy1f06fazM54ByP2hL8VjZ
         rrD+MojRZTh2QxIM5FPzwOtvOEGJiBPLsklswEnJaIvRj76Jvz/h43O8JCxdVzO//zqJ
         iXRSAu92XXTaltJ76ByhUyvIHcTkoDIsvlOZYphFFIpOPP3QslSfoRR0PlgqKsjTCJJf
         NzWOm9uSqvPjZimr/L3SmDBcvUysFschZ454nAPC5Wd2xpN4z7IkPkta0ErY2F4gOBXS
         QI8Q==
X-Gm-Message-State: APjAAAUAGUn+h4qxVE1Atj06y66dFPgml3rnYi2kn2WOGmVoaPPYQaxI
        lVH98M1JbTdv8ok4Xxrk70FglXTK
X-Google-Smtp-Source: APXvYqzg88/gZLAvKUQD5J5gPoIIkAdq2YNe2ULOeoJbACBVn4xq9t9K/ZSRJFw0djLQtBz9ezhd2g==
X-Received: by 2002:a17:906:37c2:: with SMTP id o2mr18991479ejc.209.1559932707183;
        Fri, 07 Jun 2019 11:38:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x22sm713656edd.59.2019.06.07.11.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:26 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:26 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:11 GMT
Message-Id: <a0330ebd2d9889b2fe1352cb232ac2652d32ac5d.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 08/16] commit-graph: add --split option to builtin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a new "--split" option to the 'git commit-graph write' subcommand. This
option allows the optional behavior of writing a commit-graph chain.

The current behavior will add a tip commit-graph containing any commits that
are not in the existing commit-graph or commit-graph chain. Later changes
will allow merging the chain and expiring out-dated files.

Add a new test script (t5324-split-commit-graph.sh) that demonstrates this
behavior.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c        |  10 ++-
 commit-graph.c                |  14 ++--
 t/t5324-split-commit-graph.sh | 122 ++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 8 deletions(-)
 create mode 100755 t/t5324-split-commit-graph.sh

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 828b1a713f..c2c07d3917 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,7 +10,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph verify [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -25,7 +25,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -35,9 +35,9 @@ static struct opts_commit_graph {
 	int stdin_packs;
 	int stdin_commits;
 	int append;
+	int split;
 } opts;
 
-
 static int graph_verify(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
@@ -156,6 +156,8 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_BOOL(0, "split", &opts.split,
+			N_("allow writing an incremental commit-graph file")),
 		OPT_END(),
 	};
 
@@ -169,6 +171,8 @@ static int graph_write(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 	if (opts.append)
 		flags |= COMMIT_GRAPH_APPEND;
+	if (opts.split)
+		flags |= COMMIT_GRAPH_SPLIT;
 
 	read_replace_refs = 0;
 
diff --git a/commit-graph.c b/commit-graph.c
index eb6d79567a..f94538c3df 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1472,12 +1472,16 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		}
 
 		if (ctx->base_graph_name) {
-			result = rename(ctx->base_graph_name,
-					ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
+			const char *dest = ctx->commit_graph_filenames_after[
+						ctx->num_commit_graphs_after - 2];
 
-			if (result) {
-				error(_("failed to rename base commit-graph file"));
-				return -1;
+			if (strcmp(ctx->base_graph_name, dest)) {
+				result = rename(ctx->base_graph_name, dest);
+
+				if (result) {
+					error(_("failed to rename base commit-graph file"));
+					return -1;
+				}
 			}
 		} else {
 			char *graph_name = get_commit_graph_filename(ctx->obj_dir);
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
new file mode 100755
index 0000000000..ccd24bd22b
--- /dev/null
+++ b/t/t5324-split-commit-graph.sh
@@ -0,0 +1,122 @@
+#!/bin/sh
+
+test_description='split commit graph'
+. ./test-lib.sh
+
+GIT_TEST_COMMIT_GRAPH=0
+
+test_expect_success 'setup repo' '
+	git init &&
+	git config core.commitGraph true &&
+	infodir=".git/objects/info" &&
+	graphdir="$infodir/commit-graphs" &&
+	test_oid_init
+'
+
+graph_read_expect() {
+	NUM_BASE=0
+	if test ! -z $2
+	then
+		NUM_BASE=$2
+	fi
+	cat >expect <<- EOF
+	header: 43475048 1 1 3 $NUM_BASE
+	num_commits: $1
+	chunks: oid_fanout oid_lookup commit_metadata
+	EOF
+	git commit-graph read >output &&
+	test_cmp expect output
+}
+
+test_expect_success 'create commits and write commit-graph' '
+	for i in $(test_seq 3)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git commit-graph write --reachable &&
+	test_path_is_file $infodir/commit-graph &&
+	graph_read_expect 3
+'
+
+graph_git_two_modes() {
+	git -c core.commitGraph=true $1 >output
+	git -c core.commitGraph=false $1 >expect
+	test_cmp expect output
+}
+
+graph_git_behavior() {
+	MSG=$1
+	BRANCH=$2
+	COMPARE=$3
+	test_expect_success "check normal git operations: $MSG" '
+		graph_git_two_modes "log --oneline $BRANCH" &&
+		graph_git_two_modes "log --topo-order $BRANCH" &&
+		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
+		graph_git_two_modes "branch -vv" &&
+		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
+	'
+}
+
+graph_git_behavior 'graph exists' commits/3 commits/1
+
+verify_chain_files_exist() {
+	for hash in $(cat $1/commit-graph-chain)
+	do
+		test_path_is_file $1/graph-$hash.graph || return 1
+	done
+}
+
+test_expect_success 'add more commits, and write a new base graph' '
+	git reset --hard commits/1 &&
+	for i in $(test_seq 4 5)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git reset --hard commits/2 &&
+	for i in $(test_seq 6 10)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git reset --hard commits/2 &&
+	git merge commits/4 &&
+	git branch merge/1 &&
+	git reset --hard commits/4 &&
+	git merge commits/6 &&
+	git branch merge/2 &&
+	git commit-graph write --reachable &&
+	graph_read_expect 12
+'
+
+test_expect_success 'add three more commits, write a tip graph' '
+	git reset --hard commits/3 &&
+	git merge merge/1 &&
+	git merge commits/5 &&
+	git merge merge/2 &&
+	git branch merge/3 &&
+	git commit-graph write --reachable --split &&
+	test_path_is_missing $infodir/commit-graph &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	ls $graphdir/graph-*.graph >graph-files &&
+	test_line_count = 2 graph-files &&
+	verify_chain_files_exist $graphdir
+'
+
+graph_git_behavior 'split commit-graph: merge 3 vs 2' merge/3 merge/2
+
+test_expect_success 'add one commit, write a tip graph' '
+	test_commit 11 &&
+	git branch commits/11 &&
+	git commit-graph write --reachable --split &&
+	test_path_is_missing $infodir/commit-graph &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	ls $graphdir/graph-*.graph >graph-files &&
+	test_line_count = 3 graph-files &&
+	verify_chain_files_exist $graphdir
+'
+
+graph_git_behavior 'three-layer commit-graph: commit 11 vs 6' commits/11 commits/6
+
+test_done
-- 
gitgitgadget

