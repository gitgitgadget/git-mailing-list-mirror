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
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D521F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfJJQN5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:57 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45729 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJJQNw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:52 -0400
Received: by mail-wr1-f47.google.com with SMTP id r5so8581433wrm.12
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wEsAG2dTQLAUtykvAFnYG6m1ONvIXRaMqC/2uDselDQ=;
        b=nv3N0eH+sFYBcAh1tTLBdPHC30tBKENnNM6xIm59UmIwdwBWJcjHrb107C3B9xCHsF
         2gEftUH1k9zSd03Y7ewHCC7bR9lCxS/GsPb6YBpM39s/hQregtIxj5aImtTPfRQ7koPi
         zBqyDS0gLV89K/+ulHclI759FJ1wHlVGaLsd8CeIHROQ2eVQFt14MkRKuLVCqtjnsEvO
         lrtrksqtuPcbp7Jnby38H623T2ewPJqIKvJK61fGAalwA7y5Sf3whShUG96ogZshzqFS
         HabVjGly/oCE12ngqT1sineuhB+MueXG6vmcw1Ri3AhyCyZ3PxpCICNlyhbqnRqT27HA
         l2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wEsAG2dTQLAUtykvAFnYG6m1ONvIXRaMqC/2uDselDQ=;
        b=gvE+GT/maCGv9FREroW/X0NmTQoJBgsoRCq7eCN8kPO6bxrwkZBmSfou4ZJ8qjsbe7
         OL8IsrNzp1QE6WUtggZZXuG+/+unk9jdNBipk2fsck3Erw+q0ZyeyTLNqNvACtrVN0yW
         wI6xAve0/4BnmY1hy96Ro0WBB+9ij9yuiH4Sq2hQELOgpBzUmH3UhBgRy726+nZmLMRu
         Ol8ZGsNvC/aG+pO+ZWLg373Fx4rF+Z42JcsrUE4Yk3uAb8eE5Y39C7BCL7VmrCdqdabE
         kmSGaWPA6wleE9nX8wYnUUGfZEHnUOayN4ePJ5Xy0e/NkWYCnWMLr72YIxtrjBAWWFYd
         g0Hg==
X-Gm-Message-State: APjAAAVDw6+yfgaJ9Lk9GmLpHj1JgKFNwEjyfjIILk38gB0ZYpY2ddz9
        HMWDlt3mMaOw44KXyanAEWVRreX5
X-Google-Smtp-Source: APXvYqyE07UQzTk5TZPtmo/P3840A+CpFKksJrPd0e4wRbN535tTUe6OGXf6QkpKg8SCzdIhjTmB5g==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr500534wrw.6.1570724029437;
        Thu, 10 Oct 2019 09:13:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j26sm8947620wrd.2.2019.10.10.09.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:48 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:48 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:36 GMT
Message-Id: <6c173663aac37f1d314db8637cf4a243066b8078.1570724021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 07/11] graph: commit and post-merge lines for left-skewed
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
 t/t4215-log-skewed-merges.sh | 151 +++++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+), 5 deletions(-)

diff --git a/graph.c b/graph.c
index 9136173e03..fb2e42850f 100644
--- a/graph.c
+++ b/graph.c
@@ -197,6 +197,46 @@ struct git_graph {
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
@@ -309,6 +349,8 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->commit_index = 0;
 	graph->prev_commit_index = 0;
 	graph->merge_layout = 0;
+	graph->edges_added = 0;
+	graph->prev_edges_added = 0;
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
@@ -670,6 +712,9 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 */
 	graph_update_columns(graph);
 
+	graph->prev_edges_added = graph->edges_added;
+	graph->edges_added = graph->num_parents + graph->merge_layout - 2;
+
 	graph->expansion_row = 0;
 
 	/*
@@ -943,12 +988,13 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 
 			if (graph->num_parents > 2)
 				graph_draw_octopus_merge(graph, sb);
-		} else if (seen_this && (graph->num_parents > 2)) {
+		} else if (seen_this && (graph->edges_added > 1)) {
 			strbuf_write_column(sb, col, '\\');
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
@@ -960,6 +1006,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			 * makes the output look nicer.
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
+			    graph->prev_edges_added > 0 &&
 			    graph->prev_commit_index < i)
 				strbuf_write_column(sb, col, '\\');
 			else
@@ -1031,8 +1078,14 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 				else
 					idx++;
 			}
+			if (graph->edges_added == 0)
+				strbuf_addch(sb, ' ');
+
 		} else if (seen_this) {
-			strbuf_write_column(sb, col, '\\');
+			if (graph->edges_added > 0)
+				strbuf_write_column(sb, col, '\\');
+			else
+				strbuf_write_column(sb, col, '|');
 			strbuf_addch(sb, ' ');
 		} else {
 			strbuf_write_column(sb, col, '|');
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index cfaba40f97..e479d6e676 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -39,4 +39,155 @@ test_expect_success 'log --graph with left-skewed merge' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup nested left-skewed merge' '
+	git checkout --orphan 1_p &&
+	test_commit 1_A &&
+	test_commit 1_B &&
+	test_commit 1_C &&
+	git checkout -b 1_q @^ && test_commit 1_D &&
+	git checkout 1_p && git merge --no-ff 1_q -m 1_E &&
+	git checkout -b 1_r @~3 && test_commit 1_F &&
+	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
+	git checkout @^^ && git merge --no-ff 1_p -m 1_H
+'
+
+cat > expect <<\EOF
+*   1_H
+|\
+| *   1_G
+| |\
+| | * 1_F
+| * | 1_E
+|/| |
+| * | 1_D
+* | | 1_C
+|/ /
+* | 1_B
+|/
+* 1_A
+EOF
+
+test_expect_success 'log --graph with nested left-skewed merge' '
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup nested left-skewed merge following normal merge' '
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
+	git checkout 2_p && git merge --no-ff 2_s -m 2_K
+'
+
+cat > expect <<\EOF
+*   2_K
+|\
+| *   2_J
+| |\
+| | *   2_H
+| | |\
+| | * | 2_G
+| |/| |
+| | * | 2_F
+| * | | 2_E
+| |/ /
+| * | 2_D
+* | | 2_C
+| |/
+|/|
+* | 2_B
+|/
+* 2_A
+EOF
+
+test_expect_success 'log --graph with nested left-skewed merge following normal merge' '
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup nested right-skewed merge following left-skewed merge' '
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
+	git checkout @^^ && git merge --no-ff 3_p -m 3_J
+'
+
+cat > expect <<\EOF
+*   3_J
+|\
+| *   3_H
+| |\
+| | * 3_G
+| * | 3_F
+|/| |
+| * |   3_E
+| |\ \
+| | |/
+| | * 3_D
+| * | 3_C
+| |/
+| * 3_B
+|/
+* 3_A
+EOF
+
+test_expect_success 'log --graph with nested right-skewed merge following left-skewed merge' '
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup right-skewed merge following a left-skewed one' '
+	git checkout --orphan 4_p &&
+	test_commit 4_A &&
+	test_commit 4_B &&
+	test_commit 4_C &&
+	git checkout -b 4_q @^^ && test_commit 4_D &&
+	git checkout -b 4_r 4_p^ && git merge --no-ff 4_q -m 4_E &&
+	git checkout -b 4_s 4_p^^ &&
+	git merge --no-ff 4_r -m 4_F &&
+	git merge --no-ff 4_p -m 4_G &&
+	git checkout @^^ && git merge --no-ff 4_s -m 4_H
+'
+
+cat > expect <<\EOF
+*   4_H
+|\
+| *   4_G
+| |\
+| * | 4_F
+|/| |
+| * |   4_E
+| |\ \
+| | * | 4_D
+| |/ /
+|/| |
+| | * 4_C
+| |/
+| * 4_B
+|/
+* 4_A
+EOF
+
+test_expect_success 'log --graph with right-skewed merge following a left-skewed one' '
+	git log --graph --date-order --pretty=tformat:%s | sed "s/ *$//" > actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

