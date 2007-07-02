From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sun, 01 Jul 2007 17:16:34 -0700
Message-ID: <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
	<7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
	<7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 02:16:49 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I59ax-0006Nx-P6
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 02:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056AbXGBAQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 1 Jul 2007 20:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbXGBAQh
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 20:16:37 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:61681 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbXGBAQg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jul 2007 20:16:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702001635.BQWT1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Jul 2007 20:16:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JQGa1X00Q1kojtg0000000; Sun, 01 Jul 2007 20:16:35 -0400
X-maint-at: 206488774238c94ff337dd5c997be441dbde5112
X-master-at: 71e55854fd6e5c9ce786bcd20efef43bd56f9df0
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51330>

Will do a 1.5.2.3 with the tip of 'maint' probably mid-week and
a 1.5.3-rc1 at about the same time from 'master', hopefully with
a few topics that have been in 'next', and also some "discussed
but forgotten" fixes on the list if somebody kindly can remind
me ;-).

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

=46rank Lichtenheld (2):
  config: Complete documentation of --get-regexp
  config: Change output of --get-regexp for valueless keys

Linus Torvalds (1):
  Fix zero-object version-2 packs

Matt Kraai (1):
  Correct the name of NO_R_TO_GCC_LINKER in the comment describing
      it.

Sam Vilain (3):
  cleanup merge-base test script
  repack: improve documentation on -a option
  git-remote: document -n

Shawn O. Pearce (5):
  git-gui: Correctly install to /usr/bin on Cygwin
  git-gui: Bind Tab/Shift-Tab to cycle between panes in blame
  git-gui: Don't require $DISPLAY just to get --version
  git-gui: Don't nice git blame on MSYS as nice is not supported
  git-gui: Don't require a .pvcsrc to create Tools/Migrate menu hack

Sven Verdoolaege (1):
  Ignore submodule commits when fetching over dumb protocols


* The 'master' branch has these since the last announcement
  in addition to the above.

Adam Roben (2):
  git-send-email: Add --threaded option
  git-send-email: make options easier to configure.

Alex Riesen (1):
  Avoid perl in t1300-repo-config

Alexandre Vassalotti (1):
  git-tag: Fix "can't shift that many".

Brian Gernhardt (1):
  Fix t5516-fetch for systems where `wc -l` outputs whitespace.

Carlos Rica (3):
  Fix git-stripspace to process correctly long lines and spaces.
  Add test script for git-stripspace.
  Add test-script for git-tag

=46rank Lichtenheld (2):
  config: Add --null/-z option for null-delimted output
  config: add support for --bool and --int while setting values

Gerrit Pape (1):
  git-cvsimport: force checkout of working tree after initial import

Jim Meyering (3):
  detect close failure on just-written file handles
  Don't ignore a pack-refs write failure
  git-log: detect dup and fdopen failure

Johannes Schindelin (2):
  t7004: ship trustdb to avoid gpg warnings
  git add: respect core.filemode with unmerged entries

Junio C Hamano (2):
  Add core.quotepath configuration variable.
  Update draft Release Notes for 1.5.3

Linus Torvalds (3):
  Clean up internal command handling
  Check for IO errors after running a command
  git: Try a bit harder not to lose errno in stdio

Mark Levedahl (5):
  gitk: Make selection highlight color configurable
  gitk: Update fontsize in patch / tree list
  gitk: Allow specifying tabstop as other than default 8 characters.
  gitk: Use a spinbox for setting tabstop settings
  gitk: Update selection background colorbar in prefs dialog

Matthias Lederhofer (10):
  rev-parse: document --is-inside-git-dir
  rev-parse: introduce --is-bare-repository
  test git rev-parse
  introduce GIT_WORK_TREE to specify the work tree
  Use new semantics of is_bare/inside_git_dir/inside_work_tree
  extend rev-parse test for --is-inside-work-tree
  test GIT_WORK_TREE
  setup_git_directory: fix segfault if repository is found in cwd
  filter-branch: always export GIT_DIR if it is set
  make git barf when an alias changes environment variables

Michael Krelin (1):
  git-svn: honor ~/.subversion/ client cert file settings.

Paul Mackerras (18):
  gitk: Use the -q flag to git checkout
  gitk: New infrastructure for working out branches & previous/next
      tags
  gitk: Don't try to list large numbers of tags or heads in the
      details pane
  gitk: Add some more comments to the optimize_rows procedure
  gitk: Improve the behaviour of the initial selection
  gitk: Implement a simple scheduler for the compute-intensive stuff
  gitk: Cope with commit messages with carriage-returns and initial
      blank lines
  gitk: Disable the head context menu entries for the checked-out
      branch
  gitk: Store ids in rowrangelist and idrowranges rather than row
      numbers
  gitk: New algorithm for drawing the graph lines
  gitk: Show local uncommitted changes as a fake commit
  gitk: Speed up the reading of references
  gitk: Get rid of the childlist variable
  gitk: Add a "reset branch to here" row context-menu operation
  gitk: Limit how often we change the canvas scrolling region
  gitk: Fix bug causing nearby tags/heads to sometimes not be
      displayed
  gitk: Improve handling of whitespace and special chars in filenames
  gitk: Add a progress bar to show progress while resetting

Quy Tonthat (1):
  git.spec: RPM failed, looking for wrong files.

Ren=C3=A9 Scharfe (2):
  diffcore-rename: don't change similarity index based on basename
      equality
  diff: round down similarity index

Sam Vilain (2):
  git-svn: use git-log rather than rev-list | xargs cat-file
  git-svn: cache max revision in rev_db databases

Shawn O. Pearce (3):
  git-gui: Quiet our installation process
  Teach bash how to complete +refspec on git-push
  Correct usages of sed in git-tag for Mac OS X

Simon Hausmann (1):
  git-new-workdir: Fix shell warning about operator =3D=3D used with
      test.

Theodore Ts'o (1):
  Don't fflush(stdout) when it's not helpful
