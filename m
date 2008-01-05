From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Documentation/Makefile - honor $DESTDIR for quick-install
 target
Date: Sat, 05 Jan 2008 17:32:21 -0500
Message-ID: <1199572341-3404-1-git-send-email-mdl123@verizon.net>
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 05 23:33:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBHZf-00086y-8b
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 23:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbYAEWcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 17:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbYAEWcg
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 17:32:36 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:64586 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbYAEWcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 17:32:35 -0500
Received: from localhost.localdomain ([71.163.17.196])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JU60017SZJKOE05@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 05 Jan 2008 16:23:45 -0600 (CST)
X-Mailer: git-send-email 1.5.4.rc2.50.gcfa92
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69688>

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
This is an (at least to me) obvious ommission, all other targets
honor DESTDIR.

 Documentation/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c4486d3..c641174 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -224,6 +224,6 @@ install-webdoc : html
 	sh ./install-webdoc.sh $(WEBDOC_DEST)

 quick-install:
-	sh ./install-doc-quick.sh $(DOC_REF) $(mandir)
+	sh ./install-doc-quick.sh $(DOC_REF) $(DESTDIR)$(mandir)

 .PHONY: .FORCE-GIT-VERSION-FILE
--
1.5.4.rc2.50.gcfa92
