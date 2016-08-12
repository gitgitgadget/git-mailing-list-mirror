Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E64203BD
	for <e@80x24.org>; Fri, 12 Aug 2016 07:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbcHLHJV (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:09:21 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:12464 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbcHLHIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:49 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6ZZbadhd; Fri, 12 Aug 2016 08:08:05 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=gqYX7573AvRiT2ppeXYA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 10/12] doc: revisions - clarify reachability examples
Date:	Fri, 12 Aug 2016 08:07:47 +0100
Message-Id: <20160812070749.2920-11-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfAPEIz5GC19mCUJ+RbwPPVl4n4H7JDNQIc2Gy7N4FsdFcYavWcNUiJNOpqtYHY3ey4sUqGOfwFGkWVNX7wRTazlns4RV4pnQLDQl9nv6RcvGTi0dkWnV
 e1VHl6tpHLcZ+S+zuanRs4Hc8uMmYzDZMzl2N7O+KNDmeBA4Ryf1686EA/uc51kLNipEDxdzOBKlC4PybU2Liq+H6CqYRyvlRa8=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

 For the r1..r2 case, the exclusion of r1, rather than inclusion of r2,
 would be the unexpected case in natural language for a simple linear
 development, i.e. start..end excludes start.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
unchanged
---
 Documentation/revisions.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 238be45..70864d5 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -254,7 +254,8 @@ Commit Exclusions
 '{caret}<rev>' (caret) Notation::
  To exclude commits reachable from a commit, a prefix '{caret}'
  notation is used.  E.g. '{caret}r1 r2' means commits reachable
- from 'r2' but exclude the ones reachable from 'r1'.
+ from 'r2' but exclude the ones reachable from 'r1' (i.e. 'r1' and
+ its ancestors).
 
 Dotted Range Notations
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -298,12 +299,12 @@ Revision Range Summary
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
2.9.0.windows.1

