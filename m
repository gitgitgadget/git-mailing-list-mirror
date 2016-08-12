Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F0A1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 23:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbcHLXpm (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 19:45:42 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:14609 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbcHLXpd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 19:45:33 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id YM8nbWgnZY8RwYM8obscXm; Sat, 13 Aug 2016 00:45:31 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=pGLkceISAAAA:8 a=8q6LdnVOAAAA:8 a=5rxgeBVgAAAA:8 a=FD6Yg390wA0BrhXcPeMA:9
 a=xts0dhWdiJbonKbuqhAr:22 a=6kGIvZw6iX1k4Y-7sg4_:22 a=jNYSTCpFY2gkngftge3H:22
 a=PwKx63F5tFurRwaNxrlG:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH v6 05/12] doc: revisions: extra clarification of <rev>^! notation effects
Date:	Sat, 13 Aug 2016 00:45:19 +0100
Message-Id: <20160812234522.7792-2-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812234522.7792-1-philipoakley@iee.org>
References: <20160811215035.4108-1-philipoakley@iee.org>
 <20160812234522.7792-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNs9aFPRes91QnVszPSVfvz+Eo+Kb4CuwYxQqKUvSTL6YW17+O9h5ibWKDc5mMQ78FV51EJW3mJPXVT7A8wzjWWzKoj81aT8pUc9DOqUqO78upnWFq7H
 lt9DT6hRq2wNYhyUK3QdRbFSrIUvM/wqUzR0EcGfM0rVMah5/ySvFmPPHWiQRihDFonsONmuDWTH8YpF6+Yy+MNewhqsdy1c5NlidJWuIzUpokrTZ6LHUMqa
 IjtOQxi3KAfY9zJHlZEaB7AY+MTc8O1yLNtr3SionPU=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
v6 updated
Cc: Jakub Narębski <jnareb@gmail.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
https://public-inbox.org/git/578E4F4A.2020708%40gmail.com/
---
 Documentation/revisions.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 3da0083..17fc45c 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -281,7 +281,8 @@ for naming a set that is formed by a commit and its parent commits.
 
 The 'r1{caret}@' notation means all parents of 'r1'.
 
-'r1{caret}!' includes commit 'r1' but excludes all of its parents.
+The 'r1{caret}!' notation includes commit 'r1' but excludes all of its parents.
+By itself, this notation denotes the single commit 'r1'.
 
 Revision Range Summary
 ----------------------
-- 
2.9.0.windows.1

