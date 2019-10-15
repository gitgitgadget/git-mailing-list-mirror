Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529091F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbfJOXlQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:41:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39340 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJOXlP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:41:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so25810453wrj.6
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8b1CwLZofaT4TtS8mgc9StlIYDdcual5ah/w+2e7lXY=;
        b=unifmZox32mFEhOQhWypuveLMaBh1AIxI1lPb//Xgh5LFSM1ROXxwS95b0Ab0KpIb0
         hyyeAiiIbEaHRRbE9vNrubsB03IRAlmZfEtXglknvCPVXM03sY5NSBqAY5ojUhR751U6
         V9tF1sNVvuEUgna43DYNfOyHjEchAgYdlVUejzQF/UsyWrKqILd5AIUjG0SAPBuDYdEu
         T4xwCR9TPl2KrnJdZQIJGG4Kgq17Fs4FXFjnn276bUjIM+R6qLq7QaQa6qHM9jNc3wS1
         SqV2FedzWzFy9kv1ci+zwDCYo3ej1JGiqEm3BNNGLLSVqaal+AlEkCF2tlztrxBQ/qFx
         0uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8b1CwLZofaT4TtS8mgc9StlIYDdcual5ah/w+2e7lXY=;
        b=oT53sT/Q+N5T8rbQQ4Xpz62O7vPhwOj+ymMbD5mhIiFP18FzskTh2Ms7wBj8Y0zkjx
         JfmX1dTtuVZqXWNbIMfgjUbhLYl+YqaYD+IOMaj/A8Crc8LptvAytwM3FnOL3iI4Rdaw
         hMLfV5LO2WTUVAejtpPT8pGs9hIJkaUYcog5qoYWsLXRLURJu/VOzJ6LGeUbaZib2BPE
         iGjmQXUKNEXkRIKgNvUkx7Rt3wsTqrjg4vASXNV46zPTzyvvGLxZm478QWa1Av2/cJbQ
         glxDhOv4vYDurwtg0w2SIA9vpOesgnmMljoimExy78FEskPLHsjgjkjw3iR32uSdPdwB
         3S0A==
X-Gm-Message-State: APjAAAX2UnnYIB6UQbsUaqkpkv/6f+jEbmBXI7ald5kkQXT+GCFanTW5
        N4gE0dO3woGc8JUTYBqG5R9EBMVV
X-Google-Smtp-Source: APXvYqyKEW9gjdfIa+QuiY6fSVoDbi6K05LqGpN9uRusKu+leNcoPlrZAhmjWqYj60JRlkVN2M8kJg==
X-Received: by 2002:a5d:4bc4:: with SMTP id l4mr5639wrt.146.1571182873782;
        Tue, 15 Oct 2019 16:41:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19sm792895wmh.27.2019.10.15.16.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:41:13 -0700 (PDT)
Message-Id: <0e37c88c6043ad25df1337fc7d69b3ab56294d0b.1571182864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
        <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:41:00 +0000
Subject: [PATCH v2 09/13] graph: commit and post-merge lines for left-skewed
 merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: James Coglan <jcoglan@gmail.com>

Following the introduction of "left-skewed" merges, which are merges
whose first parent fuses with another edge to its left, we have some
more edge cases to deal with in the display of commit and post-merge
lines.

The current graph code handles the following cases for edges appearing
to the right of the commit (*) on commit lines. A 2-way merge is usually
followed by vertical lines:

        | | |
        | * |
        | |\ \

An octopus merge (more than two parents) is always followed by edges
sloping to the right:

        | |  \          | |    \
        | *-. \         | *---. \
        | |\ \ \        | |\ \ \ \

A 2-way merge is followed by a right-sloping edge if the commit line
immediately follows a post-merge line for a commit that appears in the
same column as the current commit, or any column to the left of that:

        | *             | * |
        | |\            | |\ \
        | * \           | | * \
        | |\ \          | | |\ \

This commit introduces the following new cases for commit lines. If a
2-way merge skews to the left, then the edges to its right are always
vertical lines, even if the commit follows a post-merge line:

        | | |           | |\
        | * |           | * |
        |/| |           |/| |

A commit with 3 parents that skews left is followed by vertical edges:

        | | |
        | * |
        |/|\ \

If a 3-way left-skewed merge commit appears immediately after a
post-merge line, then it may be followed the right-sloping edges, just
like a 2-way merge that is not skewed.

        | |\
        | * \
        |/|\ \

Octopus merges with 4 or more parents that skew to the left will always
be followed by right-sloping edges, because the existing columns need to
expand around the merge.

        | |  \
        | *-. \
        |/|\ \ \

On post-merge lines, usually all edges following the current commit
slope to the right:

        | * | |
        | |\ \ \

However, if the commit is a left-skewed 2-way merge, the edges to its
right remain vertical. We also need to display a space after the
vertical line descending from the commit marker, whereas this line would
normally be followed by a backslash.

        | * | |
        |/| | |

If a left-skewed merge has more than 2 parents, then the edges to its
right are still sloped as they bend around the edges introduced by the
merge.

        | * | |
        |/|\ \ \

To handle these new cases, we need to know not just how many parents
each commit has, but how many new columns it adds to the display; this
quantity is recorded in the `edges_added` field for the current commit,
and `prev_edges_added` field for the previous commit.

Here, "column" refers to visual columns, not the logical columns of the
`columns` array. This is because even if all the commit's parents end up
fusing with existing edges, they initially introduce distinct edges in
the commit and post-merge lines before those edges collapse. For
example, a 3-way merge whose 2nd and 3rd parents fuse with existing
edges still introduces 2 visual columns that affect the display of edges
to their right.

        | | |  \
        | | *-. \
        | | |\ \ \
        | |_|/ / /
        |/| | / /
        | | |/ /
        | |/| |
        | | | |

This merge does not introduce any *logical* columns; there are 4 edges
before and after this commit once all edges have collapsed. But it does
initially introduce 2 new edges that need to be accommodated by the
edges to their right.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c                      |  63 +++++++++++++--
 t/t4215-log-skewed-merges.sh | 147 ++++++++++++++++++++++++++++++++++-
 2 files changed, 203 insertions(+), 7 deletions(-)

diff --git a/graph.c b/graph.c
index e37127f5ab..21edad8085 100644
--- a/graph.c
+++ b/graph.c
@@ -216,6 +216,46 @@ struct git_graph {
 	 * 		|/| | | | |		| | | | | *
 	 */
 	int merge_layout;
+	/*
+	 * The number of columns added to the graph by the current commit. For
+	 * 2-way and octopus merges, this is is usually one less than the
+	 * number of parents:
+	 *
+	 * 		| | |			| |    \
+	 *		| * |			| *---. \
+	 *		| |\ \			| |\ \ \ \
+	 *		| | | |         	| | | | | |
+	 *
+	 *		num_parents: 2		num_parents: 4
+	 *		edges_added: 1		edges_added: 3
+	 *
+	 * For left-skewed merges, the first parent fuses with its neighbor and
+	 * so one less column is added:
+	 *
+	 *		| | |			| |  \
+	 *		| * |			| *-. \
+	 *		|/| |			|/|\ \ \
+	 *		| | |			| | | | |
+	 *
+	 *		num_parents: 2		num_parents: 4
+	 *		edges_added: 0		edges_added: 2
+	 *
+	 * This number determines how edges to the right of the merge are
+	 * displayed in commit and post-merge lines; if no columns have been
+	 * added then a vertical line should be used where a right-tracking
+	 * line would otherwise be used.
+	 *
+	 *		| * \			| * |
+	 *		| |\ \			|/| |
+	 *		| | * \			| * |
+	 */
+	int edges_added;
+	/*
+	 * The number of columns added by the previous commit, which is used to
+	 * smooth edges appearing to the right of a commit in a commit line
+	 * following a post-merge line.
+	 */
+	int prev_edges_added;
 	/*
 	 * The maximum number of columns that can be stored in the columns
 	 * and new_columns arrays.  This is also half the number of entries
@@ -328,6 +368,8 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->commit_index = 0;
 	graph->prev_commit_index = 0;
 	graph->merge_layout = 0;
+	graph->edges_added = 0;
+	graph->prev_edges_added = 0;
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
@@ -689,6 +731,9 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 */
 	graph_update_columns(graph);
 
+	graph->prev_edges_added = graph->edges_added;
+	graph->edges_added = graph->num_parents + graph->merge_layout - 2;
+
 	graph->expansion_row = 0;
 
 	/*
@@ -947,12 +992,13 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 
 			if (graph->num_parents > 2)
 				graph_draw_octopus_merge(graph, line);
-		} else if (seen_this && (graph->num_parents > 2)) {
+		} else if (seen_this && (graph->edges_added > 1)) {
 			graph_line_write_column(line, col, '\\');
-		} else if (seen_this && (graph->num_parents == 2)) {
+		} else if (seen_this && (graph->edges_added == 1)) {
 			/*
-			 * This is a 2-way merge commit.
-			 * There is no GRAPH_PRE_COMMIT stage for 2-way
+			 * This is either a right-skewed 2-way merge
+			 * commit, or a left-skewed 3-way merge.
+			 * There is no GRAPH_PRE_COMMIT stage for such
 			 * merges, so this is the first line of output
 			 * for this commit.  Check to see what the previous
 			 * line of output was.
@@ -964,6 +1010,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 			 * makes the output look nicer.
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
+			    graph->prev_edges_added > 0 &&
 			    graph->prev_commit_index < i)
 				graph_line_write_column(line, col, '\\');
 			else
@@ -1033,8 +1080,14 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 				else
 					idx++;
 			}
+			if (graph->edges_added == 0)
+				graph_line_addch(line, ' ');
+
 		} else if (seen_this) {
-			graph_line_write_column(line, col, '\\');
+			if (graph->edges_added > 0)
+				graph_line_write_column(line, col, '\\');
+			else
+				graph_line_write_column(line, col, '|');
 			graph_line_addch(line, ' ');
 		} else {
 			graph_line_write_column(line, col, '|');
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index dc187b5caf..e673cdb6f7 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -11,7 +11,7 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	| *   G
 	| |\
 	| | * F
-	| * \   E
+	| * |   E
 	|/|\ \
 	| | |/
 	| | * D
@@ -43,7 +43,7 @@ test_expect_success 'log --graph with left-skewed merge' '
 	| | | | * 0_G
 	| |_|_|/|
 	|/| | | |
-	| | | * \   0_F
+	| | | * |   0_F
 	| |_|/|\ \
 	|/| | | |/
 	| | | | * 0_E
@@ -73,4 +73,147 @@ test_expect_success 'log --graph with left-skewed merge' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --graph with nested left-skewed merge' '
+	cat >expect <<-\EOF &&
+	*   1_H
+	|\
+	| *   1_G
+	| |\
+	| | * 1_F
+	| * | 1_E
+	|/| |
+	| * | 1_D
+	* | | 1_C
+	|/ /
+	* | 1_B
+	|/
+	* 1_A
+	EOF
+
+	git checkout --orphan 1_p &&
+	test_commit 1_A &&
+	test_commit 1_B &&
+	test_commit 1_C &&
+	git checkout -b 1_q @^ && test_commit 1_D &&
+	git checkout 1_p && git merge --no-ff 1_q -m 1_E &&
+	git checkout -b 1_r @~3 && test_commit 1_F &&
+	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
+	git checkout @^^ && git merge --no-ff 1_p -m 1_H &&
+
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --graph with nested left-skewed merge following normal merge' '
+	cat >expect <<-\EOF &&
+	*   2_K
+	|\
+	| *   2_J
+	| |\
+	| | *   2_H
+	| | |\
+	| | * | 2_G
+	| |/| |
+	| | * | 2_F
+	| * | | 2_E
+	| |/ /
+	| * | 2_D
+	* | | 2_C
+	| |/
+	|/|
+	* | 2_B
+	|/
+	* 2_A
+	EOF
+
+	git checkout --orphan 2_p &&
+	test_commit 2_A &&
+	test_commit 2_B &&
+	test_commit 2_C &&
+	git checkout -b 2_q @^^ &&
+	test_commit 2_D &&
+	test_commit 2_E &&
+	git checkout -b 2_r @^ && test_commit 2_F &&
+	git checkout 2_q &&
+	git merge --no-ff 2_r -m 2_G &&
+	git merge --no-ff 2_p^ -m 2_H &&
+	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
+	git checkout 2_p && git merge --no-ff 2_s -m 2_K &&
+
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --graph with nested right-skewed merge following left-skewed merge' '
+	cat >expect <<-\EOF &&
+	*   3_J
+	|\
+	| *   3_H
+	| |\
+	| | * 3_G
+	| * | 3_F
+	|/| |
+	| * |   3_E
+	| |\ \
+	| | |/
+	| | * 3_D
+	| * | 3_C
+	| |/
+	| * 3_B
+	|/
+	* 3_A
+	EOF
+
+	git checkout --orphan 3_p &&
+	test_commit 3_A &&
+	git checkout -b 3_q &&
+	test_commit 3_B &&
+	test_commit 3_C &&
+	git checkout -b 3_r @^ &&
+	test_commit 3_D &&
+	git checkout 3_q && git merge --no-ff 3_r -m 3_E &&
+	git checkout 3_p && git merge --no-ff 3_q -m 3_F &&
+	git checkout 3_r && test_commit 3_G &&
+	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
+	git checkout @^^ && git merge --no-ff 3_p -m 3_J &&
+
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --graph with right-skewed merge following a left-skewed one' '
+	cat >expect <<-\EOF &&
+	*   4_H
+	|\
+	| *   4_G
+	| |\
+	| * | 4_F
+	|/| |
+	| * |   4_E
+	| |\ \
+	| | * | 4_D
+	| |/ /
+	|/| |
+	| | * 4_C
+	| |/
+	| * 4_B
+	|/
+	* 4_A
+	EOF
+
+	git checkout --orphan 4_p &&
+	test_commit 4_A &&
+	test_commit 4_B &&
+	test_commit 4_C &&
+	git checkout -b 4_q @^^ && test_commit 4_D &&
+	git checkout -b 4_r 4_p^ && git merge --no-ff 4_q -m 4_E &&
+	git checkout -b 4_s 4_p^^ &&
+	git merge --no-ff 4_r -m 4_F &&
+	git merge --no-ff 4_p -m 4_G &&
+	git checkout @^^ && git merge --no-ff 4_s -m 4_H &&
+
+	git log --graph --date-order --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

