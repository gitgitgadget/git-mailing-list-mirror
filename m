From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 05 Mar 2008 21:49:09 -0800
Message-ID: <7vk5kgieqy.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
 <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
 <7v8x1fymei.fsf@gitster.siamese.dyndns.org>
 <7vpruljunl.fsf@gitster.siamese.dyndns.org>
 <7v1w6xoqnm.fsf@gitster.siamese.dyndns.org>
 <7vy792yzd6.fsf@gitster.siamese.dyndns.org>
 <7vmypglfwm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 06:50:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX8zR-0002Y2-J3
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 06:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbYCFFtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 00:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755003AbYCFFtY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 00:49:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbYCFFtW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 00:49:22 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4852D3226;
	Thu,  6 Mar 2008 00:49:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 685BC3225; Thu,  6 Mar 2008 00:49:18 -0500 (EST)
In-Reply-To: <7vmypglfwm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 02 Mar 2008 18:06:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76338>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

----------------------------------------------------------------
[New Topics]

Most of these are for 1.5.5 but parked in 'next' or 'pu' for now.

* ml/submodule-add-existing (Tue Mar 4 20:15:02 2008 -0500) 1 commit
 + git-submodule - Allow adding a submodule in-place

* jc/describe-always (Sun Mar 2 08:51:57 2008 -0800) 1 commit
 + describe --always: fall back to showing an abbreviated object name

* aw/maint-shortlog-blank-lines (Wed Mar 5 14:24:10 2008 +0000) 1 commit
 + shortlog: take the first populated line of the description

* ar/sgid-bsd (Wed Mar 5 00:15:39 2008 +0100) 1 commit
 + Do not use GUID on dir in git init --shared=all on FreeBSD

* jn/gitweb-pickaxe (Wed Mar 5 09:31:55 2008 +0100) 1 commit
 + gitweb: Fix and simplify pickaxe search

* cr/reset-parseopt (Tue Mar 4 23:11:34 2008 +0100) 1 commit
 + Make builtin-reset.c use parse_options.

* mr/compat-snprintf (Wed Mar 5 16:46:13 2008 +0100) 1 commit
 + Add compat/snprintf.c for systems that return bogus

* jc/am (Tue Mar 4 00:25:06 2008 -0800) 3 commits
 + am: --rebasing
 + am: remove support for -d .dotest
 + am: read from the right mailbox when started from a subdirectory

* cc/run-command (Wed Mar 5 08:35:16 2008 +0100) 1 commit
 + run-command: Redirect stderr to a pipe before redirecting stdout
   to stderr

* jc/unpack-careful (Mon Feb 25 22:46:13 2008 +0100) 4 commits
 + receive-pack: allow using --strict mode for unpacking objects
 + unpack-objects: fix --strict handling
 + t5300: add test for "unpack-objects --strict"
 + unpack-objects: prevent writing of inconsistent objects

This would re-instate the "unpack-objects --strict" but we probably should
not do this before 1.5.5.

* py/submodule (Mon Mar 3 02:15:10 2008 +0800) 4 commits
 - git-submodule summary: documentation
 - git-submodule summary: limit summary size
 - git-submodule summary: show commit summary
 - git-submodule summary: code framework

----------------------------------------------------------------
[Actively Cooking]

* cb/mergetool (Thu Feb 21 23:31:56 2008 +0000) 4 commits
 + Add a very basic test script for git mergetool
 + Teach git mergetool to use custom commands defined at config time
 + Changed an internal variable of mergetool to support custom
   commands
 + Tidy up git mergetool's backup file behaviour

The series looked Ok, and Ted seems to be busy, so I queued them myself.
Hopefully nobody would see breakages and we can have this in 1.5.5.

* dc/format-pretty (Sun Mar 2 17:05:53 2008 +0800) 3 commits
 + log/show/whatchanged: introduce format.pretty configuration
 + specify explicit "--pretty=medium" with `git log/show/whatchanged`
 + whatchanged documentation: share description of --pretty with
   others

Slated for 1.5.5.

* js/remote (Tue Mar 4 11:23:53 2008 +0000) 7 commits
 + remote: fix "update [group...]"
 + remote show: Clean up connection correctly if object fetch wasn't
   done
 + builtin-remote: prune remotes correctly that were added with --
   mirror
 + Make git-remote a builtin
 + Test "git remote show" and "git remote prune"
 + parseopt: add flag to stop on first non option
 + path-list: add functions to work with unsorted lists

Slated for 1.5.5.

* sp/fetch-optim (Mon Mar 3 22:27:40 2008 -0500) 11 commits
 + Teach git-fetch to exploit server side automatic tag following
 + Teach fetch-pack/upload-pack about --include-tag
 + git-pack-objects: Automatically pack annotated tags if object was
   packed
 + Teach git-fetch to grab a tag at the same time as a commit
 + Make git-fetch follow tags we already have objects for sooner
 + Teach upload-pack to log the received need lines to an fd
 + Free the path_lists used to find non-local tags in git-fetch
 + Allow builtin-fetch's find_non_local_tags to append onto a list
 + Ensure tail pointer gets setup correctly when we fetch HEAD only
 + Remove unnecessary delaying of free_refs(ref_map) in builtin-fetch
 + Remove unused variable in builtin-fetch find_non_local_tags

Slated for 1.5.5.

* js/reflog-delete (Sun Mar 2 14:58:51 2008 -0600) 13 commits
 + t3903-stash.sh: Add tests for new stash commands drop and pop
 + git-reflog.txt: Document new commands --updateref and --rewrite
 + t3903-stash.sh: Add missing '&&' to body of testcase
 + Merge commit '74359821' into js/reflog-delete
 + git-stash: add new 'pop' subcommand
 + git-stash: add new 'drop' subcommand
 + git-reflog: add option --updateref to write the last reflog sha1
   into the ref
 + refs.c: make close_ref() and commit_ref() non-static
 + git-reflog: add option --rewrite to update reflog entries while
   expiring
 + reflog-delete: parse standard reflog options
 + Merge branch 'bc/reflog-fix' into js/reflog-delete
 + builtin-reflog.c: fix typo that accesses an unset variable
 + Teach "git reflog" a subcommand to delete single entries

Slated for 1.5.5.

----------------------------------------------------------------
[On Hold]

* nd/worktree (Sun Mar 2 17:35:43 2008 +0700) 10 commits
 - Additional tests to capture worktree special cases
 - Documentation: update api-builtin and api-setup
 - Make setup_git_directory() auto-setup worktree if found
 - builtin-archive: mark unused prefix "unused_prefix"
 - Completely move out worktree setup from
   setup_git_directory_gently()
 - http-push: Avoid calling setup_git_directory() twice
 - Make setup_work_tree() return new prefix
 - Make get_git_dir() and 'git rev-parse --git-dir' absolute path
 - Make sure setup_git_directory is called before accessing
   repository
 - "git read-tree -m" and the like require worktree

Every time we touch work-tree stuff we seem to unstabilize; this round
seems more solid but I am still treading cautiously.  Not sure if we want
this for 1.5.5.

* ph/parseopt (Sun Mar 2 11:35:56 2008 +0100) 2 commits
 + parse-options: new option type to treat an option-like parameter
   as an argument.
 + parse-opt: bring PARSE_OPT_HIDDEN and NONEG to git-rev-parse --
   parseopt

* jc/test (Thu Feb 21 21:17:54 2008 -0800) 2 commits
 - tests: convert "cmp" and "cmp -s" to test_cmp
 - tests: test_cmp helper function

* jc/rename (Tue Jan 29 20:54:56 2008 -0800) 1 commit
 + Optimize rename detection for a huge diff

* jc/dirstat (Tue Feb 12 17:06:58 2008 -0800) 1 commit
 - diff: make --dirstat binary-file safe

* lh/git-file (Wed Feb 20 23:13:16 2008 +0100) 4 commits
 - Teach GIT-VERSION-GEN about the .git file
 - Teach git-submodule.sh about the .git file
 - Teach resolve_gitlink_ref() about the .git file
 - Add platform-independent .git "symlink"

The idea and the implementation seem Ok, but this leaves
distinct feeling that it is a solution still waiting for a user
(e.g. "git submodule" enhancements to take advantage of this
facility to preserve the subrepository while switching between a
revision with a submodule and another before the submodule was
bound to the superproject).

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.  I am not sure if we should merge this to
'next' before 1.5.5.  Most active people will be on 'next' and
if we have this there, the resulting 1.5.5 release might end up
having issues that come from differences this one introduces.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/sha1-lookup (Sun Dec 30 03:13:27 2007 -0800) 2 commits
 - sha1-lookup: make selection of 'middle' less aggressive
 - sha1-lookup: more memory efficient search in sorted list of SHA-1

Micro-optimization whose real world benefit is not proven.

* jc/cherry-pick (Wed Feb 20 23:17:06 2008 -0800) 5 commits
 - WIP: rethink replay merge
 - Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive
 + expose a helper function peel_to_type().
 + merge-recursive: split low-level merge functions out.
