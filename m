From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: version 0.10.0
Date: Sun, 26 Feb 2006 02:22:27 -0800
Message-ID: <11409493472879-git-send-email-normalperson@yhbt.net>
References: <11409493473344-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 26 11:22:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDJ2v-0003Fz-U6
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 11:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWBZKWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 05:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWBZKWa
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 05:22:30 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57506 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751313AbWBZKW2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 05:22:28 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1B92D2DC08B;
	Sun, 26 Feb 2006 02:22:28 -0800 (PST)
In-Reply-To: <11409493473344-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16777>

New features deserve an increment of the minor version.  This will very
likely become 1.0.0 unless release-critical bugs are found.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8d35c4193507147a6caa8a25b0ed1e5e9c43a49c
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 29c8690..9f12836 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -8,7 +8,7 @@ use vars qw/	$AUTHOR $VERSION
 		$GIT_SVN_INDEX $GIT_SVN
 		$GIT_DIR $REV_DIR/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
-$VERSION = '0.9.1';
+$VERSION = '0.10.0';
 $GIT_DIR = $ENV{GIT_DIR} || "$ENV{PWD}/.git";
 $GIT_SVN = $ENV{GIT_SVN_ID} || 'git-svn';
 $GIT_SVN_INDEX = "$GIT_DIR/$GIT_SVN/index";
-- 
1.2.2.ga559
