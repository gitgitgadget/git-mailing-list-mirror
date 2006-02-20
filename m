From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/9] git-svn: fix a typo in defining the --no-stop-on-copy option
Date: Mon, 20 Feb 2006 10:57:25 -0800
Message-ID: <11404618452729-git-send-email-normalperson@yhbt.net>
References: <11404618453236-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:57:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGDy-0001PS-UZ
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWBTS51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWBTS51
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:57:27 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55483 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932625AbWBTS50 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 13:57:26 -0500
Received: from untitled (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D427D2DC097;
	Mon, 20 Feb 2006 10:57:25 -0800 (PST)
In-Reply-To: <11404618453236-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16488>

Just a typo, I doubt anybody would use (and I highly recommend not
using) this option anyways.  But you never know...

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7292b0320d5aab4f335b7c1198b77231bf78d44a
diff --git a/contrib/git-svn/git-svn b/contrib/git-svn/git-svn
index 71a8b3b..1a8f40e 100755
--- a/contrib/git-svn/git-svn
+++ b/contrib/git-svn/git-svn
@@ -38,7 +38,7 @@ GetOptions(	'revision|r=s' => \$_revisio
 		'edit|e' => \$_edit,
 		'rmdir' => \$_rmdir,
 		'help|H|h' => \$_help,
-		'no-stop-copy' => \$_no_stop_copy );
+		'no-stop-on-copy' => \$_no_stop_copy );
 my %cmd = (
 	fetch => [ \&fetch, "Download new revisions from SVN" ],
 	init => [ \&init, "Initialize and fetch (import)"],
-- 
1.2.0.gdee6
