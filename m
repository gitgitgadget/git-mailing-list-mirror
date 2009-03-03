From: roylee@andestech.com
Subject: [PATCH] Documentation/git-archive.txt: Note attributes
Date: Wed,  4 Mar 2009 00:52:48 +0800
Message-ID: <1236099168-20231-1-git-send-email-roylee@andestech.com>
Cc: Roy Lee <roylee17@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 18:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeYCD-0008F3-EI
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbZCCRMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 12:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbZCCRMx
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:12:53 -0500
Received: from 59-124-160-117.HINET-IP.hinet.net ([59.124.160.117]:19971 "EHLO
	ATCPCS06.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbZCCRMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 12:12:53 -0500
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2009 12:12:52 EST
Received: from andestech.com ([10.0.4.60]) by ATCPCS06.andestech.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Mar 2009 00:57:33 +0800
X-Mailer: git-send-email 1.6.1.3
X-OriginalArrivalTime: 03 Mar 2009 16:57:33.0216 (UTC) FILETIME=[25677200:01C99C21]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112123>

From: Roy Lee <roylee17@gmail.com>

---
 Documentation/git-archive.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 41cbf9c..96f5424 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -88,6 +88,17 @@ tar.umask::
 	archiving user's umask will be used instead.  See umask(2) for
 	details.
 
+ATTRIBUTES
+----------------
+
+export-ignore::
+	Files and directories with the attribute export-ignore won't be added to archive files.
+	See linkgit:gitattributes[5] for details.
+
+export-subst::
+	If the attribute export-subst is set for a file then git will expand several placeholders when adding this file
+	to an archive.  See linkgit:gitattributes[5] for details.
+
 EXAMPLES
 --------
 git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)::
@@ -110,6 +121,11 @@ git archive --format=zip --prefix=git-docs/ HEAD:Documentation/ > git-1.4.0-docs
 	Put everything in the current head's Documentation/ directory
 	into 'git-1.4.0-docs.zip', with the prefix 'git-docs/'.
 
+
+SEE ALSO
+--------
+linkgit:gitattributes[5]
+
 Author
 ------
 Written by Franck Bui-Huu and Rene Scharfe.
-- 
1.6.1.3
