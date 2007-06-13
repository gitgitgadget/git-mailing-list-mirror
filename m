From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 13 Jun 2007 13:11:10 -0700
Message-ID: <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 22:11:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyZBT-0008NJ-Se
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 22:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbXFMULO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 13 Jun 2007 16:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbXFMULN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 16:11:13 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54764 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbXFMULM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 16:11:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613201111.ICPM1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 Jun 2007 16:11:11 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B8BB1X00R1kojtg0000000; Wed, 13 Jun 2007 16:11:11 -0400
X-maint-at: 4f01d0f92db5cb38aaaab83adb50557beb35fb91
X-master-at: 38570a47fcd9d7631c03673249f587697fa85677
In-Reply-To: <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 06 Jun 2007 19:08:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50124>

I'll be dormant for the next 72 hours or so, so please do not
get alarmed if no patches sent to the list is applied to my
tree.  Please remind me about them after they are commented on,
revised and improved, and final revision got agreed to be good
on the list.

WIth a big usability change to git-gui blame viewer on 'maint',
I think it is time to do 1.5.2.2 this weekend (if I have the
energy, that is).

The 'master' side has quite a lot of clean-ups and improvements
in the fringes, but nothing big has come out of 'next' since
1.5.2.  I would want to start the 1.5.3-rc cycle, after merging
at least the submodule Porcelain (Lars) and filter-tree
(Johannes and Pasky).  There are other topics already on 'next'
that are probably 1.5.3 material as well.

* The 'maint' branch has these fixes since the last announcement.

 Alex Riesen (2):
  Make the installation target of git-gui a little less chatty
  Fix clone to setup the origin if its name ends with .git

 Gerrit Pape (1):
  Fix typo in remote branch example in git user manual

 J. Bruce Fields (4):
  user-manual: quick-start updates
  user-manual: add a missing section ID
  Documentation: user-manual todo
  tutorial: use "project history" instead of "changelog" in header

 Junio C Hamano (1):
  checkout: do not get confused with ambiguous tag/branch names

 Kristian H=C3=B8gsberg (1):
  Unquote From line from patch before comparing with given from address=
=2E

 Luiz Fernando N. Capitulino (1):
  git-cherry: Document 'limit' command-line option

 Matthijs Melchior (1):
  New selection indication and softer colors

 Sam Vilain (1):
  Don't assume tree entries that are not dirs are blobs

 Shawn O. Pearce (47):
  git-gui: Allow creating a branch when none exists
  git-gui: Allow as few as 0 lines of diff context
  git-gui: Don't quit when we destroy a child widget
  git-gui: Attach font_ui to all spinbox widgets
  git-gui: Verify Tcl/Tk is new enough for our needs
  Revert "Make the installation target of git-gui a little less chatty"
  git-gui: Add a 4 digit commit abbreviation to the blame viewer
  git-gui: Cleanup blame::new widget initialization
  git-gui: Remove empty blank line at end of blame
  git-gui: Improve the coloring in blame viewer
  git-gui: Simplify consecutive lines that come from the same commit
  git-gui: Use arror cursor in blame viewer file data
  git-gui: Display tooltips in blame viewer
  git-gui: Highlight the blame commit header from everything else
  git-gui: Remove unnecessary reshow of blamed commit
  git-gui: Cleanup minor style nit
  git-gui: Space the commit group continuation out in blame view
  git-gui: Show author initials in blame groups
  git-gui: Allow the user to control the blame/commit split point
  git-gui: Display a progress bar during blame annotation gathering
  git-gui: Allow digging through history in blame viewer
  git-gui: Combine blame groups only if commit and filename match
  git-gui: Show original filename in blame tooltip
  git-gui: Use a label instead of a button for the back button
  git-gui: Clip the commit summaries in the blame history menu
  git-gui: Remove the loaded column from the blame viewer
  git-gui: Remove unnecessary space between columns in blame viewer
  git-gui: Use lighter colors in blame view
  git-gui: Make the line number column slightly wider in blame
  git-gui: Automatically expand the line number column as needed
  git-gui: Remove unused commit_list from blame viewer
  git-gui: Better document our blame variables
  git-gui: Cleanup redundant column management in blame viewer
  git-gui: Switch internal blame structure to Tcl lists
  git-gui: Label the uncommitted blame history entry
  git-gui: Rename fields in blame viewer to better descriptions
  git-gui: Display the "Loading annotation..." message in italic
  git-gui: Run blame twice on the same file and display both outputs
  git-gui: Display both commits in our tooltips
  git-gui: Jump to original line in blame viewer
  git-gui: Use three colors for the blame viewer background
  git-gui: Improve our labeling of blame annotation types
  git-gui: Favor the original annotations over the recent ones
  git-gui: Changed blame header bar background to match main window
  git-gui: Include 'war on whitespace' fixes from git.git
  git-gui: Give amend precedence to HEAD over MERGE_MSG
  git-gui: Save geometry before the window layout is damaged

 william pursell (1):
  Make command description imperative statement, not third-person prese=
nt.


* The 'master' branch has these since the last announcement
  in addition to the above.

 Alex Riesen (1):
  Fix push with refspecs containing wildcards

 Alexandre Julliard (1):
  pack-check: Sort entries by pack offset before unpacking them.

 Andy Whitcroft (3):
  cvsimport: add support for new style remote layout
  cvsimport: update documentation to include separate remotes option
  cvsimport: add <remote>/HEAD reference in separate remotes more

 Aneesh Kumar K.V (2):
  gitview: Fix the blame interface.
  gitview: run blame with -C -C

 Dan McGee (1):
  git-mergetool: Allow gvimdiff to be used as a mergetool

 Elvis Pranskevichus (1):
  Use git-tag in git-cvsimport

 Eric Wong (3):
  git-svn: cleanup: factor out longest_common_path() function
  git-svn: test for creating new directories over svn://
  git-svn: reduce stat() calls for a backwards compatibility check

 Frank Lichtenheld (1):
  cvsserver: Make req_Root more critical of its input data

 Jakub Narebski (6):
  gitweb: Provide links to commitdiff to each parent in 'commitdiff' vi=
ew
  gitweb: Improve "next" link in commitdiff view
  gitweb: Split git_patchset_body into separate subroutines
  gitweb: Create special from-file/to-file header for combined diff
  gitweb: Add links to blobdiffs in from-file/to-file header for merges
  gitweb: '--cc' for merges in 'commitdiff' view

 Jeff King (2):
  cmd_log_init: remove parsing of --encoding command line parameter
  refactor dir_add_name

 Jim Meyering (1):
  Don't dereference a strdup-returned NULL

 Johan Herland (1):
  Remove unnecessary code and comments on non-existing 8kB tag object r=
estriction

 Johannes Schindelin (2):
  git-merge-file: refuse to merge binary files
  Teach diff to imply --find-copies-harder upon -C -C

 Johannes Sixt (3):
  Avoid double-slash in path names that depend on $(sharedir).
  Remove trailing slash from $(template_dir).
  git-remote show: Also shorten non-fast-forward refs in the 'push' lis=
ting

 Junio C Hamano (12):
  War on whitespace
  Test wildcard push/fetch
  More missing static
  More missing static
  Even more missing static
  git-blame: do not indent with spaces.
  git-blame -w: ignore whitespace
  mktag: minimally update the description.
  Makefile: common-cmds.h depends on generate-cmdlist.sh script
  Makefile: allow generating git.o for debugging purposes
  -Wold-style-definition fix
  More static

 Lars Hjemli (2):
  git-submodule: move cloning into a separate function
  git-submodule: clone during update, not during init

 Linus Torvalds (1):
  Makefile: add an explicit rule for building assembly output

 Matthias Lederhofer (1):
  gitweb: change filename/directory name of snapshots

 Michael Ellerman (2):
  gitview: Use new-style classes
  gitview: Define __slots__ for Commit

 Pierre Habouzit (2):
  Active_nr is unsigned, hence can't be < 0
  Missing statics.

 Ren=C3=A9 Scharfe (1):
  t5000: silence unzip availability check

 Shawn O. Pearce (10):
  git gui 0.8.0
  git-gui: GUI support for running 'git remote prune <name>'
  git-gui: Show the git-gui library path in 'About git-gui'
  git-gui: Enable verbose Tcl loading earlier
  git-gui: Provide fatal error if library is unavailable
  git-gui: Disable tearoff menus on Windows, Mac OS X
  git-gui: Allow users to rename branches through 'branch -m'
  git-gui: Allow users to delete remote branches
  git-gui: Expose the merge.diffstat configuration option
  git-gui: Internalize symbolic-ref HEAD reading logic

 Theodore Ts'o (1):
  git-mergetool: Make default selection of merge-tool more intelligent
