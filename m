From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Unclutter cg status with --directory as GIT does
Date: Wed, 29 Mar 2006 16:25:59 +0200
Message-ID: <20060329142559.12059.52795.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 16:50:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FObzS-0006Jj-GA
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 16:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWC2Otk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 09:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWC2Otk
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 09:49:40 -0500
Received: from [151.97.230.9] ([151.97.230.9]:57014 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1750735AbWC2Otj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 09:49:39 -0500
Received: (qmail 16369 invoked by uid 508); 29 Mar 2006 16:49:37 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 29 Mar 2006 16:49:37 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id C97FC258CE;
	Wed, 29 Mar 2006 16:25:59 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18168>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

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
index 2b93c11..3150470 100644
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -274,7 +274,7 @@ list_untracked_files()
 	fi
 	local listdirs=
 	[ "$squashflag" = "squashdirs" ] && listdirs=--directory
-	git-ls-files -z --others $listdirs "${EXCLUDE[@]}"
+	git-ls-files -z --others --directory $listdirs "${EXCLUDE[@]}"
 }
 
 pick_id()
