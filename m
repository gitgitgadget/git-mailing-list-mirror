From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2010, #06; Wed, 24)
Date: Wed, 24 Mar 2010 17:41:16 -0700
Message-ID: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Carl Worth <cworth@cworth.org>, Jay Soffian <jaysoffian@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Steven Drake <sdrake@xnet.co.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 01:41:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nub8p-0006f5-OQ
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 01:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab0CYAlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 20:41:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0CYAle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 20:41:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ADC00A4401;
	Wed, 24 Mar 2010 20:41:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:cc:date:message-id:mime-version:content-type; s=sasl; bh=s
	bl1JDVlEzl7dOqu/iLWv01EV4U=; b=GUGgeoVgjAqUviWVYz7PmotyY2AZ/gTv2
	NuNBz1vrd+MrviMk+097dYnaUZoBb5YHlNemJyLr+7u2CxZejXKDNLkWauOeOVG4
	78BB/zFi3k0FoDK/Bu8i5Vq+cVaDDMCK4cL67GOILcpIxaT+7rUaOJlYUNo2GR6n
	WNfqPf+gmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	Sw3hIyXDR7N3EJI6FIfOXovbtymG+5R3v8qZ9MjQed/fstAblTTc6fNnYlDcbLwk
	fMviDGZchZ/k8vkqB07Mup/6nf6Qo98tVTL48Js0eWySAk6jtZKkWLYk4cMPbyXi
	RNKeohzw9lRFT1VFjq3q94Kq9x4p96bWHOkoDTxMUtU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6104A43FC;
	Wed, 24 Mar 2010 20:41:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 311D4A43FA; Wed, 24 Mar
 2010 20:41:19 -0400 (EDT)
X-master-at: 5e4f61474202122f376b16181b760f390623bf4e
X-next-at: 82eebc138fb5ed99525fe1c2d3062e9256495a05
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 24A55864-37A7-11DF-87CD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143138>

What's cooking in git.git (Mar 2010, #06; Wed, 24)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

The tip of 'pu' is broken right now; it does not pass t7006.

--------------------------------------------------
[Graduated to "master"]

* jh/maint-submodule-status-in-void (2010-03-09) 2 commits
  (merged to 'next' on 2010-03-15 at 49af9de)
 + git submodule summary: Handle HEAD as argument when on an unborn branch
  (merged to 'next' on 2010-03-08 at 0697bf4)
 + submodule summary: do not fail before the first commit

* jc/maint-refs-dangling (2010-03-15) 1 commit
  (merged to 'next' on 2010-03-16 at 376027b)
 + refs: ref entry with NULL sha1 is can be a dangling symref

* pb/log-first-parent-p-m (2010-03-09) 5 commits
  (merged to 'next' on 2010-03-15 at 0ae494e)
 + show --first-parent/-m: do not default to --cc
 + show -c: show patch text
 + revision: introduce setup_revision_opt
 + t4013: add tests for log -p -m --first-parent
  (merged to 'next' on 2010-02-17 at 2f8e5ae)
 + git log -p -m: document -m and honor --first-parent

Ready for 'master'.

* jl/submodule-diff-dirtiness (2010-03-13) 5 commits
  (merged to 'next' on 2010-03-15 at 9601fd9)
 + git status: ignoring untracked files must apply to submodules too
  (merged to 'next' on 2010-03-13 at f9bfd8a)
 + git status: Fix false positive "new commits" output for dirty submodules
 + Refactor dirty submodule detection in diff-lib.c
  (merged to 'next' on 2010-03-08 at 33f7a57)
 + git status: Show detailed dirty status of submodules in long format
  (merged to 'next' on 2010-03-04 at 58b2645)
 + git diff --submodule: Show detailed dirty status of submodules

Ready for 'master'.

* tr/notes-display (2010-03-12) 13 commits
  (merged to 'next' on 2010-03-15 at 3329361)
 + git-notes(1): add a section about the meaning of history
 + notes: track whether notes_trees were changed at all
 + notes: add shorthand --ref to override GIT_NOTES_REF
 + commit --amend: copy notes to the new commit
 + rebase: support automatic notes copying
 + notes: implement helpers needed for note copying during rewrite
 + notes: implement 'git notes copy --stdin'
 + rebase -i: invoke post-rewrite hook
 + rebase: invoke post-rewrite hook
 + commit --amend: invoke post-rewrite hook
 + Documentation: document post-rewrite hook
 + Support showing notes from more than one notes tree
 + test-lib: unset GIT_NOTES_REF to stop it from influencing tests
 (this branch is used by sb/notes-parse-opt.)

--------------------------------------------------
[New Topics]

* bw/git-completion-rpmspec (2010-03-20) 1 commit
 - Add a git-completion rpm subpackage to the spec

Shipping bash-completion as part of RPM package; since Todd Zullinger who
packages git for Fedora joined the thread, I am hoping that I can defer
the direction of the final version to the discussion between Todd and Ben.

* ef/maint-empty-commit-log (2010-03-21) 1 commit
 - rev-list: fix --pretty=oneline with empty message

Looked reasonable.  Soon in 'next'.

* em/checkout-orphan (2010-03-21) 1 commit
 - git checkout: create unparented branch by --orphan

Looked reasonable, except that we might want to come up with a way to
allow people with core.logallrefupdates set to false to still override it
with "-l" when switching to this new branch.  Or we may not care.  I dunno.

Soon in 'next'.

* mg/mailmap-update (2010-03-19) 1 commit
 - .mailmap: Entries for Alex Benn$BC)(Be, Deskin Miller, Vitaly "_Vi" Shukela

Soon in 'next'.

* mg/maint-send-email-lazy-editor (2010-03-22) 1 commit
 - [reword?] send-email: lazily assign editor variable

* mg/use-default-abbrev-length-in-rev-list (2010-03-22) 1 commit
 - rev-list: use default abbrev length when abbrev-commit is in effect

* np/malloc-threading (2010-03-24) 1 commit
 - Make xmalloc and xrealloc thread-safe

* rb/maint-python-path (2010-03-21) 1 commit
 - Correct references to /usr/bin/python which does not exist on FreeBSD

Soon in 'next'.

* rr/imap-send-unconfuse-from-line (2010-03-22) 1 commit
 - imap-send: Remove limitation on message body

Soon in 'next'.

* sp/maint-http-backend-die-triggers-die-recursively (2010-03-22) 1 commit
 - http-backend: Don't infinite loop during die()

Soon in 'next'.

--------------------------------------------------
[Stalled]

* cw/test-lib-relicense (2010-02-22) 1 commit
 . test-lib.sh: Add explicit license detail, with change from GPLv2 to GPLv2+.

Ack-collection stopped at the last three names.  I am hoping Carl can take
it from there without my keeping an eye on it.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* sg/bash-completion (2010-02-23) 4 commits
  (merged to 'next' on 2010-03-08 at bc59860)
 + bash: completion for gitk aliases
 + bash: support user-supplied completion scripts for aliases
 + bash: support user-supplied completion scripts for user's git commands
 + bash: improve aliased command recognition

Perhaps rename _git_frotz -> _git_complete_frotz?  I dunno.

* sd/log-decorate (2010-02-17) 3 commits
  (merged to 'next' on 2010-03-08 at 58a6fba)
 + log.decorate: usability fixes
 + Add `log.decorate' configuration variable.
 + git_config_maybe_bool()

Needs squelching the configuration setting when "--pretty=raw" is given,
at least, or possibly when any "--pretty" is explicitly given.

--------------------------------------------------
[Cooking]

* ar/config-from-command-line (2010-03-19) 1 commit
 - Allow passing of configuration parameters in the command line

* bc/t5505-fix (2010-03-19) 3 commits
 - t/t5505-remote.sh: escape * to prevent interpretation by shell as glob
 - t5505: add missing &&
 - t5505: remove unnecessary subshell invocations

Looked reasonable.  Soon in 'next'.

* bw/template-tool-buildconfig (2010-03-20) 2 commits
 - Modernize git calling conventions in hook templates
 - Make templates honour SHELL_PATH and PERL_PATH

Looked reasonable.  Soon in 'next'.

* mb/rebase-i-no-ff (2010-03-24) 1 commit
 - Teach rebase the --no-ff option.

Looked reasonable.  Soon in 'next'.

* jn/merge-diff3-label (2010-03-20) 14 commits
  (merged to 'next' on 2010-03-20 at 26f1805)
 + merge-recursive: add a label for ancestor
 + cherry-pick, revert: add a label for ancestor
 + revert: clarify label on conflict hunks
 + compat: add mempcpy()
 + checkout -m --conflict=diff3: add a label for ancestor
 + merge_trees(): add ancestor label parameter for diff3-style output
 + merge_file(): add comment explaining behavior wrt conflict style
 + checkout --conflict=diff3: add a label for ancestor
 + ll_merge(): add ancestor label parameter for diff3-style output
 + merge-file --diff3: add a label for ancestor
 + xdl_merge(): move file1 and file2 labels to xmparam structure
 + xdl_merge(): add optional ancestor label to diff3-style output
 + tests: document cherry-pick behavior in face of conflicts
 + tests: document format of conflicts from checkout -m

* do/rebase-i-arbitrary (2010-03-14) 1 commit
 - rebase--interactive: don't require what's rebased to be a branch

Looked reasonable.  Soon in 'next'.

* ja/send-email-ehlo (2010-03-14) 3 commits
 - git-send-email.perl - try to give real name of the calling host to HELO/EHLO
 - git-send-email.perl: add option --smtp-debug
 - git-send-email.perl: improve error message in send_message()

Looked reasonable.  Soon in 'next'.

* ak/everyday-git (2009-10-21) 1 commit
 - everyday: fsck and gc are not everyday operations

Looked reasonable.  Soon in 'next'.

* bc/acl-test (2010-03-15) 5 commits
 - t/t1304: make a second colon optional in the mask ACL check
 - t/t1304: set the ACL effective rights mask
 - t/t1304: use 'test -r' to test readability rather than looking at mode bits
 - t/t1304: set the Default ACL base entries
 - t/t1304: avoid -d option to setfacl

Looked reasonable.  Soon in 'next'.

* bc/maint-daemon-sans-ss-family (2010-03-15) 1 commit
 - daemon.c: avoid accessing ss_family member of struct sockaddr_storage

Looked reasonable.  Soon in 'next'.

* ef/cherry-abbrev (2010-03-20) 2 commits
 - ls: remove redundant logic
 - cherry: support --abbrev option

Looked reasonable.  Soon in 'next'.

* gh/maint-stash-show-error-message (2010-03-16) 1 commit
 - Improve error messages from 'git stash show'

Looked reasonable.  Soon in 'next'.

* rs/threaded-grep-context (2010-03-15) 1 commit
 - grep: enable threading for context line printing

Looked reasonable.  Soon in 'next'.

* cc/cherry-pick-ff (2010-03-20) 7 commits
  (merged to 'next' on 2010-03-20 at a1ae16b)
 + revert: fix tiny memory leak in cherry-pick --ff
 + rebase -i: use new --ff cherry-pick option
  (merged to 'next' on 2010-03-07 at 5589b26)
 + Documentation: describe new cherry-pick --ff option
 + cherry-pick: add tests for new --ff option
 + revert: add --ff option to allow fast forward when cherry-picking
 + builtin/merge: make checkout_fast_forward() non static
 + parse-options: add parse_options_concat() to concat options

Ready for 'master'.

* js/async-thread (2010-03-09) 7 commits
 - Enable threaded async procedures whenever pthreads is available
  (merged to 'next' on 2010-03-20 at 9939243)
 + Dying in an async procedure should only exit the thread, not the process.
 + Reimplement async procedures using pthreads
 + Windows: more pthreads functions
 + Fix signature of fcntl() compatibility dummy
 + Make report() from usage.c public as vreportf() and use it.
 + Modernize t5530-upload-pack-error.

The tip one will be soon in 'next', but one step at a time.

* nd/setup (2010-03-21) 40 commits
 - Guard unallowed access to repository when it's not set up
 - alias: keep repository found while collecting aliases as long as possible
 - Allow to undo setup_git_directory_gently() gracefully (and fix alias code)
 - builtins: check for startup_info->help, print and exit early
 - builtins: utilize startup_info->help where possible
 - run_builtin(): save "-h" detection result for later use
 - config: do not read .git/config if there is no repository
 - apply: do not check sha1 when repository has not been found
 - Do not read .git/info/attributes if there is no repository
 - Do not read .git/info/exclude if there is no repository
 - git_config(): do not read .git/config if there is no repository
 - init/clone: turn on startup->have_repository properly
 - worktree setup: restore original state when things go wrong
 - Use git_config_early() instead of git_config() during repo setup
 - Add git_config_early()
 - worktree setup: call set_git_dir explicitly
 - rev-parse --git-dir: print relative gitdir correctly
 - enter_repo(): initialize other variables as setup_git_directory_gently() does
 - Move enter_repo() to setup.c
 - index-pack: use RUN_SETUP_GENTLY
 - index-pack: trust the prefix returned by setup_git_directory_gently()
 - worktree setup: calculate prefix even if no worktree is found
 - merge-file: use RUN_SETUP_GENTLY
 - var: use RUN_SETUP_GENTLY
 - ls-remote: use RUN_SETUP_GENTLY
 - help: use RUN_SETUP_GENTLY
 - diff: use RUN_SETUP_GENTLY
 - bundle: use RUN_SETUP_GENTLY
 - apply: use RUN_SETUP_GENTLY
 - verify-pack: use RUN_SETUP_GENTLY
 - check-ref-format: use RUN_SETUP_GENTLY
 - mailinfo: use RUN_SETUP_GENTLY
 - archive: use RUN_SETUP_GENTLY
 - builtin: USE_PAGER should not be used without RUN_SETUP*
 - grep: use RUN_SETUP_GENTLY
 - shortlog: use RUN_SETUP_GENTLY
 - hash-object: use RUN_SETUP_GENTLY
 - config: use RUN_SETUP_GENTLY
 - builtin: Support RUN_SETUP_GENTLY to set up repository early if found
 - builtin: introduce startup_info struct

This seems to break t7006 when merged to 'pu'.

* sb/notes-parse-opt (2010-02-27) 1 commit
  (merged to 'next' on 2010-03-24 at 82eebc1)
 + notes: rework subcommands and parse options
