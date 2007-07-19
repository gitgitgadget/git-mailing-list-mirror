From: Jan Merka <merka@highsphere.net>
Subject: [PATCH] Honor the --sysconfdir option in configure.
Date: Thu, 19 Jul 2007 18:16:28 -0400
Message-ID: <11848833881747-git-send-email-merka@highsphere.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 00:39:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBeeq-0005hw-TF
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 00:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbXGSWjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 18:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbXGSWjg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 18:39:36 -0400
Received: from mailhost1.gsfc.nasa.gov ([128.183.244.133]:35680 "EHLO
	mailhost1.gsfc.nasa.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXGSWjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 18:39:36 -0400
X-Greylist: delayed 1386 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2007 18:39:35 EDT
Received: from popa.gsfc.nasa.gov (pop300.gsfc.nasa.gov [128.183.244.174])
	by mailhost1.gsfc.nasa.gov (8.12.11/8.12.11) with ESMTP id l6JMGS7P007026
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 18:16:28 -0400
Received: from localhost.localdomain (lepjmlap.gsfc.nasa.gov [128.183.135.61])
	by popa.gsfc.nasa.gov (8.13.7/8.12.11) with ESMTP id l6JMGSx3023700
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 18:16:28 -0400 (EDT)
X-Mailer: git-send-email 1.5.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53035>

Fix the installation process so git uses the sysconfdir given to configure during installation instead of defaulting to $prefix/etc.
---
 config.mak.in |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index a3032e3..1c70571 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -11,6 +11,8 @@ TCLTK_PATH = @TCLTK_PATH@
 prefix = @prefix@
 exec_prefix = @exec_prefix@
 bindir = @bindir@
+sysconfdir = @sysconfdir@
+
 #gitexecdir = @libexecdir@/git-core/
 datarootdir = @datarootdir@
 template_dir = @datadir@/git-core/templates/
-- 
1.5.2.2
