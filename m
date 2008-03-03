From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 02 Mar 2008 18:06:49 -0800
Message-ID: <7vmypglfwm.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 03:07:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW05f-0004cA-Jw
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbYCCCHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 21:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbYCCCHG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:07:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbYCCCHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 21:07:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 617142869;
	Sun,  2 Mar 2008 21:07:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 24E622867; Sun,  2 Mar 2008 21:06:57 -0500 (EST)
In-Reply-To: <7vy792yzd6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 01 Mar 2008 12:15:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75867>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

----------------------------------------------------------------
[New Topics]

* cb/mergetool (Thu Feb 21 23:31:56 2008 +0000) 4 commits
 - Add a very basic test script for git mergetool
 - Teach git mergetool to use custom commands defined at config time
 - Changed an internal variable of mergetool to support custom
   commands
 - Tidy up git mergetool's backup file behaviour

* dc/format-pretty (Sun Mar 2 17:05:53 2008 +0800) 3 commits
 - log/show/whatchanged: introduce format.pretty configuration
 - specify explicit "--pretty=medium" with `git log/show/whatchanged`
 - whatchanged documentation: share description of --pretty with
   others

* ph/parseopt (Sun Mar 2 11:35:56 2008 +0100) 2 commits
 + parse-options: new option type to treat an option-like parameter
   as an argument.
 + parse-opt: bring PARSE_OPT_HIDDEN and NONEG to git-rev-parse --
   parseopt

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

Replaced from the early ones in 'pu'.

----------------------------------------------------------------
[Graduated to "master"]

* np/verify-pack (Thu Feb 28 00:25:20 2008 -0500) 4 commits
 + add storage size output to 'git verify-pack -v'
 + fix unimplemented packed_object_info_detail() features
 + make verify_one_pack() a bit less wrong wrt packed_git structure
 + factorize revindex code out of builtin-pack-objects.c

* sp/describe-tag (Thu Feb 28 01:22:36 2008 -0500) 1 commit
 - Teach git-describe to verify annotated tag names before output

* jc/maint-log-merge-left-right (Tue Feb 26 23:18:38 2008 -0800) 1 commit
 + Fix "git log --merge --left-right"

* pb/cvsimport (Thu Feb 28 11:18:23 2008 +0100) 3 commits
 + cvsimport: document that -M can be used multiple times
 + cvsimport: allow for multiple -M options
 + cvsimport: have default merge regex allow for dashes in the branch
   name

* js/maint-daemon (Tue Feb 26 13:00:55 2008 +0100) 2 commits
 + daemon: ensure that base-path is an existing directory
 + daemon: send more error messages to the syslog

* ew/maint-svn-cert-fileprovider (Mon Feb 25 15:56:28 2008 +0100) 1 commit
 + git-svn: Don't prompt for client cert password everytime.

* sb/describe-long (Mon Feb 25 10:43:33 2008 +0100) 1 commit
 + git-describe: --long shows the object name even for a tagged
   commit

* mk/maint-parse-careful (Mon Feb 25 22:46:13 2008 +0100) 10 commits
 + receive-pack: use strict mode for unpacking objects
 + index-pack: introduce checking mode
 + unpack-objects: prevent writing of inconsistent objects
 + unpack-object: cache for non written objects
 + add common fsck error printing function
 + builtin-fsck: move common object checking code to fsck.c
 + builtin-fsck: reports missing parent commits
 + Remove unused object-ref code
 + builtin-fsck: move away from object-refs to fsck_walk
 + add generic, type aware object chain walker

* jn/gitweb-grep (Tue Feb 26 13:22:08 2008 +0100) 3 commits
 + gitweb: Clearly distinguish regexp / exact match searches
 + gitweb: Simplify fixed string search
 + gitweb: Change parse_commits signature to allow for multiple
   options

* jc/remote-multi-url (Wed Feb 27 13:50:44 2008 -0800) 1 commit
 + git-remote: do not complain on multiple URLs for a remote

* cb/http-test (Wed Feb 27 20:28:45 2008 +0100) 2 commits
 + http-push: add regression tests
 + http-push: push <remote> :<branch> deletes remote branch

* mh/maint-http-proxy-fix (Wed Feb 27 21:35:50 2008 +0100) 1 commit
 + Set proxy override with http_init()

----------------------------------------------------------------
[Actively Cooking]

* js/remote (Sun Mar 2 05:31:59 2008 +0000) 6 commits
 - remote show: Clean up connection correctly if object fetch wasn't
   done
 + builtin-remote: prune remotes correctly that were added with --
   mirror
 + Make git-remote a builtin
 + Test "git remote show" and "git remote prune"
 + parseopt: add flag to stop on first non option
 + path-list: add functions to work with unsorted lists

Slated for 1.5.5.

* sp/fetch-optim (Sat Mar 1 00:25:38 2008 -0500) 7 commits
 - Teach git-fetch to grab a tag at the same time as a commit
 - Make git-fetch follow tags we already have objects for sooner
 - Teach upload-pack to log the received need lines to fd 3
 - Allow builtin-fetch's find_non_local_tags to append onto a list
 - Ensure tail pointer gets setup correctly when we fetch HEAD only
 - Remove unnecessary delaying of free_refs(ref_map) in builtin-fetch
 - Remove unused variable in builtin-fetch find_non_local_tags

A few existing tests in 5515 need to be adjusted as they expect tags not
to be fetched early, but the point of this series is to optimize to allow
them to, under some conditions.  Otherwise slated for 1.5.5.

* js/reflog-delete (Sun Mar 2 14:58:51 2008 -0600) 13 commits
 - t3903-stash.sh: Add tests for new stash commands drop and pop
 - git-reflog.txt: Document new commands --updateref and --rewrite
 - t3903-stash.sh: Add missing '&&' to body of testcase
 - Merge commit '7435982102093179474a128648179a44042d8a1c' into
   bc/stash
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

* jc/bulk-allocate (Wed Feb 13 18:37:27 2008 -0800) 2 commits
 - Bulk allocate diff_filepair
 - patch freeable-bulk-alloc

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
