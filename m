From: =?UTF-8?q?Christof=20Kr=C3=BCger?= <git@christof-krueger.de>
Subject: [PATCH] git-completion: added suggestions for color.grep
Date: Tue, 21 Jun 2011 21:16:47 +0200
Message-ID: <1308683807-26069-1-git-send-email-git@christof-krueger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Christof=20Kr=C3=BCger?= <git@christof-krueger.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 21:33:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ6hF-0005XE-2x
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 21:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757454Ab1FUTdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jun 2011 15:33:07 -0400
Received: from vserver.localhost.li ([85.214.46.152]:59918 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757441Ab1FUTdG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2011 15:33:06 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jun 2011 15:33:06 EDT
Received: from p5794ccea.dip.t-dialin.net ([87.148.204.234]:53806 helo=oxylap)
	by mail.localhost.li with esmtpa (Exim 4.69)
	(envelope-from <oxygene@localhost.li>)
	id 1QZ6RV-0000Rr-Ii; Tue, 21 Jun 2011 21:17:00 +0200
Received: by oxylap (Postfix, from userid 1000)
	id E77EDDC14D7; Tue, 21 Jun 2011 21:16:55 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.rc2
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176188>

Show the possible settings "always", "never" or "auto" also for color.g=
rep in
addition to the the other color.* settings.

Signed-off-by: Christof Kr=C3=BCger <git@christof-krueger.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index b36290f..4aeeee6 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1884,7 +1884,7 @@ _git_config ()
 		__gitcomp "$__git_merge_strategies"
 		return
 		;;
-	color.branch|color.diff|color.interactive|\
+	color.branch|color.diff|color.grep|color.interactive|\
 	color.showbranch|color.status|color.ui)
 		__gitcomp "always never auto"
 		return
--=20
1.7.6.rc2
