From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 27 Feb 2008 16:45:01 -0800
Message-ID: <7v1w6xoqnm.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
 <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
 <7v8x1fymei.fsf@gitster.siamese.dyndns.org>
 <7vpruljunl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 01:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWuF-0007Vm-TA
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758453AbYB1ApP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 19:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758221AbYB1ApO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:45:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495AbYB1ApN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 19:45:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B0EB268E;
	Wed, 27 Feb 2008 19:45:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DDA00268A; Wed, 27 Feb 2008 19:45:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75335>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

----------------------------------------------------------------
[New Topics]

* js/maint-daemon (Tue Feb 26 13:00:55 2008 +0100) 2 commits
 + daemon: ensure that base-path is an existing directory
 + daemon: send more error messages to the syslog

* ew/maint-svn-cert-fileprovider (Mon Feb 25 15:56:28 2008 +0100) 1 commit
 + git-svn: Don't prompt for client cert password everytime.

* sb/describe-long (Mon Feb 25 10:43:33 2008 +0100) 1 commit
 + git-describe: --long shows the object name even for a tagged
   commit

* mk/maint-parse-careful (Mon Feb 25 22:46:13 2008 +0100) 10 commits
 - receive-pack: use strict mode for unpacking objects
 - index-pack: introduce checking mode
 - unpack-objects: prevent writing of inconsistent objects
 - unpack-object: cache for non written objects
 - add common fsck error printing function
 - builtin-fsck: move common object checking code to fsck.c
 - builtin-fsck: reports missing parent commits
 - Remove unused object-ref code
 - builtin-fsck: move away from object-refs to fsck_walk
 - add generic, type aware object chain walker

* jn/gitweb-grep (Tue Feb 26 13:22:08 2008 +0100) 3 commits
 + gitweb: Clearly distinguish regexp / exact match searches
 + gitweb: Simplify fixed string search
 + gitweb: Change parse_commits signature to allow for multiple
   options

* jc/remote-multi-url (Wed Feb 27 13:50:44 2008 -0800) 1 commit
 + git-remote: do not complain on multiple URLs for a remote

* cb/http-test (Wed Feb 27 20:28:45 2008 +0100) 2 commits
 - http-push: add regression tests
 - http-push: push <remote> :<branch> deletes remote branch

* mh/maint-http-proxy-fix (Wed Feb 27 21:35:50 2008 +0100) 1 commit
 - Set proxy override with http_init()

----------------------------------------------------------------
[Graduated to "master"]

* ae/pack-autothread (Fri Feb 22 20:12:58 2008 -0600)

Adds runtime detection of online CPU's

* sp/describe (Sun Feb 24 03:07:33 2008 -0500)

A new --exact-match option describes only tagged commits

* bc/reflog-fix (Fri Feb 22 12:47:08 2008 -0600)

* db/host-alias (Sun Feb 24 22:25:04 2008 -0800)

Allows URLs used in pushing and fetching to be rewritten.

* db/push-single-with-HEAD (Wed Feb 20 12:54:05 2008 -0500)

Kills two birds with a commit by (1) fixing "git push $there +HEAD"
to force the single push, and (2) allowing you to set
"remote.$there.push = HEAD" so that "git push $there" will push
only the current branch.

* db/checkout (Sat Feb 23 15:45:19 2008 -0800)

Checkout rewritten in C.

* gp/hash-stdin (Thu Feb 21 10:06:47 2008 +0000)

* jc/diff-relative (Wed Feb 13 00:34:39 2008 -0800) 2 commits

"diff --relative" outputs paths as relative to the current
subdirectory.

* js/run-command (Thu Feb 21 23:42:56 2008 +0100) 2 commits

API clean-ups.

* jk/help-alias (Sun Feb 24 17:17:37 2008 -0500) 3 commits

Shows aliases in "git help"

* cw/bisect (Sat Feb 23 17:14:17 2008 -0800) 1 commit

Fixes "won't bisect on seeked tree".

* js/branch-track (Tue Feb 19 11:24:38 2008 -0500) 2 commits

This allows you to automatically set up tracking even when forking
from a local branch; it builds on top of Daniel's "checkout in C".

* js/merge (Sun Feb 17 19:07:40 2008 +0000) 2 commits

This makes conflicting merges that have hunks separated by only
a few common lines much easier to read.

* db/cover-letter (Sat Feb 23 09:41:56 2008 +0100) 9 commits

Teaches format-patch to optionally generate cover letters.

* jm/free (Thu Jan 31 18:26:32 2008 +0100)

Drops unnecessary "if-before-free" tests.

----------------------------------------------------------------
[Actively Cooking]

* js/reflog-delete (Fri Feb 22 16:52:50 2008 -0600) 9 commits
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

I think this needs tests for both high-level ("stash drop" and
"stash pop") and low-level ("reflog delete --rewrite" and
"reflog delete --updateref"), but otherwise the series looks in
a very good shape.

----------------------------------------------------------------
[On Hold]

* jc/test (Thu Feb 21 21:17:54 2008 -0800) 2 commits
 - tests: convert "cmp" and "cmp -s" to test_cmp
 - tests: test_cmp helper function

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

* jc/rename (Tue Jan 29 20:54:56 2008 -0800) 1 commit
 + Optimize rename detection for a huge diff

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
