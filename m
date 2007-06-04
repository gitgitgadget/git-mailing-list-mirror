From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Makefile: Remove git-merge-base from PROGRAMS.
Date: Mon,  4 Jun 2007 13:53:05 +0200
Message-ID: <11809579853845-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 13:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvB7g-0002mB-K7
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 13:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbXFDLxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 07:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbXFDLxN
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 07:53:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59936 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbXFDLxM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 07:53:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1HvB7T-0002OX-Qn; Mon, 04 Jun 2007 13:53:08 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 10BBE6EF; Mon,  4 Jun 2007 13:53:07 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id 7619B102; Mon,  4 Jun 2007 13:53:05 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1.114.gc6c36
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49094>

git-merge-base is a builtin.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 78cd36a..b8ffc82 100644
--- a/Makefile
+++ b/Makefile
@@ -238,7 +238,6 @@ PROGRAMS = \
 	git-convert-objects$X git-fetch-pack$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-fast-import$X \
-	git-merge-base$X \
 	git-daemon$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-patch-id$X \
 	git-peek-remote$X git-receive-pack$X \
-- 
1.5.2.1.114.gc6c36
