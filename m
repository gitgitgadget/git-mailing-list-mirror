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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8120C1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbfJOXsQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40258 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390217AbfJOXsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so3180290wro.7
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7so7AoHa+hyi07UslMDITnDeXFtMOAH2NyRzX0pksbA=;
        b=cixFYGNMHtUIyWhKxWaAjqZQm0EMcA7sWsE+FDFM+CYxRR3h2Dsc8YiquFp4yU3CHY
         VB6MZqDr5g5iPZBm5Gt/iYpCz+KA+lQQvwTw3oP4owuZkIq2fE4cKcTdRVqgAx9w1y58
         BBLUROLhftUP7+ZIhg0UqsY67SZSYiQulGC4mKSBAkR6JvI8MNUG8gWxpTwMUcwoCVKP
         PwWRXpv0DNSIZJPePOfTZz/kudDhydrEnRkAUrAh1FYZPuR2ihED8f6ADLt2RCohKrNW
         EUQLSBOwoeBc3tuDH7Sg3Gm1sNYNl3D9yRWC9Vn8Zq54RTM/cr7ygFRipLVO4yxGhr7K
         8+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7so7AoHa+hyi07UslMDITnDeXFtMOAH2NyRzX0pksbA=;
        b=Oq5r5AYp07n/HFjZzCUaPdirLwhhZOppIrpsUtSeSGMEw068MyRN78vpybwugFzc4Q
         3ynFjFEvaN2kwvAXmROz18iIvVBGAyf7Qxn9gEbZud3Q0LIu9g75Lhrh/zPbIRyxQhWz
         xjFV0Qn6Wonk+a3tB2AAi7+VvDmwul8Nv2rkZ8TDsZBIiDTbKp0RQ0/t/+vidh2GUm/+
         nXPRky1EFtITRnGr9InnjZt6fDXxG1EUynXwrVTGJGLvkISx+UcOLHusKIOLymJvhQOc
         NgsAZufbmDFEHOvM18dXZ8JomALtj1bhrpJ6nVSD//YMvGgKCQbmp7NhRGR1Uj0FGn6D
         yjZg==
X-Gm-Message-State: APjAAAWg77nep9uTszecYpKS5s/oXOyRRlVidKeEN1Ro34laOfDji+cH
        tEjslhUFUg2rXEPXo6oo6ukrfWjS
X-Google-Smtp-Source: APXvYqxYiorKzdeaQei6HVwqED6xnsAeEIPRiLiVLXNZ/8s8lxqan2bziJ3XBvmEBZf2LNkZsOArig==
X-Received: by 2002:adf:8526:: with SMTP id 35mr14399wrh.266.1571183291131;
        Tue, 15 Oct 2019 16:48:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 13sm611871wmj.29.2019.10.15.16.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:10 -0700 (PDT)
Message-Id: <9b24893de6b7ddb95dc8813d5bbe6c68b0983dfd.1571183279.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:57 +0000
Subject: [PATCH v3 11/13] graph: smooth appearance of collapsing edges on
 commit lines
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

When a graph contains edges that are in the process of collapsing to the
left, but those edges cross a commit line, the effect is that the edges
have a jagged appearance:

        *
        |\
        | *
        |  \
        *-. \
        |\ \ \
        | | * |
        | * | |
        | |/ /
        * | |
        |/ /
        * |
        |/
        *

We already takes steps to smooth edges like this when they're expanding;
when an edge appears to the right of a merge commit marker on a
GRAPH_COMMIT line immediately following a GRAPH_POST_MERGE line, we
render it as a `\`:

        * \
        |\ \
        | * \
        | |\ \

We can make a similar improvement to collapsing edges, making them
easier to follow and giving the overall graph a feeling of increased
symmetry:

        *
        |\
        | *
        |  \
        *-. \
        |\ \ \
        | | * |
        | * | |
        | |/ /
        * / /
        |/ /
        * /
        |/
        *

To do this, we introduce a new special case for edges on GRAPH_COMMIT
lines that immediately follow a GRAPH_COLLAPSING line. By retaining a
copy of the `mapping` array used to render the GRAPH_COLLAPSING line in
the `old_mapping` array, we can determine that an edge is collapsing
through the GRAPH_COMMIT line and should be smoothed.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c                                    | 17 +++++++++---
 t/t3430-rebase-merges.sh                   |  2 +-
 t/t4202-log.sh                             |  2 +-
 t/t4214-log-graph-octopus.sh               | 32 +++++++++++-----------
 t/t4215-log-skewed-merges.sh               |  4 +--
 t/t6016-rev-list-graph-simplify-history.sh |  4 +--
 6 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/graph.c b/graph.c
index 2315f3604d..63f8d18baa 100644
--- a/graph.c
+++ b/graph.c
@@ -297,10 +297,10 @@ struct git_graph {
 	 */
 	int *mapping;
 	/*
-	 * A temporary array for computing the next mapping state
-	 * while we are outputting a mapping line.  This is stored as part
-	 * of the git_graph simply so we don't have to allocate a new
-	 * temporary array each time we have to output a collapsing line.
+	 * A copy of the contents of the mapping array from the last commit,
+	 * which we use to improve the display of columns that are tracking
+	 * from right to left through a commit line.  We also use this to
+	 * avoid allocating a fresh array when we compute the next mapping.
 	 */
 	int *old_mapping;
 	/*
@@ -1015,6 +1015,10 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 				graph_line_write_column(line, col, '\\');
 			else
 				graph_line_write_column(line, col, '|');
+		} else if (graph->prev_state == GRAPH_COLLAPSING &&
+			   graph->old_mapping[2 * i + 1] == i &&
+			   graph->mapping[2 * i] < i) {
+			graph_line_write_column(line, col, '/');
 		} else {
 			graph_line_write_column(line, col, '|');
 		}
@@ -1211,6 +1215,11 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 		}
 	}
 
+	/*
+	 * Copy the current mapping array into old_mapping
+	 */
+	COPY_ARRAY(graph->old_mapping, graph->mapping, graph->mapping_size);
+
 	/*
 	 * The new mapping may be 1 smaller than the old mapping
 	 */
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 9efcf4808a..a30d27e9f3 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -408,7 +408,7 @@ test_expect_success 'octopus merges' '
 	| | * three
 	| * | two
 	| |/
-	* | one
+	* / one
 	|/
 	o before-octopus
 	EOF
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e803ba402e..ab0d021365 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -667,7 +667,7 @@ cat > expect <<\EOF
 * | | fifth
 * | | fourth
 |/ /
-* | third
+* / third
 |/
 * second
 * initial
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 1b96276894..21bc600a82 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -31,9 +31,9 @@ test_expect_success 'log --graph with tricky octopus merge, no color' '
 	| | | * 4
 	| | * | 3
 	| | |/
-	| * | 2
+	| * / 2
 	| |/
-	* | 1
+	* / 1
 	|/
 	* initial
 	EOF
@@ -51,9 +51,9 @@ test_expect_success 'log --graph with tricky octopus merge with colors' '
 	<RED>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
 	<RED>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
 	<RED>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
-	<RED>|<RESET> * <MAGENTA>|<RESET> 2
+	<RED>|<RESET> * <MAGENTA>/<RESET> 2
 	<RED>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
-	* <MAGENTA>|<RESET> 1
+	* <MAGENTA>/<RESET> 1
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
@@ -72,9 +72,9 @@ test_expect_success 'log --graph with normal octopus merge, no color' '
 	| | | * 4
 	| | * | 3
 	| | |/
-	| * | 2
+	| * / 2
 	| |/
-	* | 1
+	* / 1
 	|/
 	* initial
 	EOF
@@ -90,9 +90,9 @@ test_expect_success 'log --graph with normal octopus merge with colors' '
 	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 4
 	<RED>|<RESET> <GREEN>|<RESET> * <BLUE>|<RESET> 3
 	<RED>|<RESET> <GREEN>|<RESET> <BLUE>|<RESET><BLUE>/<RESET>
-	<RED>|<RESET> * <BLUE>|<RESET> 2
+	<RED>|<RESET> * <BLUE>/<RESET> 2
 	<RED>|<RESET> <BLUE>|<RESET><BLUE>/<RESET>
-	* <BLUE>|<RESET> 1
+	* <BLUE>/<RESET> 1
 	<BLUE>|<RESET><BLUE>/<RESET>
 	* initial
 	EOF
@@ -110,9 +110,9 @@ test_expect_success 'log --graph with normal octopus merge and child, no color'
 	| | | * 4
 	| | * | 3
 	| | |/
-	| * | 2
+	| * / 2
 	| |/
-	* | 1
+	* / 1
 	|/
 	* initial
 	EOF
@@ -129,9 +129,9 @@ test_expect_failure 'log --graph with normal octopus and child merge with colors
 	<GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
 	<GREEN>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
 	<GREEN>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
-	<GREEN>|<RESET> * <MAGENTA>|<RESET> 2
+	<GREEN>|<RESET> * <MAGENTA>/<RESET> 2
 	<GREEN>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
-	* <MAGENTA>|<RESET> 1
+	* <MAGENTA>/<RESET> 1
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
@@ -150,9 +150,9 @@ test_expect_success 'log --graph with tricky octopus merge and its child, no col
 	| | | * 4
 	| | * | 3
 	| | |/
-	| * | 2
+	| * / 2
 	| |/
-	* | 1
+	* / 1
 	|/
 	* initial
 	EOF
@@ -171,9 +171,9 @@ test_expect_failure 'log --graph with tricky octopus merge and its child with co
 	<RED>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET> * 4
 	<RED>|<RESET> <BLUE>|<RESET> * <CYAN>|<RESET> 3
 	<RED>|<RESET> <BLUE>|<RESET> <CYAN>|<RESET><CYAN>/<RESET>
-	<RED>|<RESET> * <CYAN>|<RESET> 2
+	<RED>|<RESET> * <CYAN>/<RESET> 2
 	<RED>|<RESET> <CYAN>|<RESET><CYAN>/<RESET>
-	* <CYAN>|<RESET> 1
+	* <CYAN>/<RESET> 1
 	<CYAN>|<RESET><CYAN>/<RESET>
 	* initial
 	EOF
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index e673cdb6f7..1745b3b64c 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -17,7 +17,7 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	| | * D
 	| * | C
 	| |/
-	* | B
+	* / B
 	|/
 	* A
 	EOF
@@ -85,7 +85,7 @@ test_expect_success 'log --graph with nested left-skewed merge' '
 	| * | 1_D
 	* | | 1_C
 	|/ /
-	* | 1_B
+	* / 1_B
 	|/
 	* 1_A
 	EOF
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index f7181d1d6a..ca1682f29b 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -154,7 +154,7 @@ test_expect_success '--graph --full-history -- bar.txt' '
 	echo "* |   $A4" >> expected &&
 	echo "|\\ \\  " >> expected &&
 	echo "| |/  " >> expected &&
-	echo "* | $A3" >> expected &&
+	echo "* / $A3" >> expected &&
 	echo "|/  " >> expected &&
 	echo "* $A2" >> expected &&
 	git rev-list --graph --full-history --all -- bar.txt > actual &&
@@ -255,7 +255,7 @@ test_expect_success '--graph --boundary ^C3' '
 	echo "* | | | $A3" >> expected &&
 	echo "o | | | $A2" >> expected &&
 	echo "|/ / /  " >> expected &&
-	echo "o | | $A1" >> expected &&
+	echo "o / / $A1" >> expected &&
 	echo " / /  " >> expected &&
 	echo "| o $C3" >> expected &&
 	echo "|/  " >> expected &&
-- 
gitgitgadget

