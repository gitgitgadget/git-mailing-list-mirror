From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation for git-shell
Date: Tue, 25 Oct 2005 11:09:37 +0200
Message-ID: <20051025090937.15206.50609.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 25 11:12:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUKog-000175-Sx
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 11:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVJYJJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 05:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVJYJJp
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 05:09:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40335 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932099AbVJYJJo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 05:09:44 -0400
Received: (qmail 15221 invoked from network); 25 Oct 2005 11:09:38 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 25 Oct 2005 11:09:38 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10574>

This adds some simple documentation for git-shell.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-shell.txt |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
new file mode 100644
index 0000000..dfdfbf6
--- /dev/null
+++ b/Documentation/git-shell.txt
@@ -0,0 +1,32 @@
+git-shell(1)
+============
+
+NAME
+----
+git-shell - Restricted login shell for GIT over SSH only
+
+
+SYNOPSIS
+--------
+'git-shell -c <command> <argument>'
+
+DESCRIPTION
+-----------
+This is meant to be used as a login shell for SSH accounts you want
+to restrict to GIT pull/push access only. It permits execution only
+of two commands (`git-receive-pack` and `git-upload-pack`) with
+a single argument. The commands can be executed only by the '-c'
+option; the shell is not interactive.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Petr Baudis and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
