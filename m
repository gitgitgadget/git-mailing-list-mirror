From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] Add instructions to commit template.
Date: Fri, 26 May 2006 01:42:18 +0200
Message-ID: <20060525234218.GB14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 26 01:42:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjPTL-0007Vo-DA
	for gcvg-git@gmane.org; Fri, 26 May 2006 01:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWEYXmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 19:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbWEYXmU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 19:42:20 -0400
Received: from admingilde.org ([213.95.32.146]:22155 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S965170AbWEYXmT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 19:42:19 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FjPT8-0005eo-TH
	for git@vger.kernel.org; Fri, 26 May 2006 01:42:18 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20772>

New users can be irritated by the git status text in their editor.
Let's give them a short help.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 git-commit.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 6785826..1983d45 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -626,6 +626,9 @@ fi
 if test -z "$no_edit"
 then
 	{
+		echo ""
+		echo "# Please enter the commit message for your changes."
+		echo "# (Comment lines starting with '#' will not be included)"
 		test -z "$only_include_assumed" || echo "$only_include_assumed"
 		run_status
 	} >>"$GIT_DIR"/COMMIT_EDITMSG
-- 
1.3.3.gc6dc-dirty


-- 
Martin Waitz
