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
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3DD1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 18:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfJHS14 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 14:27:56 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33993 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHS14 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 14:27:56 -0400
Received: by mail-wr1-f43.google.com with SMTP id j11so14755989wrp.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zp3mObLxdI4RjXsRA0RmQMXkn91OkLMEZBsqRSoGNS8=;
        b=KQ6ETko3bgCiOhO1F7J3fleply9MuCDsQVi9DYZaMXgsqOGZL5odbfD9oshdcnKE03
         Ef6PL1PCvYXXnI7gvutccdw9OQBrFWapzlIuMw7GbiQPKWx9yomMPZmfkDWkc1FOGbjo
         pgri35/E2/II8IgRf6lSZqY2Q3SqvCIuy8sOuB6SR/7Q0jep3vFGUP+oJUHdMV16JnjR
         iSUZbX3fIBg2tP+VhsAClvYpy12XnBKoc8M5/b1X7OsbmqVFDOJ/IFcP0qzDRQU3TA/D
         y8/dZSV3CgeEgNHh8d5riHCRMs2Du/cRYRAwQdUQKMcB8l+c3M4mgbNnZb7ZJAe+P6cJ
         DIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zp3mObLxdI4RjXsRA0RmQMXkn91OkLMEZBsqRSoGNS8=;
        b=ieRQU0xPrwYC4P8OelzfvOct+jtZRyt2V7NlxQhEgwhKIDvDRcmTRyJw5gywFALHGu
         f5ww7GDRBsvQqIx5NF4SSGhXPVDsStoqbxJgXP+xBoMCLSA9wRsnSXZ6C7TYJSsoN3UA
         VHhK1QpSG2ZxsJC1JQTzF+IHPIYr/HoY+WlItDsaDPkW80R4EC63gjFjMird0MV3Fhgn
         Bm4R9VWzd2RMuPpJgsvLhB2qBHHhxWzEEyp/EaHpzcJciw8pbvngK57uYzC4c3UzmDZH
         K7hubdMc/SOp/7NSzv/BN4wO8ghdLi8+KZv/odj7ElyMGO4+rQa3u8Tpl54zfGrpwD7X
         +suQ==
X-Gm-Message-State: APjAAAUGbK7D0wP9h5ify8rqwULU3irrSFlufUdxOHdmZtwvxqzDHIhC
        JqaZRxINPfJjKOHgbnpQMkgYK3/5
X-Google-Smtp-Source: APXvYqygiDwxqs2kP4S2PjiuTyiD3lNb16ByoLSVhxc/NMaXsgTHbLw2ONx9QNuLQiLAPv7ihAx8Rg==
X-Received: by 2002:adf:e610:: with SMTP id p16mr16901502wrm.313.1570559272912;
        Tue, 08 Oct 2019 11:27:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b186sm5610044wmd.16.2019.10.08.11.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 11:27:52 -0700 (PDT)
Date:   Tue, 08 Oct 2019 11:27:52 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 18:27:50 GMT
Message-Id: <cb677310cecd52e853055e93a75b365a1d133968.1570559270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.380.git.gitgitgadget@gmail.com>
References: <pull.380.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] xdiffi: fix typos and touch up comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Inspired by the thoroughly stale https://github.com/git/git/pull/159,
this patch fixes a couple of typos, rewraps and clarifies some comments.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 xdiff/xdiffi.c | 99 ++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 1f1f4a3c78..bd035139f9 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -38,9 +38,9 @@ typedef struct s_xdpsplit {
  * Basically considers a "box" (off1, off2, lim1, lim2) and scan from both
  * the forward diagonal starting from (off1, off2) and the backward diagonal
  * starting from (lim1, lim2). If the K values on the same diagonal crosses
- * returns the furthest point of reach. We might end up having to expensive
- * cases using this algorithm is full, so a little bit of heuristic is needed
- * to cut the search and to return a suboptimal point.
+ * returns the furthest point of reach. We might encounter expensive edge cases
+ * using this algorithm, so a little bit of heuristic is needed to cut the
+ * search and to return a suboptimal point.
  */
 static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 		      unsigned long const *ha2, long off2, long lim2,
@@ -63,11 +63,13 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 		int got_snake = 0;
 
 		/*
-		 * We need to extent the diagonal "domain" by one. If the next
+		 * We need to extend the diagonal "domain" by one. If the next
 		 * values exits the box boundaries we need to change it in the
-		 * opposite direction because (max - min) must be a power of two.
+		 * opposite direction because (max - min) must be a power of
+		 * two.
+		 *
 		 * Also we initialize the external K value to -1 so that we can
-		 * avoid extra conditions check inside the core loop.
+		 * avoid extra conditions in the check inside the core loop.
 		 */
 		if (fmin > dmin)
 			kvdf[--fmin - 1] = -1;
@@ -98,11 +100,13 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 		}
 
 		/*
-		 * We need to extent the diagonal "domain" by one. If the next
+		 * We need to extend the diagonal "domain" by one. If the next
 		 * values exits the box boundaries we need to change it in the
-		 * opposite direction because (max - min) must be a power of two.
+		 * opposite direction because (max - min) must be a power of
+		 * two.
+		 *
 		 * Also we initialize the external K value to -1 so that we can
-		 * avoid extra conditions check inside the core loop.
+		 * avoid extra conditions in the check inside the core loop.
 		 */
 		if (bmin > dmin)
 			kvdb[--bmin - 1] = XDL_LINE_MAX;
@@ -138,7 +142,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 		/*
 		 * If the edit cost is above the heuristic trigger and if
 		 * we got a good snake, we sample current diagonals to see
-		 * if some of the, have reached an "interesting" path. Our
+		 * if some of them have reached an "interesting" path. Our
 		 * measure is a function of the distance from the diagonal
 		 * corner (i1 + i2) penalized with the distance from the
 		 * mid diagonal itself. If this value is above the current
@@ -196,8 +200,9 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 		}
 
 		/*
-		 * Enough is enough. We spent too much time here and now we collect
-		 * the furthest reaching path using the (i1 + i2) measure.
+		 * Enough is enough. We spent too much time here and now we
+		 * collect the furthest reaching path using the (i1 + i2)
+		 * measure.
 		 */
 		if (ec >= xenv->mxcost) {
 			long fbest, fbest1, bbest, bbest1;
@@ -244,9 +249,9 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 
 
 /*
- * Rule: "Divide et Impera". Recursively split the box in sub-boxes by calling
- * the box splitting function. Note that the real job (marking changed lines)
- * is done in the two boundary reaching checks.
+ * Rule: "Divide et Impera" (divide & conquer). Recursively split the box in
+ * sub-boxes by calling the box splitting function. Note that the real job
+ * (marking changed lines) is done in the two boundary reaching checks.
  */
 int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
 		 diffdata_t *dd2, long off2, long lim2,
@@ -323,7 +328,9 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	}
 
 	/*
-	 * Allocate and setup K vectors to be used by the differential algorithm.
+	 * Allocate and setup K vectors to be used by the differential
+	 * algorithm.
+	 *
 	 * One is to store the forward path and one to store the backward path.
 	 */
 	ndiags = xe->xdf1.nreff + xe->xdf2.nreff + 3;
@@ -394,8 +401,8 @@ static int recs_match(xrecord_t *rec1, xrecord_t *rec2, long flags)
 /*
  * If a line is indented more than this, get_indent() just returns this value.
  * This avoids having to do absurd amounts of work for data that are not
- * human-readable text, and also ensures that the output of get_indent fits within
- * an int.
+ * human-readable text, and also ensures that the output of get_indent fits
+ * within an int.
  */
 #define MAX_INDENT 200
 
@@ -429,9 +436,9 @@ static int get_indent(xrecord_t *rec)
 }
 
 /*
- * If more than this number of consecutive blank rows are found, just return this
- * value. This avoids requiring O(N^2) work for pathological cases, and also
- * ensures that the output of score_split fits in an int.
+ * If more than this number of consecutive blank rows are found, just return
+ * this value. This avoids requiring O(N^2) work for pathological cases, and
+ * also ensures that the output of score_split fits in an int.
  */
 #define MAX_BLANKS 20
 
@@ -443,8 +450,8 @@ struct split_measurement {
 	int end_of_file;
 
 	/*
-	 * How much is the line immediately following the split indented (or -1 if
-	 * the line is blank):
+	 * How much is the line immediately following the split indented (or -1
+	 * if the line is blank):
 	 */
 	int indent;
 
@@ -454,8 +461,8 @@ struct split_measurement {
 	int pre_blank;
 
 	/*
-	 * How much is the nearest non-blank line above the split indented (or -1
-	 * if there is no such line)?
+	 * How much is the nearest non-blank line above the split indented (or
+	 * -1 if there is no such line)?
 	 */
 	int pre_indent;
 
@@ -581,13 +588,13 @@ static void measure_split(const xdfile_t *xdf, long split,
 
 /*
  * Compute a badness score for the hypothetical split whose measurements are
- * stored in m. The weight factors were determined empirically using the tools and
- * corpus described in
+ * stored in m. The weight factors were determined empirically using the tools
+ * and corpus described in
  *
  *     https://github.com/mhagger/diff-slider-tools
  *
- * Also see that project if you want to improve the weights based on, for example,
- * a larger or more diverse corpus.
+ * Also see that project if you want to improve the weights based on, for
+ * example, a larger or more diverse corpus.
  */
 static void score_add_split(const struct split_measurement *m, struct split_score *s)
 {
@@ -809,13 +816,16 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	group_init(xdfo, &go);
 
 	while (1) {
-		/* If the group is empty in the to-be-compacted file, skip it: */
+		/*
+		 * If the group is empty in the to-be-compacted file, skip it:
+		 */
 		if (g.end == g.start)
 			goto next;
 
 		/*
 		 * Now shift the change up and then down as far as possible in
-		 * each direction. If it bumps into any other changes, merge them.
+		 * each direction. If it bumps into any other changes, merge
+		 * them.
 		 */
 		do {
 			groupsize = g.end - g.start;
@@ -858,17 +868,17 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		 * If the group can be shifted, then we can possibly use this
 		 * freedom to produce a more intuitive diff.
 		 *
-		 * The group is currently shifted as far down as possible, so the
-		 * heuristics below only have to handle upwards shifts.
+		 * The group is currently shifted as far down as possible, so
+		 * the heuristics below only have to handle upwards shifts.
 		 */
 
 		if (g.end == earliest_end) {
 			/* no shifting was possible */
 		} else if (end_matching_other != -1) {
 			/*
-			 * Move the possibly merged group of changes back to line
-			 * up with the last group of changes from the other file
-			 * that it can align with.
+			 * Move the possibly merged group of changes back to
+			 * line up with the last group of changes from the
+			 * other file that it can align with.
 			 */
 			while (go.end == go.start) {
 				if (group_slide_up(xdf, &g, flags))
@@ -879,14 +889,15 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		} else if (flags & XDF_INDENT_HEURISTIC) {
 			/*
 			 * Indent heuristic: a group of pure add/delete lines
-			 * implies two splits, one between the end of the "before"
-			 * context and the start of the group, and another between
-			 * the end of the group and the beginning of the "after"
-			 * context. Some splits are aesthetically better and some
-			 * are worse. We compute a badness "score" for each split,
-			 * and add the scores for the two splits to define a
-			 * "score" for each position that the group can be shifted
-			 * to. Then we pick the shift with the lowest score.
+			 * implies two splits, one between the end of the
+			 * "before" context and the start of the group, and
+			 * another between the end of the group and the
+			 * beginning of the "after" context. Some splits are
+			 * aesthetically better and some are worse. We compute
+			 * a badness "score" for each split, and add the scores
+			 * for the two splits to define a "score" for each
+			 * position that the group can be shifted to. Then we
+			 * pick the shift with the lowest score.
 			 */
 			long shift, best_shift = -1;
 			struct split_score best_score;
-- 
gitgitgadget
