Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 26092 invoked by uid 111); 15 May 2008 03:16:12 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 14 May 2008 23:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757827AbYEODPr (ORCPT <rfc822;peff@peff.net>);
	Wed, 14 May 2008 23:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757835AbYEODPr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 23:15:47 -0400
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:50217
	"EHLO randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754254AbYEODPq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 23:15:46 -0400
Received: from localhost.localdomain (c-24-91-11-245.hsd1.ma.comcast.net [24.91.11.245])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 29111AF8F4;
	Wed, 14 May 2008 20:15:45 -0700 (PDT)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Documentation/git-filter-branch: Fix word usage for --commit-filter
Date:	Wed, 14 May 2008 23:15:44 -0400
Message-Id: <1210821344-3803-1-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.5.1.373.g4a2ed
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The documentation for --commit-filter in git-filter-branch talks about
setting multiple parents for the "ancestors of the original commit".
It really meant to say the "children of the original commit".

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 Documentation/git-filter-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 8d80f0d..137e2ec 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -113,7 +113,7 @@ OPTIONS
 	stdin.  The commit id is expected on stdout.
 +
 As a special extension, the commit filter may emit multiple
-commit ids; in that case, ancestors of the original commit will
+commit ids; in that case, children of the original commit will
 have all of them as parents.
 +
 You can use the 'map' convenience function in this filter, and other
-- 
1.5.5.1.373.g4a2ed

