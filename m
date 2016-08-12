Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462722018E
	for <e@80x24.org>; Fri, 12 Aug 2016 07:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbcHLHIz (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:08:55 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:63333 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbcHLHIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:50 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6Zabadhi; Fri, 12 Aug 2016 08:08:06 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=Ba-_NhNZLFHza0C8bGsA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 12/12] doc: revisions: sort examples and fix alignment of the unchanged
Date:	Fri, 12 Aug 2016 08:07:49 +0100
Message-Id: <20160812070749.2920-13-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfCBS9AeE/RGdlUBRsgHYjGrqJ+nRqAzG7WAqhLEGNdSFonVoup6FYFBSfXdhmdi4uiOJnLxZrcEVtwQTecRslicZcCM4TR+WcVHctEVyTzwZ5dA4bxQd
 8XHJlcOc3WVstasmu/34Bubk5F3l/CXt6+j1VMN2c8gD/C7gcmdA44aPqukBW8W9icKeDBeFefw/pa57L8BP7juQA0yew869W8k=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The previous commit adjusted the column alignment for revision
examples which show expansion. Fix the unchanged examples and sort
those that show expansions to the end of the list.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
new
---
 Documentation/revisions.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index ac7dd8e..8d65986 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -329,14 +329,14 @@ Revision Range Summary
 Here are a handful of examples using the Loeliger illustration above:
 
    Args   Expansion       Selection
-   D                G H D
-   D F              G H I J D F
-   ^G D             H D
-   ^D B             E I J F B
+   D                      G H D
+   D F                    G H I J D F
+   ^G D                   H D
+   ^D B                   E I J F B
+   ^D B C                 E I J F B C
+   C                      I J F C
    B..C   = ^B C          C
    B...C  = B ^F C        G H D E B C
-   ^D B C           E I J F B C
-   C                I J F C
    C^@    = C^1
           = F             I J F
    B^@    = B^1 B^2 B^3
-- 
2.9.0.windows.1

