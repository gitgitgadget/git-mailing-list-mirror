From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Documentation/git-svnimport: document -T and -t switches correctly
Date: Sun, 1 Jan 2006 13:32:53 -0800
Message-ID: <20060101213253.GJ3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 01 22:33:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtAoz-0004MH-9j
	for gcvg-git@gmane.org; Sun, 01 Jan 2006 22:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWAAVcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jan 2006 16:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWAAVcy
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jan 2006 16:32:54 -0500
Received: from hand.yhbt.net ([66.150.188.102]:9617 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932270AbWAAVcy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jan 2006 16:32:54 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id D1B6C7DC005; Sun,  1 Jan 2006 13:32:53 -0800 (PST)
To: git list <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14133>

The -T and -t switches are swapped in the documentation and actual
code.  I've made the documentation match the code.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 Documentation/git-svnimport.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

dedc4d56fc4ad95158d9de0f3c7b46cda2746659
diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index f8dbee7..7583d78 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 --------
 'git-svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
 			[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
-			[ -b branch_subdir ] [ -t trunk_subdir ] [ -T tag_subdir ]
+			[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
 			[ -s start_chg ] [ -m ] [ -M regex ]
 			<SVN_repository_URL> [ <path> ]
 
@@ -47,10 +47,10 @@ When importing incementally, you might n
 	ensures the working directory and index remain untouched and will
 	not create them if they do not exist.
 
--t <trunk_subdir>::
+-T <trunk_subdir>::
 	Name the SVN trunk. Default "trunk".
 
--T <tag_subdir>::
+-t <tag_subdir>::
 	Name the SVN subdirectory for tags. Default "tags".
 
 -b <branch_subdir>::
-- 
1.0.GIT
