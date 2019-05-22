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
	by dcvr.yhbt.net (Postfix) with ESMTP id B17AD20380
	for <e@80x24.org>; Wed, 22 May 2019 19:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbfEVTx1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 15:53:27 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:35513 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbfEVTx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 15:53:26 -0400
Received: by mail-ed1-f47.google.com with SMTP id p26so5527691edr.2
        for <git@vger.kernel.org>; Wed, 22 May 2019 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=83+KezQ/3vQBa4uYbOO7GhoVTL5BuuzyJOL20wptTXs=;
        b=IOkboe1ybH7WCUKsk/ddG7vbUje/dn4By5OMlhD/peO62zUn8k5Q1zHLkDrrIMuj8e
         NNXJWMhbiXlCTZLnF31qgzIGswWzTYE9njnwS5OvwREnDixbJQRXSjBVW0+4Y7g1Ckl3
         ZYhy2AOq4Db/McZ+3V7cZTGR0vqdFlFT+hIALe2H64btXJ5CHAs3PO03rX2RzSNV5Lgq
         528oUuSMy07fF2V6yvxAD05zubtLDebSo5hIb0OcGp0+fhAK8XBcBznmY9hSl2KbeDDM
         ux5wcZOIF6fl5z4BXGW7yNid25qIvgJw7arBQXu4v9APqnYYUNI7HVJFl2qcwwZ6ujNC
         L9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=83+KezQ/3vQBa4uYbOO7GhoVTL5BuuzyJOL20wptTXs=;
        b=sBKV2EsrVS6V2HUTdPK5Sd4JiR8sJ/GIaGNij5ORXXvZU+aHcWuaeA7hPvuylbZIQH
         mm1ca1CkoA29vsxZduNL1jYQuqAEIr5xiwJKDVlB0lqijJ1bIitRLQA4z+Z60nX81zot
         2dCwfQBR7NBXcTn5WJSaBCVwQIMxtGIxJRGSiwoOlqXuZ+wLuw/HpICwuLCPX/gXzKvX
         Bd09uuWrRxg96lAVOuQoTvEQKazi5hC5kmQtwCNeAraD8v56uw5dLWeYK86lLF0iWwBs
         Udad/xxj+lRm/kCdDVSITWWqzs3GxpFGDvUzCSrBCI48Utdx9oi4yV0+Z1OWwFuzvJNw
         lC3g==
X-Gm-Message-State: APjAAAVq0uRsEsESaUOUnSeFttEVpbuR2SNo2Lb5Wa/49g7PXaP9Uee4
        NtopAkUpOhzXcTPZkZqsCjOFo3kq
X-Google-Smtp-Source: APXvYqxEozt+RpGdWh3kT596ZF27td7sJRGSUlB4VsxcGDlg+6AN1RElt+4z4m+IRZ4iL2O2ZQ7WDA==
X-Received: by 2002:a50:a389:: with SMTP id s9mr91095584edb.113.1558554802381;
        Wed, 22 May 2019 12:53:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm4009909ejj.42.2019.05.22.12.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:53:21 -0700 (PDT)
Date:   Wed, 22 May 2019 12:53:21 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 19:53:09 GMT
Message-Id: <pull.184.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/11] [RFC] Commit-graph: Write incremental files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is marked as RFC quality because it is missing some key
features and tests, but hopefully starts a concrete discussion of how the
incremental commit-graph writes can work. This version takes the design
suggestions from the earlier discussion and tries to work out most of the
concerns.

The commit-graph is a valuable performance feature for repos with large
commit histories, but suffers from the same problem as git repack: it
rewrites the entire file every time. This can be slow when there are
millions of commits, especially after we stopped reading from the
commit-graph file during a write in 43d3561 (commit-graph write: don't die
if the existing graph is corrupt).

Instead, create a "chain" of commit-graphs in the
.git/objects/info/commit-graphs folder with name graph-{hash}.graph. The
list of hashes is given by the commit-graph-chain file, and also in a "base
graph chunk" in the commit-graph format. As we read a chain, we can verify
that the hashes match the trailing hash of each commit-graph we read along
the way and each hash below a level is expected by that graph file.

When writing, we don't always want to add a new level to the stack. This
would eventually result in performance degradation, especially when
searching for a commit (before we know its graph position). We decide to
merge levels of the stack when the new commits we will write satisfy two
conditions:

 1. The expected size of the new file is more than half the size of the tip
    of the stack.
 2. The new file contains more than 64,000 commits.

The first condition alone would prevent more than a logarithmic number of
levels. The second condition is a stop-gap to prevent performance issues
when another process starts reading the commit-graph stack as we are merging
a large stack of commit-graph files. The reading process could be in a state
where the new file is not ready, but the levels above the new file were
already deleted. Thus, the commits that were merged down must be parsed from
pack-files.

The performance is necessarily amortized across multiple writes, so I tested
by writing commit-graphs from the (non-rc) tags in the Linux repo. My test
included 72 tags, and wrote everything reachable from the tag using 
--stdin-commits. Here are the overall perf numbers:

git commit-graph write --stdin-commits:         8m 12s
git commit-graph write --stdin-commits --split:    48s

The test using --split included at least six full collapses to the full
commit-graph. I believe the commit-graph stack had at most three levels
during this test.

Here are a few points that still need to be addressed before this is ready
for full review:

 * The merge strategy values should be extracted into config options.
   
   
 * If we have a commit-graph chain and someone writes without "--split" it
   will make a new commit-graph file and not clean up the old files.
   
   
 * We need to update 'git commit-graph verify' to understand the chains, and
   test that it catches the new problems. It would be good to have a
   '--shallow' option to only verify the tip file, as if we run that after
   every write we can have some confidence that the files at rest are still
   valid and we only need to check the smaller file. (This is the main
   reason this is a priority to the VFS for Git team.)
   
   

This is based on ds/commit-graph-write-refactor.

Thanks, -Stolee

[1] 
https://github.com/git/git/commit/43d356180556180b4ef6ac232a14498a5bb2b446
commit-graph write: don't die if the existing graph is corrupt

Derrick Stolee (11):
  commit-graph: document commit-graph chains
  commit-graph: prepare for commit-graph chains
  commit-graph: rename commit_compare to oid_compare
  commit-graph: load commit-graph chains
  commit-graph: add base graphs chunk
  commit-graph: rearrange chunk count logic
  commit-graph: write commit-graph chains
  commit-graph: add --split option to builtin
  commit-graph: merge commit-graph chains
  commit-graph: allow cross-alternate chains
  commit-graph: expire commit-graph files

 .../technical/commit-graph-format.txt         |  11 +-
 Documentation/technical/commit-graph.txt      | 195 +++++
 builtin/commit-graph.c                        |  10 +-
 commit-graph.c                                | 734 +++++++++++++++++-
 commit-graph.h                                |   7 +
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5323-split-commit-graph.sh                 | 172 ++++
 7 files changed, 1088 insertions(+), 43 deletions(-)
 create mode 100755 t/t5323-split-commit-graph.sh


base-commit: 8520d7fc7c6edd4d71582c69a873436029b6cb1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-184%2Fderrickstolee%2Fgraph%2Fincremental-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-184/derrickstolee/graph/incremental-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/184

Range-diff vs v1:

  1:  0be7713a25 <  -:  ---------- commit-graph: fix the_repository reference
  2:  86b18f15ba <  -:  ---------- commit-graph: return with errors during write
  3:  9299a7fe25 <  -:  ---------- commit-graph: collapse parameters into flags
  4:  f9b719fc7a <  -:  ---------- commit-graph: remove Future Work section
  5:  74e40970e0 <  -:  ---------- commit-graph: create write_commit_graph_context
  6:  54817ef50b <  -:  ---------- commit-graph: extract fill_oids_from_packs()
  7:  cf792d38ed <  -:  ---------- commit-graph: extract fill_oids_from_commit_hex()
  8:  aaae85f1ec <  -:  ---------- commit-graph: extract fill_oids_from_all_packs()
  9:  9d434dc38c <  -:  ---------- commit-graph: extract count_distinct_commits()
 10:  ebd665468e <  -:  ---------- commit-graph: extract copy_oids_to_commits()
 11:  3eee3667cf <  -:  ---------- commit-graph: extract write_commit_graph_file()
 12:  7bbe8d9150 <  -:  ---------- Documentation: describe split commit-graphs
  -:  ---------- >  1:  a423afbfdd commit-graph: document commit-graph chains
 13:  9d0e966a3d !  2:  249668fc92 commit-graph: lay groundwork for incremental files
     @@ -1,6 +1,26 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    commit-graph: lay groundwork for incremental files
     +    commit-graph: prepare for commit-graph chains
     +
     +    To prepare for a chain of commit-graph files, augment the
     +    commit_graph struct to point to a base commit_graph. As we load
     +    commits from the graph, we may actually want to read from a base
     +    file according to the graph position.
     +
     +    The "graph position" of a commit is given by concatenating the
     +    lexicographic commit orders from each of the commit-graph files in
     +    the chain. This means that we must distinguish two values:
     +
     +     * lexicographic index : the position within the lexicographic
     +       order in a single commit-graph file.
     +
     +     * graph position: the posiiton within the concatenated order
     +       of multiple commit-graph files
     +
     +    Given the lexicographic index of a commit in a graph, we can
     +    compute the graph position by adding the number of commits in
     +    the lower-level graphs. To find the lexicographic index of
     +    a commit, we subtract the number of commits in lower-level graphs.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -13,21 +33,21 @@
       
      +static void load_oid_from_graph(struct commit_graph *g, int pos, struct object_id *oid)
      +{
     ++	uint32_t lex_index;
     ++
      +	if (!g)
      +		BUG("NULL commit-graph");
      +
     -+	if (pos < g->num_commits_in_base) {
     -+		load_oid_from_graph(g->base_graph, pos, oid);
     -+		return;
     -+	}
     ++	while (pos < g->num_commits_in_base)
     ++		g = g->base_graph;
      +
      +	if (pos >= g->num_commits + g->num_commits_in_base)
      +		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
      +		    pos, g->num_commits, g->num_commits_in_base);
      +
     -+	pos -= g->num_commits_in_base;
     ++	lex_index = pos - g->num_commits_in_base;
      +
     -+	hashcpy(oid->hash, g->chunk_oid_lookup + g->hash_len * pos);
     ++	hashcpy(oid->hash, g->chunk_oid_lookup + g->hash_len * lex_index);
      +}
      +
       static struct commit_list **insert_parent_or_die(struct repository *r,
     @@ -47,24 +67,32 @@
       	if (!c)
       		die(_("could not find commit %s"), oid_to_hex(&oid));
      @@
     + 
       static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
       {
     - 	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;
     --	item->graph_pos = pos;
     -+	item->graph_pos = pos + g->num_commits_in_base;
     +-	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;
     ++	const unsigned char *commit_data;
     ++	uint32_t lex_index;
     ++
     ++	while (pos < g->num_commits_in_base)
     ++		g = g->base_graph;
     ++
     ++	lex_index = pos - g->num_commits_in_base;
     ++	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
     + 	item->graph_pos = pos;
       	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
       }
     - 
      @@
       	uint32_t *parent_data_ptr;
       	uint64_t date_low, date_high;
       	struct commit_list **pptr;
      -	const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * pos;
      +	const unsigned char *commit_data;
     ++	uint32_t lex_index;
       
      -	item->object.parsed = 1;
     -+	if (pos < g->num_commits_in_base)
     -+		return fill_commit_in_graph(r, item, g->base_graph, pos);
     ++	while (pos < g->num_commits_in_base)
     ++		g = g->base_graph;
      +
      +	if (pos >= g->num_commits + g->num_commits_in_base)
      +		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
     @@ -75,9 +103,9 @@
      +	 * "local" position for the rest of the calculation.
      +	 */
       	item->graph_pos = pos;
     -+	pos -= g->num_commits_in_base;
     ++	lex_index = pos - g->num_commits_in_base;
      +
     -+	commit_data = g->chunk_commit_data + (g->hash_len + 16) * pos;
     ++	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
      +
      +	item->object.parsed = 1;
       
     @@ -89,13 +117,13 @@
       	} else {
      -		return bsearch_graph(g, &(item->object.oid), pos);
      +		struct commit_graph *cur_g = g;
     -+		uint32_t pos_in_g;
     ++		uint32_t lex_index;
      +
     -+		while (cur_g && !bsearch_graph(cur_g, &(item->object.oid), &pos_in_g))
     ++		while (cur_g && !bsearch_graph(cur_g, &(item->object.oid), &lex_index))
      +			cur_g = cur_g->base_graph;
      +
      +		if (cur_g) {
     -+			*pos = pos_in_g + cur_g->num_commits_in_base;
     ++			*pos = lex_index + cur_g->num_commits_in_base;
      +			return 1;
      +		}
      +
     @@ -111,8 +139,8 @@
      -					   GRAPH_DATA_WIDTH * (c->graph_pos);
      +	const unsigned char *commit_data;
      +
     -+	if (c->graph_pos < g->num_commits_in_base)
     -+		return load_tree_for_commit(r, g->base_graph, c);
     ++	while (c->graph_pos < g->num_commits_in_base)
     ++		g = g->base_graph;
      +
      +	commit_data = g->chunk_commit_data +
      +			GRAPH_DATA_WIDTH * (c->graph_pos - g->num_commits_in_base);
     @@ -133,8 +161,3 @@
       	const uint32_t *chunk_oid_fanout;
       	const unsigned char *chunk_oid_lookup;
       	const unsigned char *chunk_commit_data;
     - 	const unsigned char *chunk_extra_edges;
     -+	const unsigned char *chunk_base_graph;
     - };
     - 
     - struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
 14:  4436c8f4f1 <  -:  ---------- commit-graph: load split commit-graph files
 15:  aa4a096813 <  -:  ---------- commit-graph: write split commit-graph files
  -:  ---------- >  3:  809fa7ad80 commit-graph: rename commit_compare to oid_compare
  -:  ---------- >  4:  a8c0b47c8a commit-graph: load commit-graph chains
  -:  ---------- >  5:  4fefd0a654 commit-graph: add base graphs chunk
  -:  ---------- >  6:  a595a1eb65 commit-graph: rearrange chunk count logic
  -:  ---------- >  7:  9cbfb656b3 commit-graph: write commit-graph chains
 16:  7c5bc06d14 !  8:  5ad14f574b commit-graph: add --split option
     @@ -1,6 +1,16 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    commit-graph: add --split option
     +    commit-graph: add --split option to builtin
     +
     +    Add a new "--split" option to the 'git commit-graph write' subcommand. This
     +    option allows the optional behavior of writing a commit-graph chain.
     +
     +    The current behavior will add a tip commit-graph containing any commits that
     +    are not in the existing commit-graph or commit-graph chain. Later changes
     +    will allow merging the chain and expiring out-dated files.
     +
     +    Add a new test script (t5323-split-commit-graph.sh) that demonstrates this
     +    behavior.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -55,39 +65,130 @@
       	read_replace_refs = 0;
       
      
     - diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
     - --- a/t/t5318-commit-graph.sh
     - +++ b/t/t5318-commit-graph.sh
     + diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
     + new file mode 100755
     + --- /dev/null
     + +++ b/t/t5323-split-commit-graph.sh
      @@
     - 	test_cmp_bin commit-graph-after-gc $objdir/info/commit-graph
     - '
     - 
     -+test_expect_success 'write split commit-graph' '
     -+	cd "$TRASH_DIRECTORY" &&
     -+	git clone full split &&
     -+	cd split &&
     ++#!/bin/sh
     ++
     ++test_description='split commit graph'
     ++. ./test-lib.sh
     ++
     ++GIT_TEST_COMMIT_GRAPH=0
     ++
     ++test_expect_success 'setup repo' '
     ++	git init &&
      +	git config core.commitGraph true &&
     -+	for i in $(test_seq 1 20); do
     -+		test_commit padding-$i
     ++	infodir=".git/objects/info" &&
     ++	graphdir="$infodir/commit-graphs" &&
     ++	test_oid_init
     ++'
     ++
     ++graph_read_expect() {
     ++	NUM_BASE=0
     ++	if test ! -z $2
     ++	then
     ++		NUM_BASE=$2
     ++	fi
     ++	cat >expect <<- EOF
     ++	header: 43475048 1 1 3 $NUM_BASE
     ++	num_commits: $1
     ++	chunks: oid_fanout oid_lookup commit_metadata
     ++	EOF
     ++	git commit-graph read >output &&
     ++	test_cmp expect output
     ++}
     ++
     ++test_expect_success 'create commits and write commit-graph' '
     ++	for i in $(test_seq 3)
     ++	do
     ++		test_commit $i &&
     ++		git branch commits/$i
      +	done &&
      +	git commit-graph write --reachable &&
     -+	test_commit split-commit &&
     -+	git branch -f split-commit &&
     -+	git commit-graph write --reachable --split &&
     -+	test_path_is_file .git/objects/info/commit-graphs/commit-graph-1
     ++	test_path_is_file $infodir/commit-graph &&
     ++	graph_read_expect 3
      +'
      +
     -+graph_git_behavior 'split graph, split-commit vs merge 1' bare split-commit merge/1
     ++graph_git_two_modes() {
     ++	git -c core.commitGraph=true $1 >output
     ++	git -c core.commitGraph=false $1 >expect
     ++	test_cmp expect output
     ++}
     ++
     ++graph_git_behavior() {
     ++	MSG=$1
     ++	BRANCH=$2
     ++	COMPARE=$3
     ++	test_expect_success "check normal git operations: $MSG" '
     ++		graph_git_two_modes "log --oneline $BRANCH" &&
     ++		graph_git_two_modes "log --topo-order $BRANCH" &&
     ++		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
     ++		graph_git_two_modes "branch -vv" &&
     ++		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
     ++	'
     ++}
      +
     -+test_expect_success 'collapse split commit-graph' '
     -+	cd "$TRASH_DIRECTORY/split" &&
     ++graph_git_behavior 'graph exists' commits/3 commits/1
     ++
     ++verify_chain_files_exist() {
     ++	for hash in $(cat $1/commit-graph-chain)
     ++	do
     ++		test_path_is_file $1/graph-$hash.graph
     ++	done
     ++}
     ++
     ++test_expect_success 'add more commits, and write a new base graph' '
     ++	git reset --hard commits/1 &&
     ++	for i in $(test_seq 4 5)
     ++	do
     ++		test_commit $i &&
     ++		git branch commits/$i
     ++	done &&
     ++	git reset --hard commits/2 &&
     ++	for i in $(test_seq 6 10)
     ++	do
     ++		test_commit $i &&
     ++		git branch commits/$i
     ++	done &&
     ++	git reset --hard commits/2 &&
     ++	git merge commits/4 &&
     ++	git branch merge/1 &&
     ++	git reset --hard commits/4 &&
     ++	git merge commits/6 &&
     ++	git branch merge/2 &&
      +	git commit-graph write --reachable &&
     -+	test_path_is_missing .git/objects/info/commit-graphs/commit-graph-1 &&
     -+	test_path_is_file .git/objects/info/commit-graph
     ++	graph_read_expect 12
     ++'
     ++
     ++test_expect_success 'add three more commits, write a tip graph' '
     ++	git reset --hard commits/3 &&
     ++	git merge merge/1 &&
     ++	git merge commits/5 &&
     ++	git merge merge/2 &&
     ++	git branch merge/3 &&
     ++	git commit-graph write --reachable --split &&
     ++	test_path_is_missing $infodir/commit-graph &&
     ++	test_path_is_file $graphdir/commit-graph-chain &&
     ++	ls $graphdir/graph-*.graph >graph-files &&
     ++	test_line_count = 2 graph-files &&
     ++	verify_chain_files_exist $graphdir
     ++'
     ++
     ++graph_git_behavior 'split commit-graph: merge 3 vs 2' merge/3 merge/2
     ++
     ++test_expect_success 'add one commit, write a tip graph' '
     ++	test_commit 11 &&
     ++	git branch commits/11 &&
     ++	git commit-graph write --reachable --split &&
     ++	test_path_is_missing $infodir/commit-graph &&
     ++	test_path_is_file $graphdir/commit-graph-chain &&
     ++	ls $graphdir/graph-*.graph >graph-files &&
     ++	test_line_count = 3 graph-files &&
     ++	verify_chain_files_exist $graphdir
      +'
      +
     -+graph_git_behavior 'collapsed graph, split-commit vs merge 1' bare split-commit merge/1
     ++graph_git_behavior 'three-layer commit-graph: commit 11 vs 6' commits/11 commits/6
      +
     - test_expect_success 'replace-objects invalidates commit-graph' '
     - 	cd "$TRASH_DIRECTORY" &&
     - 	test_when_finished rm -rf replace &&
     ++test_done
 17:  3c52385e56 <  -:  ---------- fetch: add fetch.writeCommitGraph config setting
  -:  ---------- >  9:  9567daa0b8 commit-graph: merge commit-graph chains
  -:  ---------- > 10:  4cfe19a933 commit-graph: allow cross-alternate chains
  -:  ---------- > 11:  72fc0a1f17 commit-graph: expire commit-graph files

-- 
gitgitgadget
