Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61362018F
	for <e@80x24.org>; Mon, 11 Jul 2016 20:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbcGKUZg (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:25:36 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:16975 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbcGKUZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:25:34 -0400
Received: from localhost.localdomain ([92.22.73.13])
	by smtp.talktalk.net with SMTP
	id MhlcbLEzMY8RwMhlkbR8mj; Mon, 11 Jul 2016 21:25:33 +0100
X-Originating-IP: [92.22.73.13]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=R5CpdR+gL2+IAQkTIkP0Ow==:117
 a=R5CpdR+gL2+IAQkTIkP0Ow==:17 a=xtxXYLxNAAAA:8 a=DVfHIANSA-IFyU9Xz_8A:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 8/8] doc: revisions - clarify reachability examples
Date:	Mon, 11 Jul 2016 21:25:18 +0100
Message-Id: <20160711202518.532-9-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160711202518.532-1-philipoakley@iee.org>
References: <20160630202509.4472-1-philipoakley@iee.org>
 <20160711202518.532-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfKo9qiuH3k+xU7qDymX0JoVRLdfyUSg8A1WpUr/rRgMfzfCWqAAjN3eprCI6fkhHgcQepHytSQC0mfG3nrzFkQ+byYmhyEVn9VW0Vz1NYrER76ptloR2
 rX2eV67hsMd4AOtmfWsZElj5o/4OsuogbR4UkfIQq90m4N50oa1rMOU+E9uO84huDp3cBXPXFLf91TiIp8LqYdkx/C5TQcutGVXUPUffQjl6OZKLeGl1s+qx
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For the r1..r2 case, the exclusion of r1, rather than inclusion of r2,
would be the unexpected case in natural language for a simple linear
development, i.e. start..end excludes start.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/revisions.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index a3cd28b..dba4fc6 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -252,7 +252,8 @@ The '{caret}' (caret) notation
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 To exclude commits reachable from a commit, a prefix '{caret}'
 notation is used.  E.g. '{caret}r1 r2' means commits reachable
-from 'r2' but exclude the ones reachable from 'r1'.
+from 'r2' but exclude those reachable from 'r1' (i.e. 'r1' and its
+ancestors).
 
 The '..' (two-dot) range notation
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -290,12 +291,12 @@ Revision Range Summary
 ----------------------
 
 '<rev>'::
-	Include commits that are reachable from (i.e. ancestors of)
-	<rev>.
+	Include commits that are reachable from <rev> (i.e. <rev> and its
+	ancestors).
 
 '{caret}<rev>'::
-	Exclude commits that are reachable from (i.e. ancestors of)
-	<rev>.
+	Exclude commits that are reachable from <rev> (i.e. <rev> and its
+	ancestors).
 
 '<rev1>..<rev2>'::
 	Include commits that are reachable from <rev2> but exclude
-- 
2.8.4.windows.1.3.ge328a54

