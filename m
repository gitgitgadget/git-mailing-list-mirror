From: Steve Haslam <shaslam@lastminute.com>
Subject: [PATCH] Remove references to git-fetch-pack from "git clone" documentation.
Date: Fri, 25 Jul 2008 19:37:48 +0100
Message-ID: <1217011068-1675-1-git-send-email-shaslam@lastminute.com>
Cc: Steve Haslam <shaslam@lastminute.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 20:39:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMSC6-0004Z7-7r
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 20:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbYGYSiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbYGYSiI
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 14:38:08 -0400
Received: from sglonmg02-out.sabre.com ([151.193.120.24]:11500 "EHLO
	sglonmg02-out.sabre.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbYGYSiH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 14:38:07 -0400
X-ExtLoop1: From 10.136.85.17
X-IronPort-AV: E=Sophos;i="4.31,253,1215385200"; 
   d="scan'208";a="1124593377"
Received: from sglonms01.global.ad.sabre.com ([10.136.85.17])
  by sglonmg02-out.sabre.com with ESMTP; 25 Jul 2008 19:38:06 +0100
Received: from sglonms02.Global.ad.sabre.com ([10.136.85.20]) by sglonms01.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 25 Jul 2008 19:38:05 +0100
Received: from localhost.localdomain ([10.104.41.28]) by sglonms02.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 25 Jul 2008 19:38:05 +0100
X-Mailer: git-send-email 1.6.0.rc0.43.g1cd6
X-OriginalArrivalTime: 25 Jul 2008 18:38:05.0193 (UTC) FILETIME=[93735790:01C8EE85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90085>

"git clone" no longer calls "git-fetch-pack", so the documentation is a bit
stale. Instead, state that the -u option is to be used when accessing a
repository over ssh.

Signed-off-by: Steve Haslam <shaslam@lastminute.com>
---
This is somewhat related to a patch I just sent; typically I forgot
about the documentation until after sending it.

 Documentation/git-clone.txt |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 91efac9..26fd1b1 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -87,8 +87,8 @@ then the cloned repository will become corrupt.
 
 --quiet::
 -q::
-	Operate quietly.  This flag is passed to "rsync" and
-	'git-fetch-pack' commands when given.
+	Operate quietly.  This flag is also passed to the `rsync'
+	command when given.
 
 --no-checkout::
 -n::
@@ -113,9 +113,8 @@ then the cloned repository will become corrupt.
 
 --upload-pack <upload-pack>::
 -u <upload-pack>::
-	When given, and the repository to clone from is handled
-	by 'git-fetch-pack', `--exec=<upload-pack>` is passed to
-	the command to specify non-default path for the command
+	When given, and the repository to clone from is accessed
+	via ssh, this specifies a non-default path for the command
 	run on the other end.
 
 --template=<template_directory>::
-- 
1.6.0.rc0.43.g1cd6
