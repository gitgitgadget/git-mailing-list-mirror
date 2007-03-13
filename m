From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: asciidoc formatting changes
Date: Tue, 13 Mar 2007 18:24:26 +0100
Message-ID: <117380666659-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 18:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRAzA-0000iN-Lm
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 18:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbXCMRkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 13:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbXCMRkJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 13:40:09 -0400
Received: from mail.lenk.info ([217.160.134.107]:61354 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569AbXCMRkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 13:40:08 -0400
X-Greylist: delayed 871 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Mar 2007 13:40:08 EDT
Received: from p54b0dfde.dip.t-dialin.net ([84.176.223.222] helo=goedel.djpig.de)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HRAoA-0001TI-BP; Tue, 13 Mar 2007 18:29:10 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HRAja-0003kK-Qz; Tue, 13 Mar 2007 18:24:26 +0100
X-Mailer: git-send-email 1.5.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42138>

Format some lists really as lists. Improves both html and man
output.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index e328db3..1c6f6a7 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -121,10 +121,10 @@ so that calling 'cvs' effectively calls git-cvsserver.
 Clients known to work
 ---------------------
 
-CVS 1.12.9 on Debian
-CVS 1.11.17 on MacOSX (from Fink package)
-Eclipse 3.0, 3.1.2 on MacOSX (see Eclipse CVS Client Notes)
-TortoiseCVS
+- CVS 1.12.9 on Debian
+- CVS 1.11.17 on MacOSX (from Fink package)
+- Eclipse 3.0, 3.1.2 on MacOSX (see Eclipse CVS Client Notes)
+- TortoiseCVS
 
 Operations supported
 --------------------
@@ -148,13 +148,16 @@ Copyright and Authors
 
 This program is copyright The Open University UK - 2006.
 
-Authors: Martyn Smith    <martyn@catalyst.net.nz>
-         Martin Langhoff <martin@catalyst.net.nz>
-         with ideas and patches from participants of the git-list <git@vger.kernel.org>.
+Authors:
+
+- Martyn Smith    <martyn@catalyst.net.nz>
+- Martin Langhoff <martin@catalyst.net.nz>
+
+with ideas and patches from participants of the git-list <git@vger.kernel.org>.
 
 Documentation
 --------------
-Documentation by Martyn Smith <martyn@catalyst.net.nz> and Martin Langhoff <martin@catalyst.net.nz> Matthias Urlichs <smurf@smurf.noris.de>.
+Documentation by Martyn Smith <martyn@catalyst.net.nz>, Martin Langhoff <martin@catalyst.net.nz>, and Matthias Urlichs <smurf@smurf.noris.de>.
 
 GIT
 ---
-- 
1.5.0.3
