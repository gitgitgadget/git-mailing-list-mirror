From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: starting a 1.1.0-pre development version
Date: Tue, 23 May 2006 19:23:40 -0700
Message-ID: <11484374222795-git-send-email-normalperson@yhbt.net>
References: <11484374214073-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 24 04:23:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fij2K-00079h-AO
	for gcvg-git@gmane.org; Wed, 24 May 2006 04:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWEXCXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 22:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWEXCXq
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 22:23:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:36228 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932551AbWEXCXp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 22:23:45 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 05A4A7DC020;
	Tue, 23 May 2006 19:23:43 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 23 May 2006 19:23:42 -0700
To: Tommi Virtanen <tv@inoi.fi>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <11484374214073-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20660>

Some not-very-well-tested changes coming...

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

49967a4b7bc2c9938b0ebf0670cd47d4ccfe85a3
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index de13a96..39471b5 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -8,7 +8,7 @@ use vars qw/	$AUTHOR $VERSION
 		$GIT_SVN_INDEX $GIT_SVN
 		$GIT_DIR $REV_DIR/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
-$VERSION = '1.0.0';
+$VERSION = '1.1.0-pre';
 
 use Cwd qw/abs_path/;
 $GIT_DIR = abs_path($ENV{GIT_DIR} || '.git');
-- 
1.3.2.g7d11
