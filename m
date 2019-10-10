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
	by dcvr.yhbt.net (Postfix) with ESMTP id D17DB1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfJJQN5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34962 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfJJQNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so8626842wrt.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sGTR1hTEKEfjsP+HPPTapknAXdH7GJypKgy9PgR3K5w=;
        b=E/UFOt1C/SCNdI3nPC1wyHkw6JiKQ/FMGQXdhXb9eu1URtSmCTPKlnj3IGdDxiXii+
         QIEUqMkdUry7pnVSln0wTkuJDsMTr2gDxbdr/S67oZmWbXf4EfVqmmBp6HEpNw6/3thc
         nXt+8s7vdUlZolz4cuVUzc6dSVgeceGFRANgVonCy3zL/pabxcA3JargbS0VFBh4KTvM
         havlpHZFqj2ucXMXzmmMhOFOUuJnmk4BKeSpmqTnsdaBMzzSbvUytF8EZAE7tJPpj70y
         +dmPSLoxviscH/c8o6itPYY8RjQpO25LlMsr4aiRzkzsdw3+uRf5DGb8+PLZbJ9HuCws
         Vozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sGTR1hTEKEfjsP+HPPTapknAXdH7GJypKgy9PgR3K5w=;
        b=TDzfiZqNYtPE3lOQVLhjyDtsXTjIvTW9eivpuJZYeZeioGs13oZzI1C0MQCVnVpBBa
         ItMXjtm4R2KWS6odClocwN66pBDvx63DlGhGpJoBNu7YViKrXEf695O+pt9wLfWLVNVs
         5S3V4uaL+PUsUuSKXLbqSqxhh9G+FVTyrq84fL3lT4yA5aA9K9f1y1lgwh8yqzsXhZNE
         sGoyjPk4/3Lj28P+X3h9Vftz804wnpninKvUQLh83/cbA2tYUOL0uVni8LzrUprY81v6
         IDv/vwk5nYBta8g3bCYFZDY46ODqZvPvujQwODuYQw/94JPF7K7hlB6kn+EWcrhRHuKM
         zLww==
X-Gm-Message-State: APjAAAUW9OBrCPYeUYa9OQVCZSqfuLOVXIULtMRa5nCEyhTwaBNSDCQ1
        0zZ0yiFI4sS2GOmKJ3s9xxjxFPO9
X-Google-Smtp-Source: APXvYqxlRaPMpfQF/eTq2Yq00ygZLuFRsKsu8EKWdxdA7vX/pf5nHNm9hSrYgRu/aYUb/SGh/HK9jw==
X-Received: by 2002:adf:e688:: with SMTP id r8mr9924041wrm.342.1570724031252;
        Thu, 10 Oct 2019 09:13:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm7545928wrw.86.2019.10.10.09.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:50 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:50 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:38 GMT
Message-Id: <f9ced9090d0b5fb46e4ffbd31ec57a5eefeaf5e4.1570724021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/11] graph: smooth appearance of collapsing edges on commit
 lines
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
 graph.c                                    | 17 +++++++++++++----
 t/t3430-rebase-merges.sh                   |  2 +-
 t/t4202-log.sh                             |  2 +-
 t/t4214-log-graph-octopus.sh               | 16 ++++++++--------
 t/t4215-log-skewed-merges.sh               |  2 +-
 t/t6016-rev-list-graph-simplify-history.sh |  4 ++--
 6 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/graph.c b/graph.c
index b0e31e23ca..6391e393ec 100644
--- a/graph.c
+++ b/graph.c
@@ -278,10 +278,10 @@ struct git_graph {
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
@@ -1011,6 +1011,10 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 				strbuf_write_column(sb, col, '\\');
 			else
 				strbuf_write_column(sb, col, '|');
+		} else if (graph->prev_state == GRAPH_COLLAPSING &&
+			   graph->old_mapping[2 * i + 1] == i &&
+			   graph->mapping[2 * i] < i) {
+			strbuf_write_column(sb, col, '/');
 		} else {
 			strbuf_write_column(sb, col, '|');
 		}
@@ -1211,6 +1215,11 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
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
index 7b6c4847ad..051351ecdf 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -402,7 +402,7 @@ test_expect_success 'octopus merges' '
 	| | * three
 	| * | two
 	| |/
-	* | one
+	* / one
 	|/
 	o before-octopus
 	EOF
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index c20209324c..c7aa0532c1 100755
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
index 40f420877b..9ada687628 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -12,9 +12,9 @@ test_expect_success 'set up merge history' '
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
@@ -25,9 +25,9 @@ test_expect_success 'set up merge history' '
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
@@ -68,9 +68,9 @@ test_expect_success 'log --graph with normal octopus merge, no color' '
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
@@ -86,9 +86,9 @@ test_expect_success 'log --graph with normal octopus merge with colors' '
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
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index e479d6e676..b739268e5e 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -62,7 +62,7 @@ cat > expect <<\EOF
 | * | 1_D
 * | | 1_C
 |/ /
-* | 1_B
+* / 1_B
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

