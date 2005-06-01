From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] One-Git Part 2 (Patch 2/3)
Date: Wed, 1 Jun 2005 14:23:03 -0400
Message-ID: <20050601182303.GA2684@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 20:33:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdXyp-000459-Fx
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 20:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVFAScI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 14:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVFASaE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 14:30:04 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:47311 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261561AbVFASXH
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 14:23:07 -0400
Received: by timesys.com (Postfix, from userid 623)
	id 7B87BEB2F; Wed,  1 Jun 2005 14:23:03 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Rename: git-whatchanged to git-whatchanged-script

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/Documentation/git-whatchanged-script.txt b/Documentation/git-whatchanged-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-whatchanged-script.txt
@@ -0,0 +1,29 @@
+git-whatchanged(1)
+==================
+v0.1, May 2005
+
+NAME
+----
+git-whatchanged - Find out what changed
+
+
+SYNOPSIS
+--------
+'git-whatchanged' 
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/git-whatchanged b/git-whatchanged
deleted file mode 100755
--- a/git-whatchanged
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/sh
-git-rev-list HEAD | git-diff-tree --stdin -v -r "$@" | LESS="$LESS -S" ${PAGER:-less}
diff --git a/git-whatchanged-script b/git-whatchanged-script
new file mode 100755
--- /dev/null
+++ b/git-whatchanged-script
@@ -0,0 +1,2 @@
+#!/bin/sh
+git-rev-list HEAD | git-diff-tree --stdin -v -r "$@" | LESS="$LESS -S" ${PAGER:-less}
======== end ========

