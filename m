From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.9f
Date: Tue, 08 Nov 2005 08:46:27 -0800
Message-ID: <7vy83zhyu4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 08 17:56:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZWcC-0006ZG-Nv
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 17:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVKHQq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 11:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVKHQq3
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 11:46:29 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35549 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932401AbVKHQq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 11:46:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108164606.JXMI1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 11:46:06 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11339>

This is more like a "current snapshot" rather than "contains
important fixes -- please update".

Much of the changes are documentation fixes, but there are two
new toys to play with.

 - git-push is now aware of push over DAV (Nick)
 - git-cvs suite has 'exportcommit' to play git commits back at
   CVS (Martin).

---

Alex Riesen:
      ls-files and read-tree need core.filemode

Fredrik Kuivinen:
      merge-recursive: Only print relevant rename messages

Johannes Schindelin:
      Small bugfixes for http-push.c

Jon Loeliger:
      Refactored merge options into separate merge-options.txt.
      Add bug isolation howto, scraped from Linus.
      Add --tags documentation, scraped from JC mail.
      Use consistent shell prompts and example style.

Junio C Hamano:
      Documentation: talk about guts of merge in tutorial.
      Recover dropped +x bit from git-pull.sh by accident.
      Do not fail on hierarchical tagnames.
      Documentation: asciidoc formatting fix for git-cvsexportcommit doc.
      Fix documentation dependency generation.
      Ignore more generated files.
      Documentation: fix dependency generation.
      Tutorial: do not use 'git resolve'.
      Debian: packaging updates.
      git-am: do not lose already edited final-commit when resuming.
      GIT 0.99.9f

Kai Ruemmler:
      Documentation update: use git branch -d foo where applicable

Martin Langhoff:
      Introducing: git-cvsexportcommit

Nick Hengeveld:
      Make http-push smarter about creating remote dirs
      Add support for git-http-push to git-push script
