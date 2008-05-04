Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 18580 invoked by uid 111); 4 May 2008 17:10:43 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 May 2008 13:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbYEDRKM (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 May 2008 13:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbYEDRKM
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 13:10:12 -0400
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:59740 "EHLO
	randymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750737AbYEDRKL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2008 13:10:11 -0400
Received: from localhost.localdomain (c-24-91-11-245.hsd1.ma.comcast.net [24.91.11.245])
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id A6D95185D5A;
	Sun,  4 May 2008 10:10:10 -0700 (PDT)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH (resend)] filter-branch: Fix word usage in documentation
Date:	Sun,  4 May 2008 13:10:09 -0400
Message-Id: <1209921009-19537-1-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.5.1.243.g4a6979
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
index 8d80f0d..959a9e9 100644
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
1.5.5.1.243.g4a6979

