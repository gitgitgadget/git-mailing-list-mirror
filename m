From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Tell Eclipse not to convert some of the patch input files.
Date: Sat, 20 Dec 2008 21:42:10 +0100
Message-ID: <1229805730-11237-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Dec 20 21:43:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE8fc-0002kb-Jb
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 21:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbYLTUmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 15:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbYLTUmO
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 15:42:14 -0500
Received: from mail.dewire.com ([83.140.172.130]:5834 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406AbYLTUmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 15:42:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8FE521484F50;
	Sat, 20 Dec 2008 21:42:12 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GCE-AuoKVBZ7; Sat, 20 Dec 2008 21:42:12 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id DF5761484F4F;
	Sat, 20 Dec 2008 21:42:11 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103665>

By default Eclipse silently converts non-UTF-8 characters to
a surrogate code point when it encounters invalid UTF-8. Since
a few of the patch input files are meant to be read as bytes
it is more appropriate and safer to assume ISO-8859-1 which
can represent any byte sequence.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../.settings/org.eclipse.core.resources.prefs     |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/.settings/org.eclipse.core.resources.prefs b/org.spearce.jgit.test/.settings/org.eclipse.core.resources.prefs
index a2724ba..d691a8e 100644
--- a/org.spearce.jgit.test/.settings/org.eclipse.core.resources.prefs
+++ b/org.spearce.jgit.test/.settings/org.eclipse.core.resources.prefs
@@ -1,3 +1,6 @@
-#Mon Aug 11 16:05:15 PDT 2008
+#Sat Dec 20 21:21:24 CET 2008
 eclipse.preferences.version=1
+encoding//tst-rsrc/org/spearce/jgit/patch/testGetText_BothISO88591.patch=ISO-8859-1
+encoding//tst-rsrc/org/spearce/jgit/patch/testGetText_Convert.patch=ISO-8859-1
+encoding//tst-rsrc/org/spearce/jgit/patch/testGetText_DiffCc.patch=ISO-8859-1
 encoding/<project>=UTF-8
-- 
1.6.1.rc3.56.gd0306
