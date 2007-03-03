From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH 6/7] Small changes
Date: Sat, 03 Mar 2007 11:20:17 +0100
Message-ID: <15313.1172917217@localhost>
Cc: julliard@winehq.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 11:23:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNROU-00058K-1c
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 11:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbXCCKXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 05:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXCCKXK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 05:23:10 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:47906 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbXCCKXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 05:23:09 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 5ACDD71B1;
	Sat,  3 Mar 2007 11:23:08 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l23AKHP3015314;
	Sat, 3 Mar 2007 11:20:17 +0100
X-Mailer: MH-E 8.0.3; nmh 1.2; GNU Emacs 23.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41284>


* Makefile: add git-blame as a candidate to the
  byte-compilation. Change the function to call to byte-compile.

Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/Makefile b/contrib/emacs/Makefile
index 350846d..8554e39 100644
--- a/contrib/emacs/Makefile
+++ b/contrib/emacs/Makefile
@@ -2,7 +2,7 @@
 
 EMACS = emacs
 
-ELC = git.elc vc-git.elc
+ELC = git.elc vc-git.elc git-blame.elc
 INSTALL ?= install
 INSTALL_ELC = $(INSTALL) -m 644
 prefix ?= $(HOME)
@@ -15,6 +15,6 @@ install: all
 	$(INSTALL_ELC) $(ELC) $(emacsdir)
 
 %.elc: %.el
-	$(EMACS) --batch --eval '(byte-compile-file "$<")'
+	$(EMACS) -batch -f batch-byte-compile $<
 
 clean:; rm -f $(ELC)
-- 
1.5.0
