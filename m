Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5AD22018E
	for <e@80x24.org>; Fri, 12 Aug 2016 07:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbcHLHJ2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:09:28 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:9904 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbcHLHIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:49 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6ZXbadhS; Fri, 12 Aug 2016 08:08:04 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=pGLkceISAAAA:8 a=5rxgeBVgAAAA:8 a=_RJ5SwgsqgWmaQhTfvIA:9
 a=xts0dhWdiJbonKbuqhAr:22 a=6kGIvZw6iX1k4Y-7sg4_:22 a=PwKx63F5tFurRwaNxrlG:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 05/12] doc: revisions: extra clarification of <rev>^! notation effects
Date:	Fri, 12 Aug 2016 08:07:42 +0100
Message-Id: <20160812070749.2920-6-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPObPgyNO4HCAUwKY/xJP9VCAEqA9oERYsGZV30EKRKQrH8FnBkGioWArB53i/xUeLI7co9SdG1lRgSBSop3JbRgUc8+RixfP4+WRE/VQW9UqW173IID
 vLMuTAVFsgqG68XRzhD0PE05gPTST0quv7XSwZ5Z8tzXTcdUDg/8gsoMunF+Ls6GokKwFawbfPSgsFxPNIVbNxuRo6TqAX5TXCK5zAkcV4w5LwFOB930hKnt
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
new
Cc: Jakub Narębski <jnareb@gmail.com>
https://public-inbox.org/git/578E4F4A.2020708%40gmail.com/
---
 Documentation/revisions.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 3da0083..0b5044d 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -281,7 +281,8 @@ for naming a set that is formed by a commit and its parent commits.
 
 The 'r1{caret}@' notation means all parents of 'r1'.
 
-'r1{caret}!' includes commit 'r1' but excludes all of its parents.
+'r1{caret}!' notation includes commit 'r1' but excludes all of its parents.
+This is the single commit 'r1', if standalone.
 
 Revision Range Summary
 ----------------------
-- 
2.9.0.windows.1

