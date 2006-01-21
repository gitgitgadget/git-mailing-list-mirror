From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Mention install-doc in INSTALL
Date: Sat, 21 Jan 2006 18:54:12 -0500
Message-ID: <E1F0SYe-0005ix-WB@puzzle.fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 00:55:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0SZP-0000Zt-QX
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 00:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWAUXyS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWAUXyS
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 18:54:18 -0500
Received: from mail.fieldses.org ([66.93.2.214]:46267 "EHLO
	puzzle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751232AbWAUXyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 18:54:16 -0500
Received: from bfields by puzzle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F0SYe-0005ix-WB; Sat, 21 Jan 2006 18:54:13 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15030>

I think most people will want to install the man pages as well.

(I'm less sure about the case of the home directory, as I assume there's
unlikely to be a reasonable place to install man pages to in that case.)

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

 INSTALL |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

81333d4427d75d039c6b5b5bd3c5b71e236ff187
diff --git a/INSTALL b/INSTALL
index 916ddd4..6fb826a 100644
--- a/INSTALL
+++ b/INSTALL
@@ -6,7 +6,7 @@ will install the git programs in your ow
 to do a global install, you can do
 
 	$ make prefix=/usr ;# as yourself
-	# make prefix=/usr install ;# as root
+	# make prefix=/usr install install-doc ;# as root
 
 (or prefix=/usr/local, of course).  Just like any program suite
 that uses $prefix, the built results have some paths encoded,
-- 
0.99.8b-g58e3
