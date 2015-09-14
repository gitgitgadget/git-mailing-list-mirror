From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.6.0-rc2
Date: Mon, 14 Sep 2015 15:42:42 -0700
Message-ID: <xmqqa8sovd0d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Sep 15 00:43:14 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ZbcSv-0005d4-Sc
	for glk-linux-kernel-3@plane.gmane.org; Tue, 15 Sep 2015 00:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbbINWmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 14 Sep 2015 18:42:50 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33441 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbbINWmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Sep 2015 18:42:44 -0400
Received: by pacex6 with SMTP id ex6so156108432pac.0;
        Mon, 14 Sep 2015 15:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=TtOJvFfI5kAom1mOZpB9U3+YKAeeFdkPfPLmzV7QCjc=;
        b=iyeUN+QOAKBZRMyopwS5P/jpBuWdQz2bgrkFne4x5ptmWMxi4htCi0vIS6ejbhD6A5
         gyZIk8WDZJxvoRNWbusnNLB8hSiMtYKdzToLcWFHGzH7T6/HujCIEqg5Pc2sthAo6/5p
         pZgp2HMrHdI3w5Lnlbnatal12ufIlFGwlO8LuegWfhPJjCZ6V1ECtW0ffvyAxpKVCW3j
         4g8HVXdTIAVw1nClt6IchNwwkeryZzrfOK3J2wt3rqjmFmuYU7psPDNcaAqKT40lX6Wp
         WoD1iOp/oMJrO+816suFWxZav7/GRi43CmInRmkY1csBhX2UuEApAczVJAohJylpP+4O
         1WUw==
X-Received: by 10.68.197.65 with SMTP id is1mr39829626pbc.109.1442270563424;
        Mon, 14 Sep 2015 15:42:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id ej3sm18157894pbd.13.2015.09.14.15.42.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 15:42:42 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277873>

A release candidate Git v2.6.0-rc2 is now available for testing
at the usual places.  It is comprised of 439 non-merge commits
since v2.5.0, contributed by 59 people, 14 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.6.0-rc2' tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.5.0 are as follows.
Welcome to the Git development community!

  Antoine Delaite, Brett Randall, Brian Degenhardt, Erik Elfstr=C3=B6m,
  Galan R=C3=A9mi, Guillaume Pag=C3=A8s, Ismael Luceno, Jan Viktorin, J=
ose
  F. Morales, Lars Schneider, Matthieu Prat, Michael Rappazzo,
  Simon A. Eugster, and Zoe=CC=88 Blade.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Shopov, Alex Henrie, Andreas Schwab, Beat Bolli, brian
  m. carlson, Charles Bailey, Christian Couder, Clemens Buchacher,
  Dave Borowitz, David Aguilar, David Turner, Elia Pinto, Eric
  Sunshine, Giuseppe Bilotta, Heiko Voigt, Ilya Bobyr, Jacob
  Keller, Jeff King, Jiang Xin, Jim Hill, Johannes Schindelin,
  Johannes Sixt, Junio C Hamano, Karsten Blees, Karthik Nayak,
  Kevin Daudt, Marc Branchaud, Matthieu Moy, Michael Haggerty,
  Michael J Gruber, Mike Hommey, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy,
  Patrick Steinhardt, Paul Mackerras, Paul Tan, Peter Krefting,
  Philip Oakley, Ralf Thielow, Remi Lespinet, Ren=C3=A9 Scharfe,
  Stefan Beller, Sven Strickroth, SZEDER G=C3=A1bor, Thomas Ackermann,
  and Thomas Braun.

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

 * After "git am" without "-3" stops, running "git am -3" pays attentio=
n
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

 * A handful of usability & cosmetic fixes to gitk and l10n updates.

 * A completely empty e-mail address <> is now allowed in the authors
   file used by git-svn, to match the way it accepts the output from
   authors-prog.


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
   (merge 5fcadc3 gb/apply-comment-typofix later to maint).
   (merge b894d3e mp/t7060-diff-index-test later to maint).
