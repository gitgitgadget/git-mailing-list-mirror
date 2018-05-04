Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64571200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEDPfe (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:35:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:40231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751394AbeEDPet (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:49 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MGSDw-1fAAkr2Oem-00DJrU; Fri, 04 May 2018 17:34:41 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/18] branch-diff: improve the order of the shown commits
Date:   Fri,  4 May 2018 17:34:39 +0200
Message-Id: <3032e2709b858c1c08e7ef47a0fd6deee7f0d010.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sXRplXjC9ABliuhbI4Unt7Bp02mVyg1PjQhoX15iuZO7fM0BkV/
 zLHsyh2nRcfqZ9KSv2AAOcDv/7wo2WK9/OHJOU5YhsDMGoPWSqROgcdQiu9bDESwgB8LcdX
 TSTuo5Yhe6oIfUde676UQXjTGqZA0tsUL5b8xsVybbK23zoTPnB9nF8nmTbw7y3uZD4Xmzs
 Qxd7goVa1H2hv0aUry/yQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c8zqoiSOhHU=:MTm6pmcdXPhu9kcLaePWp5
 10bBuh6zIPhwCT4zCZaJ/pb/+kSAvD25+7XH0LUgE/zVZbDOOzexDfSfll8PN0bDyloo+UwIx
 vSVHI2lMou/HpQlwChzidjITcxspVZNJOJortPdltSikPzVxNunJ2ytA65nwDY+GSE8mLo4DG
 OLSb7IhQ8DNxNPKJUAh+TurXM8xHJjCer7uYu5Y5YCroOsD9jwJRBmaO4cuepVg+rEYWDoyeQ
 oFYDsZiGZ2I8KlMmYjDo56ukNQWV7smLmtvHB5l8fWJeVf08ypQdybQhDgDLf/y9GzKCiojst
 2OESkBJyMQvG1wp4EmRPLiPLRrWTB2kYm7LoqEvsm2gAAQHkpRUk7L5/UGHoItLabjK4vP915
 xJ8nm577pA9cEpg28PG9FaxcxTY/TFOFuOEUDtwia5FfCSt3hTjCKFFhWppic2GATxQb8n7J8
 lDOx0izNib8dkO33QR0arqEGV+swEibugwOt8jiZNqN0tBz5lS+d0UxQNEBfGsOazLOAMi/jR
 psiUQSsGUKodPglkTPb4w61ao2Mh6GhgItut8X95/PIoQ3bT2Ldy31gyGwRqChFv7stWA4C1N
 ZKOtMTc5M2APRo/HDLiNdm5J0xBty43TC4oHhHhdSCIFPhrwEXoyq1PtC5SH3ftQztJ/716ge
 PbXKRmbKW5iIB4cXJIwnsSv7N+NsGQzG4VF4xU+DFujAJdFXeXbl6OopAzsjSBQwDTFJhJfuQ
 frLJesoZkhcqADQM6NXz3M6euUisFZK+xRRKSAdAksq2qR5zsCBNErQnjnNWGRRPUlnmUQphh
 y/tZhfp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch lets branch-diff use the same order as tbdiff.

The idea is simple: for left-to-right readers, it is natural to assume
that the branch-diff is performed between an older vs a newer version of
the branch. As such, the user is probably more interested in the
question "where did this come from?" rather than "where did that one
go?".

To that end, we list the commits in the order of the second commit range
("the newer version"), inserting the unmatched commits of the first
commit range as soon as all their predecessors have been shown.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 59 +++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index c462681067c..92302b1c339 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -31,7 +31,7 @@ struct patch_util {
 	struct hashmap_entry e;
 	const char *diff, *patch;
 
-	int i;
+	int i, shown;
 	int diffsize;
 	size_t diff_offset;
 	/* the index of the matching item in the other branch, or -1 */
@@ -274,28 +274,49 @@ static const char *short_oid(struct patch_util *util)
 
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
2.17.0.409.g71698f11835


