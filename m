From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] [PATCH] Doc: replace read-cache with git-read-tree.
Date: Fri, 02 Sep 2005 11:56:52 +0200
Message-ID: <20050902095651.13237.59602.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 12:11:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB8V1-0005fa-GT
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 12:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVIBKKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 06:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVIBKKP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 06:10:15 -0400
Received: from [151.97.230.9] ([151.97.230.9]:13800 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1750962AbVIBKKO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 06:10:14 -0400
Received: (qmail 12063 invoked by uid 508); 2 Sep 2005 12:10:07 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 2 Sep 2005 12:10:07 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id E34011A568D;
	Fri,  2 Sep 2005 11:56:53 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8015>

Replace references to "read-cache" with references to git-read-tree in the
documentation. I chose that because reference say "see read-cache about
stages", and stages are explained in git-read-tree.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 Documentation/git-ls-files.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -88,7 +88,7 @@ For an unmerged path, instead of recordi
 the dircache records up to three such pairs; one from tree O in stage
 1, A in stage 2, and B in stage 3.  This information can be used by
 the user (or the porcelain) to see what should eventually be recorded at the
-path. (see read-cache for more information on state)
+path. (see git-read-tree for more information on state)
 
 
 Exclude Patterns
@@ -180,7 +180,7 @@ An example:
 
 See Also
 --------
-link:read-cache.html[read-cache]
+link:git-read-tree.html[git-read-tree]
 
 
 Author
