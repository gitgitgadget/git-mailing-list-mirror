From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] cvsimport: added warning doc, cvsimport may fail to handle history
Date: Mon,  9 Jul 2007 07:42:42 +0200
Message-ID: <11839597623847-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 07:42:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7m1G-0001In-HA
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 07:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbXGIFmo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 01:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbXGIFmo
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 01:42:44 -0400
Received: from mailer.zib.de ([130.73.108.11]:55458 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbXGIFmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 01:42:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l695ggaY001697
	for <git@vger.kernel.org>; Mon, 9 Jul 2007 07:42:42 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l695ggWb025759;
	Mon, 9 Jul 2007 07:42:42 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51958>

There are discussions on the mailing list that git-cvsimport
fails to handle history. This should be noted in the documentation
of cvsimport.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-cvsimport.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index fdd7ec7..b4a5ebd 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -31,6 +31,16 @@ to work with; after that, you need to 'git merge' incremental imports, or
 any CVS branches, yourself.  It is advisable to specify a named remote via
 -r to separate and protect the incoming branches.
 
+There were rumors on the mailing list that git-cvsimport fails to
+handle history correctly.  Especially cvs branches seem to cause 
+problems. See the following thread on the mailing list for more details
+link:http://marc.info/?t=118385570200002&r=1&w=2[http://marc.info/?t=118385570200002&r=1&w=2].
+Alternatives discussed on the mailing list are
+
+  * parsecvs from link:http://anongit.freedesktop.org/git/users/keithp/repos/parsecvs.git/[http://anongit.freedesktop.org/git/users/keithp/repos/parsecvs.git/]
+  * fromcvs from link:http://ww2.fs.ei.tum.de/%7Ecorecode/hg/fromcvs/[http://ww2.fs.ei.tum.de/%7Ecorecode/hg/fromcvs/]
+
+As of July 2007 there is no definite recommendation which tool to use.
 
 OPTIONS
 -------
-- 
1.5.3.rc0.22.gd22ed
