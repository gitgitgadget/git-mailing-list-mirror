From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/6] Document update-server-info.
Date: Sat, 23 Jul 2005 17:54:56 -0700
Message-ID: <7vsly5ja5b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 02:55:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwUlk-0004Rc-5Z
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 02:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVGXAy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 20:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVGXAy7
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 20:54:59 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:9604 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262143AbVGXAy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 20:54:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724005453.XVAI550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 20:54:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds a minimum documentation to the new command.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-update-server-info.txt |   42 ++++++++++++++++++++++++++++++
 Documentation/git.txt                    |    4 +++
 2 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-update-server-info.txt

b0dff8ec614449f3fa59a1017f3ed92c8a10a3aa
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-update-server-info.txt
@@ -0,0 +1,42 @@
+git-update-server-info(1)
+=========================
+v0.1, July 2005
+
+NAME
+----
+git-update-server-info - Update auxiliary info file to help dumb servers
+
+
+SYNOPSIS
+--------
+'git-update-server-info' [--force]
+
+DESCRIPTION
+-----------
+A dumb server that does not do on-the-fly pack generations can
+have some auxiliary information files in $GIT_DIR/info and
+$GIT_OBJECT_DIRECTORY/info directories to help clients discover
+what references and packs the server has and make an optimized
+pull decisions.  This command generates such auxiliary files.
+
+
+OPTIONS
+-------
+
+--force::
+	Update the info files even when they do not appear
+	stale.
+
+
+Author
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+Documentation
+--------------
+Documentation by Junio C Hamano.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -167,6 +167,10 @@ link:git-upload-pack.html[git-upload-pac
 	Invoked by 'git-clone-pack' and 'git-fetch-pack' to push
 	what are asked for.
 
+link:git-update-server-info.html[git-update-server-info]::
+	Updates auxiliary information on a dumb server to help
+	clients discover references and packs on it.
+
 
 Ancilliary Commands
 -------------------
