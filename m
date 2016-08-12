Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4361F859
	for <e@80x24.org>; Fri, 12 Aug 2016 23:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbcHLXpf (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 19:45:35 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:28062 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbcHLXpd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 19:45:33 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id YM8nbWgnZY8RwYM8pbscXq; Sat, 13 Aug 2016 00:45:32 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8
 a=1XWaLZrsAAAA:8 a=8q6LdnVOAAAA:8 a=4yE7JlGXE09ExGFIikoA:9
 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22 a=nJcEw6yWrPvoIXZ49MH8:22
 a=jNYSTCpFY2gkngftge3H:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:	Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH v6 06/12] doc: revisions: single vs multi-parent notation comparison
Date:	Sat, 13 Aug 2016 00:45:20 +0100
Message-Id: <20160812234522.7792-3-philipoakley@iee.org>
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

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
v6 updated
Junio's final comment https://public-inbox.org/git/xmqqwpkq6b4d.fsf%40gitster.mtv.corp.google.com/
Cc: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/revisions.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 17fc45c..242123b 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -284,6 +284,10 @@ The 'r1{caret}@' notation means all parents of 'r1'.
 The 'r1{caret}!' notation includes commit 'r1' but excludes all of its parents.
 By itself, this notation denotes the single commit 'r1'.
 
+While '<rev>{caret}<n>' was about specifying a single commit parent, these
+two notations consider all its parents. For example you can say
+'HEAD{caret}2{caret}@', however you cannot say 'HEAD{caret}@{caret}2'.
+
 Revision Range Summary
 ----------------------
 
-- 
2.9.0.windows.1

