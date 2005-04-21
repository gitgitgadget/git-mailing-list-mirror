From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] README spellcheck again
Date: Thu, 21 Apr 2005 19:20:33 -0400
Message-ID: <1114125633.17161.3.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 22 01:16:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOkuD-0004dN-43
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 01:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVDUXUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 19:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVDUXUp
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 19:20:45 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:16283
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261664AbVDUXUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 19:20:35 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 017C4EFF81; Thu, 21 Apr 2005 19:20:33 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

Patch against current git, applies cleanly to both linus and pasky
branches.
Signed-off-by: Pavel Roskin <proski@gnu.org>

--- a/README
+++ b/README
@@ -95,7 +95,7 @@ The object types in some more detail:
 	In particular, since the blob is entirely defined by its data,
 	if two files in a directory tree (or in multiple different
 	versions of the repository) have the same contents, they will
-	share the same blob object. The object is toally independent
+	share the same blob object. The object is totally independent
 	of it's location in the directory tree, and renaming a file does
 	not change the object that file is associated with in any way.
 
@@ -150,7 +150,7 @@ CHANGESET: The "changeset" object is an 
 	actually have any relationship with the result, for example. 
 
 	Note on changesets: unlike real SCM's, changesets do not contain
-	rename information or file mode chane information.  All of that
+	rename information or file mode change information.  All of that
 	is implicit in the trees involved (the result tree, and the
 	result trees of the parents), and describing that makes no sense
 	in this idiotic file manager. 
@@ -322,7 +322,7 @@ main combinations: 
 	changes in your working directory (ie "update-cache").
 
 	However, if you decide to jump to a new version, or check out
-	somebody elses version, or just restore a previous tree, you'd
+	somebody else's version, or just restore a previous tree, you'd
 	populate your index file with read-tree, and then you need to
 	check out the result with
 


-- 
Regards,
Pavel Roskin

