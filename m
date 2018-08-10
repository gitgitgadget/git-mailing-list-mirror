Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A921F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeHKAqS (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:18 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:37741 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbeHKAqS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:18 -0400
Received: by mail-pf1-f173.google.com with SMTP id a26-v6so5129120pfo.4
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3yesZiepIhDgS4qQ8TNj8T2R0GFtJc8zzq8qZmhewCM=;
        b=WEzUDTAzIcGZf4pZxGswAS1t8vj3F4CORnhXwArlK9PkJ0mhu6SlSgByTRQOVNCjfh
         pygzWSEpite0EEklT6c4IBn8rRb63/mYqnB0dYngKobRBNPe6amoaCudU5texnjPPAaH
         lFI6v+v3s3aV5ZgvW2uLbwoQJZ7W7zMOzJFTVgo9s8TOkidoESPJUpIyboqSLd+580vz
         xwElpEtz9FBOtdJ96rEHCunDzePK8E97+SQ/+VR0JVrMQ4zY8c1KWHihpJoNO1eBbeiz
         irXXtb6k69Qq4I0VXgcjLsH1KsAJDNx7OGsvDAtpYqdJx5iGmfabuv8iIztPgYbenRWX
         6WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3yesZiepIhDgS4qQ8TNj8T2R0GFtJc8zzq8qZmhewCM=;
        b=YyHuHxaj2bPmt3KsnbxZRfLkk6LFb4s5Ysmjd1i45GAYvr44i6LeBpVxQAflzoiQxU
         Q+o93dZEUtLHJNBsRe7rfw0KQUj6sWehfWManIBG8ZjwapLp4Ef2sTMYiP+SGGGrDRXy
         IAXrPe51pSx4gIm7XIcw0+PvSoaXNNF+4wxrgufbh7XpMTjpGXuy3pLtN2Ag49ibuXqG
         I2KNugLLvKUI94u4qz3vA3oPV+GFvAiDd7/YK7d2fY0H8TRR4fk+gfgW1xCVtmqbY9eY
         qO0Ck6gDSx2xawp134dV+g0NjHPfE/47weH0VHn0CO+Jbzv7kcOYZLLyjFWx/D5r/wUK
         4JBg==
X-Gm-Message-State: AOUpUlHebc1mw81hwm+SIol+44iqG4fb1+bWy7H11R6Hf0hcTS+ab3rA
        LeBEY8slj5c7an+gpt0IGrgHFgWH
X-Google-Smtp-Source: AA+uWPzIelkbrNdO1JPTJc8UtuW5isEJ+i/mUPhbuOzJEOmTyJ2gICerJZ4aNVmBB9ichsButXCbnA==
X-Received: by 2002:a62:1f8c:: with SMTP id l12-v6mr8913439pfj.143.1533939272317;
        Fri, 10 Aug 2018 15:14:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id w2-v6sm10945189pge.44.2018.08.10.15.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:31 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:31 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:06 GMT
Message-Id: <7b90919685d1e94b50f5278ec1b57a59cba1f8e5.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 04/21] range-diff: improve the order of the shown commits
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

