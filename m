From: bfields@fieldses.org
Subject: [PATCH 2/5] documentation: add brief mention of cat-file to tutorial part I
Date: Mon, 29 May 2006 19:31:33 -0400
Message-ID: <1148945496592-git-send-email-bfields@fieldses.org>
References: <11489454961705-git-send-email-bfields@fieldses.org>
Reply-To: bfields@fieldses.org
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 01:33:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkrEo-0001pI-54
	for gcvg-git@gmane.org; Tue, 30 May 2006 01:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWE2Xd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 19:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWE2Xd1
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 19:33:27 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:10448 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1750716AbWE2Xd0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 19:33:26 -0400
Received: from puzzle.fieldses.org (c-68-40-201-198.hsd1.mi.comcast.net [68.40.201.198])
	by zeus2.kernel.org (8.13.1/8.13.1) with ESMTP id k4TNXDV8014050
	for <git@vger.kernel.org>; Mon, 29 May 2006 23:33:26 GMT
Received: from bfields by puzzle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1FkrCy-0005Kw-MM; Mon, 29 May 2006 19:31:36 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.3.g2506
In-Reply-To: <11489454961705-git-send-email-bfields@fieldses.org>
X-Virus-Scanned: ClamAV 0.88.2/1499/Mon May 29 20:35:17 2006 on zeus2.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20997>

From: J. Bruce Fields <bfields@citi.umich.edu>

I'd rather avoid git cat-file so early on, but the

	git-cat-file -p old-commit:/path/to/file

trick is too useful....

Also fix a nearby typo while we're at it.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

e47d8a459f0a2407304c9b7165b30746baa7fe29
 Documentation/tutorial.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

e47d8a459f0a2407304c9b7165b30746baa7fe29
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 5fdeab9..039a859 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -435,12 +435,18 @@ adjust gitk's fonts by holding down the 
 
 Finally, most commands that take filenames will optionally allow you
 to precede any filename by a commit, to specify a particular version
-fo the file:
+of the file:
 
 -------------------------------------
 $ git diff v2.5:Makefile HEAD:Makefile.in
 -------------------------------------
 
+You can also use "git cat-file -p" to see any such file:
+
+-------------------------------------
+$ git cat-file -p v2.5:Makefile
+-------------------------------------
+
 Next Steps
 ----------
 
-- 
1.3.3.gff62
