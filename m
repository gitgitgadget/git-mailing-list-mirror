Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED0C2018E
	for <e@80x24.org>; Fri, 12 Aug 2016 07:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbcHLHJV (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:09:21 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:13212 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcHLHIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:49 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6ZYbadhV; Fri, 12 Aug 2016 08:08:04 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8
 a=1XWaLZrsAAAA:8 a=orvpcgupcMOaiLYd4KgA:9 a=xts0dhWdiJbonKbuqhAr:22
 a=PwKx63F5tFurRwaNxrlG:22 a=nJcEw6yWrPvoIXZ49MH8:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 06/12] doc: revisions: single vs multi-parent notation comparison
Date:	Fri, 12 Aug 2016 08:07:43 +0100
Message-Id: <20160812070749.2920-7-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfPObPgyNO4HCAUwKY/xJP9VCAEqA9oERYsGZV30EKRKQrH8FnBkGioWArB53i/xUeLI7co9SdG1lRgSBSop3JbRgUc8+RixfP4+WRE/VQW9UqW173IID
 vLMuTAVFsgqG68h3kMEipqOwpJru9axgINylYYmZK8/vTmP0joea4t51E0uCxVqwu0O3JQxYcP19NmqtTfREgut72BhCIyY3wCE=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
new
Junio's final comment https://public-inbox.org/git/xmqqwpkq6b4d.fsf%40gitster.mtv.corp.google.com/
---
 Documentation/revisions.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 0b5044d..934d071 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -284,6 +284,10 @@ The 'r1{caret}@' notation means all parents of 'r1'.
 'r1{caret}!' notation includes commit 'r1' but excludes all of its parents.
 This is the single commit 'r1', if standalone.
 
+While '<rev>{caret}<n>' was about specifying a single commit parent, these
+two notations consider all its parents. For example you can say
+'HEAD{caret}2^@', however you cannot say 'HEAD{caret}@{caret}2'.
+
 Revision Range Summary
 ----------------------
 
-- 
2.9.0.windows.1

