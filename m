From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's in git/spearce.git (Sep 2008, #04; Mon, 29)
Date: Mon, 29 Sep 2008 11:46:29 -0700
Message-ID: <20080929184629.GA21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 20:47:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkNmX-0007Gq-1M
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 20:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbYI2Sqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 14:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbYI2Sqb
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 14:46:31 -0400
Received: from george.spearce.org ([209.20.77.23]:54092 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbYI2Sqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 14:46:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8F1193835F; Mon, 29 Sep 2008 18:46:29 +0000 (UTC)
Content-Disposition: inline
X-maint-at: edb7e82f72106add9f2fbaf9d99d9532a72e3f91
X-master-at: 9800c0df412869c7949935b61581b9361fc49bd1
X-maint-was: db87e3960c5a770db13c9ba9602b5e88848e2d1a
X-master-was: c4275591fbb7d582c397b228e38dbb8419c89330
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97044>

What's in git/spearce.git (Sep 2008, #04; Mon, 29)

  maint edb7e82 (Merge branch 'bc/maint-diff-hunk-header-fix' into maint)
 master 9800c0d (Merge branch 'bc/master-diff-hunk-header-fix')
------------------------------------------------------------------------

With Junio offline for another week we won't see a 1.6.0.3 until
probably mid-October.  With that in mind I've merged a number of
topics and trivial patches to maint so we can shake these out
before the 1.6.0.3 release.

* The 'maint' branch has these fixes since the last announcement.

Alex Riesen (3):
  Remove empty directories in recursive merge
  Add remove_path: a function to remove as much as possible of a path
  Use remove_path from dir.c instead of own implementation

Brandon Casey (5):
  diff.c: return pattern entry pointer rather than just the hunk header
    pattern
  diff.c: associate a flag with each pattern and use it for compiling regex
  diff.*.xfuncname which uses "extended" regex's for hunk header selection
  t4018-diff-funcname: test syntax of builtin xfuncname patterns
  git-stash.sh: don't default to refs/stash if invalid ref supplied

Chris Frey (1):
  Documentation: clarify the details of overriding LESS via core.pager

Deskin Miller (1):
  maint: check return of split_cmdline to avoid bad config strings

Johan Herland (2):
  for-each-ref: Fix --format=%(subject) for log message without newlines
  Use strchrnul() instead of strchr() plus manual workaround

Jonas Fonseca (1):
  checkout: Do not show local changes when in quiet mode

Junio C Hamano (2):
  diff: use extended regexp to find hunk headers
  diff hunk pattern: fix misconverted "\{" tex macro introducers

Michael J Gruber (1):
  make "git remote" report multiple URLs

Ping Yin (1):
  git-submodule: Fix "Unable to checkout" for the initial 'update'

Rafael Garcia-Suarez (1):
  Clarify commit error message for unmerged files

Shawn O. Pearce (1):
  Update release notes for 1.6.0.3

Stephen Haberman (1):
  Clarify how the user can satisfy stash's 'dirty state' check.


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Cleanup remove_path

Alexander Gavrilov (9):
  git-gui: Fix Blame Parent & Context for working copy lines.
  git-gui: Restore ability to Stage Working Copy for conflicts.
  git-gui: Add more integration options to citool.
  git-gui: Cleanup handling of the default encoding.
  git-gui: Add a menu of available encodings.
  git-gui: Allow forcing display encoding for diffs using a submenu.
  git-gui: Optimize encoding name resolution using a lookup table.
  git-gui: Support the encoding menu in gui blame.
  git-gui: Reenable staging unmerged files by clicking the icon.

Anders Melchiorsen (2):
  wt-status: Split header generation into three functions
  wt-status: Teach how to discard changes in the working directory

Brandon Casey (1):
  t4018-diff-funcname: test syntax of builtin xfuncname patterns

Christian Stimming (2):
  git-gui: I18n fix sentence parts into full sentences for translation
    again.
  git-gui: Updated German translation.

Dmitry Potapov (1):
  mingw: remove use of _getdrive() from lstat/fstat

Garry Dolley (1):
  Fixed some grammatical errors in git-rebase.txt documentation.

Giuseppe Bilotta (1):
  gitweb: shortlog now also obeys $hash_parent

Heikki Orsila (1):
  diff --dirstat-by-file: count changed files, not lines

Johan Herland (2):
  Fix AsciiDoc errors in merge documentation
  Fix submodule sync with relative submodule URLs

Johannes Sixt (1):
  compat/mingw: Support a timeout in the poll emulation if no fds are given

Joshua Williams (1):
  git-gui: Add support for calling out to the prepare-commit-msg hook

Junio C Hamano (21):
  checkout -f: allow ignoring unmerged paths when checking out of the index
  checkout --ours/--theirs: allow checking out one side of a conflicting
    merge
  xdl_fill_merge_buffer(): separate out a too deeply nested function
  xdiff-merge: optionally show conflicts in "diff3 -m" style
  xmerge.c: minimum readability fixups
  xmerge.c: "diff3 -m" style clips merge reduction level to EAGER or less
  rerere.c: use symbolic constants to keep track of parsing states
  rerere: understand "diff3 -m" style conflicts with the original
  merge.conflictstyle: choose between "merge" and "diff3 -m" styles
  git-merge-recursive: learn to honor merge.conflictstyle
  checkout -m: recreate merge when checking out of unmerged index
  checkout --conflict=<style>: recreate merge in a non-default style
  git-merge documentation: describe how conflict is presented
  safe_create_leading_directories(): make it about "leading" directories
  git-apply:--include=pathspec
  is_directory(): a generic helper function
  receive-pack: make it a builtin
  push: prepare sender to receive extended ref information from the
    receiver
  push: receiver end advertises refs from alternate repositories
  diff: use extended regexp to find hunk headers
  diff: fix "multiple regexp" semantics to find hunk header comment

Miklos Vajna (13):
  Split out merge_recursive() to merge-recursive.c
  merge-recursive: introduce merge_options
  builtin-merge: avoid run_command_v_opt() for recursive and subtree
  cherry-pick/revert: make direct internal call to merge_tree()
  merge-recursive: move call_depth to struct merge_options
  merge-recursive: get rid of the index_only global variable
  merge-recursive: move the global obuf to struct merge_options
  merge-recursive: move current_{file,directory}_set to struct
    merge_options
  merge-recursive: get rid of virtual_id
  builtin-merge: release the lockfile in try_merge_strategy()
  commit_tree(): add a new author parameter
  builtin-commit: use commit_tree()
  t7603: add new testcases to ensure builtin-commit uses reduce_heads()

Nanako Shiraishi (4):
  remote.c: make free_ref(), parse_push_refspec() and free_refspecs()
    static.
  graph.c: make many functions static
  usage.c: remove unused functions
  Add contrib/rerere-train script

Petr Baudis (1):
  git-web--browse: Support for using /bin/start on MinGW

Pieter de Bie (1):
  git wrapper: also use aliases to correct mistyped commands

Shawn O. Pearce (3):
  git-gui: Hide commit related UI during citool --nocommit
  git-gui: Use gitattribute "encoding" for file content display
  git-gui: Assume `blame --incremental` output is in UTF-8

Stephan Beyer (1):
  merge-recursive.c: Add more generic merge_recursive_generic()



-- 
Shawn.
