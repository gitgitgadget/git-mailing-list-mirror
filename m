From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Tue, 22 Apr 2008 03:03:49 -0700
Message-ID: <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 12:06:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoFMu-0005R0-Jm
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 12:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759192AbYDVKEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 06:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759127AbYDVKEI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 06:04:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758700AbYDVKEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 06:04:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7690922FC;
	Tue, 22 Apr 2008 06:04:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E384422FB; Tue, 22 Apr 2008 06:03:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80093>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

Note.

    Some commits on 'pu' have [comment] in front of their title, primarily
    to remind myself not to accidentally merge them to 'next' before
    issues are resolved.  They will be amended either by replacement patch
    from the author, or when the issue raised on the list gets refuted
    convincingly enough to justify the original patch (in which case only
    the comment like "[questionable???]"  will be removed without changing
    the tree of the commit).

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

* js/rebase-i-sequencer (Mon Apr 14 02:21:09 2008 +0200) 13 commits
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

----------------------------------------------------------------
[Graduated to "master"]

* mk/color (Wed Apr 9 21:32:06 2008 +0200) 1 commit
 + Use color.ui variable in scripts too

* jk/remote-default-show (Wed Apr 9 11:15:51 2008 -0400) 1 commit
 + git-remote: show all remotes with "git remote show"

* jc/terminator-separator (Mon Apr 7 17:11:34 2008 -0700) 1 commit
 + log: teach "terminator" vs "separator" mode to "--pretty=format"

* py/submodule (Sat Apr 12 23:05:33 2008 +0800) 3 commits
 + builtin-status: Add tests for submodule summary
 + builtin-status: submodule summary support
 + git-submodule summary: --for-status option

* mv/defer-gc (Wed Apr 2 21:35:11 2008 +0200) 3 commits
 + contrib/hooks: add an example pre-auto-gc hook
 + Documentation/hooks: add pre-auto-gc hook
 + git-gc --auto: add pre-auto-gc hook

A new hook to stop "git gc --auto" from running.

* jc/dirstat (Tue Feb 12 17:06:58 2008 -0800) 1 commit
 + diff: make --dirstat binary-file safe

The current "dirstat" does totally wrong thing when the set of files
changed includes a binary one.  This uses the same similarity evaluation
code as rename heuristics uses to treat text and binary the same way.

* jc/sha1-lookup (Sun Dec 30 03:13:27 2007 -0800) 2 commits
 + sha1-lookup: make selection of 'middle' less aggressive
 + sha1-lookup: more memory efficient search in sorted list of SHA-1

Micro-optimization whose real world benefit is not proven, so let's prove
it or revert it by giving it a bit more exposure.

----------------------------------------------------------------
[Actively Cooking]

* pb/remote-mirror-config (Thu Apr 17 13:17:20 2008 +0200) 1 commit
 + Add a remote.*.mirror configuration option

* ho/shared (Wed Apr 16 11:34:24 2008 +0300) 1 commit
 + Make core.sharedRepository more generic

* lh/branch-merged (Fri Apr 18 18:30:15 2008 +0200) 3 commits
 + Add tests for `branch --[no-]merged`
 + git-branch.txt: compare --contains, --merged and --no-merged
 + git-branch: add support for --merged and --no-merged

* jk/fetch-status (Wed Apr 9 20:11:52 2008 -0400) 1 commit
 + git-fetch: always show status of non-tracking-ref fetches

This changes reporting behaviour of one-shot "git pull $url $branch",
which would affect long-time users in integrator role (that's you, Linus
;-).  Let's see if we hear anybody screaming.

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

* jc/lstat (Sun Mar 30 12:39:25 2008 -0700) 2 commits
 + diff-files: mark an index entry we know is up-to-date as such
 + write_index(): optimize ce_smudge_racily_clean_entry() calls with
   CE_UPTODATE

Further reduce redundant lstat(2) calls during "git status" and other
common operations.

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

----------------------------------------------------------------
[Dropped]

* js/decorate (Mon Apr 7 14:41:12 2008 +0100) 2 commits
 . pretty=format: Add %d to show decoration
 . decorate: use "const struct object"

Per author's lack of interest

----------------------------------------------------------------
[On Hold]

* ap/svn (Tue Apr 15 21:04:18 2008 -0400) 3 commits
 - git-svn: add documentation for --add-author-from option.
 - git-svn: Add --add-author-from option.
 - git-svn: add documentation for --use-log-author option.

Eric requested a new set of tests for this series.

* py/submodule-2 (Wed Apr 16 22:19:31 2008 +0800) 1 commit
 - git-submodule: Extract functions module_info and module_url

I only managed to queue the first one so far.

It does not help motivating me reviewing the series that the overall tone
of it is to ignore .git/config more and make .gitmodules take more active
role, either.  I have already said number of times why that is not a good
idea and why it is against the overall submodule design.

* jc/test (Thu Feb 21 21:17:54 2008 -0800) 2 commits
 - tests: convert "cmp" and "cmp -s" to test_cmp
 - tests: test_cmp helper function

This one may be more elaborate, but Jeff's patch is much simpler.

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.

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
