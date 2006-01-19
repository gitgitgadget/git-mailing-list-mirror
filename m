From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Unclutter cg status with --directory as GIT does
Date: Thu, 19 Jan 2006 22:16:46 +0100
Message-ID: <20060119211646.28186.18564.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 22:21:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzhDH-0006F2-4B
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 22:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161421AbWASVUq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 16:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161432AbWASVUp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 16:20:45 -0500
Received: from [151.97.230.9] ([151.97.230.9]:56732 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1161421AbWASVUp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 16:20:45 -0500
Received: (qmail 531 invoked by uid 508); 19 Jan 2006 22:20:42 +0100
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 19 Jan 2006 22:20:42 +0100
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 41BBF5D1A;
	Thu, 19 Jan 2006 22:16:46 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14933>


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Pass the new --directory option (from git 1.1) to git-ls-others for
list_untracked_files, as does git-status - it's very useful.

Probably this must be deferred to when the git 1.1 dependency is added, however
please queue it for then.

Thanks.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 cg-Xlib |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
index 30e2ee9..539c885 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -206,7 +206,7 @@ list_untracked_files()
 		fi
 		EXCLUDE="$EXCLUDE --exclude-per-directory=.gitignore"
 	fi
-	git-ls-files -z --others $EXCLUDE
+	git-ls-files -z --others --directory $EXCLUDE
 }
 
 # Usage: showdate SECONDS TIMEZONE [FORMAT]
