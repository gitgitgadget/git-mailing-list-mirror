From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Start all test scripts with /bin/sh.
Date: Mon, 15 Jan 2007 17:31:49 -0800
Message-ID: <17448.1168911109@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Tue Jan 16 02:49:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6dSL-0003aq-Ad
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 02:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbXAPBtl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 20:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbXAPBtl
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 20:49:41 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:45209 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193AbXAPBtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 20:49:40 -0500
X-Greylist: delayed 1120 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 20:49:40 EST
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l0G1VnSH017461
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 17:31:49 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l0G1Vnwt017458
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 17:31:49 -0800 (PST)
To: git@vger.kernel.org
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36909>

My bash refused to run the two scripts missing a #!, and it's
better to use the same line for all the scripts.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>
---
 t/t9102-git-svn-deep-rmdir.sh     |    1 +
 t/t9103-git-svn-graft-branches.sh |    1 +
 t/t9200-git-cvsexportcommit.sh    |    2 +-
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 572aaed..4e08083 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 test_description='git-svn rmdir'
 . ./lib-git-svn.sh
 
diff --git a/t/t9103-git-svn-graft-branches.sh b/t/t9103-git-svn-graft-branches.sh
index b5f7677..4e55778 100755
--- a/t/t9103-git-svn-graft-branches.sh
+++ b/t/t9103-git-svn-graft-branches.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 test_description='git-svn graft-branches'
 . ./lib-git-svn.sh
 
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 315119a..fd0a554 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Robin Rosenberg
 #
-- 
1.5.0.rc1.gf4b6c
