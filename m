From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Thu, 08 Nov 2007 00:08:15 -0800
Message-ID: <7vir4d40sw.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 09:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2RN-0006DJ-Mo
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbXKHII0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 03:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbXKHII0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:08:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51455 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbXKHIIZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 03:08:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 650492EF;
	Thu,  8 Nov 2007 03:08:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 529B991AC0;
	Thu,  8 Nov 2007 03:08:44 -0500 (EST)
X-master-at: 53d149c54bdedd4cf490943a5478a7826c2379c9
X-next-at: f0e08e952450b3b0dae1fca4901a9263c020ff82
In-Reply-To: <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 03 Nov 2007 21:14:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63955>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

----------------------------------------------------------------
[Will merge to 'master' this weekend]

* js/parseopt-abbrev-fix (Mon Nov 5 13:15:21 2007 +0000) 1 commit
 + parse-options: abbreviation engine fix.

* js/reset (Sat Nov 3 15:21:21 2007 +0000) 2 commits
 + builtin-reset: avoid forking "update-index --refresh"
 + builtin-reset: do not call "ls-files --unmerged"

* js/upload-pack (Sun Nov 4 20:46:48 2007 +0100) 1 commit
 + upload-pack: Use finish_{command,async}() instead of waitpid().

----------------------------------------------------------------
[Will cook til next week and then merge to 'master']

* bg/format-patch-N (Tue Nov 6 10:04:24 2007 +1100) 3 commits
 + Rearrange git-format-patch synopsis to improve clarity.
 + format-patch: Test --[no-]numbered and format.numbered
 + format-patch: Add configuration and off switch for --numbered

* db/remote-builtin (Tue Nov 6 20:29:20 2007 -0500) 6 commits
 + Reteach builtin-ls-remote to understand remotes
 + Build in ls-remote
 + Use built-in send-pack.
 + Build-in send-pack, with an API for other programs to call.
 + Build-in peek-remote, using transport infrastructure.
 + Miscellaneous const changes and utilities

* jc/stash-create (Wed Nov 7 15:10:27 2007 -0600) 5 commits
 + git-stash: Fix listing stashes
 + git-merge: no reason to use cpio anymore
 + Revert "rebase: allow starting from a dirty tree."
 + rebase: allow starting from a dirty tree.
 + stash: implement "stash create"

* lt/rev-list-interactive (Mon Nov 5 13:22:34 2007 -0800) 4 commits
 + revision walker: mini clean-up
 + Enhance --early-output format
 + Add "--early-output" log flag for interactive GUI use
 + Simplify topo-sort logic

* jk/terse-push (Mon Nov 5 00:12:18 2007 -0500) 6 commits
 + send-pack: require --verbose to show update of tracking refs
 + receive-pack: don't mention successful updates
 + more terse push output
 + Build-in send-pack, with an API for other programs to call.
 + Build-in peek-remote, using transport infrastructure.
 + Miscellaneous const changes and utilities

* mh/retag (Sun Nov 4 01:11:15 2007 +0100) 2 commits
 + Add tests for git tag
 + Reuse previous annotation when overwriting a tag

* np/progress (Tue Nov 6 16:30:28 2007 -0500) 6 commits
 + make display of total transferred fully accurate
 + remove dead code from the csum-file interface
 + git-fetch: be even quieter.
 + make display of total transferred more accurate
 + sideband.c: ESC is spelled '\033' not '\e' for portability.
 + fix display overlap between remote and local progress

----------------------------------------------------------------
[Actively cooking]

* ph/parseopt-sh (Wed Nov 7 23:04:38 2007 -0800) 14 commits
 + git-sh-setup: fix parseopt `eval` string underquoting
 + Give git-am back the ability to add Signed-off-by lines.
 + git-rev-parse --parseopt
 + scripts: Add placeholders for OPTIONS_SPEC
 + Migrate git-repack.sh to use git-rev-parse --parseopt
 + Migrate git-quiltimport.sh to use git-rev-parse --parseopt
 + Migrate git-checkout.sh to use git-rev-parse --parseopt --keep-
   dashdash
 + Migrate git-instaweb.sh to use git-rev-parse --parseopt
 + Migrate git-merge.sh to use git-rev-parse --parseopt
 + Migrate git-am.sh to use git-rev-parse --parseopt
 + Migrate git-clone to use git-rev-parse --parseopt
 + Migrate git-clean.sh to use git-rev-parse --parseopt.
 + Update git-sh-setup(1) to allow transparent use of git-rev-parse -
   -parseopt
 + Add a parseopt mode to git-rev-parse to bring parse-options to
   shell scripts.

We are still finding breakages and applying fixes.

* rs/pretty (Wed Nov 7 00:17:14 2007 +0100) 1 commit
 - pretty=3Dformat: Avoid some expensive calculations when not needed

The numbers are impressive and the code is reasonably clean, but
Ren=C3=A9 seems to have further improvements to the API?

* sb/clean (Sun Nov 4 13:02:21 2007 -0600) 1 commit
 - Make git-clean a builtin

I ran out of time to look at the replacement patch.  Sorry.

* ss/dirty-rebase (Thu Nov 1 22:30:24 2007 +0100) 3 commits
 - Make git-svn rebase --dirty pass along --dirty to git-rebase.
 - Implement --dirty for git-rebase--interactive.
 - Introduce --dirty option to git-rebase, allowing you to start from
   a dirty state.

Really need to look at this series to merge to 'next'.  Sorry.

* sp/push-refspec (Sun Oct 28 18:46:20 2007 +0100) 5 commits
 - push: teach push to pass --verbose option to transport layer
 - push: use same rules as git-rev-parse to resolve refspecs
 - add ref_abbrev_matches_full_with_rev_parse_rules() comparing
   abbrev with full ref name
 - rename ref_matches_abbrev() to
   ref_abbrev_matches_full_with_fetch_rules()
 - push: support pushing HEAD to real branch name

Really need to look at this series to merge to 'next'.  Sorry.

----------------------------------------------------------------
[Stalled]

* bs/maint-commit-options (Mon Nov 5 20:36:33 2007 +0100) 1 commit
 - git-commit.sh: Fix usage checks regarding paths given when they do
   not make sense

This is waiting for tests.  Then merge to 'next', 'master' and
then to 'maint'.

* nd/maint-work-tree-fix (Sat Nov 3 20:18:06 2007 +0700) 1 commit
 + Add missing inside_work_tree setting in setup_git_directory_gently

This is waiting for tests.  Then merge to 'next', 'master' and
then to 'maint'.

* rr/cvsexportcommit-w (Wed Oct 31 23:12:20 2007 +0100) 1 commit
 + cvsexportcommit: Add switch to specify CVS workdir

Need success stories, but pushing it out to 'master' may be the
only way to get users' attention.

* jc/spht (Fri Nov 2 17:46:55 2007 -0700) 3 commits
 + core.whitespace: add test for diff whitespace error highlighting
 + git-diff: complain about >=3D8 consecutive spaces in initial indent
 + War on whitespace: first, a bit of retreat.

Remaining tasks are:

 1. teach "git-apply --whitespace=3D[warn|strip]" the same;
 2. (possibly) use gitattributes instead of config.

* dz/color-addi (Mon Oct 22 16:08:01 2007 -0500) 2 commits
 - Let git-add--interactive read colors from .gitconfig
 - Added basic color support to git add --interactive

There was a RFH to avoid "require Term::ANSIColor" in Git.pm and
a suggestion in response to it, but I do not recall
anything happened afterwards.  Stalled.

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

This does not have a in-tree user yet.

* kh/commit (Fri Nov 2 11:33:09 2007 -0400) 3 commits
 - Implement git commit and status as a builtin commands.
 - Export launch_editor() and make it accept ':' as a no-op editor.
 - Add testcase for ammending and fixing author in git commit.

This does not pass tests.

* sp/fetch-fix (Tue Nov 6 21:41:18 2007 -0500) 2 commits
 - git-fetch: avoid local fetching from alternate (again)
 - run-command: allow discarding the standard error output

This does not pass tests (breaks shallow clone deepening).

* jk/rename (Tue Oct 30 00:24:42 2007 -0400) 3 commits
 - handle renames using similarity engine
 - introduce generic similarity library
 - change hash table calling conventions

This does not pass tests.

* jc/maint-format-patch-encoding (Fri Nov 2 17:55:31 2007 -0700) 2 comm=
its
 - test format-patch -s: make sure MIME content type is shown as
   needed
 - format-patch -s: add MIME encoding header if signer's name
   requires so

This is already in 'master' but rebased for 'maint', just in
case we would want a maint release with this series.

* jc/branch-contains (Wed Nov 7 14:58:09 2007 -0800) 1 commit
 - git-branch --with=3Dcommit

This was just for fun.

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 - pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 - ls-tree.c: refactor show_recursive() and rename it.
 - tree-diff.c: split out a function to match a single pattern.

My pet peeve.  Completely stalled.

* jc/nu (Sun Oct 14 22:07:34 2007 -0700) 3 commits
 - merge-nu: a new merge backend without using unpack_trees()
 - read_tree: take an explicit index structure
 - gcc 4.2.1 -Werror -Wall -ansi -pedantic -std=3Dc99: minimum fix

Seriously stalled.
