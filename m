From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2012, #02; Mon, 9)
Date: Mon, 09 Jul 2012 13:13:23 -0700
Message-ID: <7vhatgk80s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 22:13:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoKKt-0003AN-LI
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 22:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868Ab2GIUN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 16:13:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab2GIUN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 16:13:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C67788C8;
	Mon,  9 Jul 2012 16:13:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=J
	37opkkfDrOtzQ8yZQAiPSzir/U=; b=VrLZDjCZm/xe3SkNmqLe3upvulP/ULEnI
	Wr3Nbn//gZzO0+yzYxMYwIOPGoaSigJHjU1HCEvavtM24PuTjNnfMJrXLEBbEQVZ
	S7AZMb+d3O6ZfYOuPunXFF6LOhrXYBENUvdE/WuRAuRwdbP/m3oc/8rWv1rF81E/
	+0mHjCMwKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Pa9
	xCyTctPKsPpGhaRSqdUN6viozk1S/GE7FKM+V3vUtg79p9f2CJoqlyHe+LYrZkN5
	HtGfzpdrIwrD7fvcPL8PIsqy22IzfJl14NfgQAinZwAmZIBI2gUFxQd1MwhFiJBd
	rApVGwhyQJF/2ZtI0IMEOHCvXc+BlwqZrKNBgZIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4210788C7;
	Mon,  9 Jul 2012 16:13:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4183188C3; Mon,  9 Jul 2012
 16:13:25 -0400 (EDT)
X-master-at: 299666cc5c792dbc3b67622fcc03d41ff95f4346
X-next-at: 61b12c254ff58ac7c57a6e1ab2aa50b1ada84e72
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A0EE996-CA02-11E1-B2CC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201223>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The fourth and fifth batches of topics have graduated to 'master'.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jl/submodule-rm (2012-07-05) 2 commits
 - rm: remove submodules from the index and the .gitmodules file
 - rm: don't fail when removing populated submodules

* mh/maint-revisions-doc (2012-07-05) 2 commits
 - Document rev^! and rev^@ as revision specifiers
 - Make <refname> documentation more consistent.

The tip one is a bit suspicious.

* nk/maint-gitweb-log-by-lines (2012-07-05) 3 commits
 - gitweb: Add support to Link: tag
 - gitweb: Handle other types of tag in git_print_log
 - gitweb: Cleanup git_print_log()

Is the use of esc_html() in the tip one correct?

* pw/git-p4-jobs (2012-07-05) 3 commits
 - git p4: notice Jobs lines in git commit messages
 - git p4 test: refactor marshal_dump
 - git p4: remove unused P4Submit interactive setting

Will merge to 'next'.

* pw/git-p4-move (2012-07-05) 2 commits
 - git p4: add support for 'p4 move' in P4Submit
 - git p4: refactor diffOpts calculation

Will be rerolled.

* ar/clone-honor-umask-at-top (2012-07-08) 1 commit
 - Restore umasks influence on the permissions of work tree created by clone

May want to rephrase the log message a bit.

Will merge to 'next'.

* jn/vcs-svn (2012-07-05) 12 commits
  (merged to 'next' on 2012-07-09 at 1d97a8f)
 + vcs-svn: allow 64-bit Prop-Content-Length
 + vcs-svn: suppress a signed/unsigned comparison warning
 + vcs-svn: suppress a signed/unsigned comparison warning
 + vcs-svn: suppress signed/unsigned comparison warnings
 + vcs-svn: use strstr instead of memmem
 + vcs-svn: use constcmp instead of prefixcmp
 + vcs-svn: simplify cleanup in apply_one_window
 + vcs-svn: avoid self-assignment in dummy initialization of pre_off
 + vcs-svn: drop no-op reset methods
 + vcs-svn: suppress -Wtype-limits warning
 + vcs-svn: allow import of > 4GiB files
 + vcs-svn: rename check_overflow and its arguments for clarity

Reroll of db/vcs-svn.

Will merge to 'master'.

* mm/mediawiki-tests (2012-07-06) 12 commits
  (merged to 'next' on 2012-07-09 at 4d874e8)
 + git-remote-mediawiki: be more defensive when requests fail
 + git-remote-mediawiki: more efficient 'pull' in the best case
 + git-remote-mediawiki: extract revision-importing loop to a function
 + git-remote-mediawiki: refactor loop over revision ids
 + git-remote-mediawiki: change return type of get_mw_pages
 + git-remote-mediawiki (t9363): test 'File:' import and export
 + git-remote-mediawiki: support for uploading file in test environment
 + git-remote-mediawiki (t9362): test git-remote-mediawiki with UTF8 characters
 + git-remote-mediawiki (t9361): test git-remote-mediawiki pull and push
 + git-remote-mediawiki (t9360): test git-remote-mediawiki clone
 + git-remote-mediawiki: test environment of git-remote-mediawiki
 + git-remote-mediawiki: scripts to install, delete and clear a MediaWiki
 (this branch uses mm/mediawiki-file-attachments.)

Will merge to 'master'.

* ph/stash-rerere (2012-07-08) 2 commits
 - stash: invoke rerere in case of conflict
 - test: git-stash conflict sets up rerere

Will be rerolled but is going in the right direction.

* tg/ce-namelen (2012-07-08) 1 commit
 - Replace strlen() with ce_namelen()

Trivially correct clean-up and micro optimization.

* jn/makefile-cleanup (2012-07-09) 14 commits
 - Makefile: document ground rules for target-specific dependencies
 - Makefile: move GIT-VERSION-FILE dependencies closer to use
 - Makefile: build instaweb similar to other scripts
 - Makefile: update scripts when build-time parameters change
 - Makefile: do not replace @@GIT_VERSION@@ in shell scripts
 - Makefile: split prefix flags from GIT-CFLAGS
 - Makefile: be silent when only GIT_USER_AGENT changes
 - Makefile: split GIT_USER_AGENT from GIT-CFLAGS
 - Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
 - Makefile: apply dependencies consistently to sparse/asm targets
 - Makefile: do not have git.o depend on common-cmds.h
 - Makefile: fold XDIFF_H and VCSSVN_H into LIB_H
 - Makefile: fold MISC_H into LIB_H
 - Makefile: sort LIB_H list
 (this branch is tangled with jk/version-string-dependency.)

Tweaks and replaces jk/version-string-dependency.

Will merge to 'next'.

* cw/amend-commit-without-message (2012-07-09) 1 commit
 - Allow edit of empty message with commit --amend

"commit --amend" used to refuse amending a commit with an empty log
message, with or without "--allow-empty-message".

Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* cw/help-over-network (2012-06-28) 2 commits
  (merged to 'next' on 2012-07-03 at 99e8d28)
 + Allow help.htmlpath to be a URL prefix
 + Add config variable to set HTML path for git-help --web

"git help -w $cmd" can show HTML version of documentation for
"git-$cmd" by setting help.htmlpath to somewhere other than the
default location where the build procedure installs them locally;
the variable can even point at a http:// URL.

* cw/no-detaching-an-unborn (2012-06-26) 1 commit
  (merged to 'next' on 2012-07-03 at 552c5ca)
 + git-checkout: disallow --detach on unborn branch

"git checkout --detach", when you are still on an unborn branch,
should be forbidden, but it wasn't.

* hv/remote-end-hung-up (2012-06-19) 1 commit
  (merged to 'next' on 2012-06-25 at d3f29e2)
 + remove the impression of unexpectedness when access is denied

When we get disconnected while expecting a response from the remote
side because authentication failed, we issued an error message "The
remote side hung up unexpectedly."  Give hint that it may be a
permission problem in the message when we can reasonably suspect it.

* jc/maint-blame-unique-abbrev (2012-07-02) 1 commit
  (merged to 'next' on 2012-07-03 at c7ed6b9)
 + blame: compute abbreviation width that ensures uniqueness

"git blame" did not try to make sure the abbreviated commit object
names in its output are unique.

* jn/perl-makemaker-leading-paths (2012-06-29) 2 commits
  (merged to 'next' on 2012-06-29 at 0f17059)
 + perl/Makefile: Fix a missing double-quote
  (merged to 'next' on 2012-06-28 at 286d854)
 + perl/Makefile: move "mkdir -p" to module installation loop for maintainability

Minor build tweak.  People who do not use ExtUtils::MakeMaker may
want to test this before it hits the 'master' branch.

* js/fast-export-paths-with-spaces (2012-06-27) 1 commit
  (merged to 'next' on 2012-07-03 at f9c23e9)
 + fast-export: quote paths with spaces

"git fast-export" produced an input stream for fast-import without
properly quoting pathnames when they contain SPs in them.

* mm/config-xdg (2012-06-25) 4 commits
  (merged to 'next' on 2012-06-28 at 57049d1)
 + config: write to $XDG_CONFIG_HOME/git/config file when appropriate
 + Let core.attributesfile default to $XDG_CONFIG_HOME/git/attributes
 + Let core.excludesfile default to $XDG_CONFIG_HOME/git/ignore
 + config: read (but not write) from $XDG_CONFIG_HOME/git/config file

Teach git to read various information from $XDG_CONFIG_HOME/git/ to allow
the user to avoid cluttering $HOME.

* mm/credential-plumbing (2012-07-08) 4 commits
  (merged to 'next' on 2012-07-08 at fce8ea2)
 + git-remote-mediawiki: update comments to reflect credential support
  (merged to 'next' on 2012-06-28 at 6e6fe9f)
 + git-remote-mediawiki: add credential support
 + git credential fill: output the whole 'struct credential'
 + add 'git credential' plumbing command
 (this branch is tangled with mm/mediawiki-file-attachments and mm/mediawiki-tests.)

Expose the credential API to scripted Porcelain writers.

* mz/empty-rebase-test (2012-06-27) 1 commit
  (merged to 'next' on 2012-07-03 at 1e7de3f)
 + add test case for rebase of empty commit

We did not have test to make sure "git rebase" without extra options
filters out an empty commit in the original history.

* nd/clone-single-fix (2012-06-22) 1 commit
  (merged to 'next' on 2012-06-26 at c9fff5e)
 + clone: fix ref selection in --single-branch --branch=xxx

"git clone --single-branch" to clone a single branch did not limit
the cloning to the specified branch.

* pw/git-p4-tests (2012-06-27) 10 commits
  (merged to 'next' on 2012-07-03 at 9bd9cda)
 + git p4 test: fix badp4dir test
 + git p4 test: split up big t9800 test
 + git p4 test: cleanup_git should make a new $git
 + git p4 test: copy source indeterminate
 + git p4 test: check for error message in failed test
 + git p4 test: rename some "git-p4 command" strings
 + git p4 test: never create default test repo
 + git p4 test: simplify quoting involving TRASH_DIRECTORY
 + git p4 test: use real_path to resolve p4 client symlinks
 + git p4 test: wait longer for p4d to start and test its pid
 (this branch is used by pw/git-p4-jobs and pw/git-p4-move.)

More "git p4" tests.

* rj/platform-pread-may-be-thread-unsafe (2012-06-26) 1 commit
  (merged to 'next' on 2012-06-28 at ce5f79f)
 + index-pack: Disable threading on cygwin

On Cygwin, the platform pread(3) is not thread safe, just like our
own compat/ emulation, and cannot be used in the index-pack program.

* th/diff-no-index-fixes (2012-06-22) 2 commits
  (merged to 'next' on 2012-06-26 at 450e781)
 + diff-no-index: exit(1) if 'diff --quiet <repo file> <external file>' finds changes
 + diff: handle relative paths in no-index

"git diff --no-index" did not correctly handle relative paths and
did not correctly give exit codes when run under "--quiet" option.

* vr/use-our-perl-in-tests (2012-06-24) 4 commits
  (merged to 'next' on 2012-07-03 at 90dfcf0)
 + t/README: add a bit more Don'ts
 + tests: enclose $PERL_PATH in double quotes
 + t/test-lib.sh: export PERL_PATH for use in scripts
 + t: Replace 'perl' by $PERL_PATH
 (this branch is used by jc/test-lib-source-build-options-early.)

Some implementations of Perl terminates "lines" with CRLF even when
the script is operating on just a sequence of bytes.  Make sure to
use "$PERL_PATH", the version of Perl the user told Git to use, in
our tests to avoid unnecessary breakages in tests.

--------------------------------------------------
[Stalled]

* jc/apply-3way (2012-06-13) 19 commits
 - apply --3way: tests
 - apply: document --3way option
 - apply: allow rerere() upon --3way results
 - apply: register conflicted stages to the index
 - apply: --3way with add/add conflict
 - apply: move verify_index_match() higher
 - apply: plug the three-way merge logic in
 - apply: fall back on three-way merge
 - apply: accept -3/--3way command line option
 - apply: move "already exists" logic to check_to_create()
 - apply: move check_to_create_blob() closer to its sole caller
 - apply: further split load_preimage()
 - apply: refactor "previous patch" logic
 - apply: split load_preimage() helper function out
 - apply: factor out checkout_target() helper function
 - apply: refactor read_file_or_gitlink()
 - apply: clear_image() clears things a bit more
 - apply: a bit more comments on PATH_TO_BE_DELETED
 - apply: fix an incomplete comment in check_patch()

"git apply" learns to wiggle the base version and perform three-way merge
when a patch does not exactly apply to the version you have.

Will merge to 'next' after reading it over once again.

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
There still seem to be other bugs hiding (e.g. try pushing twice).

Not ready.

* jc/split-blob (2012-04-03) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* jk/push-delete-ref-error-message (2012-07-03) 1 commit
  (merged to 'next' on 2012-07-09 at 82c6bd2)
 + push: don't guess at qualifying remote refs on deletion

The error message from "git push $there :bogo" mentioned we tried
and failed to guess what ref is being deleted based on the LHS of
the refspec, which we don't.

* tb/sanitize-decomposed-utf-8-pathname (2012-07-08) 1 commit
  (merged to 'next' on 2012-07-09 at 61b12c2)
 + git on Mac OS and precomposed unicode

Teaches git to normalize pathnames read from readdir(3) and all
arguments from the command line into precomposed UTF-8 (assuming
that they come as decomposed UTF-8) to work around issues on Mac OS.

I think there still are other places that need conversion
(e.g. paths that are read from stdin for some commands), but this
should be a good first step in the right direction.

Will merge to 'master'.

* cw/rebase-i-root (2012-07-05) 3 commits
  (merged to 'next' on 2012-07-05 at aeb4c56)
 + t3404: make test 57 work with dash and others
  (merged to 'next' on 2012-07-03 at 231c0a4)
 + Add tests for rebase -i --root without --onto
 + rebase -i: support --root without --onto

"git rebase [-i] --root $tip" can now be used to rewrite all the
history down to the root.

* mm/mediawiki-file-attachments (2012-07-04) 6 commits
  (merged to 'next' on 2012-07-09 at 4b85fa2)
 + git-remote-mediawiki: improve support for non-English Wikis
  (merged to 'next' on 2012-07-03 at 90f2f45)
 + git-remote-mediawiki: import "File:" attachments
 + git-remote-mediawiki: split get_mw_pages into smaller functions
 + git-remote-mediawiki: send "File:" attachments to a remote wiki
 + git-remote-mediawiki: don't "use encoding 'utf8';"
 + git-remote-mediawiki: don't compute the diff when getting commit message
 (this branch is used by mm/mediawiki-tests.)

"mediawiki" remote helper (in contrib/) learned to handle file
attachments.

Will merge to 'master'.

* mz/rebase-no-mbox (2012-06-26) 4 commits
  (merged to 'next' on 2012-07-03 at 5bf5c12)
 + am: don't call mailinfo if $rebasing
 + am --rebasing: get patch body from commit, not from mailbox
 + rebase --root: print usage on too many args
 + rebase: don't source git-sh-setup twice

Teach "am --rebasing" codepath to grab authorship, log message and
the patch text directly out of existing commits.  This will help
rebasing commits that have confusing "diff" output in their log
messages.

Will merge to 'master'.

* jc/refactor-diff-stdin (2012-06-28) 3 commits
  (merged to 'next' on 2012-07-09 at ef407ee)
 + diff-index.c: "git diff" has no need to read blob from the standard input
 + diff-index.c: unify handling of command line paths
 + diff-index.c: do not pretend paths are pathspecs

Due to the way "git diff --no-index" is bolted onto by touching the
low level code that is shared with the rest of the "git diff" code,
even though it has to work in a very different way, any comparison
that involves a file "-" at the root level incorrectly tried to read
from the standard input.  This cleans up the no-index codepath
further to remove code that reads from the standard input from the
core side, which is never necessary when git is running its usual
diff operation.

Will merge to 'master', and later down to older maintenance releases.

* lt/commit-tree-guess-utf-8 (2012-06-28) 1 commit
 - commit/commit-tree: correct latin1 to utf-8

Teaches "git commit" and "git commit-tree" the "we are told to use
utf-8 in log message, but this does not look like utf-8---attempt to
pass it through convert-from-latin1-to-utf8 and see if it makes
sense" heuristics "git mailinfo" already uses.

A draft from Linus received privately without a log message.
Hopefully it will be rerolled.

* jc/test-lib-source-build-options-early (2012-06-24) 1 commit
 - test-lib: reorder and include GIT-BUILD-OPTIONS a lot earlier

Reorders t/test-lib.sh so that we dot-source GIT-BUILD-OPTIONS that
records the shell and Perl the user told us to use with Git a lot
early, so that test-lib.sh script itself can use "$PERL_PATH" in
one of its early operations.

Needs to be eyeballed by people who run tests with exotic options
like valgrind, --root=/dev/shm/somewhere, etc.

* jc/sha1-name-more (2012-07-04) 25 commits
 - rev-parse --disambiguate=<prefix>
 - rev-parse: A and B in "rev-parse A..B" refer to committish
 - reset: the command takes committish
 - commit-tree: the command wants a tree and commits
 - apply: --build-fake-ancestor expects blobs
 - sha1_name.c: add support for disambiguating other types
 - revision.c: the "log" family, except for "show", takes committish
 - revision.c: allow handle_revision_arg() to take other flags
 - sha1_name.c: introduce get_sha1_committish()
 - sha1_name.c: teach lookup context to get_sha1_with_context()
 - sha1_name.c: many short names can only be committish
 - sha1_name.c: get_sha1_1() takes lookup flags
 - sha1_name.c: get_describe_name() by definition groks only commits
 - sha1_name.c: teach get_short_sha1() a commit-only option
 - sha1_name.c: allow get_short_sha1() to take other flags
 - get_sha1(): fix error status regression
 - sha1_name.c: restructure disambiguation of short names
 - sha1_name.c: correct misnamed "canonical" and "res"
 - sha1_name.c: refactor find_short_packed_object()
 - sha1_name.c: rename "now" to "current"
 - sha1_name.c: clarify what "fake" is for in find_short_object_filename()
 - sha1_name.c: get rid of get_sha1_with_mode()
 - sha1_name.c: get rid of get_sha1_with_mode_1()
 - sha1_name.c: hide get_sha1_with_context_1() ugliness
 - sha1_name.c: indentation fix

Teaches the object name parser things like a "git describe" output
is always a commit object, "A" in "git log A" must be a committish,
and "A" and "B" in "git log A...B" both must be committish, etc., to
prolong the lifetime of abbreviated object names.

Will merge to 'next'.

* tr/maint-show-walk (2012-06-19) 2 commits
  (merged to 'next' on 2012-07-09 at c8e0e06)
 + show: fix "range implies walking"
 + Demonstrate git-show is broken with ranges

Fixes "git show"'s auto-walking behaviour, and make it behave just
like "git log" does when it walks.

Note that this is different from Thomas's patch.

Will merge to 'master'.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* mm/push-default-switch-warning (2012-06-24) 1 commit
  (merged to 'next' on 2012-06-26 at fea512a)
 + push: start warning upcoming default change for push.default

Will defer for another cycle.

--------------------------------------------------
[Discarded]

* nl/http-proxy-more (2012-05-11) 2 commits
 . http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 . http: Avoid limit of retrying request only twice

I queued only the later two patches from this series, even though they do
not make much sense without the first one that seems to need a bit more
work, so that we won't forget.

* jk/no-op-push-message (2012-05-30) 1 commit
 . improve no-op push output

Rewords the status message of "git push" that pushed only one ref
differently from "Everything up-to-date", to give a bit more help to
people who get the message when their current branch is not pushed.

I had an impression after the discussion thread that a redesign is
coming, but it hasn't happened yet.

* db/vcs-svn (2012-06-01) 6 commits
 . vcs-svn: drop no-op reset methods
 . vcs-svn: fix signedness warnings
 . vcs-svn: prefer strstr over memmem
 . vcs-svn: prefer constcmp to prefixcmp
 . vcs-svn: simplify cleanup in apply_one_window()
 . vcs-svn: fix clang-analyzer error

Replaced by jn/vcs-svn.

* jk/version-string-dependency (2012-06-20) 11 commits
 . Makefile: move GIT-VERSION-FILE dependencies closer to use
 . Makefile: build instaweb similar to other scripts
 . Makefile: update scripts when build-time parameters change
 . Makefile: do not replace @@GIT_VERSION@@ in shell scripts
 . Makefile: split prefix flags from GIT-CFLAGS
 . Makefile: split GIT_USER_AGENT from GIT-CFLAGS
 . Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
 . Makefile: apply dependencies consistently to sparse/asm targets
 . Makefile: do not have git.o depend on common-cmds.h
 - Makefile: fold MISC_H into LIB_H
 - Makefile: sort LIB_H list
 (this branch is tangled with jn/makefile-cleanup.)

Replaced by jn/makefile-cleanup.
