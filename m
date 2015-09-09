From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.6.0-rc1
Date: Tue, 08 Sep 2015 17:09:19 -0700
Message-ID: <xmqqio7k78sw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 02:09:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZSx7-00069o-9z
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 02:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbbIIAJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 20:09:26 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35099 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbbIIAJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 20:09:21 -0400
Received: by pacfv12 with SMTP id fv12so141197503pac.2;
        Tue, 08 Sep 2015 17:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=kIIdnQ/cI9UQo5xULgfRhZCkWXf3MlF5RfoWDqr3O9Q=;
        b=pdo17C/K1URiYHEU5ta8jZdk5n8muE1DmqQ4rS/PZuxvvnVoPG7oaJoGW5uuZrBOqX
         zCi/sHvjEViaT+TvCIPwOSzlCB1rZn72B7N6j+EESdprnJCgtIJOrVZf7R87nsIb4gd8
         NjAfrwd9+IgltVQPDPkLc6Cxnv/7wVjzZOTi4ARKip3FL37taFSpkTbYla5KaLUiWomJ
         r+dSvjVAWL/cruRKMJypVq+qF/PbH0TZWhqmfpk8CGcBYIA+1vlNd6xm5oQnh6VQhxTA
         oYwBZxZnVyD9DPFg5WA2ANi1aMWnHsj44mLE4RkYqm6H93C1+MkruXVuCIsxvo3Fo19q
         WwMw==
X-Received: by 10.68.249.36 with SMTP id yr4mr63492927pbc.18.1441757361129;
        Tue, 08 Sep 2015 17:09:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:31c8:2790:408d:8446])
        by smtp.gmail.com with ESMTPSA id h2sm3811573pdm.94.2015.09.08.17.09.19
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 17:09:20 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277530>

A release candidate Git v2.6.0-rc1 is now available for testing
at the usual places.  It is comprised of 409 non-merge commits
since v2.5.0, contributed by 50 people, 12 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.6.0-rc1' tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.5.0 are as follows.
Welcome to the Git development community!

  Antoine Delaite, Brett Randall, Brian Degenhardt, Erik Elfstr=C3=B6m,
  Galan R=C3=A9mi, Guillaume Pag=C3=A8s, Jan Viktorin, Jose F. Morales,
  Lars Schneider, Michael Rappazzo, Simon A. Eugster, and Zoe=CC=88
  Blade.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alex Henrie, Andreas Schwab, brian m. carlson, Charles Bailey,
  Christian Couder, Clemens Buchacher, Dave Borowitz, David
  Aguilar, David Turner, Elia Pinto, Eric Sunshine, Heiko
  Voigt, Ilya Bobyr, Jacob Keller, Jeff King, Jiang Xin, Jim
  Hill, Johannes Schindelin, Johannes Sixt, Junio C Hamano,
  Karsten Blees, Karthik Nayak, Kevin Daudt, Matthieu Moy,
  Michael Haggerty, Mike Hommey, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy,
  Patrick Steinhardt, Paul Tan, Philip Oakley, Ralf Thielow,
  Remi Lespinet, Ren=C3=A9 Scharfe, Stefan Beller, Sven Strickroth,
  SZEDER G=C3=A1bor, Thomas Ackermann, and Thomas Braun.

----------------------------------------------------------------

Git 2.6 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Updates since v2.5
------------------

UI, Workflows & Features

 * An asterisk as a substring (as opposed to the entirety) of a path
   component for both side of a refspec, e.g.
   "refs/heads/o*:refs/remotes/heads/i*", is now allowed.

 * New userdiff pattern definition for fountain screenwriting markup
   format has been added.

 * "git log" and friends learned a new "--date=3Dformat:..." option to
   format timestamps using system's strftime(3).

 * "git fast-import" learned to respond to the get-mark command via
   its cat-blob-fd interface.

 * "git rebase -i" learned "drop commit-object-name subject" command
   as another way to skip replaying of a commit.

 * A new configuration variable can enable "--follow" automatically
   when "git log" is run with one pathspec argument.

 * "git status" learned to show a more detailed information regarding
   the "rebase -i" session in progress.

 * "git cat-file" learned "--batch-all-objects" option to enumerate all
   available objects in the repository more quickly than "rev-list
   --all --objects" (the output includes unreachable objects, though).

 * "git fsck" learned to ignore errors on a set of known-to-be-bad
   objects, and also allows the warning levels of various kinds of
   non-critical breakages to be tweaked.

 * "git rebase -i"'s list of todo is made configurable.

 * "git send-email" now performs alias-expansion on names that are
   given via --cccmd, etc.

 * An environment variable GIT_REPLACE_REF_BASE tells Git to look into
   refs hierarchy other than refs/replace/ for the object replacement
   data.

 * Allow untracked cache (experimental) to be used when sparse
   checkout (experimental) is also in use.

 * "git pull --rebase" has been taught to pay attention to
   rebase.autostash configuration.

 * The command-line completion script (in contrib/) has been updated.

 * A negative !ref entry in multi-value transfer.hideRefs
   configuration can be used to say "don't hide this one".

 * After "git am" without "-3" stops, running "git am -" pays attention
   to "-3" only for the patch that caused the original invocation
   to stop.

 * When linked worktree is used, simultaneous "notes merge" instances
   for the same ref in refs/notes/* are prevented from stomping on
   each other.

 * "git send-email" learned a new option --smtp-auth to limit the SMTP
   AUTH mechanisms to be used to a subset of what the system library
   supports.

 * A new configuration variable http.sslVersion can be used to specify
   what specific version of SSL/TLS to use to make a connection.

 * "git notes merge" can be told with "--strategy=3D<how>" option how t=
o
   automatically handle conflicts; this can now be configured by
   setting notes.mergeStrategy configuration variable.

 * "git log --cc" did not show any patch, even though most of the time
   the user meant "git log --cc -p -m" to see patch output for commits
   with a single parent, and combined diff for merge commits.  The
   command is taught to DWIM "--cc" (without "--raw" and other forms
   of output specification) to "--cc -p -m".

 * "git config --list" output was hard to parse when values consist of
   multiple lines.  "--name-only" option is added to help this.


Performance, Internal Implementation, Development Support etc.

 * In preparation for allowing different "backends" to store the refs
   in a way different from the traditional "one ref per file in
   $GIT_DIR or in a $GIT_DIR/packed-refs file" filesystem storage,
   direct filesystem access to ref-like things like CHERRY_PICK_HEAD
   from scripts and programs has been reduced.

 * Computation of untracked status indicator by bash prompt
   script (in contrib/) has been optimized.

 * Memory use reduction when commit-slab facility is used to annotate
   sparsely (which is not recommended in the first place).

 * Clean up refs API and make "git clone" less intimate with the
   implementation detail.

 * "git pull" was reimplemented in C.

 * The packet tracing machinery allows to capture an incoming pack
   data to a file for debugging.

 * Move machinery to parse human-readable scaled numbers like 1k, 4M,
   and 2G as an option parameter's value from pack-objects to
   parse-options API, to make it available to other codepaths.

 * "git verify-tag" and "git verify-commit" have been taught to share
   more code, and then learned to optionally show the verification
   message from the underlying GPG implementation.

 * Various enhancements around "git am" reading patches generated by
   foreign SCM have been made.

 * Ref listing by "git branch -l" and "git tag -l" commands has
   started to be rebuilt, based on the for-each-ref machinery.

 * The code to perform multi-tree merges has been taught to repopulate
   the cache-tree upon a successful merge into the index, so that
   subsequent "diff-index --cached" (hence "status") and "write-tree"
   (hence "commit") will go faster.

   The same logic in "git checkout" may now be removed, but that is a
   separate issue.

 * Tests that assume how reflogs are represented on the filesystem too
   much have been corrected.

 * "git am" has been rewritten in "C".

 * git_path() and mkpath() are handy helper functions but it is easy
   to misuse, as the callers need to be careful to keep the number of
   active results below 4.  Their uses have been reduced.

 * The "lockfile" API has been rebuilt on top of a new "tempfile" API.

 * To prepare for allowing a different "ref" backend to be plugged in
   to the system, update_ref()/delete_ref() have been taught about
   ref-like things like MERGE_HEAD that are per-worktree (they will
   always be written to the filesystem inside $GIT_DIR).

 * The gitmodules API that is accessed from the C code learned to
   cache stuff lazily.


Also contains various documentation updates and code clean-ups.


=46ixes since v2.5
----------------

Unless otherwise noted, all the fixes since v2.5 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * "git subtree" (in contrib/) depended on "git log" output to be
   stable, which was a no-no.  Apply a workaround to force a
   particular date format.
   (merge e7aac44 da/subtree-date-confusion later to maint).

 * An attempt to delete a ref by pushing into a repository whose HEAD
   symbolic reference points at an unborn branch that cannot be
   created due to ref D/F conflict (e.g. refs/heads/a/b exists, HEAD
   points at refs/heads/a) failed.
   (merge b112b14 jx/do-not-crash-receive-pack-wo-head later to maint).

 * The low-level "git send-pack" did not honor 'user.signingkey'
   configuration variable when sending a signed-push.
   (merge d830d39 db/send-pack-user-signingkey later to maint).

 * "sparse checkout" misbehaved for a path that is excluded from the
   checkout when switching between branches that differ at the path.
   (merge 7d78241 as/sparse-checkout-removal later to maint).

 * An experimental "untracked cache" feature used uname(2) in a
   slightly unportable way.
   (merge 100e433 cb/uname-in-untracked later to maint).

 * A "rebase" replays changes of the local branch on top of something
   else, as such they are placed in stage #3 and referred to as
   "theirs", while the changes in the new base, typically a foreign
   work, are placed in stage #2 and referred to as "ours".  Clarify
   the "checkout --ours/--theirs".
   (merge f303016 se/doc-checkout-ours-theirs later to maint).

 * The "rev-parse --parseopt" mode parsed the option specification
   and the argument hint in a strange way to allow '=3D' and other
   special characters in the option name while forbidding them from
   the argument hint.  This made it impossible to define an option
   like "--pair <key>=3D<value>" with "pair=3Dkey=3Dvalue" specificatio=
n,
   which instead would have defined a "--pair=3Dkey <value>" option.
   (merge 2d893df ib/scripted-parse-opt-better-hint-string later to mai=
nt).

 * Often a fast-import stream builds a new commit on top of the
   previous commit it built, and it often unconditionally emits a
   "from" command to specify the first parent, which can be omitted in
   such a case.  This caused fast-import to forget the tree of the
   previous commit and then re-read it from scratch, which was
   inefficient.  Optimize for this common case.
   (merge 0df3245 mh/fast-import-optimize-current-from later to maint).

 * Running an aliased command from a subdirectory when the .git thing
   in the working tree is a gitfile pointing elsewhere did not work.
   (merge d95138e nd/export-worktree later to maint).

 * "Is this subdirectory a separate repository that should not be
   touched?" check "git clean" was inefficient.  This was replaced
   with a more optimized check.
   (merge fbf2fec ee/clean-remove-dirs later to maint).

 * The "new-worktree-mode" hack in "checkout" that was added in
   nd/multiple-work-trees topic has been removed by updating the
   implementation of new "worktree add".
   (merge 65f9b75 es/worktree-add-cleanup later to maint).

 * Remove remaining cruft from  "git checkout --to", which
   transitioned to "git worktree add".
   (merge 114ff88 es/worktree-add later to maint).

 * An off-by-one error made "git remote" to mishandle a remote with a
   single letter nickname.
   (merge bc598c3 mh/get-remote-group-fix later to maint).

 * "git clone $URL", when cloning from a site whose sole purpose is to
   host a single repository (hence, no path after <scheme>://<site>/),
   tried to use the site name as the new repository name, but did not
   remove username or password when <site> part was of the form
   <user>@<pass>:<host>.  The code is taught to redact these.
   (merge adef956 ps/guess-repo-name-at-root later to maint).

 * Running tests with the "-x" option to make them verbose had some
   unpleasant interactions with other features of the test suite.
   (merge 9b5fe78 jk/test-with-x later to maint).

 * t1509 test that requires a dedicated VM environment had some
   bitrot, which has been corrected.
   (merge faacc5a ps/t1509-chroot-test-fixup later to maint).

 * "git pull" in recent releases of Git has a regression in the code
   that allows custom path to the --upload-pack=3D<program>.  This has
   been corrected.

   Note that this is irrelevant for 'master' with "git pull" rewritten
   in C.
   (merge 13e0e28 mm/pull-upload-pack later to maint).

 * When trying to see that an object does not exist, a state errno
   leaked from our "first try to open a packfile with O_NOATIME and
   then if it fails retry without it" logic on a system that refuses
   O_NOATIME.  This confused us and caused us to die, saying that the
   packfile is unreadable, when we should have just reported that the
   object does not exist in that packfile to the caller.
   (merge dff6f28 cb/open-noatime-clear-errno later to maint).

 * The codepath to produce error messages had a hard-coded limit to
   the size of the message, primarily to avoid memory allocation while
   calling die().
   (merge f4c3edc jk/long-error-messages later to maint).

 * strbuf_read() used to have one extra iteration (and an unnecessary
   strbuf_grow() of 8kB), which was eliminated.
   (merge 3ebbd00 jh/strbuf-read-use-read-in-full later to maint).

 * We rewrote one of the build scripts in Perl but this reimplements
   in Bourne shell.
   (merge 82aec45 sg/help-group later to maint).

 * The experimental untracked-cache feature were buggy when paths with
   a few levels of subdirectories are involved.
   (merge 73f9145 dt/untracked-subdir later to maint).

 * "interpret-trailers" helper mistook a single-liner log message that
   has a colon as the end of existing trailer.

 * The "interpret-trailers" helper mistook a multi-paragraph title of
   a commit log message with a colon in it as the end of the trailer
   block.
   (merge 5c99995 cc/trailers-corner-case-fix later to maint).

 * "git describe" without argument defaulted to describe the HEAD
   commit, but "git describe --contains" didn't.  Arguably, in a
   repository used for active development, such defaulting would not
   be very useful as the tip of branch is typically not tagged, but it
   is better to be consistent.
   (merge 2bd0706 sg/describe-contains later to maint).

 * The client side codepaths in "git push" have been cleaned up
   and the user can request to perform an optional "signed push",
   i.e. sign only when the other end accepts signed push.
   (merge 68c757f db/push-sign-if-asked later to maint).

 * Because the configuration system does not allow "alias.0foo" and
   "pager.0foo" as the configuration key, the user cannot use '0foo'
   as a custom command name anyway, but "git 0foo" tried to look these
   keys up and emitted useless warnings before saying '0foo is not a
   git command'.  These warning messages have been squelched.
   (merge 9e9de18 jk/fix-alias-pager-config-key-warnings later to maint=
).

 * "git rev-list" does not take "--notes" option, but did not complain
   when one is given.
   (merge 2aea7a5 jk/rev-list-has-no-notes later to maint).

 * When re-priming the cache-tree opportunistically while committing
   the in-core index as-is, we mistakenly invalidated the in-core
   index too aggressively, causing the experimental split-index code
   to unnecessarily rewrite the on-disk index file(s).
   (merge 475a344 dt/commit-preserve-base-index-upon-opportunistic-cach=
e-tree-update later to maint).

 * "git archive" did not use zip64 extension when creating an archive
   with more than 64k entries, which nobody should need, right ;-)?
   (merge 88329ca rs/archive-zip-many later to maint).

 * The code in "multiple-worktree" support that attempted to recover
   from an inconsistent state updated an incorrect file.
   (merge 82fde87 nd/fixup-linked-gitdir later to maint).

 * On case insensitive systems, "git p4" did not work well with client
   specs.

 * "git init empty && git -C empty log" said "bad default revision 'HEA=
D'",
   which was found to be a bit confusing to new users.
   (merge ce11360 jk/log-missing-default-HEAD later to maint).

 * Code cleanups and documentation updates.
   (merge 1c601af es/doc-clean-outdated-tools later to maint).
   (merge 3581304 kn/tag-doc-fix later to maint).
   (merge 3a59e59 kb/i18n-doc later to maint).
   (merge 45abdee sb/remove-unused-var-from-builtin-add later to maint)=
=2E
   (merge 14691e3 sb/parse-options-codeformat later to maint).
   (merge 4a6ada3 ad/bisect-cleanup later to maint).
   (merge da4c5ad ta/docfix-index-format-tech later to maint).
   (merge ae25fd3 sb/check-return-from-read-ref later to maint).
   (merge b3325df nd/dwim-wildcards-as-pathspecs later to maint).
   (merge 7aa9b9b sg/wt-status-header-inclusion later to maint).
   (merge f04c690 as/docfix-reflog-expire-unreachable later to maint).
   (merge 1269847 sg/t3020-typofix later to maint).
   (merge 8b54c23 jc/calloc-pathspec later to maint).
   (merge a6926b8 po/po-readme later to maint).
   (merge 54d160e ss/fix-config-fd-leak later to maint).
   (merge b80fa84 ah/submodule-typofix-in-error later to maint).
   (merge 99885bc ah/reflog-typofix-in-error later to maint).
   (merge 9476c2c ah/read-tree-usage-string later to maint).
   (merge b8c1d27 ah/pack-objects-usage-strings later to maint).
   (merge 486e1e1 br/svn-doc-include-paths-config later to maint).
   (merge 1733ed3 ee/clean-test-fixes later to maint).

----------------------------------------------------------------

Changes since v2.5.0 are as follows:

Alex Henrie (4):
      reflog: add missing single quote to error message
      git-submodule: remove extraneous space from error message
      pack-objects: place angle brackets around placeholders in usage s=
trings
      read-tree: replace bracket set with parentheses to clarify usage

Andreas Schwab (1):
      Documentation/config: fix inconsistent label on gc.*.reflogExpire=
Unreachable

Antoine Delaite (3):
      bisect: correction of typo
      bisect: replace hardcoded "bad|good" by variables
      bisect: simplify the addition of new bisect terms

Brett Randall (1):
      git-svn doc: mention "svn-remote.<name>.include-paths"

Brian Degenhardt (1):
      unpack-trees: populate cache-tree on successful merge

Charles Bailey (3):
      test-parse-options: update to handle negative ints
      parse-options: move unsigned long option parsing out of pack-obje=
cts.c
      untracked: fix detection of uname(2) failure

Christian Couder (3):
      trailer: ignore first line of message
      trailer: retitle a test and correct an in-comment message
      trailer: support multiline title

Clemens Buchacher (1):
      git_open_noatime: return with errno=3D0 on success

Dave Borowitz (9):
      Documentation/git-push.txt: document when --signed may fail
      Documentation/git-send-pack.txt: wrap long synopsis line
      Documentation/git-send-pack.txt: document --signed
      gitremote-helpers.txt: document pushcert option
      transport: remove git_transport_options.push_cert
      config.c: rename git_config_maybe_bool_text and export it as git_=
parse_maybe_bool
      builtin/send-pack.c: use parse_options API
      push: support signing pushes iff the server supports it
      push: add a config option push.gpgSign for default signed pushes

David Aguilar (1):
      contrib/subtree: ignore log.date configuration

David Turner (22):
      log: add "log.follow" configuration variable
      unpack-trees: don't update files with CE_WT_REMOVE set
      refs.c: add err arguments to reflog functions
      refs: break out check for reflog autocreation
      refs: new public ref function: safe_create_reflog
      git-reflog: add exists command
      refs: add REF_FORCE_CREATE_REFLOG flag
      update-ref and tag: add --create-reflog arg
      git-stash: use update-ref --create-reflog instead of creating fil=
es
      t/t7509: remove unnecessary manipulation of reflog
      tests: remove some direct access to .git/logs
      refs: introduce pseudoref and per-worktree ref concepts
      refs: add ref_type function
      pseudorefs: create and use pseudoref update and delete functions
      bisect: use update_ref
      sequencer: replace write_cherry_pick_head with update_ref
      untracked-cache: support sparse checkout
      worktrees: add find_shared_symref
      notes: handle multiple worktrees
      pseudoref: check return values from read_ref()
      untracked-cache: fix subdirectory handling
      commit: don't rewrite shared index unnecessarily

Elia Pinto (1):
      http: add support for specifying the SSL version

Eric Sunshine (31):
      config: rename "gc.pruneWorktreesExpire" to "gc.worktreePruneExpi=
re"
      checkout: avoid resolving HEAD unnecessarily
      checkout: name check_linked_checkouts() more meaningfully
      checkout: improve die_if_checked_out() robustness
      checkout: die_if_checked_out: simplify strbuf management
      checkout: generalize die_if_checked_out() branch name argument
      checkout: check_linked_checkout: improve "already checked out" ae=
sthetic
      checkout: check_linked_checkout: simplify symref parsing
      checkout: teach check_linked_checkout() about symbolic link HEAD
      branch: publish die_if_checked_out()
      worktree: improve worktree setup message
      worktree: simplify new branch (-b/-B) option checking
      worktree: introduce options container
      worktree: make --detach mutually exclusive with -b/-B
      worktree: add: suppress auto-vivication with --detach and no <bra=
nch>
      worktree: make branch creation distinct from worktree population
      worktree: elucidate environment variables intended for child proc=
esses
      worktree: add_worktree: construct worktree-population command loc=
ally
      worktree: detect branch-name/detached and error conditions locall=
y
      worktree: make setup of new HEAD distinct from worktree populatio=
n
      worktree: avoid resolving HEAD unnecessarily
      worktree: populate via "git reset --hard" rather than "git checko=
ut"
      checkout: drop intimate knowledge of newly created worktree
      Documentation/git-worktree: fix broken 'linkgit' invocation
      Documentation/git: drop outdated Cogito reference
      Documentation/git-tools: improve discoverability of Git wiki
      Documentation/git-tools: fix item text formatting
      Documentation/git-tools: drop references to defunct tools
      Documentation/git-tools: retire manually-maintained list
      Documentation/config: mention "now" and "never" for 'expire' sett=
ings
      generate-cmdlist: re-implement as shell script

Erik Elfstr=C3=B6m (6):
      setup: add gentle version of read_gitfile
      setup: sanity check file size in read_gitfile_gently
      t7300: add tests to document behavior of clean and nested git
      p7300: add performance tests for clean
      clean: improve performance when removing lots of directories
      t7300: fix broken && chains

Galan R=C3=A9mi (3):
      git-rebase -i: add command "drop" to remove a commit
      git rebase -i: warn about removed commits
      git rebase -i: add static check for commands and SHA-1

Guillaume Pag=C3=A8s (4):
      status: factor two rebase-related messages together
      status: differentiate interactive from non-interactive rebases
      status: give more information during rebase -i
      status: add new tests for status during rebase -i

Heiko Voigt (4):
      submodule: implement a config API for lookup of .gitmodules value=
s
      submodule: extract functions for config set and lookup
      submodule: use new config API for worktree configurations
      submodule: allow erroneous values for the fetchRecurseSubmodules =
option

Ilya Bobyr (1):
      rev-parse --parseopt: allow [*=3D?!] in argument hints

Jacob Keller (8):
      refs: cleanup comments regarding check_refname_component()
      refs: loosen restriction on wildcard "*" refspecs
      notes: document cat_sort_uniq rewriteMode
      notes: extract enum notes_merge_strategy to notes-utils.h
      notes: extract parse_notes_merge_strategy to notes-utils
      notes: add tests for --commit/--abort/--strategy exclusivity
      notes: add notes.mergeStrategy option to select default strategy
      notes: teach git-notes about notes.<name>.mergeStrategy option

Jan Viktorin (1):
      send-email: provide whitelist of SMTP AUTH mechanisms

Jeff King (46):
      pkt-line: simplify starts_with checks in packet tracing
      pkt-line: tighten sideband PACK check when tracing
      pkt-line: support tracing verbatim pack contents
      cat-file: minor style fix in options list
      cat-file: move batch_options definition to top of file
      cat-file: add --buffer option
      cat-file: stop returning value from batch_one_object
      cat-file: split batch_one_object into two stages
      cat-file: add --batch-all-objects option
      read_gitfile_gently: fix use-after-free
      cat-file: sort and de-dup output of --batch-all-objects
      show-branch: use DATE_RELATIVE instead of magic number
      convert "enum date_mode" into a struct
      introduce "format" date-mode
      strbuf: make strbuf_addftime more robust
      docs/config.txt: reorder hideRefs config
      refs: support negative transfer.hideRefs
      test-lib: turn off "-x" tracing during chain-lint check
      test-lib: disable trace when test is not verbose
      clone: add tests for output directory
      clone: use computed length in guess_dir_name
      cache.h: clarify documentation for git_path, et al
      cache.h: complete set of git_path_submodule helpers
      t5700: modernize style
      add_to_alternates_file: don't add duplicate entries
      prefer git_pathdup to git_path in some possibly-dangerous cases
      prefer mkpathdup to mkpath in assignments
      remote.c: drop extraneous local variable from migrate_file
      refs.c: remove extra git_path calls from read_loose_refs
      path.c: drop git_path_submodule
      refs.c: simplify strbufs in reflog setup and writing
      refs.c: avoid repeated git_path calls in rename_tmp_log
      refs.c: avoid git_path assignment in lock_ref_sha1_basic
      refs.c: remove_empty_directories can take a strbuf
      find_hook: keep our own static buffer
      get_repo_path: refactor path-allocation
      memoize common git-path "constant" files
      vreportf: report to arbitrary filehandles
      vreportf: avoid intermediate buffer
      format_config: don't init strbuf
      format_config: simplify buffer handling
      get_urlmatch: avoid useless strbuf write
      config: silence warnings for command names with invalid keys
      rev-list: make it obvious that we do not support notes
      log: diagnose empty HEAD more clearly
      rerere: release lockfile in non-writing functions

Jiang Xin (2):
      receive-pack: crash when checking with non-exist HEAD
      i18n: am: fix typo in description of -b option

Jim Hill (1):
      strbuf_read(): skip unnecessary strbuf_grow() at eof

Johannes Schindelin (19):
      fsck: introduce fsck options
      fsck: introduce identifiers for fsck messages
      fsck: provide a function to parse fsck message IDs
      fsck: offer a function to demote fsck errors to warnings
      fsck (receive-pack): allow demoting errors to warnings
      fsck: report the ID of the error/warning
      fsck: make fsck_ident() warn-friendly
      fsck: make fsck_commit() warn-friendly
      fsck: handle multiple authors in commits specially
      fsck: make fsck_tag() warn-friendly
      fsck: add a simple test for receive.fsck.<msg-id>
      fsck: disallow demoting grave fsck errors to warnings
      fsck: optionally ignore specific fsck issues completely
      fsck: allow upgrading fsck warnings to errors
      fsck: document the new receive.fsck.<msg-id> options
      fsck: support demoting errors to warnings
      fsck: introduce `git fsck --connectivity-only`
      fsck: git receive-pack: support excluding objects from fsck'ing
      fsck: support ignoring objects in `git fsck` via fsck.skiplist

Johannes Sixt (2):
      t7300-clean: require POSIXPERM for chmod 0 test
      t2019: skip test requiring '*' in a file name non Windows

Jose F. Morales (1):
      Mingw: verify both ends of the pipe () call

Junio C Hamano (29):
      commit-slab: introduce slabname##_peek() function
      builtin/send-pack.c: respect user.signingkey
      Git 2.4.8
      First batch for 2.6
      sha1_file.c: rename move_temp_to_file() to finalize_object_file()
      Second batch for 2.6
      Third batch for 2.6
      Start preparing for 2.5.1
      Fourth batch for 2.6
      ps_matched: xcalloc() takes nmemb and then element size
      log: rename "tweak" helpers
      log: when --cc is given, default to -p unless told otherwise
      log: show merge commit when --cc is given
      builtin/am: introduce write_state_*() helper functions
      builtin/am: make sure state files are text
      write_file(): drop "fatal" parameter
      write_file_v(): do not leave incomplete line at the end
      write_file(): drop caller-supplied LF from calls to create a one-=
liner file
      builtin/log.c: minor reformat
      Fifth batch for 2.6
      pull: pass upload_pack only when it was given
      Sixth batch for 2.6
      Git 2.5.1
      Seventh batch for 2.6
      Eighth batch for 2.6
      Ninth batch for 2.6
      Git 2.6-rc0
      am: match --signoff to the original scripted version
      Git 2.6-rc1

Karsten Blees (1):
      Documentation/i18n.txt: clarify character encoding support

Karthik Nayak (12):
      for-each-ref: extract helper functions out of grab_single_ref()
      for-each-ref: clean up code
      for-each-ref: rename 'refinfo' to 'ref_array_item'
      for-each-ref: introduce new structures for better organisation
      for-each-ref: introduce 'ref_array_clear()'
      for-each-ref: rename some functions and make them public
      for-each-ref: rename variables called sort to sorting
      ref-filter: add 'ref-filter.h'
      Documentation/tag: remove double occurance of "<pattern>"
      ref-filter: move code from 'for-each-ref'
      for-each-ref: introduce filter_refs()
      ref-filter: make 'ref_array_item' use a FLEX_ARRAY for refname

Kevin Daudt (1):
      pull: allow dirty tree when rebase.autostash enabled

Lars Schneider (1):
      git-p4: honor core.ignorecase when using P4 client specs

Matthieu Moy (3):
      Documentation/bisect: move getting help section to the end
      pull.sh: quote $upload_pack when passing it to git-fetch
      bisect: don't mix option parsing and non-trivial code

Michael Haggerty (45):
      delete_ref(): move declaration to refs.h
      remove_branches(): remove temporary
      delete_ref(): handle special case more explicitly
      delete_refs(): new function for the refs API
      delete_refs(): make error message more generic
      delete_refs(): bail early if the packed-refs file cannot be rewri=
tten
      prune_remote(): use delete_refs()
      prune_refs(): use delete_refs()
      repack_without_refs(): make function private
      initial_ref_transaction_commit(): function for initial ref creati=
on
      refs: remove some functions from the module's public interface
      initial_ref_transaction_commit(): check for duplicate refs
      initial_ref_transaction_commit(): check for ref D/F conflicts
      refs: move the remaining ref module declarations to refs.h
      refs.h: add some parameter names to function declarations
      check_branch_commit(): make first parameter const
      update_ref(): don't read old reference value before delete
      cmd_update_ref(): make logic more straightforward
      delete_ref(): use the usual convention for old_sha1
      Documentation/bisect: revise overall content
      fast-import: add a get-mark command
      Documentation/git-worktree: consistently use term "linked working=
 tree"
      Documentation/git-worktree: fix incorrect reference to file "lock=
ed"
      Documentation/config: fix stale "git prune --worktree" reference
      Documentation/git-worktree: wordsmith worktree-related manpages
      get_remote_group(): handle remotes with single-character names
      get_remote_group(): rename local variable "space" to "wordlen"
      get_remote_group(): eliminate superfluous call to strcspn()
      get_remote_group(): use skip_prefix()
      lockfile: move documentation to lockfile.h and lockfile.c
      create_bundle(): duplicate file descriptor to avoid closing it tw=
ice
      lockfile: add accessors get_lock_file_fd() and get_lock_file_fp()
      lockfile: add accessor get_lock_file_path()
      commit_lock_file(): use get_locked_file_path()
      tempfile: a new module for handling temporary files
      prepare_tempfile_object(): new function, extracted from create_te=
mpfile()
      tempfile: add several functions for creating temporary files
      register_tempfile(): new function to handle an existing temporary=
 file
      write_shared_index(): use tempfile module
      setup_temporary_shallow(): use tempfile module
      diff: use tempfile module
      lock_repo_for_gc(): compute the path to "gc.pid" only once
      gc: use tempfile module to handle gc.pid file
      credential-cache--daemon: delete socket from main()
      credential-cache--daemon: use tempfile module

Michael Rappazzo (1):
      git-rebase--interactive.sh: add config option for custom instruct=
ion format

Mike Hommey (2):
      Allow to control where the replace refs are looked for
      fast-import: do less work when given "from" matches current branc=
h head

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
      setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DI=
R
      t7063: use --force-untracked-cache to speed up a bit
      untracked cache: fix entry invalidation
      setup: update the right file in multiple checkouts

Patrick Steinhardt (6):
      Documentation/git-worktree: fix duplicated 'from'
      tests: fix broken && chains in t1509-root-worktree
      tests: fix cleanup after tests in t1509-root-worktree
      clone: do not include authentication data in guessed dir
      clone: do not use port number as dir name
      clone: abort if no dir name could be guessed

Paul Tan (85):
      t4150: test applying StGit patch
      am: teach StGit patch parser how to read from stdin
      t4150: test applying StGit series
      am: use gmtime() to parse mercurial patch date
      am: teach mercurial patch parser how to read from stdin
      parse-options-cb: implement parse_opt_passthru()
      parse-options-cb: implement parse_opt_passthru_argv()
      argv-array: implement argv_array_pushv()
      pull: implement skeletal builtin pull
      pull: implement fetch + merge
      pull: pass verbosity, --progress flags to fetch and merge
      pull: pass git-merge's options to git-merge
      pull: pass git-fetch's options to git-fetch
      pull: error on no merge candidates
      pull: support pull.ff config
      pull: check if in unresolved merge state
      pull: fast-forward working tree if head is updated
      pull: implement pulling into an unborn branch
      pull: set reflog message
      pull: teach git pull about --rebase
      pull: configure --rebase via branch.<name>.rebase or pull.rebase
      pull --rebase: exit early when the working directory is dirty
      pull --rebase: error on no merge candidate cases
      pull: remove redirection to git-pull.sh
      t4150: am.messageid really adds the message id
      t4150: am fails if index is dirty
      t4151: am --abort will keep dirty index intact
      t4150: am refuses patches when paused
      t4150: am --resolved fails if index has no changes
      t4150: am --resolved fails if index has unmerged entries
      t4150: am with applypatch-msg hook
      t4150: am with pre-applypatch hook
      t4150: am with post-applypatch hook
      t4150: tests for am --[no-]scissors
      t3418: non-interactive rebase --continue with rerere enabled
      t3901: test git-am encoding conversion
      wrapper: implement xopen()
      wrapper: implement xfopen()
      builtin-am: implement skeletal builtin am
      builtin-am: implement patch queue mechanism
      builtin-am: split out mbox/maildir patches with git-mailsplit
      builtin-am: auto-detect mbox patches
      builtin-am: extract patch and commit info with git-mailinfo
      builtin-am: apply patch with git-apply
      builtin-am: implement committing applied patch
      builtin-am: refuse to apply patches if index is dirty
      builtin-am: implement --resolved/--continue
      builtin-am: don't parse mail when resuming
      builtin-am: implement --skip
      builtin-am: implement --abort
      builtin-am: reject patches when there's a session in progress
      builtin-am: implement -q/--quiet
      builtin-am: exit with user friendly message on failure
      builtin-am: implement -s/--signoff
      cache-tree: introduce write_index_as_tree()
      builtin-am: implement --3way
      builtin-am: implement --rebasing mode
      builtin-am: bypass git-mailinfo when --rebasing
      builtin-am: handle stray state directory
      builtin-am: implement -u/--utf8
      builtin-am: implement -k/--keep, --keep-non-patch
      builtin-am: implement --[no-]message-id, am.messageid
      builtin-am: support --keep-cr, am.keepcr
      builtin-am: implement --[no-]scissors
      builtin-am: pass git-apply's options to git-apply
      builtin-am: implement --ignore-date
      builtin-am: implement --committer-date-is-author-date
      builtin-am: implement -S/--gpg-sign, commit.gpgsign
      builtin-am: invoke post-rewrite hook
      builtin-am: support automatic notes copying
      builtin-am: invoke applypatch-msg hook
      builtin-am: invoke pre-applypatch hook
      builtin-am: invoke post-applypatch hook
      builtin-am: rerere support
      builtin-am: support and auto-detect StGit patches
      builtin-am: support and auto-detect StGit series files
      builtin-am: support and auto-detect mercurial patches
      builtin-am: implement -i/--interactive
      builtin-am: implement legacy -b/--binary option
      builtin-am: check for valid committer ident
      builtin-am: remove redirection to git-am.sh
      test_terminal: redirect child process' stdin to a pty
      am: let command-line options override saved options
      am: let --signoff override --no-signoff
      am --skip/--abort: merge HEAD/ORIG_HEAD tree into index

Philip Oakley (1):
      po/README: Update directions for l10n contributors

Ralf Thielow (1):
      lockfile: remove function "hold_lock_file_for_append"

Remi Lespinet (11):
      t9001-send-email: move script creation in a setup test
      send-email: allow aliases in patch header and command script outp=
uts
      t9001-send-email: refactor header variable fields replacement
      send-email: refactor address list process
      send-email: allow use of aliases in the From field of --compose m=
ode
      send-email: minor code refactoring
      send-email: reduce dependencies impact on parse_address_line
      send-email: consider quote as delimiter instead of character
      send-email: allow multiple emails using --cc, --to and --bcc
      send-email: suppress meaningless whitespaces in from field
      git-am: add am.threeWay config variable

Ren=C3=A9 Scharfe (3):
      t5004: test ZIP archives with many entries
      archive-zip: use a local variable to store the creator version
      archive-zip: support more than 65535 entries

SZEDER G=C3=A1bor (8):
      bash prompt: test untracked files status indicator with untracked=
 dirs
      bash prompt: faster untracked status indicator with untracked dir=
ectories
      config: add '--name-only' option to list only variable names
      completion: list variable names reliably with 'git config --name-=
only'
      t3020: fix typo in test description
      config: restructure format_config() for better control flow
      wt-status: move #include "pathspec.h" to the header
      describe --contains: default to HEAD when no commit-ish is given

Simon A. Eugster (1):
      checkout: document subtlety around --ours/--theirs

Stefan Beller (4):
      parse-options: align curly braces for all options
      add: remove dead code
      transport-helper: die on errors reading refs.
      read-cache: fix indentation in read_index_from

Sven Strickroth (1):
      config: close config file handle in case of error

Thomas Ackermann (1):
      typofix for index-format.txt

Thomas Braun (1):
      completion: offer '--edit-todo' during interactive rebase

Zoe=CC=88 Blade (1):
      userdiff: add support for Fountain documents

brian m. carlson (7):
      verify-tag: add tests
      verify-tag: share code with verify-commit
      verify-commit: add test for exit status on untrusted signature
      gpg: centralize signature check
      gpg: centralize printing signature buffers
      verify-commit: add option to print raw gpg status information
      verify-tag: add option to print raw gpg status information
