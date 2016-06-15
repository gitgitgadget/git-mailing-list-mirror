From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sat, 26 Apr 2008 23:04:47 -0700
Message-ID: <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 08:05:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq01I-0008MX-Fn
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 08:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbYD0GFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 02:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbYD0GFG
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 02:05:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbYD0GFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 02:05:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 78A5E4D26;
	Sun, 27 Apr 2008 02:05:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 807E24D23; Sun, 27 Apr 2008 02:04:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80413>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

A rough timeline from now on.

 * Discussion and review on new feature and enhancement patch series
   begins.  Please resubmit things that you were cooking in your head
   during 1.5.5-rc period after cleaning up and retesting.

 * 1.5.6 merge window closes (2008-05-14).

 * Fixes of 'master' continues; 1.5.6-rc0 gets tagged (2008-05-21).

 * 1.5.6 Final (2008-06-08).

----------------------------------------------------------------
[New Topics]

* db/learn-HEAD (Sat Apr 26 15:53:12 2008 -0400) 2 commits
 - Make ls-remote http://... list HEAD, like for git://...
 - Make walker.fetch_ref() take a struct ref.

* cc/help (Fri Apr 25 08:25:41 2008 +0200) 5 commits
 - documentation: web--browse: add a note about konqueror
 - documentation: help: add info about "man.<tool>.cmd" config var
 - help: use "man.<tool>.cmd" as custom man viewer command
 - documentation: help: add "man.<tool>.path" config variable
 - help: use man viewer path from "man.<tool>.path" config var

* jn/webfeed (Sun Apr 20 22:09:48 2008 +0200) 1 commit
 + gitweb: Use feed link according to current view

* ar/batch-cat (Wed Apr 23 15:17:53 2008 -0400) 11 commits
 - git-svn: Speed up fetch
 - Git.pm: Add hash_and_insert_object and cat_blob
 - Git.pm: Add command_bidi_pipe and command_close_bidi_pipe
 - git-hash-object: Add --stdin-paths option
 - Add more tests for git hash-object
 - Move git-hash-object tests from t5303 to t1007
 - git-cat-file: Add --batch option
 - git-cat-file: Add --batch-check option
 - git-cat-file: Make option parsing a little more flexible
 - git-cat-file: Small refactor of cmd_cat_file
 - <<REJECT>> Add tests for git cat-file

* lt/dirmatch-optim (Sat Apr 19 14:22:38 2008 -0700) 1 commit
 + Optimize match_pathspec() to avoid fnmatch()

* dm/cherry-pick-s (Sat Apr 26 15:14:28 2008 -0500) 1 commit
 + Allow cherry-pick (and revert) to add signoff line

----------------------------------------------------------------
[Graduated to "master"]

* ho/shared (Wed Apr 16 11:34:24 2008 +0300) 1 commit
 + Make core.sharedRepository more generic

----------------------------------------------------------------
[Will merge to "master" soonish]

* pb/remote-mirror-config (Thu Apr 17 13:17:20 2008 +0200) 1 commit
 + Add a remote.*.mirror configuration option

* lh/branch-merged (Fri Apr 18 18:30:15 2008 +0200) 3 commits
 + Add tests for `branch --[no-]merged`
 + git-branch.txt: compare --contains, --merged and --no-merged
 + git-branch: add support for --merged and --no-merged

* jk/fetch-status (Wed Apr 9 20:11:52 2008 -0400) 1 commit
 + git-fetch: always show status of non-tracking-ref fetches

This changes reporting behaviour of one-shot "git pull $url $branch",
which would affect long-time users in integrator role (that's you, Linus
;-).  Let's see if we hear anybody screaming.

* lh/git-file (Wed Feb 20 23:13:16 2008 +0100) 4 commits
 + Teach GIT-VERSION-GEN about the .git file
 + Teach git-submodule.sh about the .git file
 + Teach resolve_gitlink_ref() about the .git file
 + Add platform-independent .git "symlink"

There was a GSoC project idea to enhance "git submodule" to take advantage
of this facility to preserve the subrepository while switching between a
revision with a submodule and another before the submodule was bound to
the superproject, but it appears nobody took it.

* bc/filter-branch (Wed Mar 26 10:47:09 2008 -0500) 1 commit
 + filter-branch.sh: support nearly proper tag name filtering

Instead of discarding annotated and/or signed tags, this keeps them and
demotes the signed ones to simply annotated.  It issues warning when it
does this demotion.  I think the behaviour is sensible.

* jc/lstat (Sun Mar 30 12:39:25 2008 -0700) 2 commits
 + diff-files: mark an index entry we know is up-to-date as such
 + write_index(): optimize ce_smudge_racily_clean_entry() calls with
   CE_UPTODATE

Further reduce redundant lstat(2) calls during "git status" and other
common operations.

----------------------------------------------------------------
[Actively Cooking]

* js/rebase-i-sequencer (Fri Apr 25 22:50:53 2008 -0700) 14 commits
 + rebase -i: update the implementation of 'mark' command
 + Add option --preserve-tags
 + Teach rebase interactive the tag command
 + Add option --first-parent
 + Do rebase with preserve merges with advanced TODO list
 + Select all lines with fake-editor
 + Unify the length of $SHORT* and the commits in the TODO list
 + Teach rebase interactive the merge command
 + Move redo merge code in a function
 + Teach rebase interactive the reset command
 + Teach rebase interactive the mark command
 + Move cleanup code into it's own function
 + Don't append default merge message to -m message
 + fake-editor: output TODO list if unchanged

This may complement the proposed "sequencer" GSoC project.

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 6 commits
 - merge: remove deprecated summary and diffstat options and config
   variables
 + merge, pull: add '--(no-)log' command line option
 + fmt-merge-msg: add '--(no-)log' options and 'merge.log' config
   variable
 + add 'merge.stat' config variable
 + merge, pull: introduce '--(no-)stat' option
 + doc: moved merge.* config variables into separate merge-config.txt

The last one needs to be held back, as it actually removes the support for
features that the main part of the series deprecates, until 1.6.0 or
later.

* jc/blame (Wed Apr 2 22:17:53 2008 -0700) 5 commits
 + git-blame --reverse
 + builtin-blame.c: allow more than 16 parents
 + builtin-blame.c: move prepare_final() into a separate function.
 + rev-list --children
 + revision traversal: --children option

The blame that finds where each line in the original lines moved to.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 + "git push": tellme-more protocol extension

Allows common ancestor negotiation for git-push to help people with shared
repository workflow in certain minority situations.  The lack of protocol
support has been bugging me for quite some time, and that was the reason I
did this.  There recently was a problem report that had a scent of this
issue which turned out to be a false alarm (it was about http-push which
does not do the native pack protocol optimization and the reporter was
pushing into an empty repository which needs full transfer anyway).

* lt/case-insensitive (Sat Mar 22 14:22:44 2008 -0700) 9 commits
 + Make git-add behave more sensibly in a case-insensitive
   environment
 + When adding files to the index, add support for case-independent
   matches
 + Make unpack-tree update removed files before any updated files
 + Make branch merging aware of underlying case-insensitive
   filsystems
 + Add 'core.ignorecase' option
 + Make hash_name_lookup able to do case-independent lookups
 + Make "index_name_exists()" return the cache_entry it found
 + Move name hashing functions into a file of its own
 + Make unpack_trees_options bit flags actual bitfields

The beginning of case insensitive filesystem support, currently
ASCII-only.

----------------------------------------------------------------
[Dropped]


----------------------------------------------------------------
[On Hold]

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.

* db/clone-in-c (Thu Apr 17 19:32:43 2008 -0400) 8 commits
 - [mess] Build in clone
 - [strdup() and other clean-ups needed] Provide API access to
   init_db()
 - [waiting for response] Add a function to set a non-default work
   tree
 - Allow for having for_each_ref() list extra refs
 - Have a constant extern refspec for "--tags"
 - Add a library function to add an alternate to the alternates file
 - Add a lockfile function to append to a file
 - Mark the list of refs to fetch as const

There were a few comments and suggestions to the ones near the tip that
need to be addressed.  Earlier ones look Ok.

* ap/svn (Tue Apr 15 21:04:18 2008 -0400) 3 commits
 - git-svn: add documentation for --add-author-from option.
 - git-svn: Add --add-author-from option.
 - git-svn: add documentation for --use-log-author option.

Eric requested a new set of tests for this series.

* py/submodule-2 (Wed Apr 16 22:19:31 2008 +0800) 1 commit
 - git-submodule: Extract functions module_info and module_url

Not going well.

* jc/test (Thu Feb 21 21:17:54 2008 -0800) 2 commits
 - tests: convert "cmp" and "cmp -s" to test_cmp
 - tests: test_cmp helper function

This one may be more elaborate, but Jeff's patch is much simpler.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/cherry-pick (Wed Feb 20 23:17:06 2008 -0800) 3 commits
 - WIP: rethink replay merge
 - Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive

This is meant to improve cherry-pick's behaviour by not using
merge-recursive, but unfortunately has stalled for some time now.

* jc/lstat-debug (Thu Mar 27 16:56:53 2008 -0700) 1 commit
 - lstat: introduce a wrapper xlstat

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

Just my toy at this moment.
