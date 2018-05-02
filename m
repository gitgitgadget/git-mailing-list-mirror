Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989611F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbeGCL0R (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:17 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:41923 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCL0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:16 -0400
Received: by mail-pg0-f49.google.com with SMTP id l65-v6so838982pgl.8
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=y0tibTaStWh5MzYsgXV610jLSzwE2OZ5UWbjO0ySSJw=;
        b=k+XeFiT889PrXyj743iVl92pHNpAcpUwan7tFj0zJ7lBnj74NIzKOtji2qfu6uog2U
         yrjZRrWPjD1rc6ojOgWYSYFlRqn6UsV2VzK83imror8PEKXY36hcehARh0S/bVbdyOMz
         vIZSPwkKUuMzAq1vlvv77Q/zEHL7vcbgZXlxl60gS4paOUPKqkg7DvXIy61MZwEOoRcX
         RqZg1lDby+Cp2bQvKnge9J+XSXMNJTw4fNdC+UfGUR8N7VSIBP5WN2wWFH6IjjkbGzbq
         59B/JJ2wgkvPHnUO5NxYwDVlu8QClcz9E7hlIHQNkS33HI4nWI8zY6pZokQQ0lHg2CmH
         XvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=y0tibTaStWh5MzYsgXV610jLSzwE2OZ5UWbjO0ySSJw=;
        b=pr47uPH5/FClOGocp/B9y1rk2p2R5dlFIgax48OA/Zqfev7QmvEufHWeEpkfNL0l+Z
         ZSAUhquD08bWJqg6KmDzfeVvR4kdmFumzRbHECgkvjSM7TQZj2xg8mVZpK/GAjIs1fFQ
         U9iTazTEeK3kVHfXe58WIWI0zGlPofp8mApd8QMRgTqwEoKhIUVCEwQ7Lg0eqOVKlK6x
         3DAVBvFAHjTs/giD/I/4CkgqAj6weLtpLV1jN5PUev5eUPWwyg2PJJfjVmerOLIXvtOo
         BlonbYRWLAa5LKG+v2oWfrYdiKIFtnKiqKUVT88VzAje1OdMz3QBqjgHkAeawpiq2dSb
         DB8A==
X-Gm-Message-State: APt69E1AcemNrhmpe1V5UmNVgANgO5yREzEzR+76lSoag+0O34tS+j7a
        xakWlyL4SW8cRC+s30rbtcHGdw==
X-Google-Smtp-Source: AAOMgpfmKvw6TzmIGYs/8YRCEgzSIz6jAFxStmO7Ng120v4JusYMD8gtILhn11fuhlYrJo926577Yw==
X-Received: by 2002:a62:6882:: with SMTP id d124-v6mr29253043pfc.122.1530617175229;
        Tue, 03 Jul 2018 04:26:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 145-v6sm2303096pfz.69.2018.07.03.04.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:14 -0700 (PDT)
Message-Id: <e98489c8cfd8d45fab5f70923a0788f5abe17789.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 2 May 2018 12:22:29 +0200
Subject: [PATCH v3 04/20] range-diff: improve the order of the shown commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch lets `git range-diff` use the same order as tbdiff.

The idea is simple: for left-to-right readers, it is natural to assume
that the `git range-diff` is performed between an older vs a newer
version of the branch. As such, the user is probably more interested in
the question "where did this come from?" rather than "where did that one
go?".

To that end, we list the commits in the order of the second commit range
("the newer version"), inserting the unmatched commits of the first
commit range as soon as all their predecessors have been shown.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 59 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index c374333a4..e71cf0ba7 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -12,7 +12,7 @@ struct patch_util {
 	struct hashmap_entry e;
 	const char *diff, *patch;
 
-	int i;
+	int i, shown;
 	int diffsize;
 	size_t diff_offset;
 	/* the index of the matching item in the other branch, or -1 */
@@ -256,28 +256,49 @@ static const char *short_oid(struct patch_util *util)
 
 static void output(struct string_list *a, struct string_list *b)
 {
-	int i;
-
-	for (i = 0; i < b->nr; i++) {
-		struct patch_util *util = b->items[i].util, *prev;
+	int i = 0, j = 0;
+
+	/*
+	 * We assume the user is really more interested in the second argument
+	 * ("newer" version). To that end, we print the output in the order of
+	 * the RHS (the `b` parameter). To put the LHS (the `a` parameter)
+	 * commits that are no longer in the RHS into a good place, we place
+	 * them once we have shown all of their predecessors in the LHS.
+	 */
+
+	while (i < a->nr || j < b->nr) {
+		struct patch_util *a_util, *b_util;
+		a_util = i < a->nr ? a->items[i].util : NULL;
+		b_util = j < b->nr ? b->items[j].util : NULL;
+
+		/* Skip all the already-shown commits from the LHS. */
+		while (i < a->nr && a_util->shown)
+			a_util = ++i < a->nr ? a->items[i].util : NULL;
+
+		/* Show unmatched LHS commit whose predecessors were shown. */
+		if (i < a->nr && a_util->matching < 0) {
+			printf("%d: %s < -: --------\n",
+			       i + 1, short_oid(a_util));
+			i++;
+			continue;
+		}
 
-		if (util->matching < 0)
+		/* Show unmatched RHS commits. */
+		while (j < b->nr && b_util->matching < 0) {
 			printf("-: -------- > %d: %s\n",
-					i + 1, short_oid(util));
-		else {
-			prev = a->items[util->matching].util;
-			printf("%d: %s ! %d: %s\n",
-			       util->matching + 1, short_oid(prev),
-			       i + 1, short_oid(util));
+			       j + 1, short_oid(b_util));
+			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
-	}
-
-	for (i = 0; i < a->nr; i++) {
-		struct patch_util *util = a->items[i].util;
 
-		if (util->matching < 0)
-			printf("%d: %s < -: --------\n",
-			       i + 1, short_oid(util));
+		/* Show matching LHS/RHS pair. */
+		if (j < b->nr) {
+			a_util = a->items[b_util->matching].util;
+			printf("%d: %s ! %d: %s\n",
+			       b_util->matching + 1, short_oid(a_util),
+			       j + 1, short_oid(b_util));
+			a_util->shown = 1;
+			j++;
+		}
 	}
 }
 
-- 
gitgitgadget

