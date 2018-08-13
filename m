Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4AEA1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeHMOO7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:14:59 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:42605 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:14:59 -0400
Received: by mail-pg1-f175.google.com with SMTP id y4-v6so7374460pgp.9
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3yesZiepIhDgS4qQ8TNj8T2R0GFtJc8zzq8qZmhewCM=;
        b=ofOl0Vo9y+jc+WaIhrcpqT5vaoXbyFC8tJ3H8biNv0iI03f8hoJuNZjQf6g77PC+E4
         y2l20DlUh7nLmuVd7cFQIZSmscFXGXVpw89Q5TzN0QBdL9YhsVdR+gRE1EoAjl0JQqJZ
         ywR+n+OTizJPyfgwZqQNFw+DLZSA+50PliFTErdXQ9ML63sz4Cyaw4J8VJ+590dna/qI
         6tjhSfj4DnnoU1QccQ1cIqGoxjnUWk1gd4iSMv5NgFMWop06rtaZXCSoZMIbmungrm06
         XDWJw7kkeRlTo7EKSwwbxSa+KxOhf+xfaLJ7djx0xpJiLF3bYe/G4zspqWAqJ7Qo49ql
         70Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3yesZiepIhDgS4qQ8TNj8T2R0GFtJc8zzq8qZmhewCM=;
        b=miHnFcG9OaZt5WGI78LDYK4lbdZ5zlqZUooYIjKOcX/+CrQ5+Ch+9JN/TTf4az0UHm
         z0yGYtrerdO69tkQ4a/j4jFbIVgbZhJRw1pfF1bTTCQdaG0XTFCBfDF4UkF9Iooqdopq
         E8n7A4HDH/DQnxi+45cCglOKhe4eIq9gK9t2fr4PU8wmB031T97Kd/9GyI0g2rkVCROd
         Rcr31Cu+BZFRok/gUP+KBv5Ba66LA6c7e49LDFyfjCGVJ0HRMEntd2bHnhaMCpsdgrlB
         YnPdHUL5FBjuBILj5dwWABeDI9vkKoItpfmJ3tNhnI1dPNWI5O+1HoiH4niU8Wrs/F2X
         nVCQ==
X-Gm-Message-State: AOUpUlF26ak0ZCTExivq2j+dLu4r3sHHzWJwXainkTw4Cwj3xdGOQipx
        wT/1dcZUSQQm8xZDHr8TKQFACG4T
X-Google-Smtp-Source: AA+uWPxzzCz5tfO1vLqPChmwq2Gnj8TrK1Lx4RKyrs5PyPwtUixPmyG+sxfmXBt/lVZ2Hxia63+Alw==
X-Received: by 2002:a62:83ca:: with SMTP id h193-v6mr18543632pfe.79.1534159986538;
        Mon, 13 Aug 2018 04:33:06 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y4-v6sm20338006pfm.137.2018.08.13.04.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:05 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:05 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:39 GMT
Message-Id: <7b90919685d1e94b50f5278ec1b57a59cba1f8e5.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 04/21] range-diff: improve the order of the shown commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
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
index 15d418afa..2d94200d3 100644
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
@@ -260,28 +260,49 @@ static const char *short_oid(struct patch_util *util)
 
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

