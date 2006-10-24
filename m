From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Mon, 23 Oct 2006 23:32:08 -0700
Message-ID: <7v4pturzpz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Oct 24 08:32:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcFpd-00011e-TO
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 08:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbWJXGcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 02:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbWJXGcL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 02:32:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58786 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1752086AbWJXGcJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 02:32:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024063208.CLEW18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Oct 2006 02:32:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id e6YC1V00C1kojtg0000000
	Tue, 24 Oct 2006 02:32:12 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29933>

* The 'maint' branch has spawned 1.4.3.2 tonight.

* The 'master' branch has these since the last announcement.  In
  addition to all fixes in 1.4.3.2, a major change is that it
  contains Nico's delta-base-offset series that has been cooking
  in "next" for quite some time.

   Alexandre Julliard (1):
      prune-packed: Fix uninitialized variable.

   Dmitry V. Levin (1):
      git-clone: define die() and use it.

   Eric Wong (1):
      git-send-email: do not pass custom Date: header

   J. Bruce Fields (1):
      Make prune also run prune-packed

   Jakub Narebski (4):
      gitweb: Whitespace cleanup - tabs are for indent, spaces are for =
align (2)
      gitweb: Do not esc_html $basedir argument to git_print_tree_entry
      gitweb: Improve git_print_page_path
      gitweb: Add '..' (up directory) to tree view if applicable

   Jim Meyering (3):
      Don't use $author_name undefined when $from contains no /\s</.
      git-clone: honor --quiet
      xdiff/xemit.c (xdl_find_func): Elide trailing white space in a co=
ntext header.

   Junio C Hamano (5):
      pack-objects: document --delta-base-offset option
      git-repack: repo.usedeltabaseoffset
      pager: default to LESS=3DFRS
      pager: default to LESS=3DFRSX not LESS=3DFRS
      daemon: do not die on older clients.

   Karl Hasselstr=F6m (2):
      git-vc: better installation instructions
      ignore-errors requires cl

   Lars Hjemli (2):
      Fix typo in show-index.c
      Fix usagestring for git-branch

   Linus Torvalds (1):
      git-apply: prepare for upcoming GNU diff -u format change.

   Nicolas Pitre (10):
      introduce delta objects with offset to base
      teach git-unpack-objects about deltas with offset to base
      teach git-index-pack about deltas with offset to base
      make git-pack-objects able to create deltas with offset to base
      make pack data reuse compatible with both delta types
      let the GIT native protocol use offsets to delta base when possib=
le
      zap a debug remnant
      allow delta data reuse even if base object is a preferred base
      index-pack: compare only the first 20-bytes of the key.
      add the capability for index-pack to read from a stream

   Petr Baudis (1):
      gitweb: Fix setting $/ in parse_commit()

   Rene Scharfe (1):
      git-merge: show usage if run without arguments

   Santi B=E9jar (1):
      Documentation for the [remote] config

   Shawn Pearce (1):
      Use column indexes in git-cvsserver where necessary.


* The 'next' branch, in addition, has these.

  - Linus's packed-refs and related changes are supposed to
    graduate to "master" when the dust settles from the
    tonight's update.  I think it is pretty much ready.

  - git-blame --porcelain should be ready to get pushed out, but
    it's not that urgent.

  - Superseding git-annotate by git-blame could be merged
    anytime.

  - We have accumulated some gitweb changes in "next".  Some
    depend on the packed-refs and related work, and some other
    depend on blame --porcelain.

  - An early part of my git-pickaxe is in "next", but more
    interesting bits are still cooking in "pu".

   Alan Chandler (1):
      Gitweb - provide site headers and footers

   Andy Whitcroft (2):
      cvsimport: move over to using git-for-each-ref to read refs.
      git-for-each-ref: improve the documentation on scripting modes

   Christian Couder (12):
      Add [-s|--hash] option to Linus' show-ref.
      Use Linus' show ref in "git-branch.sh".
      Document git-show-ref [-s|--hash] option.
      Fix show-ref usage for --dereference.
      Add pack-refs and show-ref test cases.
      When creating branch c/d check that branch c does not already exi=
sts.
      Uncomment test case: git branch c/d should barf if branch c exist=
s.
      Fix a remove_empty_dir_recursive problem.
      Clean up "git-branch.sh" and add remove recursive dir test cases.
      Use git-update-ref to delete a tag instead of rm()ing the ref fil=
e.
      Check that a tag exists using show-ref instead of looking for the=
 ref file.
      Do not create tag leading directories since git update-ref does i=
t.

   Dennis Stosberg (2):
      lock_ref_sha1_basic does not remove empty directories on BSD
      Remove bashism from t3210-pack-refs.sh

   Jeff King (3):
      wt-status: use simplified resolve_ref to find current branch
      gitignore: git-pack-refs is a generated file.
      gitignore: git-show-ref is a generated file.

   Johannes Schindelin (2):
      Fix git-update-index --again
      show-branch: mark active branch with a '*' again

   Jonas Fonseca (1):
      Add man page for git-show-ref

   Junio C Hamano (55):
      upload-pack: stop the other side when they have more roots than w=
e do.
      Add git-for-each-ref: helper for language bindings
      Fix t1400-update-ref test minimally
      fsck-objects: adjust to resolve_ref() clean-up.
      symbolit-ref: fix resolve_ref conversion.
      Add callback data to for_each_ref() family.
      Tell between packed, unpacked and symbolic refs.
      pack-refs: do not pack symbolic refs.
      git-pack-refs --prune
      pack-refs: fix git_path() usage.
      lock_ref_sha1_basic: remove unused parameter "plen".
      Clean-up lock-ref implementation
      update-ref: -d flag and ref creation safety.
      update a few Porcelain-ish for ref lock safety.
      Teach receive-pack about ref-log
      receive-pack: call setup_ident before git_config
      ref locking: allow 'foo' when 'foo/bar' used to exist but not any=
more.
      refs: minor restructuring of cached refs data.
      lock_ref_sha1(): do not sometimes error() and sometimes die().
      lock_ref_sha1(): check D/F conflict with packed ref when creating=
=2E
      delete_ref(): delete packed ref
      git-branch: remove D/F check done by hand.
      show-ref --hash=3Dlen, --abbrev=3Dlen, and --abbrev
      git-fetch: adjust to packed-refs.
      Fix refs.c;:repack_without_ref() clean-up path
      gitweb: make leftmost column of blame less cluttered.
      git-fetch: do not look into $GIT_DIR/refs to see if a tag exists.
      pack-refs: use lockfile as everybody else does.
      gitweb: prepare for repositories with packed refs.
      Revert 954a6183756a073723a7c9fd8d2feb13132876b0
      pack-refs: call fflush before fsync.
      blame.c: whitespace and formatting clean-up.
      git-blame: --show-number (and -n)
      git-blame: --show-name (and -f)
      blame.c: move code to output metainfo into a separate function.
      ref-log: allow ref@{count} syntax.
      git-blame --porcelain
      gitweb: use blame --porcelain
      core.logallrefupdates create new log file only for branch heads.
      git-pack-refs --all
      core.logallrefupdates thinko-fix
      blame: Document and add help text for -f, -n, and -p
      gitweb: spell "blame --porcelain" with -p
      pack-objects: use of version 3 delta is now optional.
      gitweb: use for-each-ref to show the latest activity across branc=
hes
      Revert "pack-objects: use of version 3 delta is now optional."
      ref-log: fix D/F conflict coming from deleted refs.
      git-pickaxe: blame rewritten.
      git-pickaxe -M: blame line movements within a file.
      git-pickaxe -C: blame cut-and-pasted lines.
      git-pickaxe: pagenate output by default.
      git-pickaxe: fix nth_line()
      git-pickaxe: improve "best match" heuristics
      git-pickaxe: introduce heuristics to avoid "trivial" chunks
      sha1_name.c: avoid compilation warnings.

   Linus Torvalds (6):
      Add "git show-ref" builtin command
      Teach "git checkout" to use git-show-ref
      Start handling references internally as a sorted in-memory list
      Add support for negative refs
      Make ref resolution saner
      Enable the packed refs file format

   Luben Tuikov (4):
      gitweb: blame: print commit-8 on the leading row of a commit-bloc=
k
      gitweb: blame: Mouse-over commit-8 shows author and date
      gitweb: blame porcelain: lineno and orig lineno swapped
      git-revert with conflicts to behave as git-merge with conflicts

   Petr Baudis (6):
      Fix broken sha1 locking
      Fix buggy ref recording
      gitweb: Restore object-named links in item lists
      gitweb: Make search type a popup menu
      gitweb: Do not automatically append " git" to custom site name
      gitweb: Show project's README.html if available

   Rene Scharfe (1):
      Built-in cherry

   Ryan Anderson (1):
      Remove git-annotate.perl and create a builtin-alias for git-blame


* The 'pu' branch, in addition, has these.

   Junio C Hamano (11):
      git-pickaxe: do not keep commit buffer.
      git-pickaxe: do not confuse two origins that are the same.
      git-pickaxe: get rid of wasteful find_origin().
      git-pickaxe: swap comparison loop used for -C
      merge: loosen overcautious "working file will be lost" check.
      rev-list --left-right
      para-walk: walk n trees, index and working tree in parallel
      merge-recursive: use abbreviated commit object name.
      merge-recursive: make a few functions static.
      git-diff/git-apply: make diff output a bit friendlier to GNU patc=
h (part 2)
      t3200: git-branch testsuite update

   Lars Hjemli (1):
      Make git-branch a builtin

   Petr Baudis (1):
      gitweb: Support for 'forks'
