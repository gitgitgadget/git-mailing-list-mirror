From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/2] Basic documentation for git-show
Date: Tue, 07 Feb 2006 12:47:47 +0100
Message-ID: <20060207114746.27532.54362.stgit@machine.or.cz>
References: <20060207114744.27532.21094.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 12:47:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6RJx-0007eU-Kv
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 12:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWBGLrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 06:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWBGLrg
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 06:47:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32999 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965034AbWBGLrg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 06:47:36 -0500
Received: (qmail 27578 invoked from network); 7 Feb 2006 12:47:47 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 7 Feb 2006 12:47:47 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060207114744.27532.21094.stgit@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15692>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-show.txt |   49 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
new file mode 100644
index 0000000..9c359a4
--- /dev/null
+++ b/Documentation/git-show.txt
@@ -0,0 +1,49 @@
+git-show(1)
+===========
+
+NAME
+----
+git-show - Show one commit with difference it introduces.
+
+
+SYNOPSIS
+--------
+'git-show' <option>...
+
+DESCRIPTION
+-----------
+Shows commit log and textual diff for a single commit.  The
+command internally invokes 'git-rev-list' piped to
+'git-diff-tree', and takes command line options for both of
+these commands. It also presents the merge commit in a special
+format as produced by 'git-diff-tree --cc'.
+
+This manual page describes only the most frequently used options.
+
+
+OPTIONS
+-------
+<commitid>::
+	ID of the commit to show.
+
+--pretty=<format>::
+	Controls the output format for the commit logs.
+	<format> can be one of 'raw', 'medium', 'short', 'full',
+	and 'oneline'.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org> and
+Junio C Hamano <junkio@cox.net>
+
+
+Documentation
+-------------
+Documentation by David Greaves, Petr Baudis and the git-list <git@vger.kernel.org>.
+
+This manual page is a stub. You can help the git documentation by expanding it.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
