X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Thu, 26 Oct 2006 01:47:12 -0700
Message-ID: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 08:47:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-maint-at: 0ac3056850394723c9b407754b44d3d37f1dcc3f
X-master-at: e893f7ad73d387afc582d7eb063d57a88be4663d
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30155>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd0tY-0002tF-Og for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751730AbWJZIrO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 04:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWJZIrO
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:47:14 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12172 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1751730AbWJZIrM
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:47:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026084712.UCSR6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 04:47:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ewmv1V0071kojtg0000000 Thu, 26 Oct 2006
 04:46:55 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

* The 'maint' branch has produced 1.4.3.3 and has these fixes
  since the last announcement (some of them are post 1.4.3.3).

   Christian Couder (1):
      Remove --syslog in git-daemon inetd documentation examples.

   Eric Wong (1):
      git-svn: fix symlink-to-file changes when using command-line svn 1.4.0

   Gerrit Pape (1):
      Set $HOME for selftests

   J. Bruce Fields (1):
      Documentation: updates to "Everyday GIT"

   Jakub Narebski (1):
      diff-format.txt: Combined diff format documentation supplement

   Junio C Hamano (6):
      Documentation: note about contrib/.
      RPM package re-classification.
      Refer to git-rev-parse:Specifying Revisions from git.txt
      Update cherry documentation.
      Documentation/SubmittingPatches: 3+1 != 6
      Documentation: clarify refname disambiguation rules.

   Petr Baudis (1):
      xdiff: Match GNU diff behaviour when deciding hunk comment worthiness of lines

   Tuncer Ayaz (1):
      git-fetch.sh printed protocol fix


* The 'master' branch has these since the last announcement.

  I've flushed all the 'gitweb/' changes from "next" and core
  support that some of them needed; notably "for-each-ref" and
  "blame --porcelain" is now in "master".  Oh, and "annotate"
  is now a mere synonym for "blame -c".

   Alan Chandler (1):
      Gitweb - provide site headers and footers

   Andy Whitcroft (2):
      cvsimport: move over to using git-for-each-ref to read refs.
      git-for-each-ref: improve the documentation on scripting modes

   Christian Couder (1):
      Remove --syslog in git-daemon inetd documentation examples.

   Eric Wong (1):
      git-svn: fix symlink-to-file changes when using command-line svn 1.4.0

   Gerrit Pape (1):
      Set $HOME for selftests

   J. Bruce Fields (1):
      Documentation: updates to "Everyday GIT"

   Jakub Narebski (4):
      gitweb: Get rid of git_print_simplified_log
      gitweb: Filter out commit ID from @difftree in git_commit and git_commitdiff
      gitweb: Print commit message without title in commitdiff only if there is any
      diff-format.txt: Combined diff format documentation supplement

   Junio C Hamano (20):
      Add git-for-each-ref: helper for language bindings
      gitweb: make leftmost column of blame less cluttered.
      gitweb: prepare for repositories with packed refs.
      Revert 954a6183756a073723a7c9fd8d2feb13132876b0
      blame.c: whitespace and formatting clean-up.
      git-blame: --show-name (and -f)
      git-blame: --show-number (and -n)
      blame.c: move code to output metainfo into a separate function.
      git-blame --porcelain
      gitweb: use blame --porcelain
      blame: Document and add help text for -f, -n, and -p
      gitweb: spell "blame --porcelain" with -p
      gitweb: use for-each-ref to show the latest activity across branches
      Documentation: note about contrib/.
      RPM package re-classification.
      Refer to git-rev-parse:Specifying Revisions from git.txt
      Update cherry documentation.
      Documentation/SubmittingPatches: 3+1 != 6
      Documentation: clarify refname disambiguation rules.
      combine-diff: a few more finishing touches.

   Luben Tuikov (3):
      gitweb: blame: print commit-8 on the leading row of a commit-block
      gitweb: blame: Mouse-over commit-8 shows author and date
      gitweb: blame porcelain: lineno and orig lineno swapped

   Petr Baudis (5):
      gitweb: Restore object-named links in item lists
      gitweb: Make search type a popup menu
      gitweb: Do not automatically append " git" to custom site name
      gitweb: Show project's README.html if available
      xdiff: Match GNU diff behaviour when deciding hunk comment worthiness of lines

   Ryan Anderson (1):
      Remove git-annotate.perl and create a builtin-alias for git-blame

   Tuncer Ayaz (1):
      git-fetch.sh printed protocol fix


* The 'next' branch, in addition, has these.

  The next series to graduate is Linus's "packed-ref" and
  associated changes, including rewrite of "branch" in C,
  perhaps early next week.

   Christian Couder (12):
      Add [-s|--hash] option to Linus' show-ref.
      Use Linus' show ref in "git-branch.sh".
      Document git-show-ref [-s|--hash] option.
      Fix show-ref usage for --dereference.
      Add pack-refs and show-ref test cases.
      When creating branch c/d check that branch c does not already exists.
      Uncomment test case: git branch c/d should barf if branch c exists.
      Fix a remove_empty_dir_recursive problem.
      Clean up "git-branch.sh" and add remove recursive dir test cases.
      Use git-update-ref to delete a tag instead of rm()ing the ref file.
      Check that a tag exists using show-ref instead of looking for the ref file.
      Do not create tag leading directories since git update-ref does it.

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

   Junio C Hamano (47):
      upload-pack: stop the other side when they have more roots than we do.
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
      ref locking: allow 'foo' when 'foo/bar' used to exist but not anymore.
      refs: minor restructuring of cached refs data.
      lock_ref_sha1(): do not sometimes error() and sometimes die().
      lock_ref_sha1(): check D/F conflict with packed ref when creating.
      delete_ref(): delete packed ref
      git-branch: remove D/F check done by hand.
      show-ref --hash=len, --abbrev=len, and --abbrev
      git-fetch: adjust to packed-refs.
      Fix refs.c;:repack_without_ref() clean-up path
      git-fetch: do not look into $GIT_DIR/refs to see if a tag exists.
      pack-refs: use lockfile as everybody else does.
      pack-refs: call fflush before fsync.
      ref-log: allow ref@{count} syntax.
      core.logallrefupdates create new log file only for branch heads.
      git-pack-refs --all
      core.logallrefupdates thinko-fix
      pack-objects: use of version 3 delta is now optional.
      Revert "pack-objects: use of version 3 delta is now optional."
      ref-log: fix D/F conflict coming from deleted refs.
      git-pickaxe: blame rewritten.
      git-pickaxe -M: blame line movements within a file.
      git-pickaxe -C: blame cut-and-pasted lines.
      git-pickaxe: pagenate output by default.
      git-pickaxe: fix nth_line()
      git-pickaxe: improve "best match" heuristics
      git-pickaxe: introduce heuristics to avoid "trivial" chunks
      git-pickaxe: do not keep commit buffer.
      git-pickaxe: do not confuse two origins that are the same.
      git-pickaxe: get rid of wasteful find_origin().
      git-pickaxe: swap comparison loop used for -C
      sha1_name.c: avoid compilation warnings.
      t3200: git-branch testsuite update

   Lars Hjemli (1):
      Make git-branch a builtin

   Linus Torvalds (6):
      Add "git show-ref" builtin command
      Teach "git checkout" to use git-show-ref
      Start handling references internally as a sorted in-memory list
      Add support for negative refs
      Make ref resolution saner
      Enable the packed refs file format

   Luben Tuikov (1):
      git-revert with conflicts to behave as git-merge with conflicts

   Nicolas Pitre (1):
      enable index-pack streaming capability

   Petr Baudis (2):
      Fix broken sha1 locking
      Fix buggy ref recording

   Rene Scharfe (1):
      Built-in cherry


* The 'pu' branch, in addition, has these.

  We'd still need more work on merge-recursive to fix the
  overcautious "working file will be overwritten by merge" --
  this is really needed for usability.

  The diff/apply change I am holding back is the one that
  appends an extra tab after "---/+++" filename to the diff
  output, when the filename has an embedded SP in it, to make it
  compatible with GNU diff.  Updates to git-apply to understand
  the new output is already in "master" but not in 1.4.3 series,
  and until it propagates to majority of users, this change
  cannot be unleashed, in order to keep people with older git
  who use such a pathname happy.

  I did not hear any comments on the left-right stuff; perhaps
  it is not needed, or it is not useful as its current shape (it
  could be enhanced to say which starting commits each of the
  commit is reachable from, by borrowing much of show-branch
  code).

  I looked at Pasky's "project forks" gitweb code, and while I
  liked it a lot (having a demonstration site repo.or.cz really
  helps), I read on #git log that Pasky himself was having
  doubt, so it is parked in "pu", not in "next".

  Nico's 3-patch index-pack rework is quite nice; unfortunately
  the last one in the series seems to make the test fail so it
  is not included here, and I did not find enough time to see if
  the other two are "next" material.  They are parked in "pu" in
  the meantime.

   Junio C Hamano (7):
      merge: loosen overcautious "working file will be lost" check.
      merge-recursive: use abbreviated commit object name.
      merge-recursive: make a few functions static.
      git-commit: show --summary after successful commit.
      para-walk: walk n trees, index and working tree in parallel
      git-diff/git-apply: make diff output a bit friendlier to GNU patch (part 2)
      rev-list --left-right

   Nicolas Pitre (2):
      make index-pack able to complete thin packs.
      add progress status to index-pack

   Petr Baudis (1):
      gitweb: Support for 'forks'

