Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 6104 invoked by uid 111); 25 Apr 2008 16:17:31 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 25 Apr 2008 12:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762682AbYDYQRE (ORCPT <rfc822;peff@peff.net>);
	Fri, 25 Apr 2008 12:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761290AbYDYQRD
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 12:17:03 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:56219 "EHLO
	randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758884AbYDYQRB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2008 12:17:01 -0400
Received: from localhost.localdomain (kballard.res.wpi.net [130.215.239.91])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id 3D759EF3AE;
	Fri, 25 Apr 2008 09:17:00 -0700 (PDT)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH] filter-branch: Fix word usage in documentation
Date:	Fri, 25 Apr 2008 12:16:59 -0400
Message-Id: <1209140219-79259-1-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.5.1.141.gd55b
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The documentation for --commit-filter in git-filter-branch talks about
setting multiple parents for the "ancestors of the original commit".
This is logically impossible. I believe the intended word was "descendants".

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 Documentation/git-filter-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 9d11b41..1fe2b42 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -113,7 +113,7 @@ OPTIONS
 	stdin.  The commit id is expected on stdout.
 +
 As a special extension, the commit filter may emit multiple
-commit ids; in that case, ancestors of the original commit will
+commit ids; in that case, descendants of the original commit will
 have all of them as parents.
 +
 You can use the 'map' convenience function in this filter, and other
-- 
1.5.5.1.141.gd55b

