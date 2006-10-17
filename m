From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Tue, 17 Oct 2006 00:44:13 -0700
Message-ID: <7vvemjmlo2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Oct 17 09:44:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZjcZ-0004Gu-OO
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 09:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWJQHoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 03:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWJQHoP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 03:44:15 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51362 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932220AbWJQHoO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 03:44:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017074414.HWIM12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 03:44:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bKk11V0031kojtg0000000
	Tue, 17 Oct 2006 03:44:01 -0400
To: git@vger.kernel.org
X-maint-at: 9de0834663f28bee9e6b2c4647ed6128241ed26f
X-master-at: 3453f862e1c74e400da67def9b810300ef90c3ac
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29029>

* The 'maint' branch has this fix and produced 1.4.2.4 release.

   Linus Torvalds (1):
      Fix hash function in xdiff library


* The 'master' branch has these since the last announcement.
  The fix in 'maint' is also included.  Hopefully we can cut the
  real 1.4.3 with this sometime this week.

   Junio C Hamano (1):
      Revert "move pack creation to version 3"

   Petr Baudis (1):
      svnimport: Fix broken tags being generated

   Rene Scharfe (2):
      Make write_sha1_file_prepare() void
      Replace open-coded version of hash_sha1_file()


* The 'next' branch, in addition, has these.

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

   Johannes Schindelin (3):
      Fix git-update-index --again
      show-branch: mark active branch with a '*' again
      Turn on recursive with --summary

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
      grep --all-match
      teach revision walker about --all-match.
      git-diff/git-apply: make diff output a bit friendlier to GNU patc=
h (part 1)
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
      git-send-email: do not drop custom headers the user prepared
      ref-log: allow ref@{count} syntax.
      git-send-email: real name with period need to be dq-quoted on Fro=
m: line
      git-blame --porcelain
      gitweb: use blame --porcelain
      Make git-send-email detect mbox-style patches more readily
      core.logallrefupdates create new log file only for branch heads.
      git-pack-refs --all
      core.logallrefupdates thinko-fix
      pack-objects: document --delta-base-offset option
      blame: Document and add help text for -f, -n, and -p
      gitweb: spell "blame --porcelain" with -p
      git-repack: repo.usedeltabaseoffset
      diff --numstat
      pack-objects: use of version 3 delta is now optional.
      gitweb: use for-each-ref to show the latest activity across branc=
hes
      Revert "pack-objects: use of version 3 delta is now optional."

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

   Martin Waitz (2):
      gitweb: start to generate PATH_INFO URLs.
      gitweb: warn if feature cannot be overridden.

   Matthew Wilcox (1):
      Add --dry-run option to git-send-email

   Nicolas Pitre (8):
      introduce delta objects with offset to base
      teach git-unpack-objects about deltas with offset to base
      teach git-index-pack about deltas with offset to base
      make git-pack-objects able to create deltas with offset to base
      make pack data reuse compatible with both delta types
      let the GIT native protocol use offsets to delta base when possib=
le
      zap a debug remnant
      allow delta data reuse even if base object is a preferred base

   Petr Baudis (5):
      Fix broken sha1 locking
      Fix buggy ref recording
      gitweb: Document features better
      gitweb: Fix search form when PATH_INFO is enabled
      bisect reset: Leave the tree in usable state if git-checkout fail=
ed

   Rene Scharfe (2):
      git-archive --format=3Dzip: use default version ID
      git-archive --format=3Dzip: add symlink support

   Robert Shearman (2):
      git-rebase: Use --ignore-if-in-upstream option when executing git=
-format-patch.
      git-rebase: Add a -v option to show a diffstat of the changes ups=
tream at the start of a rebase.

   Ryan Anderson (1):
      Remove git-annotate.perl and create a builtin-alias for git-blame

   Santi B=E9jar (2):
      fetch: Misc output cleanup
      merge and resolve: Output short hashes and .. in "Updating ..."

   Sasha Khapyorsky (1):
      git-svnimport.perl: copying directory from original SVN place


* The 'pu' branch, in addition, has these.

   Junio C Hamano (17):
      git-diff/git-apply: make diff output a bit friendlier to GNU patc=
h (part 2)
      para-walk: walk n trees, index and working tree in parallel
      para walk wip
      merge: loosen overcautious "working file will be lost" check.
      git-pickaxe: blame rewritten.
      git-pickaxe: minimally use revision machinery.
      git-pickaxe: fix output for more than one paths from the same com=
mit.
      git-pickaxe: fix "bottom" commit handling.
      git-pickaxe: allow using non -u0 diff internally.
      git-pickaxe: use linked list of blame entries.
      git-pickaxe: collapse trivial blame entry.
      git-pickaxe: blame line movements within a file.
      git-pickaxe: blame cut-and-pasted lines.
      git-pickaxe: -M, -C, and -C -C
      git-pickaxe: optimize nth_line()
      git-pickaxe: make -C (copy from other file) take immediate blame.
      git-pickaxe: document -M, -C, and -C -C

   Petr Baudis (1):
      gitweb: Show project README if available
