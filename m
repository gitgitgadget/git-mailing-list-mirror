From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-rebase: suggest to use git-add instead of git-update-index
Date: Sat, 2 Jun 2007 19:59:49 +0200
Message-ID: <20070602175949.GB19952@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 20:07:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuY0O-0001vF-7Q
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 20:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760556AbXFBSHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 14:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761667AbXFBSHH
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 14:07:07 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:34192 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760556AbXFBSHF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 14:07:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 654A4F008F;
	Sat,  2 Jun 2007 20:07:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s4dXGSFk6JEM; Sat,  2 Jun 2007 20:07:01 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 10427F00DB;
	Sat,  2 Jun 2007 19:59:50 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D84336DFC1C; Sat,  2 Jun 2007 19:57:43 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id ED36962A5D; Sat,  2 Jun 2007 19:59:49 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48941>

The command is part of the main porcelain making git-add more
appropriate.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 git-rebase.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

 I don't know if this is good or not, maybe it is a matter of taste, but
 as a new git user I prefer to use git add.

diff --git a/git-rebase.sh b/git-rebase.sh
index 61770b5..2aa3a01 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -55,7 +55,7 @@ continue_merge () {
 	if test -n "$unmerged"
 	then
 		echo "You still have unmerged paths in your index"
-		echo "did you forget update-index?"
+		echo "did you forget to use git add?"
 		die "$RESOLVEMSG"
 	fi
 
@@ -126,7 +126,7 @@ do
 	--continue)
 		git-diff-files --quiet || {
 			echo "You must edit all merge conflicts and then"
-			echo "mark them as resolved using git update-index"
+			echo "mark them as resolved using git add"
 			exit 1
 		}
 		if test -d "$dotest"
-- 
1.5.2.816.gc5560-dirty

-- 
Jonas Fonseca
