From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Wed, 18 Apr 2007 16:58:17 -0700
Message-ID: <7virbtck12.fsf@assigned-by-dhcp.cox.net>
References: <7vfy71yupd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 01:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeK2Y-00079C-QI
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 01:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993015AbXDRX6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 19:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbXDRX6T
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 19:58:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41104 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030360AbXDRX6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 19:58:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418235817.PSQS1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 19:58:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id onyH1W00d1kojtg0000000; Wed, 18 Apr 2007 19:58:18 -0400
X-maint-at: 0ad64fd0b8d073e0c73836858a54f693c9191918
X-master-at: 6fb8e8f401a065bdffe379764871551e37a041a0
In-Reply-To: <7vfy71yupd.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 15 Apr 2007 18:27:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44967>

Accumulated fixes on 'maint' are mostly documentation updates.
I will do a 1.5.1.2 probably this weekend, when I find time.

On 'master' are Frank's cvsserver updates to use DBI to allow
backends other than sqlite.  There also is an update to
merge-recursive to make it saner for merges that involves a
directory changing to a file (or vice versa).

I did not hear anything positive nor negative while they were on
'next', so if you have been using cvsserver or merge and this
breaks them for you, you had it coming.  At least you can keep
both pieces ;-).

But more seriously, hopefully no news was a good news.  There
are also other minor new features and enhancements on 'master'.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

 Alex Riesen (1):
  Fix overwriting of files when applying contextually independent diffs

 Andrew Ruder (4):
  Update git-am documentation
  Update git-applymbox documentation
  Update git-apply documentation
  Update git-annotate/git-blame documentation

 Carlos Rica (1):
  Use const qualifier for 'sha1' parameter in delete_ref function

 Eric Wong (3):
  git-svn: respect lower bound of -r/--revision when following parent
  git-svn: quiet some warnings when run only with --version/--help
  git-svn: don't allow globs to match regular files

 Frank Lichtenheld (1):
  git-shortlog: Fix two formatting errors in asciidoc documentation

 Gerrit Pape (2):
  variable $projectdesc needs to be set before checking against unchanged default.
  Have sample update hook not refuse deleting a branch through push.

 J. Bruce Fields (7):
  Documentation: minor edits of git-lost-found manpage
  Documentation: clarify git-checkout -f, minor editing
  Documentation: clarify track/no-track option.
  user-manual: fix discussion of default clone
  user-manual: detached HEAD
  user-manual: start revising "internals" chapter
  user-manual: use detached head when rewriting history

 Junio C Hamano (1):
  Start preparing for 1.5.1.2

 Shawn O. Pearce (1):
  git-gui: Brown paper bag fix division by 0 in blame


* The 'master' branch has these since the last announcement
  in addition to the above.

 Alex Riesen (2):
  Fix t4201: accidental arithmetic expansion
  Fix permissions on test scripts

 Andrew Ruder (1):
  Add policy on user-interface changes

 Christian Couder (2):
  Bisect: simplify "bisect start" logging.
  Bisect: rename "t/t6030-bisect-run.sh" to "t/t6030-bisect-porcelain.sh".

 Eygene Ryabinkin (4):
  Allow wish interpreter to be defined with TCLTK_PATH
  Teach git-gui to use the user-defined UI font everywhere.
  Improve look-and-feel of the git-gui tool.
  Do not break git-gui messages into multiple lines.

 Frank Lichtenheld (12):
  cvsserver: Introduce new state variable 'method'
  cvsserver: Handle three part keys in git config correctly
  cvsserver: Allow to override the configuration per access method
  cvsserver: Make the database backend configurable
  cvsserver: Abort if connect to database fails
  cvsserver: Use DBI->table_info instead of DBI->tables
  cvsserver: Corrections to the database backend configuration
  cvsserver: Add asciidoc documentation for new database backend configuration
  cvsserver: Allow to "add" a removed file
  cvsserver: Reword documentation on necessity of write access
  cvsserver: Document the GIT branches -> CVS modules mapping more prominently
  config.txt: Add gitcvs.db* variables

 Johannes Schindelin (1):
  Use print_wrapped_text() in shortlog

 Junio C Hamano (9):
  shortlog -w: make wrap-line behaviour optional.
  t1000: fix case table.
  Treat D/F conflict entry more carefully in unpack-trees.c::threeway_merge()
  merge-recursive: do not barf on "to be removed" entries.
  merge-recursive: handle D/F conflict case more carefully.
  t3030: merge-recursive backend test.
  send-email: do not leave an empty CC: line if no cc is present.
  git-gui: Honor TCLTK_PATH if supplied
  Update draft release notes for 1.5.2 with accumulated changes.

 Linus Torvalds (2):
  Add a generic "object decorator" interface, and make object refs use it
  Add support for "commit name decorations" to log family of commands

 Michael S. Tsirkin (1):
  Display the subject of the commit just made.

 Shawn O. Pearce (3):
  Always bind the return key to the default button
  git-gui: Display the directory basename in the title
  Revert "Allow wish interpreter to be defined with TCLTK_PATH"

 Steven Grimm (3):
  Add --quiet option to suppress output of "rm" commands for removed files.
  git-rm: Trivial fix for a comment typo.
  Add --ignore-unmatch option to exit with zero status when no files are removed.
