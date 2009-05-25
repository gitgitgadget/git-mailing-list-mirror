From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH 3/3] Makefile: add commented out 's for Emacs here, too
Date: Mon, 25 May 2009 18:07:11 -0400
Message-ID: <1243289231-32500-3-git-send-email-naesten@gmail.com>
References: <1243289231-32500-1-git-send-email-naesten@gmail.com>
 <1243289231-32500-2-git-send-email-naesten@gmail.com>
Cc: git@vger.kernel.org, Samuel Bronson <naesten@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 26 00:08:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iKw-0003Kc-GT
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbZEYWHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 18:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbZEYWH3
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:07:29 -0400
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:52748 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbZEYWH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 18:07:28 -0400
Received: from mr02.lnh.mail.rcn.net ([207.172.157.22])
  by smtp02.lnh.mail.rcn.net with ESMTP; 25 May 2009 18:07:30 -0400
Received: from smtp01.lnh.mail.rcn.net (smtp01.lnh.mail.rcn.net [207.172.4.11])
	by mr02.lnh.mail.rcn.net (MOS 3.10.5-GA)
	with ESMTP id PXI13382;
	Mon, 25 May 2009 18:07:29 -0400 (EDT)
Received: from 207-172-203-39.c3-0.upd-ubr7.trpr-upd.pa.cable.rcn.com (HELO hydrogen) ([207.172.203.39])
  by smtp01.lnh.mail.rcn.net with ESMTP; 25 May 2009 18:07:30 -0400
Received: from naesten by hydrogen with local (Exim 4.69)
	(envelope-from <naesten@gmail.com>)
	id 1M8iKP-0008Sy-0l; Mon, 25 May 2009 18:07:29 -0400
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1243289231-32500-2-git-send-email-naesten@gmail.com>
X-Junkmail-Whitelist: YES (by domain whitelist at mr02.lnh.mail.rcn.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119967>

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 Makefile |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 07a141d..b485c21 100644
--- a/Makefile
+++ b/Makefile
@@ -1190,6 +1190,13 @@ prefix_SQ = $(subst ','\'',$(prefix))
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
+# unconfuse Emacs: '
+
+# The above comment is in case there is an odd number of _SQ
+# definitions above, since they seem to confuse Emacs. If there is an
+# even number of such definitions, it does no harm, since emacs
+# doesn't recognize string delimiters inside recognized comments.
+
 
 LIBS = $(GITLIBS) $(EXTLIBS)
 
@@ -1437,6 +1444,8 @@ cscope:
 ### Detect prefix changes
 TRACK_CFLAGS = $(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ)
+# unconfuse Emacs: '
+# (see above comment about "unconfuse Emacs")
 
 GIT-CFLAGS: .FORCE-GIT-CFLAGS
 	@FLAGS='$(TRACK_CFLAGS)'; \
@@ -1457,6 +1466,8 @@ GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
 TRACK_VARS = $(subst ','\'',-DTCLTK_PATH='$(TCLTK_PATH_SQ)')
+# unconfuse Emacs: '
+# (see above comment about "unconfuse Emacs")
 
 GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
 	@VARS='$(TRACK_VARS)'; \
@@ -1540,6 +1551,8 @@ gitexec_instdir = $(prefix)/$(gitexecdir)
 endif
 gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
 export gitexec_instdir
+# unconfuse Emacs: '
+# (see above comment about "unconfuse Emacs")
 
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
-- 
1.6.3.1
