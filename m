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
	by dcvr.yhbt.net (Postfix) with ESMTP id 560BF1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfJJQN4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34966 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfJJQNz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id v8so8626915wrt.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JK2inobb5zhUsTBE/QtcNCBJfbDIsr/OGF0HFkFqJrQ=;
        b=MbCW5BbbBbiniMOSWUTwLORBgoF2hnSZokJKXu65wJuqNFCdmava1jlBZZlI6Pt9kr
         70kGktJbYTTLqLNxIZCyZx+E5HpHrRq28ifx05ijvxj1flg0R2zlZFYxGoD86RGGR78m
         V/ID43iKzr3jGbLb6x8ETrkuQ46R4ZgX7vC5hvrMydjp1t5YGnzvc1BUiEx0RILkdczK
         6Zoij/vEYZRFXNSRy7X8cXxRue3oxPwIUAXXv7tSqHAnzSLaR1h/zTV/UIYsqC7ROF6S
         XLvfk3Ey7RGUYxDB3J5QCJKF8lgeWr3F3N4M08668G5ysDv1GFrPXpt5sFIn3F0++rRZ
         rSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JK2inobb5zhUsTBE/QtcNCBJfbDIsr/OGF0HFkFqJrQ=;
        b=hN38H4PlYgkUDUnNrwWPUtxbLaaZsMY9ASgOG7b0ykXtrpt716ujpD0uAc6U1uosMH
         VjVxp/HAENvDCDOt1wFZew1kcNCoE4F+Kg59MMhHMjqnotjA0cAenObf4MOiaCsDB/qS
         tZA37YbkKz0pMrjIVmriYBv3J+jXjROrkSKfTdOxinqqjsHcOTwKDnXN/v5b/2bDBWKY
         iRdp8GLPclAVUXY3g+3WkQSXGzt0gATr/dyVf4TYYa39GTTjsaGQoW/t1V0m3T45SoG0
         XhPlGZYCEnFDMYsbyk8FIFmGszITd+YdCMXB4BWAmIftZsHLJuNQ/PvYeVNlYWl0qRk7
         9SlA==
X-Gm-Message-State: APjAAAUJdTUoEbVrTMz6UiclUniHItQrE02ZCGtYCUgON//D2KvxBCtk
        mw8N+88fIOA0VrNtJkX08KDxHJCM
X-Google-Smtp-Source: APXvYqznvRoFaVZAPfoGSGlPcxixRKqU955/3WePmMcI7MMEGQVMEQnB2xQzC8dXs5g3Umj5oKSyIg==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr8893093wrv.52.1570724032107;
        Thu, 10 Oct 2019 09:13:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm4236692wmh.43.2019.10.10.09.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:51 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:51 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:39 GMT
Message-Id: <50756edcf7075b27b1ac0b0fb7af8688787bcd00.1570724021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 10/11] graph: flatten edges that join to their right neighbor
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

When a merge commit is printed and its final parent is the same commit
that occupies the column to the right of the merge, this results in a
kink in the displayed edges:

        * |
        |\ \
        | |/
        | *

Graphs containing these shapes can be hard to read, as the expansion to
the right followed immediately by collapsing back to the left creates a
lot of zig-zagging edges, especially when many columns are present.

We can improve this by eliminating the zig-zag and having the merge's
final parent edge fuse immediately with its neighbor:

        * |
        |\|
        | *

This reduces the horizontal width for the current commit by 2, and
requires one less row, making the graph display more compact. Taken in
combination with other graph-smoothing enhancements, it greatly
compresses the space needed to display certain histories:

        *
        |\
        | *                       *
        | |\                      |\
        | | *                     | *
        | | |                     | |\
        | |  \                    | | *
        | *-. \                   | * |
        | |\ \ \        =>        |/|\|
        |/ / / /                  | | *
        | | | /                   | * |
        | | |/                    | |/
        | | *                     * /
        | * |                     |/
        | |/                      *
        * |
        |/
        *

One of the test cases here cannot be correctly rendered in Git v2.23.0;
it produces this output following commit E:

        | | *-. \   5_E
        | | |\ \ \
        | |/ / / /
        | | | / _
        | |_|/
        |/| |

The new implementation makes sure that the rightmost edge in this
history is not left dangling as above.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c                                    | 34 ++++++---
 t/t4215-log-skewed-merges.sh               | 80 +++++++++++++++++++++-
 t/t6016-rev-list-graph-simplify-history.sh | 30 ++++----
 3 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/graph.c b/graph.c
index 6391e393ec..7dd2fab625 100644
--- a/graph.c
+++ b/graph.c
@@ -538,8 +538,24 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 		shift = (dist > 1) ? 2 * dist - 3 : 1;
 
 		graph->merge_layout = (dist > 0) ? 0 : 1;
+		graph->edges_added = graph->num_parents + graph->merge_layout  - 2;
+
 		mapping_idx = graph->width + (graph->merge_layout - 1) * shift;
 		graph->width += 2 * graph->merge_layout;
+
+	} else if (graph->edges_added > 0 && i == graph->mapping[graph->width - 2]) {
+		/*
+		 * If some columns have been added by a merge, but this commit
+		 * was found in the last existing column, then adjust the
+		 * numbers so that the two edges immediately join, i.e.:
+		 *
+		 *		* |		* |
+		 *		|\ \	=>	|\|
+		 *		| |/		| *
+		 *		| *
+		 */
+		mapping_idx = graph->width - 2;
+		graph->edges_added = -1;
 	} else {
 		mapping_idx = graph->width;
 		graph->width += 2;
@@ -585,6 +601,8 @@ static void graph_update_columns(struct git_graph *graph)
 		graph->mapping[i] = -1;
 
 	graph->width = 0;
+	graph->prev_edges_added = graph->edges_added;
+	graph->edges_added = 0;
 
 	/*
 	 * Populate graph->new_columns and graph->mapping
@@ -712,9 +730,6 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 */
 	graph_update_columns(graph);
 
-	graph->prev_edges_added = graph->edges_added;
-	graph->edges_added = graph->num_parents + graph->merge_layout - 2;
-
 	graph->expansion_row = 0;
 
 	/*
@@ -1039,7 +1054,7 @@ const char merge_chars[] = {'/', '|', '\\'};
 static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
-	int i;
+	int i, j;
 
 	struct commit_list *first_parent = first_interesting_parent(graph);
 	int seen_parent = 0;
@@ -1071,16 +1086,19 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 			char c;
 			seen_this = 1;
 
-			for (; parents; parents = next_interesting_parent(graph, parents)) {
+			for (j = 0; j < graph->num_parents; j++) {
 				par_column = graph_find_new_column_by_commit(graph, parents->item);
 				assert(par_column >= 0);
 
 				c = merge_chars[idx];
 				strbuf_write_column(sb, &graph->new_columns[par_column], c);
-				if (idx == 2)
-					strbuf_addch(sb, ' ');
-				else
+				if (idx == 2) {
+					if (graph->edges_added > 0 || j < graph->num_parents - 1)
+						strbuf_addch(sb, ' ');
+				} else {
 					idx++;
+				}
+				parents = next_interesting_parent(graph, parents);
 			}
 			if (graph->edges_added == 0)
 				strbuf_addch(sb, ' ');
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index b739268e5e..1481e6fd80 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -137,9 +137,8 @@ cat > expect <<\EOF
 | | * 3_G
 | * | 3_F
 |/| |
-| * |   3_E
-| |\ \
-| | |/
+| * | 3_E
+| |\|
 | | * 3_D
 | * | 3_C
 | |/
@@ -190,4 +189,79 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
 	test_cmp expect actual
 '
 
+test_expect_success 'setup octopus merge with column joining its penultimate parent' '
+	git checkout --orphan 5_p &&
+	test_commit 5_A &&
+	git branch 5_q &&
+	git branch 5_r &&
+	test_commit 5_B &&
+	git checkout 5_q && test_commit 5_C &&
+	git checkout 5_r && test_commit 5_D &&
+	git checkout 5_p &&
+	git merge --no-ff 5_q 5_r -m 5_E &&
+	git checkout 5_q && test_commit 5_F &&
+	git checkout -b 5_s 5_p^ &&
+	git merge --no-ff 5_p 5_q -m 5_G &&
+	git checkout 5_r &&
+	git merge --no-ff 5_s -m 5_H
+'
+
+cat > expect <<\EOF
+*   5_H
+|\
+| *-.   5_G
+| |\ \
+| | | * 5_F
+| | * |   5_E
+| |/|\ \
+| |_|/ /
+|/| | /
+| | |/
+* | | 5_D
+| | * 5_C
+| |/
+|/|
+| * 5_B
+|/
+* 5_A
+EOF
+
+test_expect_success 'log --graph with octopus merge with column joining its penultimate parent' '
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup merge fusing with its left and right neighbors' '
+	git checkout --orphan 6_p &&
+	test_commit 6_A &&
+	test_commit 6_B &&
+	git checkout -b 6_q @^ && test_commit 6_C &&
+	git checkout -b 6_r @^ && test_commit 6_D &&
+	git checkout 6_p && git merge --no-ff 6_q 6_r -m 6_E &&
+	git checkout 6_r && test_commit 6_F &&
+	git checkout 6_p && git merge --no-ff 6_r -m 6_G &&
+	git checkout @^^ && git merge --no-ff 6_p -m 6_H
+'
+
+cat > expect <<\EOF
+*   6_H
+|\
+| *   6_G
+| |\
+| | * 6_F
+| * | 6_E
+|/|\|
+| | * 6_D
+| * | 6_C
+| |/
+* / 6_B
+|/
+* 6_A
+EOF
+
+test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index ca1682f29b..f5e6e92f5b 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -67,11 +67,10 @@ test_expect_success '--graph --all' '
 	echo "| * $C4" >> expected &&
 	echo "| * $C3" >> expected &&
 	echo "* | $A5" >> expected &&
-	echo "| |     " >> expected &&
-	echo "|  \\    " >> expected &&
-	echo "*-. \\   $A4" >> expected &&
-	echo "|\\ \\ \\  " >> expected &&
-	echo "| | |/  " >> expected &&
+	echo "| |   " >> expected &&
+	echo "|  \\  " >> expected &&
+	echo "*-. | $A4" >> expected &&
+	echo "|\\ \\| " >> expected &&
 	echo "| | * $C2" >> expected &&
 	echo "| | * $C1" >> expected &&
 	echo "| * | $B2" >> expected &&
@@ -97,11 +96,10 @@ test_expect_success '--graph --simplify-by-decoration' '
 	echo "| * $C4" >> expected &&
 	echo "| * $C3" >> expected &&
 	echo "* | $A5" >> expected &&
-	echo "| |     " >> expected &&
-	echo "|  \\    " >> expected &&
-	echo "*-. \\   $A4" >> expected &&
-	echo "|\\ \\ \\  " >> expected &&
-	echo "| | |/  " >> expected &&
+	echo "| |   " >> expected &&
+	echo "|  \\  " >> expected &&
+	echo "*-. | $A4" >> expected &&
+	echo "|\\ \\| " >> expected &&
 	echo "| | * $C2" >> expected &&
 	echo "| | * $C1" >> expected &&
 	echo "| * | $B2" >> expected &&
@@ -131,9 +129,8 @@ test_expect_success '--graph --simplify-by-decoration prune branch B' '
 	echo "| * $C4" >> expected &&
 	echo "| * $C3" >> expected &&
 	echo "* | $A5" >> expected &&
-	echo "* |   $A4" >> expected &&
-	echo "|\\ \\  " >> expected &&
-	echo "| |/  " >> expected &&
+	echo "* | $A4" >> expected &&
+	echo "|\\| " >> expected &&
 	echo "| * $C2" >> expected &&
 	echo "| * $C1" >> expected &&
 	echo "* | $A3" >> expected &&
@@ -151,10 +148,9 @@ test_expect_success '--graph --full-history -- bar.txt' '
 	echo "|\\  " >> expected &&
 	echo "| * $C4" >> expected &&
 	echo "* | $A5" >> expected &&
-	echo "* |   $A4" >> expected &&
-	echo "|\\ \\  " >> expected &&
-	echo "| |/  " >> expected &&
-	echo "* / $A3" >> expected &&
+	echo "* | $A4" >> expected &&
+	echo "|\\| " >> expected &&
+	echo "* | $A3" >> expected &&
 	echo "|/  " >> expected &&
 	echo "* $A2" >> expected &&
 	git rev-list --graph --full-history --all -- bar.txt > actual &&
-- 
gitgitgadget

