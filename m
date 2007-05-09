From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Wed, 09 May 2007 01:46:09 -0700
Message-ID: <7vhcqmwfji.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 10:46:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlhoU-0004i5-Iq
	for gcvg-git@gmane.org; Wed, 09 May 2007 10:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980AbXEIIqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 04:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755975AbXEIIqN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 04:46:13 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50580 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbXEIIqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 04:46:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509084609.IPDG1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 04:46:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wwm91W00E1kojtg0000000; Wed, 09 May 2007 04:46:09 -0400
X-maint-at: 1cc202bd4ebd0390d738f0d633d42791cb79dd05
X-master-at: fba23c87fda0ac6698f191db6df57b8fdf23e2f8
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46681>

v1.5.1.4 is out.

Thanks to HPA who installed libdbi-dbd interface to sqlite on
kernel.org machines, Frank's cvsserver tests are now in
'master', along with updates to gitweb and git-gui.  I've thrown
in the diff-tree memory optimization we discussed in the OOo
thread as well.

I haven't tagged the tip of the 'master', but this is pretty
much 1.5.2-rc3 -- I may tag it tomorrow with a few more fixes I
noticed are needed while I was reviewing the list traffic (I
updated todo:TODO with them).

v1.5.2 final is scheduled for sometime late next week, hopefully
with git-gui v0.7.0 final.

----------------------------------------------------------------

* The 'maint' branch is now at 1.5.1.4, with these fixes since
  the last announcement.

 Amos Waterland (1):
  wcwidth redeclaration

 J. Bruce Fields (7):
  user-manual: more discussion of detached heads, fix typos
  user-manual: add section ID's
  user-manual: clean up fast-forward and dangling-objects sections
  user-manual: fix .gitconfig editing examples
  user-manual: miscellaneous editing
  user-manual: stop deprecating the manual
  user-manual: fix clone and fetch typos

 Jeff King (1):
  Documentation: don't reference non-existent 'git-cvsapplycommit'

 Junio C Hamano (1):
  GIT v1.5.1.4

 Paul Mackerras (1):
  gitk: Allow user to choose whether to see the diff, old file, or new file

 Quy Tonthat (1):
  Add howto files to rpm packages.

 Shawn O. Pearce (1):
  git-gui: Allow spaces in path to 'wish'


* The 'master' branch has these since the last announcement
  in addition to the above.

 Alex Riesen (1):
  Use GIT_OBJECT_DIR for temporary files of pack-objects

 Frank Lichtenheld (1):
  cvsserver: Add test cases for git-cvsserver

 Jakub Narebski (6):
  gitweb: Add parsing of raw combined diff format to parse_difftree_raw_line
  gitweb: Add combined diff support to git_difftree_body
  gitweb: Add combined diff support to git_patchset_body
  gitweb: Make it possible to use pre-parsed info in git_difftree_body
  gitweb: Show combined diff for merge commits in 'commitdiff' view
  gitweb: Show combined diff for merge commits in 'commit' view

 Junio C Hamano (5):
  diff: release blobs after generating textual diff.
  diff.c: do not use a separate "size cache".
  diff -M: release the preimage candidate blobs after rename detection.
  diff -S: release the image after looking for needle in it
  Update documentation links to point at 1.5.1.4

 Matthieu Moy (2):
  Document git add -u introduced earlier.
  Added a reference to git-add in the documentation for git-update-index

 Michael Spang (3):
  dir.c: Omit non-excluded directories with dir->show_ignored
  t7300: Basic tests for git-clean
  Fix minor documentation errors

 Shawn O. Pearce (17):
  git-gui: Correctly handle UTF-8 encoded commit messages
  git-gui: Include the subject in the status bar after commit
  git-gui: Warn users before making an octopus merge
  git-gui: Correct line wrapping for too many branch message
  git-gui: Cleanup common font handling for font_ui
  git-gui: Use option database defaults to set the font
  git-gui: Refactor to use our git proc more often
  git-gui: Track our own embedded values and rebuild when they change
  git-gui: Refactor into multiple files to save my sanity
  git-gui: Move console procs into their own namespace
  git-gui: Allow vi keys to scroll the diff/blame regions
  git-gui: Move merge support into a namespace
  git-gui: Show all possible branches for merge
  git-gui: Include commit id/subject in merge choices
  git-gui: Use vi-like keys in merge dialog
  Remove duplicate exports from Makefile
  Use .git/MERGE_MSG in cherry-pick/revert

 Theodore Ts'o (2):
  Add pack.depth option to git-pack-objects.
  Increase pack.depth default to 50
