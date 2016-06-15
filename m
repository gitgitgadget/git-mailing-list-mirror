From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2012, #07; Wed, 21)
Date: Wed, 21 Nov 2012 14:18:26 -0800
Message-ID: <7vwqxezjkd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 19:37:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbbe4-0002vK-DR
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 19:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab2KVSew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 13:34:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859Ab2KVSer (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:34:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C857591BB;
	Wed, 21 Nov 2012 17:18:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	KXUsJGsEGhpHbDqoh3NGIlwkn8=; b=nyHv+GEk5PHzf8LavRZ29/8ZRK5CdUg3s
	vamKKGFPtOc9jEhC+pyy7maC9NZOy5xik5u29OJWyNBgA6ui4P9dA8WugJtQOHfW
	YsGkq5baxLsQITVKzmHmZSMBpjHck9QO32Z20+rue+sX9VZh8aBPybbc7dzuL5t1
	p2/cArlWw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ufA
	bU2Fl5vBYw9auP+oRSSkju5IY0Z9IKaj2ayLQ54A3tlwkG24yc7CxMg1yxuoNPI9
	MKjAfUoudgN/OtiYVhhDScnK4I2tMRpsf2y75IekvIbCYUo1g8QNvpB4wfqYNdAY
	QCqsR/5i/WSEUn8PPWC2PEK1/UBuPkYTBZQ3MK7Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B587091BA;
	Wed, 21 Nov 2012 17:18:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C35191B8; Wed, 21 Nov 2012
 17:18:28 -0500 (EST)
X-master-at: 2d242fb3fc19fc9ba046accdd9210be8b9913f64
X-next-at: ce6fbe5b9dc5e1e8ce1499bd8f7fb982e0c68289
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FF21CFA-3429-11E2-BB3A-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210181>

What's cooking in git.git (Nov 2012, #07; Wed, 21)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Many topics have been merged to 'maint' in preparation for 1.8.0.1;
and some more dormant topics have been moved to the stalled category
(to be discarded without prejudice unless they see some activities).
The upcoming 1.8.1 release is slowly taking shape.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* nd/maint-compat-fnmatch-fix (2012-11-20) 1 commit
  (merged to 'next' on 2012-11-21 at ce6fbe5)
 + compat/fnmatch: fix off-by-one character class's length check

 Will merge to 'master' and then 'maint'.

--------------------------------------------------
[Graduated to "master"]

* cn/config-missing-path (2012-11-15) 1 commit
  (merged to 'next' on 2012-11-18 at c08b73c)
 + config: don't segfault when given --path with a missing value


* jk/checkout-out-of-unborn (2012-11-15) 1 commit
  (merged to 'next' on 2012-11-18 at 7d2aa24)
 + checkout: print a message when switching unborn branches


* jk/config-ignore-duplicates (2012-10-29) 9 commits
  (merged to 'next' on 2012-10-29 at 67fa0a2)
 + builtin/config.c: Fix a sparse warning
  (merged to 'next' on 2012-10-25 at 233df08)
 + git-config: use git_config_with_options
 + git-config: do not complain about duplicate entries
 + git-config: collect values instead of immediately printing
 + git-config: fix regexp memory leaks on error conditions
 + git-config: remove memory leak of key regexp
 + t1300: test "git config --get-all" more thoroughly
 + t1300: remove redundant test
 + t1300: style updates

 Drop duplicate detection from git-config; this lets it better match
 the internal config callbacks, which clears up some corner cases
 with includes.  This is an API breakage, though.


* jk/maint-gitweb-xss (2012-11-12) 1 commit
  (merged to 'next' on 2012-11-14 at 7a667bc)
 + gitweb: escape html in rss title

 Fixes an XSS vulnerability in gitweb.


* jk/maint-http-half-auth-fetch (2012-10-31) 2 commits
  (merged to 'next' on 2012-11-09 at af69926)
 + remote-curl: retry failed requests for auth even with gzip
 + remote-curl: hoist gzip buffer size to top of post_rpc

 Fixes fetch from servers that ask for auth only during the actual
 packing phase. This is not really a recommended configuration, but it
 cleans up the code at the same time.


* jl/submodule-rm (2012-11-14) 1 commit
  (merged to 'next' on 2012-11-18 at bf4525d)
 + docs: move submodule section

 Documentation correction for d21240f (Merge branch
 'jl/submodule-rm', 2012-10-29) that needs to be fast-tracked.


* kb/preload-index-more (2012-11-02) 1 commit
  (merged to 'next' on 2012-11-09 at a750ebd)
 + update-index/diff-index: use core.preloadindex to improve performance

 Use preloadindex in more places, which has a nice speedup on systems
 with slow stat calls (and even on Linux).


* mg/replace-resolve-delete (2012-11-13) 1 commit
  (merged to 'next' on 2012-11-14 at fa785ae)
 + replace: parse revision argument for -d

 Be more user friendly to people using "git replace -d".


* mh/alt-odb-string-list-cleanup (2012-11-08) 2 commits
  (merged to 'next' on 2012-11-13 at 2bf41d9)
 + link_alt_odb_entries(): take (char *, len) rather than two pointers
 + link_alt_odb_entries(): use string_list_split_in_place()

 Cleanups in the alternates code. Fixes a potential bug and makes the
 code much cleaner.


* ml/cygwin-mingw-headers (2012-11-18) 2 commits
  (merged to 'next' on 2012-11-19 at f9964da)
 + USE CGYWIN_V15_WIN32API as macro to select api for cygwin
  (merged to 'next' on 2012-11-15 at 22e11b3)
 + Update cygwin.c for new mingw-64 win32 api headers

 Make git work on newer cygwin.


* pw/maint-p4-rcs-expansion-newline (2012-11-08) 1 commit
  (merged to 'next' on 2012-11-13 at e90cc7c)
 + git p4: RCS expansion should not span newlines

 I do not have p4 to play with, but looks obviously correct to me.


* rh/maint-gitweb-highlight-ext (2012-11-08) 1 commit
  (merged to 'next' on 2012-11-13 at c57d856)
 + gitweb.perl: fix %highlight_ext mappings

 Fixes a clever misuse of perl's list interpretation.


* so/prompt-command (2012-10-17) 4 commits
  (merged to 'next' on 2012-10-25 at 79565a1)
 + coloured git-prompt: paint detached HEAD marker in red
 + Fix up colored git-prompt
 + show color hints based on state of the git tree
 + Allow __git_ps1 to be used in PROMPT_COMMAND

 Updates __git_ps1 so that it can be used as $PROMPT_COMMAND,
 instead of being used for command substitution in $PS1, to embed
 color escape sequences in its output.

 Will merge to 'master' in the seventh batch.


* ta/doc-cleanup (2012-10-25) 6 commits
  (merged to 'next' on 2012-11-13 at e11fafd)
 + Documentation: build html for all files in technical and howto
 + Documentation/howto: convert plain text files to asciidoc
 + Documentation/technical: convert plain text files to asciidoc
 + Change headline of technical/send-pack-pipeline.txt to not confuse its content with content from git-send-pack.txt
 + Shorten two over-long lines in git-bisect-lk2009.txt by abbreviating some sha1
 + Split over-long synopsis in git-fetch-pack.txt into several lines

--------------------------------------------------
[Stalled]

* pf/editor-ignore-sigint (2012-11-11) 5 commits
 - launch_editor: propagate SIGINT from editor to git
 - run-command: do not warn about child death by SIGINT
 - run-command: drop silent_exec_failure arg from wait_or_whine
 - launch_editor: ignore SIGINT while the editor has control
 - launch_editor: refactor to use start/finish_command

 Avoid confusing cases where the user hits Ctrl-C while in the editor
 session, not realizing git will receive the signal. Since most editors
 will take over the terminal and will block SIGINT, this is not likely
 to confuse anyone.

 Some people raised issues with emacsclient, which are addressed by this
 re-roll. It should probably also handle SIGQUIT, and there were a
 handful of other review comments.

 Expecting a re-roll.


* mo/cvs-server-updates (2012-10-16) 10 commits
 - cvsserver Documentation: new cvs ... -r support
 - cvsserver: add t9402 to test branch and tag refs
 - cvsserver: support -r and sticky tags for most operations
 - cvsserver: Add version awareness to argsfromdir
 - cvsserver: generalize getmeta() to recognize commit refs
 - cvsserver: implement req_Sticky and related utilities
 - cvsserver: add misc commit lookup, file meta data, and file listing functions
 - cvsserver: define a tag name character escape mechanism
 - cvsserver: cleanup extra slashes in filename arguments
 - cvsserver: factor out git-log parsing logic

 Needs review by folks interested in cvsserver.


* jn/warn-on-inaccessible-loosen (2012-10-14) 4 commits
 - config: exit on error accessing any config file
 - doc: advertise GIT_CONFIG_NOSYSTEM
 - config: treat user and xdg config permission problems as errors
 - config, gitignore: failure to access with ENOTDIR is ok

 An RFC to deal with a situation where .config/git is a file and we
 notice .config/git/config is not readable due to ENOTDIR, not
 ENOENT; I think a bit more refactored approach to consistently
 address permission errors across config, exclude and attrs is
 desirable.  Don't we also need a check for an opposite situation
 where we open .config/git/config or .gitattributes for reading but
 they turn out to be directories?


* as/check-ignore (2012-11-08) 14 commits
 - t0007: fix tests on Windows
 - Documentation/check-ignore: we show the deciding match, not the first
 - Add git-check-ignore sub-command
 - dir.c: provide free_directory() for reclaiming dir_struct memory
 - pathspec.c: move reusable code from builtin/add.c
 - dir.c: refactor treat_gitlinks()
 - dir.c: keep track of where patterns came from
 - dir.c: refactor is_path_excluded()
 - dir.c: refactor is_excluded()
 - dir.c: refactor is_excluded_from_list()
 - dir.c: rename excluded() to is_excluded()
 - dir.c: rename excluded_from_list() to is_excluded_from_list()
 - dir.c: rename path_excluded() to is_path_excluded()
 - dir.c: rename cryptic 'which' variable to more consistent name

 Duy helped to reroll this.

 Expecting a re-roll.


* aw/rebase-am-failure-detection (2012-10-11) 1 commit
 - rebase: Handle cases where format-patch fails

 I am unhappy a bit about the possible performance implications of
 having to store the output in a temporary file only for a rare case
 of format-patch aborting.


* jk/lua-hackery (2012-10-07) 6 commits
 - pretty: fix up one-off format_commit_message calls
 - Minimum compilation fixup
 - Makefile: make "lua" a bit more configurable
 - add a "lua" pretty format
 - add basic lua infrastructure
 - pretty: make some commit-parsing helpers more public

 Interesting exercise. When we do this for real, we probably would want
 to wrap a commit to make it more like an "object" with methods like
 "parents", etc.


* fc/remote-testgit-feature-done (2012-10-29) 1 commit
 - remote-testgit: properly check for errors

 Is this still in "Needs review" state?  Are people involved in the
 remote interface happy with this change?


* jk/send-email-sender-prompt (2012-11-15) 8 commits
 - send-email: do not prompt for explicit repo ident
 - Git.pm: teach "ident" to query explicitness
 - var: provide explicit/implicit ident information
 - var: accept multiple variables on the command line
 - ident: keep separate "explicit" flags for author and committer
 - ident: make user_ident_explicitly_given static
 - t7502: factor out autoident prerequisite
 - test-lib: allow negation of prerequisites

 Avoid annoying sender prompt in git-send-email, but only when it is
 safe to do so.

 Perhaps keep only the first three patches, and replace the rest
 with the one from Felipe that takes a much simpler approach (the
 rationale of that patch needs to be cleaned up first, along the
 lines Jeff outlined, though).  Frozen until that happens.


* nd/unify-appending-of-s-o-b (2012-11-15) 1 commit
 - Unify appending signoff in format-patch, commit and sequencer

 I am not sure if the logic to refrain from adding a sign-off based
 on the existing run of sign-offs is done correctly in this change.


* nd/pretty-placeholder-with-color-option (2012-09-30) 9 commits
 . pretty: support %>> that steal trailing spaces
 . pretty: support truncating in %>, %< and %><
 . pretty: support padding placeholders, %< %> and %><
 . pretty: two phase conversion for non utf-8 commits
 . utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
 . utf8.c: move display_mode_esc_sequence_len() for use by other functions
 . pretty: support %C(auto[,N]) to turn on coloring on next placeholder(s)
 . pretty: split parsing %C into a separate function
 . pretty: share code between format_decoration and show_decorations

 This causes warnings with -Wuninitialized, so I've ejected it from pu
 for the time being.


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
  (merged to 'next' on 2012-10-29 at af52cef)
 + Teach git-completion about git p4

 Comment from Pete will need to be addressed in a follow-up patch.


* as/test-tweaks (2012-09-20) 7 commits
 - tests: paint unexpectedly fixed known breakages in bold red
 - tests: test the test framework more thoroughly
 - [SQUASH] t/t0000-basic.sh: quoting of TEST_DIRECTORY is screwed up
 - tests: refactor mechanics of testing in a sub test-lib
 - tests: paint skipped tests in bold blue
 - tests: test number comes first in 'not ok $count - $message'
 - tests: paint known breakages in bold yellow

 Various minor tweaks to the test framework to paint its output
 lines in colors that match what they mean better.

 Has the "is this really blue?" issue Peff raised resolved???


* jc/maint-name-rev (2012-09-17) 7 commits
 - describe --contains: use "name-rev --algorithm=weight"
 - name-rev --algorithm=weight: tests and documentation
 - name-rev --algorithm=weight: cache the computed weight in notes
 - name-rev --algorithm=weight: trivial optimization
 - name-rev: --algorithm option
 - name_rev: clarify the logic to assign a new tip-name to a commit
 - name-rev: lose unnecessary typedef

 "git name-rev" names the given revision based on a ref that can be
 reached in the smallest number of steps from the rev, but that is
 not useful when the caller wants to know which tag is the oldest one
 that contains the rev.  This teaches a new mode to the command that
 uses the oldest ref among those which contain the rev.

 I am not sure if this is worth it; for one thing, even with the help
 from notes-cache, it seems to make the "describe --contains" even
 slower. Also the command will be unusably slow for a user who does
 not have a write access (hence unable to create or update the
 notes-cache).

 Stalled mostly due to lack of responses.


* jc/xprm-generation (2012-09-14) 1 commit
 - test-generation: compute generation numbers and clock skews

 A toy to analyze how bad the clock skews are in histories of real
 world projects.

 Stalled mostly due to lack of responses.


* jc/blame-no-follow (2012-09-21) 2 commits
 - blame: pay attention to --no-follow
 - diff: accept --no-follow option

 Teaches "--no-follow" option to "git blame" to disable its
 whole-file rename detection.

 Stalled mostly due to lack of responses.


* jc/doc-default-format (2012-10-07) 2 commits
 - [SQAUSH] allow "cd Doc* && make DEFAULT_DOC_TARGET=..."
 - Allow generating a non-default set of documentation

 Need to address the installation half if this is to be any useful.


* mk/maint-graph-infinity-loop (2012-09-25) 1 commit
 - graph.c: infinite loop in git whatchanged --graph -m

 The --graph code fell into infinite loop when asked to do what the
 code did not expect ;-)

 Anybody who worked on "--graph" wants to comment?
 Stalled mostly due to lack of responses.


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 Waiting for comments.


* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

 When the user does not specify what remote to interact with, we
 often attempt to use 'origin'.  This can now be customized via a
 configuration variable.

 Expecting a re-roll.

 "The first remote becomes the default" bit is better done as a
 separate step.


* mh/ceiling (2012-10-29) 8 commits
 - string_list_longest_prefix(): remove function
 - setup_git_directory_gently_1(): resolve symlinks in ceiling paths
 - longest_ancestor_length(): require prefix list entries to be normalized
 - longest_ancestor_length(): take a string_list argument for prefixes
 - longest_ancestor_length(): use string_list_split()
 - Introduce new function real_path_if_valid()
 - real_path_internal(): add comment explaining use of cwd
 - Introduce new static function real_path_internal()

 Elements of GIT_CEILING_DIRECTORIES list may not match the real
 pathname we obtain from getcwd(), leading the GIT_DIR discovery
 logic to escape the ceilings the user thought to have specified.

--------------------------------------------------
[Cooking]

* fc/fast-export-fixes (2012-11-21) 19 commits
 - fast-export: don't handle uninteresting refs
 - fast-export: make sure updated refs get updated
 - fast-export: fix comparison in tests
 - fast-export: trivial cleanup
 - remote-testgit: advertise "done" feature and write "done" ourselves
 - fixup! remote-testgit: report success after an import
 - remote-testgit: report success after an import
 - fixup! remote-testgit: exercise non-default refspec feature
 - remote-testgit: exercise non-default refspec feature
 - remote-testgit: cleanup tests
 - remote-testgit: remove irrelevant test
 - remote-testgit: remove non-local tests
 - fixup! Add git-remote-testgit
 - Add git-remote-testgit
 - Rename git-remote-testgit to git-remote-testpy
 - remote-helpers: fix failure message
 - remote-testgit: fix direction of marks
 - fixup! fast-export: avoid importing blob marks
 - fast-export: avoid importing blob marks

 Replaced with the last re-roll posted to the list, queued with
 various fixup! commits to record suggested changes (most are
 trivial style fixes).


* pp/gitweb-config-underscore (2012-11-21) 1 commit
 - gitweb: make remote_heads config setting work

 The key "gitweb.remote_heads" is not legal git config; this maps it to
 "gitweb.remoteheads".


* jc/apply-trailing-blank-removal (2012-10-12) 1 commit
 - apply.c:update_pre_post_images(): the preimage can be truncated

 Fix to update_pre_post_images() that did not take into account the
 possibility that whitespace fix could shrink the preimage and
 change the number of lines in it.

 Will merge to 'next'.


* nd/pathspec-wildcard (2012-11-19) 4 commits
 - tree_entry_interesting: do basedir compare on wildcard patterns when possible
 - pathspec: apply "*.c" optimization from exclude
 - pathspec: do exact comparison on the leading non-wildcard part
 - pathspec: save the non-wildcard length part


* sg/complete-help-undup (2012-11-14) 1 commit
  (merged to 'next' on 2012-11-18 at eadd0f3)
 + completion: remove 'help' duplicate from porcelain commands

 Will merge to 'master' in the seventh batch.


* bc/do-not-recurse-in-die (2012-11-15) 1 commit
  (merged to 'next' on 2012-11-18 at 79d62a8)
 + usage.c: detect recursion in die routines and bail out immediately

 Will merge to 'master' in the seventh batch.


* mk/complete-tcsh (2012-11-16) 1 commit
  (merged to 'next' on 2012-11-19 at 8309029)
 + tcsh-completion re-using git-completion.bash

 Will merge to 'master' in the seventh batch.


* mm/status-push-pull-advise (2012-11-16) 1 commit
 - status: add advice on how to push/pull to tracking branch

 Will merge to 'next'.


* lt/diff-stat-show-0-lines (2012-10-17) 1 commit
  (merged to 'next' on 2012-11-19 at 0037290)
 + Fix "git diff --stat" for interesting - but empty - file changes

 We failed to mention a file without any content change but whose
 permission bit was modified, or (worse yet) a new file without any
 content in the "git diff --stat" output.

 Will merge to 'master' in the seventh batch.


* fc/zsh-completion (2012-11-19) 2 commits
 - completion: start moving to the new zsh completion
 - completion: add new zsh completion

 Replaced by shedding large changes to other independent topics.
 Any comments from zsh users?


* nd/wildmatch (2012-11-20) 14 commits
  (merged to 'next' on 2012-11-21 at 151288f)
 + test-wildmatch: avoid Windows path mangling
  (merged to 'next' on 2012-10-25 at 510e8df)
 + Support "**" wildcard in .gitignore and .gitattributes
 + wildmatch: make /**/ match zero or more directories
 + wildmatch: adjust "**" behavior
 + wildmatch: fix case-insensitive matching
 + wildmatch: remove static variable force_lower_case
 + wildmatch: make wildmatch's return value compatible with fnmatch
 + t3070: disable unreliable fnmatch tests
 + Integrate wildmatch to git
 + wildmatch: follow Git's coding convention
 + wildmatch: remove unnecessary functions
 + Import wildmatch from rsync
 + ctype: support iscntrl, ispunct, isxdigit and isprint
 + ctype: make sane_ctype[] const array

 Allows pathname patterns in .gitignore and .gitattributes files
 with double-asterisks "foo/**/bar" to match any number of directory
 hierarchies.

 I suspect that this needs to be plugged to pathspec matching code;
 otherwise "git log -- 'Docum*/**/*.txt'" would not show the log for
 commits that touch Documentation/git.txt, which would be confusing
 to the users.

 Will cook in 'next'.


* jh/update-ref-d-through-symref (2012-10-21) 2 commits
  (merged to 'next' on 2012-11-19 at 6bcca4c)
 + Fix failure to delete a packed ref through a symref
 + t1400-update-ref: Add test verifying bug with symrefs in delete_ref()

 "update-ref -d --deref SYM" to delete a ref through a symbolic ref
 that points to it did not remove it correctly.

 Will merge to 'master' in the seventh batch.


* fc/completion-test-simplification (2012-11-16) 6 commits
 - completion: simplify __gitcomp() test helper
 - completion: refactor __gitcomp related tests
 - completion: consolidate test_completion*() tests
 - completion: simplify tests using test_completion_long()
 - completion: standardize final space marker in tests
 - completion: add comment for test_completion()

 Clean up completion tests.  Use of conslidated helper may make
 instrumenting one particular test during debugging of the test
 itself, but I think that issue should be addressed in some other
 way (e.g. making sure individual tests in 9902 can be skipped).


* jk/pickaxe-textconv (2012-10-28) 2 commits
 - pickaxe: use textconv for -S counting
 - pickaxe: hoist empty needle check

 Use textconv filters when searching with "log -S".

 Will merge to 'next'.


* fc/remote-bzr (2012-11-08) 5 commits
  (merged to 'next' on 2012-11-18 at 86add07)
 + remote-bzr: update working tree
 + remote-bzr: add support for remote repositories
 + remote-bzr: add support for pushing
 + remote-bzr: add simple tests
 + Add new remote-bzr transport helper

 New remote helper for bzr.

 Will merge to 'master' in the seventh batch.


* fc/remote-hg (2012-11-12) 20 commits
  (merged to 'next' on 2012-11-18 at 4a4f2e4)
 + remote-hg: avoid bad refs
 + remote-hg: try the 'tip' if no checkout present
 + remote-hg: fix compatibility with older versions of hg
 + remote-hg: add missing config for basic tests
 + remote-hg: the author email can be null
 + remote-hg: add option to not track branches
 + remote-hg: add extra author test
 + remote-hg: add tests to compare with hg-git
 + remote-hg: add bidirectional tests
 + test-lib: avoid full path to store test results
 + remote-hg: add basic tests
 + remote-hg: fake bookmark when there's none
 + remote-hg: add compat for hg-git author fixes
 + remote-hg: add support for hg-git compat mode
 + remote-hg: match hg merge behavior
 + remote-hg: make sure the encoding is correct
 + remote-hg: add support to push URLs
 + remote-hg: add support for remote pushing
 + remote-hg: add support for pushing
 + Add new remote-hg transport helper

 New remote helper for hg.

 Will merge to 'master' in the seventh batch.


* cr/push-force-tag-update (2012-11-19) 5 commits
 - push: update remote tags only with force
 - push: flag updates that require force
 - push: keep track of "update" state separately
 - push: add advice for rejected tag reference
 - push: return reject reasons via a mask

 Require "-f" for push to update a tag, even if it is a fast-forward.


* rr/submodule-diff-config (2012-11-18) 4 commits
  (merged to 'next' on 2012-11-19 at 355319e)
 + submodule: display summary header in bold
 + diff: rename "set" variable
 + diff: introduce diff.submodule configuration variable
 + Documentation: move diff.wordRegex from config.txt to diff-config.txt

 Lets "git diff --submodule=log" become the default via configuration.

 Will merge to 'master' in the seventh batch.
