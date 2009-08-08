From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] pull: Change tab to spaces in error mesage
Date: Sat,  8 Aug 2009 11:51:52 -0700
Message-ID: <1249757512-21492-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 08 21:38:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZrkA-0005Li-PT
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 21:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbZHHTiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 15:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbZHHTiI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 15:38:08 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:37008 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbZHHTiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 15:38:08 -0400
X-Greylist: delayed 2632 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Aug 2009 15:38:08 EDT
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net ([71.119.193.199] helo=macbookpro)
	by neon.ftbfs.org with esmtpa (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1MZr3R-000099-Ch; Sat, 08 Aug 2009 11:54:13 -0700
Received: from kraai by macbookpro with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1MZr1K-0005rd-9B; Sat, 08 Aug 2009 11:51:58 -0700
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125298>

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 git-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0f24182..9ad3662 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -99,7 +99,7 @@ error_on_no_merge_candidates () {
 	else
 		echo "You asked me to pull without telling me which branch you"
 		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
-		echo "your configuration file does not tell me either.	Please"
+		echo "your configuration file does not tell me either.  Please"
 		echo "specify which branch you want to merge on the command line and"
 		echo "try again (e.g. 'git pull <repository> <refspec>')."
 		echo "See git-pull(1) for details."
-- 
1.6.3.3
