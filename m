From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Fix some typos in asciidoc documentation
Date: Sun, 27 May 2007 14:33:08 +0200
Message-ID: <11802692101535-git-send-email-frank@lichtenheld.de>
References: <1180269190126-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 27 14:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsICF-000432-Jw
	for gcvg-git@gmane.org; Sun, 27 May 2007 14:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbXE0Mtx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 08:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbXE0Mtw
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 08:49:52 -0400
Received: from v32413.1blu.de ([88.84.155.73]:41066 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbXE0Mtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 08:49:46 -0400
X-Greylist: delayed 981 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 May 2007 08:49:42 EDT
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HsHwU-0004eK-Qz; Sun, 27 May 2007 14:33:50 +0200
Received: from p3ee3d801.dip.t-dialin.net ([62.227.216.1] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HsHwU-0007aC-2Y; Sun, 27 May 2007 14:33:50 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HsHwK-0006Ly-HC; Sun, 27 May 2007 14:33:40 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
In-Reply-To: <1180269190126-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48537>


Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index ca7579d..e5005f0 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -86,7 +86,7 @@ write access to the log file and to the database (see
 SSH, the users of course also need write access to the git repository itself.
 
 [[configaccessmethod]]
-All configuration variables can also be overriden for a specific method of
+All configuration variables can also be overridden for a specific method of
 access. Valid method names are "ext" (for SSH access) and "pserver". The
 following example configuration would disable pserver access while still
 allowing access over SSH.
@@ -128,7 +128,7 @@ Database Backend
 
 git-cvsserver uses one database per git head (i.e. CVS module) to
 store information about the repository for faster access. The
-database doesn't contain any persitent data and can be completly
+database doesn't contain any persistent data and can be completely
 regenerated from the git repository at any time. The database
 needs to be updated (i.e. written to) after every commit.
 
-- 
1.5.2-rc3.GIT
