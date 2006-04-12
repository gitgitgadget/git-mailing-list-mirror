From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/3] Add list of bugs to TODO
Date: Wed, 12 Apr 2006 23:21:13 +0200
Message-ID: <20060412212113.14579.86918.stgit@gandelf.nowhere.earth>
References: <20060412211633.14579.98008.stgit@gandelf.nowhere.earth>
X-From: git-owner@vger.kernel.org Wed Apr 12 23:19:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTmk9-0004mx-BT
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 23:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWDLVTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 17:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWDLVTH
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 17:19:07 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:32728 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932317AbWDLVTG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Apr 2006 17:19:06 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 3649317E68
	for <git@vger.kernel.org>; Wed, 12 Apr 2006 23:19:05 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FTmt2-0008P7-1l
	for git@vger.kernel.org; Wed, 12 Apr 2006 23:28:28 +0200
To: git@vger.kernel.org
In-Reply-To: <20060412211633.14579.98008.stgit@gandelf.nowhere.earth>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18641>

From:  <>


---

 TODO |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index e5affe0..a9a8b1f 100644
--- a/TODO
+++ b/TODO
@@ -17,3 +17,12 @@ The future, when time allows or if someo
   synchronising with other patches (diff format or in other
   repositories)
 - write bash-completion script for the StGIT commands
+- support for branches with / in names
+  (ml: "Handle branch names with slashes")
+- "pull" argument should default to a sane value, "origin" is wrong in
+  many cases
+
+Bugs:
+
+- the following commands break in subdirs:
+  - refresh (ml: "Running StGIT in subdirectories")
