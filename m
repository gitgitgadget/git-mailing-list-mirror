X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: andyparkins@gmail.com
Subject: (unknown)
Date: Wed, 25 Oct 2006 15:50:05 +0100
Message-ID: <E1Gck4z-0003JK-00@dvr.360vision.com>
NNTP-Posting-Date: Wed, 25 Oct 2006 14:50:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-OriginalArrivalTime: 25 Oct 2006 14:53:05.0223 (UTC) FILETIME=[46E12570:01C6F845]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30062>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gck56-0006dR-J0 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 16:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932432AbWJYOuI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 10:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWJYOuI
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 10:50:08 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:50455 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S932432AbWJYOuH
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 10:50:07 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Wed, 25 Oct 2006 15:53:05 +0100
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gck4z-0003JK-00 for <git@vger.kernel.org>; Wed, 25 Oct
 2006 15:50:05 +0100
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org

From f52af4e576cb1ad688c72f6cc1443443b7d12b69 Mon Sep 17 00:00:00 2001
From: Andy Parkins <andyparkins@gmail.com>
Date: Wed, 25 Oct 2006 15:50:03 +0100
Subject: [PATCH] git-clone documentation didn't mention --origin as equivalent of -o
To: git@vger.kernel.org
X-Length: 979
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251550.04024.andyparkins@gmail.com>

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/git-clone.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
X-TUID: 4aebd5773bc8eef9

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f973c64..e22a036 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -75,6 +75,7 @@ OPTIONS
 	this option is used, neither the `origin` branch nor the
 	default `remotes/origin` file is created.
 
+--origin::
 -o <name>::
 	Instead of using the branch name 'origin' to keep track
 	of the upstream repository, use <name> instead.  Note
-- 
1.4.2.3
