From: <amery@geeks.cl>
Subject: (unknown)
Date: Mon, 16 Jun 2008 21:42:08 +0200
Message-ID: <1213645328.474727.6881.nullmailer@rafaella.geeks.cl>
Cc: recipient list not shown:;
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Jun 16 21:50:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Ki2-0003TS-BC
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 21:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbYFPTsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbYFPTsw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 15:48:52 -0400
Received: from yoda.expert-erp.net ([88.198.9.201]:53593 "EHLO
	mail.expert-erp.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbYFPTsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 15:48:51 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jun 2008 15:48:51 EDT
Received: (qmail 8300 invoked from network); 16 Jun 2008 19:45:24 -0000
X-Mail-Scanner: Scanned by qSheff-II-2.1-r3 (http://www.enderunix.org/qsheff/)
Received: from 224.pool85-57-67.dynamic.orange.es (HELO rafaella.geeks.cl) (amery@geeks.cl@[85.57.67.224])
          (envelope-sender <amery@geeks.cl>)
          by mail.expert-erp.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 16 Jun 2008 19:45:24 -0000
Received: (nullmailer pid 6882 invoked by uid 1000);
	Mon, 16 Jun 2008 19:42:08 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85220>

>From 25cb047690dd6101527cdfa6198dd6a6f93bf095 Mon Sep 17 00:00:00 2001
From: Alejandro Mery <amery@geeks.cl>
Date: Mon, 16 Jun 2008 20:27:14 +0200
Subject: [PATCH] git-am: head -1 is obsolete and doesn't work on some new systems

http://www.opengroup.org/onlinepubs/009695399/utilities/head.html
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b48096e..797988f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -421,7 +421,7 @@ do
 	else
 	    action=yes
 	fi
-	FIRSTLINE=$(head -1 "$dotest/final-commit")
+	FIRSTLINE=$(head -n1 "$dotest/final-commit")
 
 	if test $action = skip
 	then
-- 
1.5.4.3
