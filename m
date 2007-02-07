From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.0-rc4
Date: Wed, 07 Feb 2007 15:21:01 -0800
Message-ID: <7v1wl15zc2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 00:21:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEw69-00020J-Q6
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161484AbXBGXVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 18:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161420AbXBGXVF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:21:05 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:34908 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422793AbXBGXVD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Feb 2007 18:21:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207232102.RWCQ1306.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 18:21:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LnM11W00d1kojtg0000000; Wed, 07 Feb 2007 18:21:02 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38997>

The latest and hopefully the last rc for GIT 1.5.0 is available
at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.0.rc4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.0.rc4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.0.rc4.tar.{gz,bz2}		(preformatted docs)
  testing/git-*-1.5.0.rc4-1.$arch.rpm	(RPM)

Late comers are independent reflog for HEAD, git-blame that
annotates the working tree files (and "--contents <file>"), and
git-fast-import.

----------------------------------------------------------------

Changes since v1.5.0-rc3 are as follows:

Alex Riesen (1):
      Avoid ActiveState Perl IO in t800[12]

Andy Parkins (2):
      doc: hooks.txt said post-commit default sends an email, it doesn'=
t
      git-for-each-ref doesn't return "the bit after $GIT_DIR/refs"

Aneesh Kumar K.V (1):
      blameview: Support browsable functionality to blameview.

David K=C3=A5gedal (1):
      git-blame: an Emacs minor mode to view file with git-blame output=
=2E

Eric Wong (2):
      git-svn: do not let Git.pm warn if we prematurely close pipes
      Disallow invalid --pretty=3D abbreviations

Gerrit Pape (1):
      git-archimport: initial import needs empty directory

Horst H. von Brand (1):
      Call make always with CFLAGS in git.spec

Johannes Schindelin (4):
      Teach the '@{...}' notation to git-log -g
      Update the documentation for the new '@{...}' syntax
      Commands requiring a work tree must not run in GIT_DIR
      fast-import: Fix compile warnings

Junio C Hamano (36):
      create_symref(): do not assume pathname from git_path() persists =
long enough
      detached HEAD -- finishing touches
      Use "git checkout -q" in git-bisect
      Tutorial: fix asciidoc formatting of "git add" section.
      Tutorial-2: Adjust git-status output to recent reality.
      core-tutorial: http reference link fix
      fix reflog entries for "git-branch"
      honor GIT_REFLOG_ACTION in git-commit
      Why is it bad to rewind a branch that has already been pushed out=
?
      combine-diff: special case --unified=3D0
      show-branch -g: default to the current branch.
      git-clone --reference: saner handling of borrowed symrefs.
      Revert "Allow branch.*.merge to talk about remote tracking branch=
es."
      Rename get_ident() to fmt_ident() and make it available to outsid=
e
      t9200: Work around HFS+ issues.
      bisect: it needs to be done in a working tree.
      git-blame: no rev means start from the working tree file.
      Add pretend_sha1_file() interface.
      Use pretend_sha1_file() in git-blame and git-merge-recursive.
      blame: document --contents option
      Teach git-remote add to fetch and track
      Fix longstanding mismerge of ALL_CFLAGS vs BASIC_CFLAGS
      gitk: Use show-ref instead of ls-remote
      git-push: allow globbing wildcard refspec.
      gitweb: fix mismatched parenthesis
      annotate: fix for cvsserver.
      S_IFLNK !=3D 0140000
      Remove contrib/colordiff
      Add deprecation notices.
      Remove git-merge-recur
      git-clone --reference: work well with pack-ref'ed reference repos=
itory
      for-each-reflog: fix case for empty log directory
      t4200: skip gc-rerere test on systems with non GNU date.
      git-add -i: update removed path correctly.
      Documentation: Add gfi to the main command list.
      GIT v1.5.0-rc4

Linus Torvalds (2):
      pager: Work around window resizing bug in 'less'
      Fix "git log -z" behaviour

Mark Levedahl (2):
      gitk - remove trailing whitespace from a few lines.
      Make gitk work reasonably well on Cygwin.

Michael (1):
      Documentation: add KMail in SubmittingPatches

Mike Coleman (1):
      Fix some documentation typos and grammar

Nicolas Pitre (14):
      make reflog filename independent from struct ref_lock
      lock_ref_sha1_basic(): remember the original name of a ref when r=
esolving it
      enable separate reflog for HEAD
      add reflog entries for HEAD when detached
      move create_symref() past log_ref_write()
      add logref support to git-symbolic-ref
      add reflog when moving HEAD to a new branch
      reword the detached head message a little again
      add a quiet option to git-checkout
      prevent HEAD reflog to be interpreted as current branch reflog
      provide a nice @{...} syntax to always mean the current branch re=
flog
      scan reflogs independently from refs
      Enable HEAD@{...} and make it independent from the current branch
      Let git-checkout always drop any detached head

Pavel Roskin (2):
      git-config --rename-section could rename wrong section
      Assorted typo fixes

Robin Rosenberg (1):
      Why is it bad to rewind a branch that has already been pushed out=
?

Shawn O. Pearce (113):
      Created fast-import, a tool to quickly generating a pack from blo=
bs.
      Added automatic index generation to fast-import.
      Cleaned up memory allocation for object_entry structs.
      Refactored fast-import's internals for future additions.
      Added basic command handler to fast-import.
      Implemented branch handling and basic tree support in fast-import=
=2E
      Added tree and commit writing to fast-import.
      Implement blob ID validation in fast-import.
      Converted fast-import to a text based protocol.
      Changed fast-import's pack header creation to use pack.h
      Allow symlink blobs in trees during fast-import.
      Fixed segfault in fast-import after growing a tree.
      Converted fast-import to accept standard command line parameters.
      Added mark store/find to fast-import.
      Added branch load counter to fast-import.
      Implemented 'tag' command in fast-import.
      Implemented tree reloading in fast-import.
      Round out memory pool allocations in fast-import to pointer sizes=
=2E
      Remove branch creation command from fast-import.
      Moved from command to after data to help cvs2svn.
      Account for tree entry memory costs in fast-import.
      Added option to export the marks table when fast-import terminate=
s.
      Added --branch-log to option to fast-import.
      Fixed GPF in fast-import caused by unterminated linked list.
      Fixed compile error in fast-import.
      Map only part of the generated pack file at any point in time.
      Added 'reset' command to clear a branch's tree.
      Don't crash fast-import if no branch log was requested.
      Converted hash memcpy/memcmp to new hashcpy/hashcmp/hashclr.
      Implemented tree delta compression in fast-import.
      Recycle data buffers for tree generation in fast-import.
      Reuse the same buffer for all commits/tags in fast-import.
      Replace ywrite in fast-import with the standard write_or_die.
      Correct tree corruption problems in fast-import.
      Additional fast-import tree delta corruption cleanups.
      Fix repository corruption when using marks for modified blobs.
      Support creation of merge commits in fast-import.
      Allow creating branches without committing in fast-import.
      Improve reuse of sha1_file library within fast-import.
      Misc. type cleanups within fast-import.
      Restructure fast-import to support creating multiple packfiles.
      Remove unnecessary duplicate_count in fast-import.
      Implemented manual packfile switching in fast-import.
      Don't create a final empty packfile in fast-import.
      Optimize index creation on large object sets in fast-import.
      Implemented automatic checkpoints within fast-import.
      Print the packfile names to stdout from fast-import.
      Corrected buffer overflow during automatic checkpoint in fast-imp=
ort.
      Use uintmax_t for marks in fast-import.
      Replace redundant yread() with read_in_full() in fast-import.
      Reuse sha1 in packed_git in fast-import.
      Use .keep files in fast-import during processing.
      Ensure we close the packfile after creating it in fast-import.
      Remove unnecessary pack_fd global in fast-import.
      Correct max_packsize default in fast-import.
      Correct object_count type and stat output in fast-import.
      Print out the edge commits for each packfile in fast-import.
      Corrected BNF input documentation for fast-import.
      Correct a few types to be unsigned in fast-import.
      Declare no-arg functions as (void) in fast-import.
      Correct packfile edge output in fast-import.
      Always use struct pack_header for pack header in fast-import.
      Use fixed-size integers when writing out the index in fast-import=
=2E
      Remove unnecessary options from fast-import.
      Support delimited data regions in fast-import.
      Create test case for fast-import.
      Reduce value duplication in t9300-fast-import.
      Accept 'inline' file data in fast-import commit structure.
      Pull out remote listing functions in git-remote.
      Teach 'git remote' how to cleanup stale tracking branches.
      Cleanup prepare_packed_git_one to reuse install_packed_git.
      Correct comment in prepare_packed_git_one.
      Refactor open_packed_git to return an error code.
      Don't find objects in packs which aren't available anymore.
      Don't leak file descriptors from unavailable pack files.
      Cleanup subcommand documentation for git-remote.
      Keep untracked files not involved in a merge.
      Default GIT_MERGE_VERBOSITY to 5 during tests.
      bash: Remove short option completions for branch/checkout/diff.
      bash: Classify cat-file and reflog as plumbing.
      bash: Complete long options to git-add.
      bash: Add space after unique command name is completed.
      bash: Classify more commends out of completion.
      bash: Support unique completion on git-config.
      bash: Support unique completion when possible.
      bash: Support internal revlist options better.
      Include checkpoint command in the BNF.
      Reduce memory usage of fast-import.
      Show an example of deleting commits with git-rebase.
      bash: Support completion on git-cherry.
      bash: Hide diff-stages from completion.
      bash: Offer --prune completion for git-gc.
      bash: Hide git-resolve, its deprecated.
      bash: Support --add completion to git-config.
      bash: Support git-bisect and its subcommands.
      Don't support shell-quoted refnames in fast-import.
      Initial draft of fast-import documentation.
      bash: Support git-rebase -m continuation completion.
      bash: Complete git-remote subcommands.
      Remove --branch-log from fast-import.
      Correct compiler warnings in fast-import.
      Correct minor style issue in fast-import.
      Correct fast-import timezone documentation.
      Remove unnecessary null pointer checks in fast-import.
      Minor fast-import documentation corrections.
      Support RFC 2822 date parsing in fast-import.
      Don't do non-fastforward updates in fast-import.
      Minor timestamp related documentation corrections for fast-import=
=2E
      Teach fast-import how to clear the internal branch content.
      Teach fast-import how to sit quietly in the corner.
      Dump all refs and marks during a checkpoint in fast-import.
      Don't crash fast-import if the marks cannot be exported.
      Add a Tips and Tricks section to fast-import's manual.

Simon 'corecode' Schubert (1):
      Allow forcing of a parent commit, even if the parent is not a dir=
ect one.

Stelian Pop (1):
      Add hg-to-git conversion utility.

Uwe Kleine-K=C3=B6nig (1):
      add replay and log to the usage string of git-bisect

Yasushi SHOJI (1):
      gitweb: Convert project name to UTF-8
