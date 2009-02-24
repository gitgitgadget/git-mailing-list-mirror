From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] git-gui: Fix file name pattern in .gitattributes.
Date: Tue, 24 Feb 2009 09:01:33 +0100
Message-ID: <1235462493-8761-1-git-send-email-j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 09:36:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbsmM-0003YZ-QE
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 09:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbZBXIfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 03:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbZBXIfG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 03:35:06 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4160 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbZBXIfF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 03:35:05 -0500
X-Greylist: delayed 1997 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Feb 2009 03:35:05 EST
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1LbsEP-0001qI-Or; Tue, 24 Feb 2009 09:01:41 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 67ABE4E4; Tue, 24 Feb 2009 09:01:33 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 3FFFEFA46; Tue, 24 Feb 2009 09:01:33 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc0.81.g1e300
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111236>

The pattern for the *.po files was anchored at the repository's root, but
this would match the files only in the git-gui repository itself, but
not in the version that is subtree-merged into git.git.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 .gitattributes |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index f96112d..c69f4a0 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,3 +1,3 @@
 *           encoding=US-ASCII
 git-gui.sh  encoding=UTF-8
-/po/*.po    encoding=UTF-8
+po/*.po     encoding=UTF-8
-- 
1.6.2.rc0.81.g1e300
