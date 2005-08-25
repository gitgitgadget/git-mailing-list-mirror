From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Subject: [PATCH] More missing terms in glossary.txt
Date: Thu, 25 Aug 2005 16:24:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508251622360.6088@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Aug 25 16:27:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8IeR-0004eb-KI
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 16:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVHYOYR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 10:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVHYOYR
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 10:24:17 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27349 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965018AbVHYOYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 10:24:16 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6E4E113C797; Thu, 25 Aug 2005 16:24:13 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 55F919AAB1; Thu, 25 Aug 2005 16:24:13 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3FC9F9AA71; Thu, 25 Aug 2005 16:24:13 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx67.rz.uni-wuerzburg.de [132.187.3.67])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3355213C797; Thu, 25 Aug 2005 16:24:13 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7750>

Describe a DAG and octopus, and change wording of tree object.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/glossary.txt |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

e077919262930f6ce494c963d23317eb2aaf0dd3
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -27,14 +27,20 @@ blob object::
 
 tree object::
 	An object containing a list of file names and modes along with refs
-	to the associated blob and/or tree objects. A tree object is
-	equivalent to a directory.
+	to the associated blob and/or tree objects. A tree is equivalent
+	to a directory.
 
 tree::
 	Either a working tree, or a tree object together with the
 	dependent blob and tree objects (i.e. a stored representation
 	of a working tree).
 
+DAG::
+	Directed acyclic graph. The commit objects form a directed acyclic
+	graph, because they have parents (directed), and the graph of commit
+	objects is acyclic (there is no chain which begins and ends with the
+	same object).
+
 index::
 	A collection of files with stat information, whose contents are
 	stored as objects. The cache is a stored version of your working
@@ -142,6 +148,10 @@ merge::
 	merge uses heuristics to accomplish that. Evidently, an automatic
 	merge can fail.
 
+octopus::
+	To merge more than two branches. Also denotes an intelligent
+	predator.
+
 resolve::
 	The action of fixing up manually what a failed automatic merge
 	left behind.
