Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 437A81F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbeGUW7H (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:07 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38873 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeGUW7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:07 -0400
Received: by mail-pg1-f181.google.com with SMTP id k3-v6so9545545pgq.5
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3yesZiepIhDgS4qQ8TNj8T2R0GFtJc8zzq8qZmhewCM=;
        b=NQYdgNiUTkQlrtB/D9ixk+yU6yWmu6cUzH5Aa5Eew+3abhRNXl12t19lKurG8cD9Yw
         Vv8Hr6/hJnuf8sNf6T4I84KmzV3pqkAGoh2yOpzAyrfTeMGgiuoWvlucHGHIAGhaBF6s
         ziOQJZmHCmkgWXTbaOBMtOf/Uw1RHJ+ZNkCFyJkxyB8dMokzFgcnGas6e6zvU737Gqo7
         8eoklwpEOogwwCjoDwegxKhJIcEmanW0pKScq9+KL1Jead1/3hxH38pWrXIvsBJ+Gmbz
         VGcl1fkVBeCWkWtoIogmnJT5/KDmZKA5NMYA1crFaXF74DAV8MfFvCUtj+PNQIjNtgqs
         lOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3yesZiepIhDgS4qQ8TNj8T2R0GFtJc8zzq8qZmhewCM=;
        b=KwTCkWTM4bOPa24+801dG1frglVPD84r0n9ndGJTuux47HOoO/AbTrVZAYA7UXgOWO
         9m3xX+chdXIhtjcmbY1gf1SW1O6t80a1qD/QYUw3JrccHo5MVD5ei/QCGMa++Z2nJY7z
         OENWMAI5/iT554pA7hAsk6IXUGZOQegaKHYaJ6R5ljnGolyMMLjwUAJgKL9vI7dKqFYT
         LB3YxcuFNCMN9NUgLsWDMltbdguQsD0AhGPLKnHyN8Eb5bI5M6OXTPqqmEnouJG92RhA
         qMLr5roolEiXVi2Rj8OxKXCL0eCvOnnXdXxA37kbggILMF9ItXfpir369c7h8LitssVN
         DMfg==
X-Gm-Message-State: AOUpUlGpmvaa+ugfNEJE1jP8bE/8+m+8e7d80oQOHP+t5Ipw14sHzfbl
        3eFTsDROONyxY/3UgIFiQKD3DZ6n
X-Google-Smtp-Source: AAOMgpeiPHgL8eyQEiDUAgWkcHCoCDY8FEPWuRYbQFdvnQJp1RHPPCcyrKMx5oPjgERAPbbI4FTcdw==
X-Received: by 2002:a65:6551:: with SMTP id a17-v6mr6857297pgw.132.1532210691308;
        Sat, 21 Jul 2018 15:04:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id k26-v6sm15250397pfb.167.2018.07.21.15.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:04:50 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:04:50 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:25 GMT
Message-Id: <47bee09b059745ed2dcc19f05ea0fc087f67d236.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 04/21] range-diff: improve the order of the shown commits
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

