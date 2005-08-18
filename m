From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Subject: [PATCH] Updates to glossary
Date: Thu, 18 Aug 2005 21:17:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508182117160.6210@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Aug 18 21:21:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5ptt-0006UX-LY
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 21:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVHRTRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 15:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVHRTRt
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 15:17:49 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:16844 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932386AbVHRTRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 15:17:49 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C4C09136847; Thu, 18 Aug 2005 21:17:47 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A87E3B099C; Thu, 18 Aug 2005 21:17:47 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 83DB5B096E; Thu, 18 Aug 2005 21:17:47 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 577A9136847; Thu, 18 Aug 2005 21:17:47 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Changes to the descriptions of tree and tag objects, a link for ent, and
descriptions for rewind, rebase and core git were added.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

 Documentation/glossary.txt |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

83d69aaac371160ea0da0a6de6c9898c8f6915b2
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -26,9 +26,9 @@ blob object::
 	Untyped object, e.g. the contents of a file.
 
 tree object::
-	An object containing a list of blob and/or tree objects.
-	(A tree usually corresponds to a directory without
-	subdirectories).
+	An object containing a list of file names and modes along with refs
+	to the associated blob and/or tree objects. A tree object is
+	equivalent to a directory.
 
 tree::
 	Either a working tree, or a tree object together with the
@@ -118,11 +118,14 @@ tree-ish::
 	tag object pointing to a tag or commit or tree object.
 
 ent::
-	Favorite synonym to "tree-ish" by some total geeks.
+	Favorite synonym to "tree-ish" by some total geeks. See
+	http://en.wikipedia.org/wiki/Ent_(Middle-earth) for an in-depth
+	explanation.
 
 tag object::
-	An object containing a ref pointing to another object. It can
-	contain a (PGP) signature, in which case it is called "signed
+	An object containing a ref pointing to another object, which can
+	contain a message just like a commit object. It can also
+	contain a (PGP) signature, in which case it is called a "signed
 	tag object".
 
 tag::
@@ -143,6 +146,15 @@ resolve::
 	The action of fixing up manually what a failed automatic merge
 	left behind.
 
+rewind::
+	To throw away part of the development, i.e. to assign the head to
+	an earlier revision.
+
+rebase::
+	To clean a branch by starting from the head of the main line of
+	development ("master"), and reapply the (possibly cherry-picked)
+	changes from that branch.
+
 repository::
 	A collection of refs together with an object database containing
 	all objects, which are reachable from the refs, possibly accompanied
@@ -196,6 +208,10 @@ pack index::
 	The list of identifiers, and other information, of the objects in a
 	pack, to assist in efficiently accessing the contents of a pack. 
 
+core git::
+	Fundamental data structures and utilities of git. Exposes only
+	limited source code management tools.
+
 plumbing::
 	Cute name for core git.
 
