From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sun, 31 Dec 2006 00:07:10 -0800
Message-ID: <7virfsfpzl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 31 09:07:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0vj3-0005YE-6k
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 09:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933091AbWLaIHN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 03:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933092AbWLaIHN
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 03:07:13 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64041 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933091AbWLaIHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 03:07:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231080711.KWXC15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 03:07:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5L6R1W0071kojtg0000000; Sun, 31 Dec 2006 03:06:25 -0500
To: git@vger.kernel.org
X-maint-at: e6d40d65df07059fc655fabe62fa5b575ead7815
X-master-at: a862f97e98decc317437fa3b04081f68fb4ffbf3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35687>

I am happy that we are making steady progress towards v1.5.0,
especially with tonight's handful fixes from Shawn.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

* The 'master' branch has these since the last announcement.

  Jakub Narebski (1):
   Add info about new test families (8 and 9) to t/README

  Johannes Schindelin (1):
   Fix yet another subtle xdl_merge() bug

  Junio C Hamano (12):
   Work around http-fetch built with cURL 7.16.0
   t5400 send-pack test: try a bit more nontrivial transfer.
   Revert "read_directory: show_both option."
   Fix 'git add' with .gitignore
   commit re-encoding: fix confusion between no and default conversion.
   t3900: test log --encoding=none
   Documentation: i18n commit log message notes.
   Documentation: minor rewording for git-log and git-show pages.
   Move commit reencoding parameter parsing to revision.c
   commit-tree: cope with different ways "utf-8" can be spelled.
   i18n: drop "encoding" header in the output after re-coding.
   Documentation/config.txt (and repo-config manpage): mark-up fix.

  Shawn O. Pearce (8):
   Force core.filemode to false on Cygwin.
   Use PATH_MAX constant for --bare.
   Replace "GIT_DIR" with GIT_DIR_ENVIRONMENT.
   Automatically detect a bare git repository.
   Remove unnecessary argc parameter from run_command_v.
   Redirect update hook stdout to stderr.
   Use /dev/null for update hook stdin.
   Teach Git how to parse standard power of 2 suffixes.

  Theodore Ts'o (1):
   Fix formatting for urls section of fetch, pull, and push manpages
