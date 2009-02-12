From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] bash-completion: Complete the values of color.interactive, color.ui, color.pager
Date: Thu, 12 Feb 2009 07:55:54 -0800
Message-ID: <1234454154-9739-1-git-send-email-kraai@ftbfs.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Matt Kraai <kraai@ftbfs.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 12 17:39:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXeas-0001fU-R5
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 17:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759102AbZBLQhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 11:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757488AbZBLQhu
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 11:37:50 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:33972 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758718AbZBLQht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 11:37:49 -0500
X-Greylist: delayed 2489 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2009 11:37:49 EST
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net ([71.119.193.199] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LXdv3-0003pM-Bk; Thu, 12 Feb 2009 07:56:09 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LXdus-0002XT-DQ; Thu, 12 Feb 2009 07:55:54 -0800
X-Mailer: git-send-email 1.5.6.5
X-Spam-Score-Int: -40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109629>

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f44f63c..a7a10c0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1196,10 +1196,14 @@ _git_config ()
 		__gitcomp "$(__git_merge_strategies)"
 		return
 		;;
-	color.branch|color.diff|color.status)
+	color.branch|color.diff|color.interactive|color.status|color.ui)
 		__gitcomp "always never auto"
 		return
 		;;
+	color.pager)
+		__gitcomp "false true"
+		return
+		;;
 	color.*.*)
 		__gitcomp "
 			normal black red green yellow blue magenta cyan white
-- 
1.5.6.5
