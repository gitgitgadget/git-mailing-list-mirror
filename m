From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add documentation for git-rename-script
Date: Mon, 25 Jul 2005 02:13:11 -0400
Message-ID: <20050725061311.GD6098@mythryan2.michonline.com>
References: <20050725052646.GB6098@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 08:15:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwwFB-0003oy-7j
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 08:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVGYGO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 02:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGYGO5
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 02:14:57 -0400
Received: from mail.autoweb.net ([198.172.237.26]:39885 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261745AbVGYGNM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 02:13:12 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwwD9-0006Uv-Tl; Mon, 25 Jul 2005 02:13:11 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DwwLp-00037A-00; Mon, 25 Jul 2005 02:22:09 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwwD9-00065K-Ab; Mon, 25 Jul 2005 02:13:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050725052646.GB6098@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 Documentation/git-rename-script.txt |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-rename-script.txt

715924203401309ceb2f696e507b8b2c18244d08
diff --git a/Documentation/git-rename-script.txt b/Documentation/git-rename-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-rename-script.txt
@@ -0,0 +1,34 @@
+
+git-rename-script(1)
+=====================
+v0.1, May 2005
+
+NAME
+----
+git-rename-script - Script used to rename a file, directory or symlink.
+
+
+SYNOPSIS
+--------
+'git-rename-script' <source> <destination>
+
+DESCRIPTION
+-----------
+This script is used to rename a file, directory or symlink.
+
+The index is updated after successful completion, but the change must still be
+committed.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+Rewritten by Ryan Anderson <ryan@michonline.com>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
