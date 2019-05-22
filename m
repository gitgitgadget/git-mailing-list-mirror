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
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2BC1F462
	for <e@80x24.org>; Wed, 22 May 2019 19:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbfEVTxc (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 15:53:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42735 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbfEVTxa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 15:53:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so5477036eda.9
        for <git@vger.kernel.org>; Wed, 22 May 2019 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4JlBgFiudFQI7CeNVwepBnxxKr/DjgAIcBYeJvSglg0=;
        b=iTwyfunibW0tgHc4Dpfk0/eUEAZaNZucxgW5SeDsWboE6Az6PuiaUS4WUgDSnajku6
         Kq+7oJReRXHFphCw4oRUVv5sEP8YFC+RYEJMIz1bF70gy/SXhu0yR8ocQqqqCO0QLAd2
         qcGsdz60OPoW2cj8wLvuL+cQxOgdwBBU6Tx0LYDa8r8E7InZQ3s9l7DlZrrg2YpJn8Zy
         t5yqywkJvqsUvDHOD5X98DvBP44oUbgHAQMWlsIDLjNQ+K6oai1+/Z0QzJxwa4gWikwj
         GtcFNwNzs8zGfuwKnIlKlDeDuZldTl3Tf4RmXq5bLIDgF4jizDb5rqbl3r1RIh64l9z6
         NfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4JlBgFiudFQI7CeNVwepBnxxKr/DjgAIcBYeJvSglg0=;
        b=mbTygTE5aqTcZ17adsmUn/ZBzHMI7rAZQtTGipXQ5BC9G2pkb77g89HAZcVA3UjSKh
         Ci2Ypn/yQw67rRtNxmbbpm2CBf4stgtigC8edX0LxiMGbMbBGjykClEol4hl9hqdaVWF
         VWIm/BmO3PdYsD14UP5Z4MuCdbD/a+9fQO3l0OxIiqwttpreCHW7qZRrzBaH1JACw+cB
         +pQAXEMCIaHp36mmdUNfVNYHeUOyb2WwPRdWD7A2S33+wkqzNvaNUbFW4BdWIeFi76Ry
         LX6NqTqQL4eCsz4YQB9hzL79lr15v0GdMpyb4x3VS+TG8sxl/SuDI0eJNDjiUdPJYjjW
         EBHg==
X-Gm-Message-State: APjAAAW2Y3FXRtF/NSIi31LVkI+xtpAq39l44zqKTx0Yg876LPdA4lHu
        rWazEI281iFGvAQ/ljiREQkfonLm
X-Google-Smtp-Source: APXvYqyBxk4h05Vg97yvbc2v1oaRD83+lJevX+ZZEuTJ7lbLsimNvTMl4kWHtGXFXzqD3pmq8bkN+w==
X-Received: by 2002:a50:aeaf:: with SMTP id e44mr92095340edd.239.1558554808361;
        Wed, 22 May 2019 12:53:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10sm7278451edl.35.2019.05.22.12.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:53:27 -0700 (PDT)
Date:   Wed, 22 May 2019 12:53:27 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 19:53:17 GMT
Message-Id: <5ad14f574b6ffa5e233d61098dbcfc29c3632be5.1558554800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v2.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
        <pull.184.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/11] commit-graph: add --split option to builtin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
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

Add a new test script (t5323-split-commit-graph.sh) that demonstrates this
behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c        |  10 ++-
 t/t5323-split-commit-graph.sh | 122 ++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100755 t/t5323-split-commit-graph.sh

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
 
diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
new file mode 100755
index 0000000000..96704b9f5b
--- /dev/null
+++ b/t/t5323-split-commit-graph.sh
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
+		git branch commits/$i
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
+		test_path_is_file $1/graph-$hash.graph
+	done
+}
+
+test_expect_success 'add more commits, and write a new base graph' '
+	git reset --hard commits/1 &&
+	for i in $(test_seq 4 5)
+	do
+		test_commit $i &&
+		git branch commits/$i
+	done &&
+	git reset --hard commits/2 &&
+	for i in $(test_seq 6 10)
+	do
+		test_commit $i &&
+		git branch commits/$i
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

