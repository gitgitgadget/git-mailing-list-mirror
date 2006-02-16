From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.17rc2
Date: Thu, 16 Feb 2006 14:51:00 +0100
Message-ID: <20060216135100.GR31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Feb 16 14:50:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9jWM-0006pB-AJ
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 14:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWBPNuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 08:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWBPNuG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 08:50:06 -0500
Received: from w241.dkm.cz ([62.24.88.241]:21739 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932074AbWBPNuF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 08:50:05 -0500
Received: (qmail 942 invoked by uid 2001); 16 Feb 2006 14:51:00 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16302>

  Hello,

  here comes Cogito version 0.17rc1, the human-friendly version control
UI for Linus' GIT tool. Share and enjoy at:

	http://www.kernel.org/pub/software/scm/cogito/

  Few bugfixes and actually few minor features compared to 0.17rc1.
You're encouraged to upgrade if you are using 0.17rc2. I am receiving
less bugreports than what I have expected, which either means there are
no bugs (hah!) or that noone cares about the rcs (more likely). So if
there will be no bugreports in two or three days, I'll make this the
final 0.17.

  The notable new stuff includes:

  * cg-clean -d fix (do not clean the contents of untracked directories)
  * cg-log -d renamed to cg-log -D, please fix your scripts and retrain
    your fingers if you actually use it regularily
  * cg-commit -M to load the commit message from a file
  * cg-commit -f will commit even if you are seeked

  * Fix repeated cg-seek <commit> invocations
  * Fix pushing to symlinked repositories (it was racy before and would
    not deal appropriately with permissions)

  * Random documentation improvements


$ cg-log --summary -r cogito-0.17rc1..
Jonas Fonseca:
      cg-commit: use -- to delimit paths args to git-diff-index for --review
      cg-status: pretty-print heads using printf
      Add warn function which can beep; use it to generalise warnings

Pavel Roskin:
      [PATCH 1/2] cg-clean shouldn't clean untracked directories without -d
      [PATCH 2/2] Workaround git < 1.2.0 ignoring .gitignore in parent directories

Petr Baudis:
      0.17rc1.GIT
      Doc clarification.
      Do not list cg-object-id in helper commands
      Fix shortdesc.
      Rename cg-log -d to cg-log -D
      Network together the cg-switch,cg-seek,cg-admin-uncommit docs
      Refuse to uncommit merges, redirect the user to cg-switch
      Simplify the editor testing code
      Warn about seeking to a branch head
      cg-commit -M to take the commit message from a file
      cg-commit -f will override cg-seek's blocking
      Hint cg-switch -n to save the volatile commit
      Automatically determine cg-status headname column width
      Fix cg-seek re-seeking
      Remove the obsolete umask mention
      Fix pushing to symlinked repositories
      cogito-0.17rc2


P.S.: See us at #git @ FreeNode!

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
