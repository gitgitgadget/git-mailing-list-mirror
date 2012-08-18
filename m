From: Beat Bolli <bbolli@ewanet.ch>
Subject: [PATCH 1/2] git-gui: Fix a loose/lose mistake
Date: Sat, 18 Aug 2012 11:07:30 +0200
Message-ID: <1345280851-6626-1-git-send-email-bbolli@ewanet.ch>
Cc: Beat Bolli <bbolli@ewanet.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 18 11:17:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2f9t-0006ZR-0V
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 11:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab2HRJQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 05:16:42 -0400
Received: from smtp2.mail.fcom.ch ([212.60.46.171]:42212 "EHLO
	smtp2.mail.fcom.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab2HRJQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 05:16:38 -0400
Received: from smtp2.mail.fcom.ch (localhost [127.0.0.1])
	by smtp2 (Postfix) with ESMTP id 12A042D4C5;
	Sat, 18 Aug 2012 11:07:48 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp2.mail.fcom.ch
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=no version=3.2.5
Received: from drbeat.li (143-45-60-212-pool.cable.fcom.ch [212.60.45.143])
	by smtp2 (Postfix) with ESMTPS id E032D2D4C4;
	Sat, 18 Aug 2012 11:07:47 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
	id E1A3B71552; Sat, 18 Aug 2012 11:07:46 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
X-AV-Checked: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203671>

No po update needed, as this string is untranslated.

Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
---
 git-gui/lib/commit.tcl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 0d81432..78c5eeb 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -268,7 +268,7 @@ proc commit_commitmsg {curHEAD msg_p} {
 	    && 	[is_config_true gui.warndetachedcommit]} {
 		set msg [mc "You are about to commit on a detached head.\
 This is a potentially dangerous thing to do because if you switch\
-to another branch you will loose your changes and it can be difficult\
+to another branch you will lose your changes and it can be difficult\
 to retrieve them later from the reflog. You should probably cancel this\
 commit and create a new branch to continue.\n\
 \n\
-- 
1.7.10.4
