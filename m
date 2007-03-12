From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] GIT_WORK_DIR: documentation for relative path
Date: Mon, 12 Mar 2007 20:53:48 +0100
Message-ID: <20070312195348.GA30520@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <20070312115350.GA15179@moooo.ath.cx> <20070312121226.GB2268@always.joy.eth.net> <20070312131253.GA16452@moooo.ath.cx> <fcaeb9bf0703120636r7038a7fat24e571e7c087d13d@mail.gmail.com> <20070312140808.GA17450@moooo.ath.cx> <7vabyitlld.fsf@assigned-by-dhcp.cox.net> <20070312180837.GA22701@moooo.ath.cx> <20070312191812.GA29327@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:54:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqax-0002Ui-NB
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbXCLTxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbXCLTxv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:53:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:50385 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752838AbXCLTxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:53:50 -0400
Received: (qmail invoked by alias); 12 Mar 2007 19:53:49 -0000
Received: from pD9EBB74D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.183.77]
  by mail.gmx.net (mp034) with SMTP; 12 Mar 2007 20:53:49 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/scawr0P/s4VmY+xf6RmWTqXiMhQlNzW9o1PzO0t
	I7+TRZQ6S7OKsI
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070312191812.GA29327@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42076>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 Documentation/git.txt |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d2f5d27..177adf5 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -83,11 +83,13 @@ OPTIONS
 	setting the GIT_DIR environment variable.
 
 --work-dir=<path>::
-	Set the path to the toplevel working directory.  The value will
-	be used only in combination with $GIT_DIR or '--git-dir'.
-	Without this option git will assume that the current directory
-	is also the toplevel directory.  This can also be controlled by
-	setting the GIT_WORK_DIR environment variable.
+	Set the path to the toplevel working directory.  If the path is
+	relative it is interpreted from $GIT_DIR, not the current
+	working directory.  The value will be used only in combination
+	with $GIT_DIR or '--git-dir'.  Without this option git will
+	assume that the current working directory is also the toplevel
+	directory.  This can also be controlled by setting the
+	GIT_WORK_DIR environment variable.
 
 --bare::
 	Same as --git-dir=`pwd`.
@@ -334,10 +336,12 @@ git so take care if using Cogito etc.
 	for the base of the repository.
 
 'GIT_WORK_DIR'::
-	Set the path to the toplevel working directory.  The value will
-	be used only in combination with $GIT_DIR or '--git-dir'.
-	Without this environment variable git will assume that the
-	current directory is also the toplevel directory.
+	Set the path to the toplevel working directory.  If the path is
+	relative it is interpreted from $GIT_DIR, not the current
+	working directory.  The value will be used only in combination
+	with $GIT_DIR or '--git-dir'.  Without this environment variable
+	git will assume that the current working directory is also the
+	toplevel directory.
 
 git Commits
 ~~~~~~~~~~~
-- 
1.5.0.3.1007.g7ff7
