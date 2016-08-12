Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB98E1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 23:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbcHLXpf (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 19:45:35 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:31107 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbcHLXpe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 19:45:34 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id YM8nbWgnZY8RwYM8qbscXx; Sat, 13 Aug 2016 00:45:32 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=8q6LdnVOAAAA:8
 a=Ba-_NhNZLFHza0C8bGsA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=xts0dhWdiJbonKbuqhAr:22 a=jNYSTCpFY2gkngftge3H:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:	Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH v6 12/12] doc: revisions: sort examples and fix alignment of the unchanged
Date:	Sat, 13 Aug 2016 00:45:22 +0100
Message-Id: <20160812234522.7792-5-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812234522.7792-1-philipoakley@iee.org>
References: <20160811215035.4108-1-philipoakley@iee.org>
 <20160812234522.7792-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfI31xI8fasbwdZ5X0jwQfLot5XA2ewLxw2XNONpU5w8GOUagBsYBlIP+sbWEE4x1YVM0uuQZpX27KpWpG6vgLEEmIMGRdxtXIQiNwsXyCxqk5cojc4pI
 WYq+/9Goa5HrgN+zIr3P0STJiBgrJzhMkhnWYTpV6AfFEJRiEJWASVhYaUQcz5XI/wrHHkxj1sYUoCUM4z9ZNJv5iWCHjIO8sFI4Ynx6p2gddCAR+4AInsSW
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The previous commit adjusted the column alignment for revision
examples which show expansion. Fix the unchanged examples and sort
those that show expansions to the end of the list.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
v6 updated
Cc: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/revisions.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index f15d5ed..b9b45c0 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -331,14 +331,14 @@ with each step in the notation's expansion and selection carefully
 spelt out:
 
    Args   Expanded arguments    Selected commits
-   D                G H D
-   D F              G H I J D F
-   ^G D             H D
-   ^D B             E I J F B
+   D                            G H D
+   D F                          G H I J D F
+   ^G D                         H D
+   ^D B                         E I J F B
+   ^D B C                       E I J F B C
+   C                            I J F C
    B..C   = ^B C                C
    B...C  = B ^F C              G H D E B C
-   ^D B C           E I J F B C
-   C                I J F C
    C^@    = C^1
           = F                   I J F
    B^@    = B^1 B^2 B^3
-- 
2.9.0.windows.1

