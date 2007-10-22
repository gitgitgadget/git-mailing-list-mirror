From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's in git/spearce.git (stable)
Date: Mon, 22 Oct 2007 02:11:15 -0400
Message-ID: <20071022061115.GR14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 08:11:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjqVf-0004ba-Ox
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbXJVGLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2007 02:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbXJVGLU
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:11:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47157 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbXJVGLT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 02:11:19 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjqVQ-00024u-Uk
	for git@vger.kernel.org; Mon, 22 Oct 2007 02:11:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AE3C220FBAE; Mon, 22 Oct 2007 02:11:15 -0400 (EDT)
Content-Disposition: inline
X-maint-at: 2ee52eb17c26323b3f62538a44510aae75f09d6f
X-master-at: dd8175f83c725619d72d6bbaacf8eaafc158edea
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61952>

=46or those who may be new to the git/spearce.git concept I'm filling
in for Junio and have published a tree on repo.or.cz:

  git://repo.or.cz/git/spearce.git
  http://repo.or.cz/r/git/spearce.git

------

* The 'maint' branch has these fixes since the last announcement.

Alex Bennee (1):
  Ensure we add directories in the correct order

Andrew Clausen (1):
  helpful error message when send-pack finds no refs in common.

Brian Gernhardt (1):
  cvsserver: Use exit 1 instead of die when req_Root fails.

Gerrit Pape (1):
  git-config: print error message if the config file cannot be read

Jeff King (1):
  send-pack: respect '+' on wildcard refspecs

Joakim Tjernlund (1):
  Improve receive-pack error message about funny ref creation

Johannes Schindelin (3):
  Fix setup_git_directory_gently() with relative GIT_DIR &
      GIT_WORK_TREE
  fix filter-branch documentation
  filter-branch: update current branch when rewritten

Julian Phillips (1):
  fast-import: Fix argument order to die in file_change_m

Linus Torvalds (4):
  git-blame shouldn't crash if run in an unmerged tree
  Avoid scary errors about tagged trees/blobs during git-fetch
  Fix directory scanner to correctly ignore files without d_type
  Fix diffcore-break total breakage

Patrick Welche (1):
  Define NI_MAXSERV if not defined by operating system

Ralf Wildenhues (1):
  gitk.txt: Fix markup.

Robert Schiele (1):
  fixing output of non-fast-forward output of post-receive-email

Shawn O. Pearce (16):
  git-gui: Display message box when we cannot find git in $PATH
  git-gui: Handle starting on mapped shares under Cygwin
  git-gui: Ensure .git/info/exclude is honored in Cygwin workdirs
  git-gui: Allow gitk to be started on Cygwin with native Tcl/Tk
  git-gui: Don't crash when starting gitk from a browser session
  Correct typos in release notes for 1.5.3.5
  Avoid 'expr index' on Mac OS X as it isn't supported
  Document additional 1.5.3.5 fixes in release notes
  Yet more 1.5.3.5 fixes mentioned in release notes
  Avoid invoking diff drivers during git-stash
  Further 1.5.3.5 fixes described in release notes
  Paper bag fix diff invocation in 'git stash show'
  git-gui: Correctly report failures from git-write-tree
  git-gui: Handle progress bars from newer gits
  git-gui: Don't display CR within console windows
  Describe more 1.5.3.5 fixes in release notes

Simon Sasburg (1):
  git-gui: Avoid using bold text in entire gui for some fonts

Steffen Prohaska (2):
  git-gui: accept versions containing text annotations, like
      1.5.3.mingw.1
  attr: fix segfault in gitattributes parsing code


* The 'master' branch has these since the last announcement
  in addition to the above.

Benoit Sigoure (5):
  git-svn: add a generic tree traversal to fetch SVN properties
  git-svn: implement git svn create-ignore
  git-svn: add git svn propget
  git-svn: add git svn proplist
  git-svn: simplify the handling of fatal errors

Chris Pettitt (1):
  git-p4 support for perforce renames.

Eygene Ryabinkin (1):
  git-svn: use "no warnings 'once'" to disable false-positives

Jeff King (3):
  git-gc: improve wording of --auto notification
  Documentation/git-gc: explain --auto in description
  Documentation/git-gc: improve description of --auto

Johannes Schindelin (1):
  Deduce exec_path also from calls to git with a relative path

Johannes Sixt (1):
  gitk: Do not pick up file names of "copy from" lines

Jonathan del Strother (1):
  gitk: Add support for OS X mouse wheel

Junio C Hamano (2):
  git-am: make the output quieter.
  git-am: fix typo in the previous one.

Linus Torvalds (1):
  optimize diffcore-delta by sorting hash entries.

Luke Lu (1):
  gitweb: speed up project listing on large work trees by limiting
      find depth

Marius Storm-Olsen (1):
  Teach core.autocrlf to 'git blame'

Michael Witten (1):
  git-cvsexportcommit.perl: git-apply no longer needs --binary

Paul Mackerras (3):
  gitk: Check that we are running on at least Tcl/Tk 8.4
  gitk: Avoid an error when cherry-picking if HEAD has moved on
  gitk: Fix "can't unset prevlines(...)" Tcl error

Ralf Wildenhues (1):
  git-cherry-pick: improve description of -x.

Ren=C3=A9 Scharfe (1):
  Correct some sizeof(size_t) !=3D sizeof(unsigned long) typing errors

Sam Vilain (1):
  gitk: disable colours when calling git log

Shawn O. Pearce (2):
  Improved const correctness for strings
  Use PRIuMAX instead of 'unsigned long long' in show-index

Simon Hausmann (1):
  git-p4: When skipping a patch as part of "git-p4 submit" make sure
      we correctly revert to the previous state of the files using
      "p4 revert".

koreth@midwinter.com (1):
  Add a message explaining that automatic GC is about to start
