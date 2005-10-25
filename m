From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Documentation for git-shell
Date: Tue, 25 Oct 2005 23:43:30 +0200
Message-ID: <20051025214330.GI22079@pasky.or.cz>
References: <20051025090937.15206.50609.stgit@machine.or.cz> <7vsluph6vx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gti@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 23:45:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUWaf-0007ur-QX
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 23:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVJYVoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 17:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVJYVoF
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 17:44:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53157 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932414AbVJYVoD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 17:44:03 -0400
Received: (qmail 8896 invoked by uid 2001); 25 Oct 2005 23:44:01 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsluph6vx.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10622>

Dear diary, on Tue, Oct 25, 2005 at 06:57:06PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Thanks.  I'd leave the door open for possibility of future
> command additions by saying what *kind* of things it is meant to
> allow spawning first and then listing what commands we
> *currently* allow next.
> 
> Also we need a link to this in either Ancillary (in which
> subsection I am not sure of, though) or Synching repository
> section of git.txt.

Done.

---

[PATCH] Documentation for git-shell

This adds some simple documentation for git-shell.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-shell.txt |   35 +++++++++++++++++++++++++++++++++++
 Documentation/git.txt       |    3 +++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
new file mode 100644
index 0000000..3f4d804
--- /dev/null
+++ b/Documentation/git-shell.txt
@@ -0,0 +1,35 @@
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
+of server-side GIT commands implementing the pull/push functionality.
+The commands can be executed only by the '-c' option; the shell is not
+interactive.
+
+Currently, only the `git-receive-pack` and `git-upload-pack` commands
+are permitted to be called, with a single required argument.
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
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 796c4f6..769054b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -182,6 +182,9 @@ gitlink:git-receive-pack[1]::
 gitlink:git-send-pack[1]::
 	Pushes to a remote repository, intelligently.
 
+gitlink:git-shell[1]::
+	Restricted shell for GIT-only SSH access.
+
 gitlink:git-ssh-fetch[1]::
 	Pulls from a remote repository over ssh connection
 	Previously this command was known as git-ssh-pull.


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
