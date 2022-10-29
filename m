Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8D8C433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 16:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ2Ql3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ2QlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 12:41:25 -0400
Received: from smtp-out-6.talktalk.net (smtp-out-6.talktalk.net [62.24.135.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1F1A81B
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 09:41:23 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id ootdodzgpnO7EooteoWf2K; Sat, 29 Oct 2022 17:41:22 +0100
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=X8gs11be c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=l4iZrl2lBOJF5wAcl3YA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Subject: [PATCH v3 3/4] glossary: add reachability bitmap description
Date:   Sat, 29 Oct 2022 17:41:11 +0100
Message-Id: <20221029164112.2097-4-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <20221029164112.2097-1-philipoakley@iee.email>
References: <20221022222539.2333-1-philipoakley@iee.email>
 <20221029164112.2097-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOKsCis3vDScwXOoU+93/5lVtlzNd3Dj8x6CzIUracups1vICUZRpsjtuwrIR1EK0mMVZuRy7Kv6idXopNzlr7ZO56RuNsyCvXphLtdanRddg32GaiUM
 cmF7PGytbO1myt8ofqqmM+iHG2b43QWL9zdvslSQ7n8zeKx1N+3wF6XVP93Da6sJZIUBHJoSCpvQ+l5KF7vWK/y5YuSvs0uUCOkmQcyx0zJTDMq08GEph58I
 yJQD4QtQbQBZ1RTaS7m5RqJH5x6LFJLG6hRu75rmN699TxaACh4u3e95Dm4eSAF4PFy+6iovh6iYrhiMrdlXYM2Y1B5+p/D2Bk93O1Zw2RW9qT7sT8Q+BANX
 5lXQYKv5
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Describe the purpose of the reachability bitmap.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/glossary-content.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index a526710278..5a537268e2 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -508,6 +508,14 @@ exclude;;
 	<<def_tree_object,trees>> to the trees or <<def_blob_object,blobs>>
 	that they contain.
 
+[[def_reachability_bitmap]]reachability bitmaps::
+	Reachability bitmaps store information about the
+	<<def_reachable,reachability>> of a selected set of commits in
+	a packfile, or a multi-pack index (MIDX), to speed up object search.
+	The bitmaps are stored in a ".bitmap" file. A repository may have at
+	most one bitmap file in use. The bitmap file may belong to either one
+	pack, or the repository's multi-pack index (if it exists).
+
 [[def_rebase]]rebase::
 	To reapply a series of changes from a <<def_branch,branch>> to a
 	different base, and reset the <<def_head,head>> of that branch
-- 
2.38.1.windows.1

