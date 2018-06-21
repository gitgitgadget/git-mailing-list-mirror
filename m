Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99231F516
	for <e@80x24.org>; Thu, 21 Jun 2018 19:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeFUT1f (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 15:27:35 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33131 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754128AbeFUT1b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 15:27:31 -0400
Received: by mail-wr0-f178.google.com with SMTP id k16-v6so4342703wro.0;
        Thu, 21 Jun 2018 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IMZVTcNWAf++E5YGSLq9PGic6mqV8HFlg/lCdl/b6PA=;
        b=Mku6tp0mNvgZtvp9ToOVeJK4R8hjwZ4kix9zgKS3stSuo1GpUVTzAmpDk6cxZX7n0W
         Sj5O3XJBiofDFNRuNkmsMgJkTwWnOkYfy4l6dFP1JnVRbvHD/Gq6+CwE4006FgNCBVc8
         7hst4xOinNdMb/yTvCneBFoC2PL4gaunFgsPTm8y09nlq3kSmYbixzNMNLrsaPpgnW+7
         HitCcpyvNGARYN9TwyIJwR0genEp3SfNNH7iqx6d4SMIknpc8ZMgTtKYJzuAUrvHAKI1
         pUQuFY67Edbe0NA3GunD9xICBvPoExqQTWyeOJRkl0Ny9HTxiHT8Xi13V56zDgmgFh6N
         El6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IMZVTcNWAf++E5YGSLq9PGic6mqV8HFlg/lCdl/b6PA=;
        b=qAt563bGM4n/dZVem1OgYb+c++lGQEg/ky9wrfOMT1scUIUEMPOcowLsl5IpCt8wVW
         qN14jwb3nChvANjVU7a0hj67yng3W7bGoSB//j8jbJzz/tfYrWzKN9YZO71srHGEQmRB
         LG0Dcdf+mdSLIRnhjoVM9dY81atRkq5MwVsDvq4xsKsHhiKkX1STU4+fAlEtpKgdvo4S
         gBVxK5PIVztiqlyFt8TOGjSbGgne3/zof6iYuy29SuVtg75BRYA8KJMJo1rr2Jcq9FAA
         2+W9qzjwtdwV5oW/ctRY75mxahCBNYOuea/ZWH/5azBPuMS0rP/sjL3UT1UJY8ziw0Ji
         VvWg==
X-Gm-Message-State: APt69E3CYzLoa+tus78wSXk9jv7iLUjNiOIwuIlAuBAKMqpqcB792RPB
        OSmpvQTEHtliDnOy23RPtXJGRX4P
X-Google-Smtp-Source: ADUXVKK6lGvgFuAf71kxEkn8sFBt3jjecqrIoFs2bflrU2+pr0xrdeqWp/taaiI6pAKh9cHE2MR67w==
X-Received: by 2002:adf:96c4:: with SMTP id u62-v6mr23531470wrb.204.1529609248441;
        Thu, 21 Jun 2018 12:27:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l84-v6sm8569386wmi.3.2018.06.21.12.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 12:27:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.18.0
Date:   Thu, 21 Jun 2018 12:27:27 -0700
Message-ID: <xmqqbmc4szxc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.18.0 is now available at the
usual places.  It is comprised of 903 non-merge commits since
v2.17.0, contributed by 80 people, 24 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.18.0'
tag and the 'master' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.17.0 are as follows.
Welcome to the Git development community!

  Bill Ritcher, Birger Skogeng Pedersen, Casey Fitzpatrick,
  Dan Jacques, Drew DeVault, Eckhard S. Maaß, Erik E Brady,
  Florian Gamböck, Harald Nordgren, Jeremy Linton, Karthikeyan
  Singaravelan, Leif Middelschulte, Loganaden Velvindron, Luis
  Marsano, Meng-Sung Wu, Paul-Sebastian Ungureanu, Pedro Alvarez
  Piedehierro, Pratik Karki, Romain Merland, Ryan Dammrose,
  Takuto Ikuta, Tao Qingyun, Wink Saville, and Yuki Kokubun.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Ævar Arnfjörð Bjarmason, Alexander Shopov, Anders Kaseorg,
  Andreas Heiduk, Andre Hinrichs, Antonio Ospite, Beat Bolli,
  Ben Peart, Brandon Williams, brian m. carlson, Changwoo Ryu,
  Christian Couder, Christian Hesse, Christopher Diaz Riveros,
  Clemens Buchacher, David Turner, Derrick Stolee, Elijah Newren,
  Eric Sunshine, Jameson Miller, Jean-Noël Avila, Jeff King,
  Jiang Xin, Johannes Schindelin, Johannes Sixt, Jonathan Nieder,
  Jonathan Tan, Jordi Mas, Junio C Hamano, Kaartic Sivaraam,
  Kyle Meyer, Lars Schneider, Lucas Werkmeister, Luke Diamand,
  Martin Ågren, Michal Nazarewicz, Michele Locati, Nguyễn Thái
  Ngọc Duy, Olga Telezhnaya, Orgad Shaneh, Peter Krefting, Philip
  Oakley, Phillip Wood, Ralf Thielow, Ramsay Jones, René Scharfe,
  Robert P. J. Day, Sergey Organov, Stefan Agner, Stefan Beller,
  SZEDER Gábor, Taylor Blau, Thomas Gummerer, Todd Zullinger,
  Torsten Bögershausen, and Trần Ngọc Quân.

----------------------------------------------------------------

Git 2.18 Release Notes
======================

Updates since v2.17
-------------------

UI, Workflows & Features

 * Rename detection logic that is used in "merge" and "cherry-pick" has
   learned to guess when all of x/a, x/b and x/c have moved to z/a,
   z/b and z/c, it is likely that x/d added in the meantime would also
   want to move to z/d by taking the hint that the entire directory
   'x' moved to 'z'.  A bug causing dirty files involved in a rename
   to be overwritten during merge has also been fixed as part of this
   work.  Incidentally, this also avoids updating a file in the
   working tree after a (non-trivial) merge whose result matches what
   our side originally had.

 * "git filter-branch" learned to use a different exit code to allow
   the callers to tell the case where there was no new commits to
   rewrite from other error cases.

 * When built with more recent cURL, GIT_SSL_VERSION can now specify
   "tlsv1.3" as its value.

 * "git gui" learned that "~/.ssh/id_ecdsa.pub" and
   "~/.ssh/id_ed25519.pub" are also possible SSH key files.
   (merge 2e2f0288ef bb/git-gui-ssh-key-files later to maint).

 * "git gui" performs commit upon CTRL/CMD+ENTER but the
   CTRL/CMD+KP_ENTER (i.e. enter key on the numpad) did not have the
   same key binding.  It now does.
   (merge 28a1d94a06 bp/git-gui-bind-kp-enter later to maint).

 * "git gui" has been taught to work with old versions of tk (like
   8.5.7) that do not support "ttk::style theme use" as a way to query
   the current theme.
   (merge 4891961105 cb/git-gui-ttk-style later to maint).

 * "git rebase" has learned to honor "--signoff" option when using
   backends other than "am" (but not "--preserve-merges").

 * "git branch --list" during an interrupted "rebase -i" now lets
   users distinguish the case where a detached HEAD is being rebased
   and a normal branch is being rebased.

 * "git mergetools" learned talking to guiffy.

 * The scripts in contrib/emacs/ have outlived their usefulness and
   have been replaced with a stub that errors out and tells the user
   there are replacements.

 * The new "working-tree-encoding" attribute can ask Git to convert the
   contents to the specified encoding when checking out to the working
   tree (and the other way around when checking in).

 * The "git config" command uses separate options e.g. "--int",
   "--bool", etc. to specify what type the caller wants the value to
   be interpreted as.  A new "--type=<typename>" option has been
   introduced, which would make it cleaner to define new types.

 * "git config --get" learned the "--default" option, to help the
   calling script.  Building on top of the above changes, the
   "git config" learns "--type=color" type.  Taken together, you can
   do things like "git config --get foo.color --default blue" and get
   the ANSI color sequence for the color given to foo.color variable,
   or "blue" if the variable does not exist.

 * "git ls-remote" learned an option to allow sorting its output based
   on the refnames being shown.

 * The command line completion (in contrib/) has been taught that "git
   stash save" has been deprecated ("git stash push" is the preferred
   spelling in the new world) and does not offer it as a possible
   completion candidate when "git stash push" can be.

 * "git gc --prune=nonsense" spent long time repacking and then
   silently failed when underlying "git prune --expire=nonsense"
   failed to parse its command line.  This has been corrected.

 * Error messages from "git push" can be painted for more visibility.

 * "git http-fetch" (deprecated) had an optional and experimental
   "feature" to fetch only commits and/or trees, which nobody used.
   This has been removed.

 * The functionality of "$GIT_DIR/info/grafts" has been superseded by
   the "refs/replace/" mechanism for some time now, but the internal
   code had support for it in many places, which has been cleaned up
   in order to drop support of the "grafts" mechanism.

 * "git worktree add" learned to check out an existing branch.

 * "git --no-pager cmd" did not have short-and-sweet single letter
   option. Now it does as "-P".
   (merge 7213c28818 js/no-pager-shorthand later to maint).

 * "git rebase" learned "--rebase-merges" to transplant the whole
   topology of commit graph elsewhere.

 * "git status" learned to pay attention to UI related diff
   configuration variables such as diff.renames.

 * The command line completion mechanism (in contrib/) learned to load
   custom completion file for "git $command" where $command is a
   custom "git-$command" that the end user has on the $PATH when using
   newer version of bash-completion.

 * "git send-email" can sometimes offer confirmation dialog "Send this
   email?" with choices 'Yes', 'No', 'Quit', and 'All'.  A new action
   'Edit' has been added to this dialog's choice.

 * With merge.renames configuration set to false, the recursive merge
   strategy can be told not to spend cycles trying to find renamed
   paths and merge them accordingly.

 * "git status" learned to honor a new status.renames configuration to
   skip rename detection, which could be useful for those who want to
   do so without disabling the default rename detection done by the
   "git diff" command.

 * Command line completion (in contrib/) learned to complete pathnames
   for various commands better.

 * "git blame" learns to unhighlight uninteresting metadata from the
   originating commit on lines that are the same as the previous one,
   and also paint lines in different colors depending on the age of
   the commit.

 * Transfer protocol v2 learned to support the partial clone.

 * When a short hexadecimal string is used to name an object but there
   are multiple objects that share the string as the prefix of their
   names, the code lists these ambiguous candidates in a help message.
   These object names are now sorted according to their types for
   easier eyeballing.

 * "git fetch $there $refspec" that talks over protocol v2 can take
   advantage of server-side ref filtering; the code has been extended
   so that this mechanism triggers also when fetching with configured
   refspec.

 * Our HTTP client code used to advertise that we accept gzip encoding
   from the other side; instead, just let cURL library to advertise
   and negotiate the best one.

 * "git p4" learned to "unshelve" shelved commit from P4.
   (merge 123f631761 ld/p4-unshelve later to maint).


Performance, Internal Implementation, Development Support etc.

 * A "git fetch" from a repository with insane number of refs into a
   repository that is already up-to-date still wasted too many cycles
   making many lstat(2) calls to see if these objects at the tips
   exist as loose objects locally.  These lstat(2) calls are optimized
   away by enumerating all loose objects beforehand.
   It is unknown if the new strategy negatively affects existing use
   cases, fetching into a repository with many loose objects from a
   repository with small number of refs.

 * Git can be built to use either v1 or v2 of the PCRE library, and so
   far, the build-time configuration USE_LIBPCRE=YesPlease instructed
   the build procedure to use v1, but now it means v2.  USE_LIBPCRE1
   and USE_LIBPCRE2 can be used to explicitly choose which version to
   use, as before.

 * The build procedure learned to optionally use symbolic links
   (instead of hardlinks and copies) to install "git-foo" for built-in
   commands, whose binaries are all identical.

 * Conversion from uchar[20] to struct object_id continues.

 * The way "git worktree prune" worked internally has been simplified,
   by assuming how "git worktree move" moves an existing worktree to a
   different place.

 * Code clean-up for the "repository" abstraction.
   (merge 00a3da2a13 nd/remove-ignore-env-field later to maint).

 * Code to find the length to uniquely abbreviate object names based
   on packfile content, which is a relatively recent addtion, has been
   optimized to use the same fan-out table.

 * The mechanism to use parse-options API to automate the command line
   completion continues to get extended and polished.

 * Copies of old scripted Porcelain commands in contrib/examples/ have
   been removed.

 * Some tests that rely on the exact hardcoded values of object names
   have been updated in preparation for hash function migration.

 * Perf-test update.

 * Test helper update.

 * The effort continues to refactor the internal global data structure
   to make it possible to open multiple repositories, work with and
   then close them,

 * Small test-helper programs have been consolidated into a single
   binary.

 * API clean-up around ref-filter code.

 * Shell completion (in contrib) that gives list of paths have been
   optimized somewhat.

 * The index file is updated to record the fsmonitor section after a
   full scan was made, to avoid wasting the effort that has already
   spent.

 * Performance measuring framework in t/perf learned to help bisecting
   performance regressions.

 * Some multi-word source filenames are being renamed to separate
   words with dashes instead of underscores.

 * An reusable "memory pool" implementation has been extracted from
   fast-import.c, which in turn has become the first user of the
   mem-pool API.

 * A build-time option has been added to allow Git to be told to refer
   to its associated files relative to the main binary, in the same
   way that has been possible on Windows for quite some time, for
   Linux, BSDs and Darwin.

 * Precompute and store information necessary for ancestry traversal
   in a separate file to optimize graph walking.

 * The effort to pass the repository in-core structure throughout the
   API continues.  This round deals with the code that implements the
   refs/replace/ mechanism.

 * The build procedure "make DEVELOPER=YesPlease" learned to enable a
   bit more warning options depending on the compiler used to help
   developers more.  There also is "make DEVOPTS=tokens" knob
   available now, for those who want to help fixing warnings we
   usually ignore, for example.

 * A new version of the transport protocol is being worked on.

 * The code to interface to GPG has been restructured somewhat to make
   it cleaner to integrate with other types of signature systems later.

 * The code has been taught to use the duplicated information stored
   in the commit-graph file to learn the tree object name for a commit
   to avoid opening and parsing the commit object when it makes sense
   to do so.

 * "git gc" in a large repository takes a lot of time as it considers
   to repack all objects into one pack by default.  The command has
   been taught to pretend as if the largest existing packfile is
   marked with ".keep" so that it is left untouched while objects in
   other packs and loose ones are repacked.

 * The transport protocol v2 is getting updated further.

 * The codepath around object-info API has been taught to take the
   repository object (which in turn tells the API which object store
   the objects are to be located).

 * "git pack-objects" needs to allocate tons of "struct object_entry"
   while doing its work, and shrinking its size helps the performance
   quite a bit.

 * The implementation of "git rebase -i --root" has been updated to use
   the sequencer machinery more.

 * Developer support update, by using BUG() macro instead of die() to
   mark codepaths that should not happen more clearly.

 * Developer support.  Use newer GCC on one of the builds done at
   TravisCI.org to get more warnings and errors diagnosed.

 * Conversion from uchar[20] to struct object_id continues.

 * By code restructuring of submodule merge in merge-recursive,
   informational messages from the codepath are now given using the
   same mechanism as other output, and honor the merge.verbosity
   configuration.  The code also learned to give a few new messages
   when a submodule three-way merge resolves cleanly when one side
   records a descendant of the commit chosen by the other side.

 * Avoid unchecked snprintf() to make future code auditing easier.
   (merge ac4896f007 jk/snprintf-truncation later to maint).

 * Many tests hardcode the raw object names, which would change once
   we migrate away from SHA-1.  While some of them must test against
   exact object names, most of them do not have to use hardcoded
   constants in the test.  The latter kind of tests have been updated
   to test the moral equivalent of the original without hardcoding the
   actual object names.

 * The list of commands with their various attributes were spread
   across a few places in the build procedure, but it now is getting a
   bit more consolidated to allow more automation.

 * Quite a many tests assumed that newly created refs are made as
   loose refs using the files backend, which have been updated to use
   proper plumbing like rev-parse and update-ref, to avoid breakage
   once we start using different ref backends.


Also contains various documentation updates and code clean-ups.


Fixes since v2.17
-----------------

 * "git shortlog cruft" aborted with a BUG message when run outside a
   Git repository.  The command has been taught to complain about
   extra and unwanted arguments on its command line instead in such a
   case.
   (merge 4aa0161e83 ma/shortlog-revparse later to maint).

 * "git stash push -u -- <pathspec>" gave an unnecessary and confusing
   error message when there was no tracked files that match the
   <pathspec>, which has been fixed.
   (merge 353278687e tg/stash-untracked-with-pathspec-fix later to maint).

 * "git tag --contains no-such-commit" gave a full list of options
   after giving an error message.
   (merge 3bb0923f06 ps/contains-id-error-message later to maint).

 * "diff-highlight" filter (in contrib/) learned to understand "git log
   --graph" output better.
   (merge 4551fbba14 jk/diff-highlight-graph-fix later to maint).

 * when refs that do not point at committish are given, "git
   filter-branch" gave a misleading error messages.  This has been
   corrected.
   (merge f78ab355e7 yk/filter-branch-non-committish-refs later to maint).

 * "git submodule status" misbehaved on a submodule that has been
   removed from the working tree.
   (merge 74b6bda32f rs/status-with-removed-submodule later to maint).

 * When credential helper exits very quickly without reading its
   input, it used to cause Git to die with SIGPIPE, which has been
   fixed.
   (merge a0d51e8d0e eb/cred-helper-ignore-sigpipe later to maint).

 * "git rebase --keep-empty" still removed an empty commit if the
   other side contained an empty commit (due to the "does an
   equivalent patch exist already?" check), which has been corrected.
   (merge 3d946165e1 pw/rebase-keep-empty-fixes later to maint).

 * Some codepaths, including the refs API, get and keep relative
   paths, that go out of sync when the process does chdir(2).  The
   chdir-notify API is introduced to let these codepaths adjust these
   cached paths to the new current directory.
   (merge fb9c2d2703 jk/relative-directory-fix later to maint).

 * "cd sub/dir && git commit ../path" ought to record the changes to
   the file "sub/path", but this regressed long time ago.
   (merge 86238e07ef bw/commit-partial-from-subdirectory-fix later to maint).

 * Recent introduction of "--log-destination" option to "git daemon"
   did not work well when the daemon was run under "--inetd" mode.
   (merge e67d906d73 lw/daemon-log-destination later to maint).

 * Small fix to the autoconf build procedure.
   (merge 249482daf0 es/fread-reads-dir-autoconf-fix later to maint).

 * Fix an unexploitable (because the oversized contents are not under
   attacker's control) buffer overflow.
   (merge d8579accfa bp/fsmonitor-bufsize-fix later to maint).

 * Recent simplification of build procedure forgot a bit of tweak to
   the build procedure of contrib/mw-to-git/
   (merge d8698987f3 ab/simplify-perl-makefile later to maint).

 * Moving a submodule that itself has submodule in it with "git mv"
   forgot to make necessary adjustment to the nested sub-submodules;
   now the codepath learned to recurse into the submodules.

 * "git config --unset a.b", when "a.b" is the last variable in an
   otherwise empty section "a", left an empty section "a" behind, and
   worse yet, a subsequent "git config a.c value" did not reuse that
   empty shell and instead created a new one.  These have been
   (partially) corrected.
   (merge c71d8bb38a js/empty-config-section-fix later to maint).

 * "git worktree remove" learned that "-f" is a shorthand for
   "--force" option, just like for "git worktree add".
   (merge d228eea514 sb/worktree-remove-opt-force later to maint).

 * The completion script (in contrib/) learned to clear cached list of
   command line options upon dot-sourcing it again in a more efficient
   way.
   (merge 94408dc71c sg/completion-clear-cached later to maint).

 * "git svn" had a minor thinko/typo which has been fixed.
   (merge 51db271587 ab/git-svn-get-record-typofix later to maint).

 * During a "rebase -i" session, the code could give older timestamp
   to commits created by later "pick" than an earlier "reword", which
   has been corrected.
   (merge 12f7babd6b js/ident-date-fix later to maint).

 * "git submodule status" did not check the symbolic revision name it
   computed for the submodule HEAD is not the NULL, and threw it at
   printf routines, which has been corrected.
   (merge 0b5e2ea7cf nd/submodule-status-fix later to maint).

 * When fed input that already has In-Reply-To: and/or References:
   headers and told to add the same information, "git send-email"
   added these headers separately, instead of appending to an existing
   one, which is a violation of the RFC.  This has been corrected.
   (merge 256be1d3f0 sa/send-email-dedup-some-headers later to maint).

 * "git fast-export" had a regression in v2.15.0 era where it skipped
   some merge commits in certain cases, which has been corrected.
   (merge be011bbe00 ma/fast-export-skip-merge-fix later to maint).

 * The code did not propagate the terminal width to subprocesses via
   COLUMNS environment variable, which it now does.  This caused
   trouble to "git column" helper subprocess when "git tag --column=row"
   tried to list the existing tags on a display with non-default width.
   (merge b5d5a567fb nd/term-columns later to maint).

 * We learned that our source files with ".pl" and ".py" extensions
   are Perl and Python files respectively and changes to them are
   better viewed as such with appropriate diff drivers.
   (merge 7818b619e2 ab/perl-python-attrs later to maint).

 * "git rebase -i" sometimes left intermediate "# This is a
   combination of N commits" message meant for the human consumption
   inside an editor in the final result in certain corner cases, which
   has been fixed.
   (merge 15ef69314d js/rebase-i-clean-msg-after-fixup-continue later to maint).

 * A test to see if the filesystem normalizes UTF-8 filename has been
   updated to check what we need to know in a more direct way, i.e. a
   path created in NFC form can be accessed with NFD form (or vice
   versa) to cope with APFS as well as HFS.
   (merge 742ae10e35 tb/test-apfs-utf8-normalization later to maint).

 * "git format-patch --cover --attach" created a broken MIME multipart
   message for the cover letter, which has been fixed by keeping the
   cover letter as plain text file.
   (merge 50cd54ef4e bc/format-patch-cover-no-attach later to maint).

 * The split-index feature had a long-standing and dormant bug in
   certain use of the in-core merge machinery, which has been fixed.
   (merge 7db118303a en/unpack-trees-split-index-fix later to maint).

 * Asciidoctor gives a reasonable imitation for AsciiDoc, but does not
   render illustration in a literal block correctly when indented with
   HT by default. The problem is fixed by forcing 8-space tabs.
   (merge 379805051d bc/asciidoctor-tab-width later to maint).

 * Code clean-up to adjust to a more recent lockfile API convention that
   allows lockfile instances kept on the stack.
   (merge 0fa5a2ed8d ma/lockfile-cleanup later to maint).

 * the_repository->index is not a allocated piece of memory but
   repo_clear() indiscriminately attempted to free(3) it, which has
   been corrected.
   (merge 74373b5f10 nd/repo-clear-keep-the-index later to maint).

 * Code clean-up to avoid non-standard-conformant pointer arithmetic.
   (merge c112084af9 rs/no-null-ptr-arith-in-fast-export later to maint).

 * Code clean-up to turn history traversal more robust in a
   semi-corrupt repository.
   (merge 8702b30fd7 jk/unavailable-can-be-missing later to maint).

 * "git update-ref A B" is supposed to ensure that ref A does not yet
   exist when B is a NULL OID, but this check was not done correctly
   for pseudo-refs outside refs/ hierarchy, e.g. MERGE_HEAD.

 * "git submodule update" and "git submodule add" supported the
   "--reference" option to borrow objects from a neighbouring local
   repository like "git clone" does, but lacked the more recent
   invention "--dissociate".  Also "git submodule add" has been taught
   to take the "--progress" option.
   (merge a0ef29341a cf/submodule-progress-dissociate later to maint).

 * Update credential-netrc helper (in contrib/) to allow customizing
   the GPG used to decrypt the encrypted .netrc file.
   (merge 786ef50a23 lm/credential-netrc later to maint).

 * "git submodule update" attempts two different kinds of "git fetch"
   against the upstream repository to grab a commit bound at the
   submodule's path, but it incorrectly gave up if the first kind
   (i.e. a normal fetch) failed, making the second "last resort" one
   (i.e. fetching an exact commit object by object name) ineffective.
   This has been corrected.
   (merge e30d833671 sb/submodule-update-try-harder later to maint).

 * Error behaviour of "git grep" when it cannot read the index was
   inconsistent with other commands that uses the index, which has
   been corrected to error out early.
   (merge b2aa84c789 sb/grep-die-on-unreadable-index later to maint).

 * We used to call regfree() after regcomp() failed in some codepaths,
   which have been corrected.
   (merge 17154b1576 ma/regex-no-regfree-after-comp-fail later to maint).

 * The import-tars script (in contrib/) has been taught to handle
   tarballs with overly long paths that use PAX extended headers.
   (merge 12ecea46e3 pa/import-tars-long-names later to maint).

 * "git rev-parse Y..." etc. misbehaved when given endpoints were
   not committishes.
   (merge 0ed556d38f en/rev-parse-invalid-range later to maint).

 * "git pull --recurse-submodules --rebase", when the submodule
   repository's history did not have anything common between ours and
   the upstream's, failed to execute.  We need to fetch from them to
   continue even in such a case.
   (merge 4d36f88be7 jt/submodule-pull-recurse-rebase later to maint).

 * "git remote update" can take both a single remote nickname and a
   nickname for remote groups, but only one of them was documented.
   (merge a97447a42a nd/remote-update-doc later to maint).

 * "index-pack --strict" has been taught to make sure that it runs the
   final object integrity checks after making the freshly indexed
   packfile available to itself.
   (merge 3737746120 jk/index-pack-maint later to maint).

 * Make zlib inflate codepath more robust against versions of zlib
   that clobber unused portion of outbuf.
   (merge b611396e97 jl/zlib-restore-nul-termination later to maint).

 * Fix old merge glitch in Documentation during v2.13-rc0 era.
   (merge 28cb06020b mw/doc-merge-enumfix later to maint).

 * The code to read compressed bitmap was not careful to avoid reading
   past the end of the file, which has been corrected.
   (merge 1140bf01ec jk/ewah-bounds-check later to maint).

 * "make NO_ICONV=NoThanks" did not override NEEDS_LIBICONV
   (i.e. linkage of -lintl, -liconv, etc. that are platform-specific
   tweaks), which has been corrected.
   (merge fdb1fbbc7d es/make-no-iconv later to maint).

 * Other minor doc, test and build updates and code cleanups.
   (merge 248f66ed8e nd/trace-with-env later to maint).
   (merge 14ced5562c ys/bisect-object-id-missing-conversion-fix later to maint).
   (merge 5988eb631a ab/doc-hash-brokenness later to maint).
   (merge a4d4e32a70 pk/test-avoid-pipe-hiding-exit-status later to maint).
   (merge 05e293c1ac jk/flockfile-stdio later to maint).
   (merge e9184b0789 jk/t5561-missing-curl later to maint).
   (merge b1801b85a3 nd/worktree-move later to maint).
   (merge bbd374dd20 ak/bisect-doc-typofix later to maint).
   (merge 4855f06fb3 mn/send-email-credential-doc later to maint).
   (merge 8523b1e355 en/doc-typoes later to maint).
   (merge 43b44ccfe7 js/t5404-path-fix later to maint).
   (merge decf711fc1 ps/test-chmtime-get later to maint).
   (merge 22d11a6e8e es/worktree-docs later to maint).
   (merge 92a5dbbc22 tg/use-git-contacts later to maint).
   (merge adc887221f tq/t1510 later to maint).
   (merge bed21a8ad6 sg/doc-gc-quote-mismatch-fix later to maint).
   (merge 73364e4f10 tz/doc-git-urls-reference later to maint).
   (merge cd1e606bad bc/mailmap-self later to maint).
   (merge f7997e3682 ao/config-api-doc later to maint).
   (merge ee930754d8 jk/apply-p-doc later to maint).
   (merge 011b648646 nd/pack-format-doc later to maint).
   (merge 87a6bb701a sg/t5310-jgit-bitmap-test later to maint).
   (merge f6b82970aa sg/t5516-fixes later to maint).
   (merge 4362da078e sg/t7005-spaces-in-filenames-cleanup later to maint).
   (merge 7d0ee47c11 js/test-unset-prereq later to maint).
   (merge 5356a3c354 ah/misc-doc-updates later to maint).
   (merge 92c4a7a129 nd/completion-aliasfiletype-typofix later to maint).
   (merge 58bd77b66a nd/pack-unreachable-objects-doc later to maint).
   (merge 4ed79d5203 sg/t6500-no-redirect-of-stdin later to maint).
   (merge 17b8a2d6cd jk/config-blob-sans-repo later to maint).
   (merge 590551ca2c rd/tag-doc-lightweight later to maint).
   (merge 44f560fc16 rd/init-typo later to maint).
   (merge f156a0934a rd/p4-doc-markup-env later to maint).
   (merge 2a00502b14 tg/doc-sec-list later to maint).
   (merge 47cc91310a jk/submodule-fsck-loose-fixup later to maint).
   (merge efde7b725c rd/comment-typofix-in-sha1-file later to maint).
   (merge 7eedad15df rd/diff-options-typofix later to maint).
   (merge 58ebd936cc km/doc-workflows-typofix later to maint).
   (merge 30aa96cdf8 rd/doc-remote-tracking-with-hyphen later to maint).
   (merge cf317877e3 ks/branch-set-upstream later to maint).
   (merge 8de19d6be8 sg/t7406-chain-fix later to maint).

----------------------------------------------------------------

Changes since v2.17.0 are as follows:

Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (3608t)
      l10n: bg.po: Updated Bulgarian translation (3608t)

Anders Kaseorg (1):
      Documentation/git-bisect.txt: git bisect term → git bisect terms

Andre Hinrichs (1):
      l10n: de.po: fix typos

Andreas Heiduk (9):
      git-svn: search --authors-prog in PATH too
      git-svn: allow empty email-address using authors-prog and authors-file
      doc: improve formatting in githooks.txt
      doc: align 'diff --no-index' in text and synopsis
      doc: clarify ignore rules for git ls-files
      doc: add '-d' and '-o' for 'git push'
      git-svn: remove ''--add-author-from' for 'commit-diff'
      doc: add note about shell quoting to revision.txt
      doc: normalize [--options] to [options] in git-diff

Antonio Ospite (1):
      doc: fix config API documentation about config_with_options

Beat Bolli (1):
      git-gui: search for all current SSH key types

Ben Peart (7):
      fsmonitor: fix incorrect buffer size when printing version number
      fsmonitor: force index write after full scan
      test-drop-caches: simplify delay loading of NtSetSystemInformation
      merge: update documentation for {merge,diff}.renameLimit
      merge: add merge.renames config setting
      merge: pass aggressive when rename detection is turned off
      add status config and command line options for rename detection

Bill Ritcher (1):
      mergetools: add support for guiffy

Birger Skogeng Pedersen (1):
      git-gui: bind CTRL/CMD+numpad ENTER to do_commit

Brandon Williams (79):
      pkt-line: introduce packet_read_with_status
      pkt-line: allow peeking a packet line without consuming it
      pkt-line: add delim packet support
      upload-pack: convert to a builtin
      upload-pack: factor out processing lines
      transport: use get_refs_via_connect to get refs
      connect: convert get_remote_heads to use struct packet_reader
      connect: discover protocol version outside of get_remote_heads
      transport: store protocol version
      protocol: introduce enum protocol_version value protocol_v2
      test-pkt-line: introduce a packet-line test helper
      serve: introduce git-serve
      ls-refs: introduce ls-refs server command
      connect: request remote refs using v2
      transport: convert get_refs_list to take a list of ref prefixes
      transport: convert transport_get_remote_refs to take a list of ref prefixes
      ls-remote: pass ref prefixes when requesting a remote's refs
      fetch: pass ref prefixes when fetching
      push: pass ref prefixes when pushing
      upload-pack: introduce fetch server command
      fetch-pack: perform a fetch using v2
      fetch-pack: support shallow requests
      connect: refactor git_connect to only get the protocol version once
      connect: don't request v2 when pushing
      transport-helper: remove name parameter
      transport-helper: refactor process_connect_service
      transport-helper: introduce stateless-connect
      pkt-line: add packet_buf_write_len function
      remote-curl: create copy of the service name
      remote-curl: store the protocol version the server responded with
      http: allow providing extra headers for http requests
      http: don't always add Git-Protocol header
      http: eliminate "# service" line when using protocol v2
      remote-curl: implement stateless-connect command
      remote-curl: don't request v2 when pushing
      commit: allow partial commits with relative paths
      serve: introduce the server-option capability
      ls-remote: send server options when using protocol v2
      fetch: send server options when using protocol v2
      refspec: move refspec parsing logic into its own file
      refspec: rename struct refspec to struct refspec_item
      refspec: factor out parsing a single refspec
      refspec: introduce struct refspec
      refspec: convert valid_fetch_refspec to use parse_refspec
      submodule--helper: convert push_check to use struct refspec
      pull: convert get_tracking_branch to use refspec_item_init
      transport: convert transport_push to use struct refspec
      remote: convert check_push_refs to use struct refspec
      remote: convert match_push_refs to use struct refspec
      clone: convert cmd_clone to use refspec_item_init
      fast-export: convert to use struct refspec
      remote: convert push refspecs to struct refspec
      remote: convert fetch refspecs to struct refspec
      remote: remove add_prune_tags_to_fetch_refspec
      transport-helper: convert to use struct refspec
      fetch: convert fetch_one to use struct refspec
      fetch: convert refmap to use struct refspec
      refspec: remove the deprecated functions
      fetch: convert do_fetch to take a struct refspec
      fetch: convert get_ref_map to take a struct refspec
      fetch: convert prune_refs to take a struct refspec
      remote: convert get_stale_heads to take a struct refspec
      remote: convert apply_refspecs to take a struct refspec
      remote: convert query_refspecs to take a struct refspec
      remote: convert get_ref_match to take a struct refspec
      remote: convert match_explicit_refs to take a struct refspec
      push: check for errors earlier
      push: convert to use struct refspec
      transport: convert transport_push to take a struct refspec
      send-pack: store refspecs in a struct refspec
      transport: remove transport_verify_remote_names
      http-push: store refspecs in a struct refspec
      remote: convert match_push_refs to take a struct refspec
      remote: convert check_push_refs to take a struct refspec
      submodule: convert push_unpushed_submodules to take a struct refspec
      refspec: consolidate ref-prefix generation logic
      fetch: generate ref-prefixes when using a configured refspec
      remote-curl: accept all encodings supported by curl
      remote-curl: accept compressed responses with protocol v2

Casey Fitzpatrick (3):
      submodule: clean up substitutions in script
      submodule: add --progress option to add command
      submodule: add --dissociate option to add/update commands

Changwoo Ryu (1):
      l10n: ko.po: Update Korean translation

Christian Couder (7):
      perf/aggregate: add display_dir()
      perf/aggregate: add --sort-by=regression option
      perf/run: add --subsection option
      t/perf: add scripts to bisect performance regressions
      perf/aggregate: use Getopt::Long for option parsing
      perf/bisect_run_script: disable codespeed
      t990X: use '.git/objects' as 'deep inside .git' path

Christian Hesse (2):
      perl: fix installing modules from contrib
      Makefile: mark perllibdir as a .PHONY target

Christopher Diaz Riveros (3):
      l10n: es.po: Spanish update for v2.18.0 round 1
      l10n: es.po: Spanish update for v2.18.0 round 2
      l10n: es.po: Spanish update for v2.18.0 round 3

Clemens Buchacher (2):
      git-gui: workaround ttk:style theme use
      completion: improve ls-files filter performance

Dan Jacques (3):
      Makefile: generate Perl header from template file
      Makefile: add Perl runtime prefix support
      exec_cmd: RUNTIME_PREFIX on some POSIX systems

David Turner (1):
      t: make many tests depend less on the refs being files

Derrick Stolee (20):
      packfile: define and use bsearch_pack()
      sha1_name: use bsearch_pack() for abbreviations
      csum-file: rename hashclose() to finalize_hashfile()
      csum-file: refactor finalize_hashfile() method
      commit-graph: add format document
      graph: add commit graph design document
      commit-graph: create git-commit-graph builtin
      commit-graph: implement write_commit_graph()
      commit-graph: implement git-commit-graph write
      commit-graph: implement git commit-graph read
      commit-graph: add core.commitGraph setting
      commit-graph: close under reachability
      commit: integrate commit graph with commit parsing
      commit-graph: read only from specific pack-indexes
      commit-graph: build graph from starting commits
      commit-graph: implement "--append" option
      treewide: rename tree to maybe_tree
      commit: create get_commit_tree() method
      treewide: replace maybe_tree with accessor methods
      commit-graph: lazy-load trees for commits

Drew DeVault (1):
      git-send-email: allow re-editing of message

Eckhard S. Maaß (1):
      wt-status: use settings from git_diff_ui_config

Elijah Newren (73):
      directory rename detection: basic testcases
      directory rename detection: directory splitting testcases
      directory rename detection: testcases to avoid taking detection too far
      directory rename detection: partially renamed directory testcase/discussion
      directory rename detection: files/directories in the way of some renames
      directory rename detection: testcases checking which side did the rename
      directory rename detection: more involved edge/corner testcases
      directory rename detection: testcases exploring possibly suboptimal merges
      directory rename detection: miscellaneous testcases to complete coverage
      directory rename detection: tests for handling overwriting untracked files
      directory rename detection: tests for handling overwriting dirty files
      merge-recursive: move the get_renames() function
      merge-recursive: introduce new functions to handle rename logic
      merge-recursive: fix leaks of allocated renames and diff_filepairs
      merge-recursive: make !o->detect_rename codepath more obvious
      merge-recursive: split out code for determining diff_filepairs
      merge-recursive: make a helper function for cleanup for handle_renames
      merge-recursive: add get_directory_renames()
      merge-recursive: check for directory level conflicts
      merge-recursive: add computation of collisions due to dir rename & merging
      merge-recursive: check for file level conflicts then get new name
      merge-recursive: when comparing files, don't include trees
      merge-recursive: apply necessary modifications for directory renames
      merge-recursive: avoid clobbering untracked files with directory renames
      merge-recursive: fix overwriting dirty files involved in renames
      merge-recursive: fix remaining directory rename + dirty overwrite cases
      directory rename detection: new testcases showcasing a pair of bugs
      merge-recursive: avoid spurious rename/rename conflict from dir renames
      merge-recursive: ensure we write updates for directory-renamed file
      Documentation: fix several one-character-off spelling errors
      Documentation: normalize spelling of 'normalised'
      directory rename detection: basic testcases
      directory rename detection: directory splitting testcases
      directory rename detection: testcases to avoid taking detection too far
      directory rename detection: partially renamed directory testcase/discussion
      directory rename detection: files/directories in the way of some renames
      directory rename detection: testcases checking which side did the rename
      directory rename detection: more involved edge/corner testcases
      directory rename detection: testcases exploring possibly suboptimal merges
      directory rename detection: miscellaneous testcases to complete coverage
      directory rename detection: tests for handling overwriting untracked files
      directory rename detection: tests for handling overwriting dirty files
      merge-recursive: move the get_renames() function
      merge-recursive: introduce new functions to handle rename logic
      merge-recursive: fix leaks of allocated renames and diff_filepairs
      merge-recursive: make !o->detect_rename codepath more obvious
      merge-recursive: split out code for determining diff_filepairs
      merge-recursive: make a helper function for cleanup for handle_renames
      Make running git under other debugger-like programs easy
      unpack_trees: fix breakage when o->src_index != o->dst_index
      merge-recursive: add get_directory_renames()
      merge-recursive: check for directory level conflicts
      merge-recursive: add computation of collisions due to dir rename & merging
      merge-recursive: check for file level conflicts then get new name
      merge-recursive: when comparing files, don't include trees
      merge-recursive: apply necessary modifications for directory renames
      merge-recursive: avoid clobbering untracked files with directory renames
      merge-recursive: fix overwriting dirty files involved in renames
      merge-recursive: fix remaining directory rename + dirty overwrite cases
      directory rename detection: new testcases showcasing a pair of bugs
      merge-recursive: avoid spurious rename/rename conflict from dir renames
      merge-recursive: improve add_cacheinfo error handling
      merge-recursive: move more is_dirty handling to merge_content
      merge-recursive: avoid triggering add_cacheinfo error with dirty mod
      t6046: testcases checking whether updates can be skipped in a merge
      merge-recursive: fix was_tracked() to quit lying with some renamed paths
      merge-recursive: fix remainder of was_dirty() to use original index
      merge-recursive: make "Auto-merging" comment show for other merges
      merge-recursive: fix check for skipability of working tree updates
      merge-recursive: provide pair of `unpack_trees_{start,finish}()`
      rev-parse: check lookup'ed commit references for NULL
      RelNotes: remove duplicate release note
      RelNotes 2.18: clarify where directory rename detection applies

Eric Sunshine (6):
      t3200: verify "branch --list" sanity when rebasing from detached HEAD
      t2028: tighten grep expression to make "move worktree" test more robust
      git-worktree.txt: recommend 'git worktree remove' over manual deletion
      git-worktree.txt: unify command-line prompt in example blocks
      configure.ac: fix botched FREAD_READS_DIRECTORIES check
      Makefile: make NO_ICONV really mean "no iconv"

Erik E Brady (1):
      credential: ignore SIGPIPE when writing to credential helpers

Florian Gamböck (1):
      completion: load completion file for external subcommand

Harald Nordgren (1):
      ls-remote: create '--sort' option

Jameson Miller (3):
      fast-import: rename mem_pool type to mp_block
      fast-import: introduce mem_pool type
      mem-pool: move reusable parts of memory pool into its own file

Jean-Noël Avila (2):
      l10n: fr.po v2.18 round 1
      l10n: fr.po v2.18.0 round 3

Jeff King (60):
      diff-highlight: correct test graph diagram
      diff-highlight: use test_tick in graph test
      diff-highlight: prefer "echo" to "cat" in tests
      diff-highlight: test interleaved parallel lines of history
      diff-highlight: test graphs with --color
      diff-highlight: use flush() helper consistently
      diff-highlight: detect --graph by indent
      set_git_dir: die when setenv() fails
      add chdir-notify API
      set_work_tree: use chdir_notify
      refs: use chdir_notify to update cached relative paths
      config: move flockfile() closer to unlocked functions
      t5561: drop curl stderr redirects
      t5561: skip tests if curl is not available
      ref-filter: use "struct object_id" consistently
      ref-filter: make ref_array_item allocation more consistent
      ref-filter: factor ref_array pushing into its own function
      t7004: fix mistaken tag name
      gpg-interface: handle bool user.signingkey
      gpg-interface: modernize function declarations
      gpg-interface: use size_t for signature buffer size
      gpg-interface: fix const-correctness of "eol" pointer
      gpg-interface: extract gpg line matching helper
      gpg-interface: find the last gpg signature line
      apply: clarify "-p" documentation
      pager: set COLUMNS to term_columns()
      mark_tree_contents_uninteresting(): drop missing object check
      mark_parents_uninteresting(): drop missing object check
      mark_parents_uninteresting(): replace list with stack
      mark_parents_uninteresting(): avoid most allocation
      get_main_ref_store: BUG() when outside a repository
      config: die when --blob is used outside a repository
      http: use strbufs instead of fixed buffers
      log_write_email_headers: use strbufs
      shorten_unambiguous_ref: use xsnprintf
      fmt_with_err: add a comment that truncation is OK
      submodule-config: verify submodule names as paths
      is_ntfs_dotgit: use a size_t for traversing string
      is_hfs_dotgit: match other .git files
      skip_prefix: add case-insensitive variant
      verify_path: drop clever fallthrough
      verify_dotfile: mention case-insensitivity in comment
      update-index: stat updated files earlier
      verify_path: disallow symlinks in .gitmodules
      index-pack: make fsck error message more specific
      fsck: simplify ".git" check
      fsck: actually fsck blob data
      fsck: detect gitmodules files
      fsck: handle promisor objects in .gitmodules check
      fsck: check .gitmodules content
      fsck: call fsck_finish() after fscking objects
      unpack-objects: call fsck_finish() after fscking objects
      index-pack: check .gitmodules files with --strict
      fsck: complain when .gitmodules is a symlink
      prepare_commit_graft: treat non-repository as a noop
      index-pack: handle --strict checks of non-repo packs
      t7415: don't bother creating commit for symlink test
      fsck: avoid looking at NULL blob->object
      ewah_read_mmap: bounds-check mmap reads
      ewah: adjust callers of ewah_read_mmap()

Jeremy Linton (1):
      packfile: correct zlib buffer handling

Jiang Xin (4):
      l10n: git.pot: v2.18.0 round 1 (108 new, 14 removed)
      l10n: git.pot: v2.18.0 round 2 (144 new, 6 removed)
      l10n: git.pot: v2.18.0 round 3 (1 new, 1 removed)
      l10n: zh_CN: for git v2.18.0 l10n round 1 to 3

Johannes Schindelin (69):
      git_config_set: fix off-by-two
      t1300: rename it to reflect that `repo-config` was deprecated
      t1300: demonstrate that --replace-all can "invent" newlines
      config --replace-all: avoid extra line breaks
      t1300: avoid relying on a bug
      t1300: remove unreasonable expectation from TODO
      t5404: relax overzealous test
      t1300: add a few more hairy examples of sections becoming empty
      t1300: `--unset-all` can leave an empty section behind (bug)
      config: introduce an optional event stream while parsing
      config: avoid using the global variable `store`
      config_set_store: rename some fields for consistency
      git_config_set: do not use a state machine
      git_config_set: make use of the config parser's event stream
      git config --unset: remove empty sections (in the common case)
      git_config_set: reuse empty sections
      exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
      mingw/msvc: use the new-style RUNTIME_PREFIX helper
      color: introduce support for colorizing stderr
      push: test to verify that push errors are colored
      config: document the settings to colorize push errors/hints
      gettext: avoid initialization if the locale dir is not present
      git_setup_gettext: plug memory leak
      sequencer: avoid using errno clobbered by rollback_lock_file()
      sequencer: make rearrange_squash() a bit more obvious
      sequencer: refactor how original todo list lines are accessed
      sequencer: offer helpful advice when a command was rescheduled
      sequencer: introduce new commands to reset the revision
      sequencer: introduce the `merge` command
      sequencer: fast-forward `merge` commands, if possible
      rebase-helper --make-script: introduce a flag to rebase merges
      rebase: introduce the --rebase-merges option
      sequencer: make refs generated by the `label` command worktree-local
      sequencer: handle post-rewrite for merge commands
      rebase --rebase-merges: avoid "empty merges"
      pull: accept --rebase=merges to recreate the branch topology
      rebase -i: introduce --rebase-merges=[no-]rebase-cousins
      rebase -i --rebase-merges: add a section to the man page
      argv_array: offer to split a string by whitespace
      commit: Let the callback of for_each_mergetag return on error
      replace: avoid using die() to indicate a bug
      tests: introduce test_unset_prereq, for debugging
      replace: "libify" create_graft() and callees
      replace: prepare create_graft() for converting graft files wholesale
      replace: introduce --convert-graft-file
      Add a test for `git replace --convert-graft-file`
      Deprecate support for .git/info/grafts
      filter-branch: stop suggesting to use grafts
      technical/shallow: stop referring to grafts
      technical/shallow: describe why shallow cannot use replace refs
      Remove obsolete script to convert grafts to replace refs
      rebase -i: demonstrate bugs with fixup!/squash! commit messages
      rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
      sequencer: always commit without editing when asked for
      rebase --skip: clean up commit message after a failed fixup/squash
      sequencer: extract helper to update active_cache_tree
      sequencer: allow introducing new root commits
      rebase --rebase-merges: a "merge" into a new root is a fast-forward
      sequencer: learn about the special "fake root commit" handling
      rebase --rebase-merges: root commits can be cousins, too
      rebase -i --root: let the sequencer handle even the initial part
      test-tool: help verifying BUG() code paths
      run-command: use BUG() to report bugs, not die()
      Replace all die("BUG: ...") calls by BUG() ones
      Convert remaining die*(BUG) messages
      config: a user-provided invalid section is not a BUG
      is_ntfs_dotgit: match other .git files
      is_{hfs,ntfs}_dotgitmodules: add tests
      rebase --root: fix amending root commit messages

Johannes Sixt (2):
      sequencer: reset the committer date before commits
      git: add -P as a short option for --no-pager

Jonathan Nieder (6):
      sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
      sha1_file: allow sha1_loose_object_info to handle arbitrary repositories
      Makefile: remove unused @@PERLLIBDIR@@ substitution variable
      Makefile: quote $INSTLIBDIR when passing it to sed
      packfile: add repository argument to packed_object_info
      fetch: do not pass ref-prefixes for fetch by exact SHA1

Jonathan Tan (5):
      grep: remove "repo" arg from non-supporting funcs
      upload-pack: fix error message typo
      upload-pack: read config when serving protocol v2
      {fetch,upload}-pack: support filter in protocol v2
      submodule: do not pass null OID to setup_revisions

Jordi Mas (1):
      l10n: Update Catalan translation

Junio C Hamano (27):
      stash: fix nonsense pipeline
      The first batch for 2.18 cycle
      The second batch for 2.18
      The third batch for 2.18
      Revert "Merge branch 'en/rename-directory-detection'"
      gc: do not upcase error message shown with die()
      parseopt: handle malformed --expire arguments more nicely
      The fourth batch for 2.18
      The fifth batch for 2.18
      argv-array: return the pushed string from argv_push*()
      Git 2.13.7
      Git 2.14.4
      Git 2.15.2
      Git 2.16.4
      Git 2.17.1
      The sixth batch for 2.18
      The seventh batch for 2.18
      Git 2.18-rc0
      refspec-api: avoid uninitialized field in refspec item
      A bit more topics before -rc1
      Git 2.18-rc1
      RelNotes 2.18: typofixes
      index-pack: correct install_packed_git() args
      Git 2.18-rc2
      A bunch of micro-fixes before going 2.18 final
      Almost 2.18 final
      Git 2.18

Kaartic Sivaraam (2):
      branch --list: print useful info whilst interactive rebasing a detached HEAD
      t3200: clarify description of --set-upstream test

Karthikeyan Singaravelan (1):
      doc: fix typos in documentation and release notes

Kyle Meyer (1):
      gitworkflows: fix grammar in 'Merge upwards' rule

Lars Schneider (10):
      strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
      strbuf: add xstrdup_toupper()
      strbuf: add a case insensitive starts_with()
      utf8: teach same_encoding() alternative UTF encoding names
      utf8: add function to detect prohibited UTF-16/32 BOM
      utf8: add function to detect a missing UTF-16/32 BOM
      convert: add 'working-tree-encoding' attribute
      convert: check for detectable errors in UTF encodings
      convert: add tracing for 'working-tree-encoding' attribute
      convert: add round trip check based on 'core.checkRoundtripEncoding'

Leif Middelschulte (2):
      merge-recursive: give notice when submodule commit gets fast-forwarded
      merge-submodule: reduce output verbosity

Loganaden Velvindron (1):
      http: allow use of TLS 1.3

Lucas Werkmeister (1):
      daemon.c: fix condition for redirecting stderr

Luis Marsano (2):
      git-credential-netrc: adapt to test framework for git
      git-credential-netrc: accept gpg option

Luke Diamand (7):
      git-p4: add unshelve command
      git-p4: disable-rebase: allow setting this via configuration
      git-p4: add option to disable syncing of p4/master with p4
      git-p4: better error reporting when p4 fails
      git-p4: raise exceptions from p4CmdList based on error from p4 server
      git-p4: narrow the scope of exceptions caught when parsing an int
      git-p4: auto-size the block

Martin Ågren (24):
      git-shortlog.txt: reorder usages
      shortlog: add usage-string for stdin-reading
      shortlog: disallow left-over arguments outside repo
      doc: convert \--option to --option
      doc: convert [\--] to [--]
      git-[short]log.txt: unify quoted standalone --
      git-submodule.txt: quote usage in monospace, drop backslash
      fast-export: fix regression skipping some merge-commits
      http-fetch: make `-a` standard behaviour
      walker: drop fields of `struct walker` which are always 1
      t/helper/test-write-cache: clean up lock-handling
      refs.c: do not die if locking fails in `write_pseudoref()`
      refs.c: do not die if locking fails in `delete_pseudoref()`
      lock_file: make function-local locks non-static
      lock_file: move static locks into functions
      refs.c: refer to "object ID", not "sha1", in error messages
      t1400: add tests around adding/deleting pseudorefs
      refs: handle zero oid for pseudorefs
      merge: setup `opts` later in `checkout_fast_forward()`
      config: free resources of `struct config_store_data`
      config: let `config_store_data_clear()` handle `value_regex`
      config: let `config_store_data_clear()` handle `key`
      regex: do not call `regfree()` if compilation fails
      unpack_trees_options: free messages when done

Meng-Sung Wu (1):
      doc: update the order of the syntax `git merge --continue`

Michal Nazarewicz (1):
      send-email: simplify Gmail example in the documentation

Michele Locati (1):
      filter-branch: return 2 when nothing to rewrite

Nguyễn Thái Ngọc Duy (108):
      repository: initialize the_repository in main()
      repository.c: move env-related setup code back to environment.c
      repository.c: delete dead functions
      sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
      repository: delete ignore_env member
      gc.txt: more details about what gc does
      worktree: delete dead code
      worktree prune: improve prune logic when worktree is moved
      repository.h: add comment and clarify repo_set_gitdir
      git.c: move cmd_struct declaration up
      git.c: add hidden option --list-parseopt-builtins
      completion: mention the oldest version we need to support
      completion: factor out _git_xxx calling code
      completion: add --option completion for most builtin commands
      completion: delete option-only completion commands
      completion: use __gitcomp_builtin in _git_ls_tree
      completion: use __gitcomp_builtin in _git_cherry
      packfile: keep prepare_packed_git() private
      t/helper: add an empty test-tool program
      t/helper: merge test-chmtime into test-tool
      t/helper: merge test-sha1 into test-tool
      t/helper: merge test-lazy-init-name-hash into test-tool
      t/helper: merge test-config into test-tool
      t/helper: merge test-ctype into test-tool
      t/helper: merge test-date into test-tool
      t/helper: merge (unused) test-delta into test-tool
      t/helper: merge test-drop-caches into test-tool
      t/helper: merge test-dump-cache-tree into test-tool
      t/helper: merge test-dump-split-index into test-tool
      t/helper: merge test-example-decorate into test-tool
      t/helper: merge test-genrandom into test-tool
      t/helper: merge test-hashmap into test-tool
      t/helper: merge test-index-version into test-tool
      t/helper: merge (unused) test-match-trees into test-tool
      t/helper: merge (unused) test-mergesort into test-tool
      t/helper: merge test-mktemp into test-tool
      t/helper: merge test-online-cpus into test-tool
      t/helper: merge test-path-utils into test-tool
      t/helper: merge test-prio-queue into test-tool
      t/helper: merge test-read-cache into test-tool
      t/helper: merge test-ref-store into test-tool
      t/helper: merge test-regex into test-tool
      t/helper: merge test-revision-walking into test-tool
      t/helper: merge test-run-command into test-tool
      t/helper: merge test-scrap-cache-tree into test-tool
      t/helper: merge test-sha1-array into test-tool
      t/helper: merge test-sigchain into test-tool
      t/helper: merge test-strcmp-offset into test-tool
      t/helper: merge test-string-list into test-tool
      t/helper: merge test-submodule-config into test-tool
      t/helper: merge test-subprocess into test-tool
      t/helper: merge test-urlmatch-normalization into test-tool
      t/helper: merge test-wildmatch into test-tool
      t/helper: merge test-write-cache into test-tool
      trace.c: export trace_setup_key
      read-cache.c: make $GIT_TEST_SPLIT_INDEX boolean
      pack-objects: a bit of document about struct object_entry
      pack-objects: turn type and in_pack_type to bitfields
      pack-objects: use bitfield for object_entry::dfs_state
      pack-objects: use bitfield for object_entry::depth
      pack-objects: move in_pack_pos out of struct object_entry
      pack-objects: move in_pack out of struct object_entry
      pack-objects: refer to delta objects by index instead of pointer
      pack-objects: shrink z_delta_size field in struct object_entry
      pack-objects: don't check size when the object is bad
      pack-objects: clarify the use of object_entry::size
      pack-objects: shrink size field in struct object_entry
      pack-objects: shrink delta_size field in struct object_entry
      pack-objects: reorder members to shrink struct object_entry
      ci: exercise the whole test suite with uncommon code in pack-objects
      t7700: have closing quote of a test at the beginning of line
      repack: add --keep-pack option
      gc: add --keep-largest-pack option
      gc: add gc.bigPackThreshold config
      gc: handle a corner case in gc.bigPackThreshold
      gc --auto: exclude base pack if not enough mem to "repack -ad"
      pack-objects: show some progress when counting kept objects
      connect.c: mark die_initial_contact() NORETURN
      Makefile: detect compiler and enable more warnings in DEVELOPER=1
      submodule--helper: don't print null in 'submodule status'
      doc: keep first level section header in upper case
      pack-objects: validation and documentation about unreachable options
      completion: fix misspelled config key aliasesfiletype
      repository: fix free problem with repo_clear(the_repository)
      generate-cmds.sh: factor out synopsis extract code
      generate-cmds.sh: export all commands to command-list.h
      help: use command-list.h for common command list
      Remove common-cmds.h
      pack-format.txt: more details on pack file format
      column: fix off-by-one default width
      commit.h: rearrange 'index' to shrink struct commit
      git.c: convert --list-* to --list-cmds=*
      git --list-cmds: collect command list in a string_list
      completion: implement and use --list-cmds=main,others
      git: support --list-cmds=list-<category>
      help: add "-a --verbose" to list all commands with synopsis
      help: use command-list.txt for the source of guides
      command-list.txt: documentation and guide line
      completion: let git provide the completable command list
      completion: reduce completable command list
      Move declaration for alias.c to alias.h
      completion: add and use --list-cmds=nohelpers
      completion: add and use --list-cmds=alias
      completion: allow to customize the completable command list
      travis-ci: run gcc-8 on linux-gcc jobs
      Use OPT_SET_INT_F() for cmdline option specification
      remote.txt: update documentation for 'update' command
      remote: doc typofix

Olga Telezhnaya (6):
      ref-filter: add shortcut to work with strbufs
      ref-filter: start adding strbufs with errors
      ref-filter: add return value && strbuf to handlers
      ref-filter: change parsing function error handling
      ref-filter: add return value to parsers
      ref-filter: libify get_ref_atom_value()

Orgad Shaneh (1):
      git-rebase--interactive: fix copy-paste mistake

Paul-Sebastian Ungureanu (2):
      parse-options: do not show usage upon invalid option value
      t/helper: 'test-chmtime (--get|-g)' to print only the mtime

Pedro Alvarez Piedehierro (1):
      import-tars: read overlong names from pax extended header

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (3470t0f0u)
      l10n: sv.po: Update Swedish translation (3608t0f0u)

Philip Oakley (1):
      Avoid multiple PREFIX definitions

Phillip Wood (7):
      rebase --root: stop assuming squash_onto is unset
      rebase -i --keep-empty: don't prune empty commits
      rebase: respect --no-keep-empty
      rebase: extend --signoff support
      rebase -p: error out if --signoff is given
      rebase --keep-empty: always use interactive rebase
      rebase --rebase-merges: add test for --keep-empty

Pratik Karki (1):
      test: avoid pipes in git related commands for test

Ralf Thielow (1):
      l10n: TEAMS: remove inactive de team members

Ramsay Jones (1):
      BUG_exit_code: fix sparse "symbol not declared" warning

René Scharfe (11):
      sha1_name: use bsearch_pack() in unique_in_pack()
      bisect: use oid_to_hex() for converting object_id hashes to hex strings
      run-command: use strbuf_addstr() for adding a string to a strbuf
      submodule: check for NULL return of get_submodule_ref_store()
      replace_object: use oidmap
      fast-export: avoid NULL pointer arithmetic
      t5512: run git fetch inside test
      fsmonitor: use internal argv_array of struct child_process
      merge-recursive: use xstrdup() instead of fixed buffer
      blame: release string_list after use in parse_color_fields()
      merge-recursive: use xstrdup() instead of fixed buffer

Robert P. J. Day (7):
      Use proper syntax for replaceables in command docs
      tag: clarify in the doc that a tag can refer to a non-commit object
      init: fix grammar in "templates not found" msg
      p4.txt: Use backquotes for variable names
      sha1-file.c: correct $GITDIR to $GIT_DIR in a comment
      diff-options.txt: fix minor typos, font inconsistencies, in docs
      Use hyphenated "remote-tracking branch" (docs and comments)

Romain Merland (1):
      git-p4: add options --commit and --disable-rebase

Ryan Dammrose (1):
      push: colorize errors

SZEDER Gábor (25):
      test_must_be_empty: simplify file existence check
      t9902-completion: add tests demonstrating issues with quoted pathnames
      completion: move __git_complete_index_file() next to its helpers
      completion: simplify prefix path component handling during path completion
      completion: support completing non-ASCII pathnames
      completion: improve handling quoted paths on the command line
      completion: let 'ls-files' and 'diff-index' filter matching paths
      completion: use 'awk' to strip trailing path components
      t9902-completion: ignore COMPREPLY element order in some tests
      completion: remove repeated dirnames with 'awk' during path completion
      completion: improve handling quoted paths in 'git ls-files's output
      completion: fill COMPREPLY directly when completing paths
      completion: reduce overhead of clearing cached --options
      docs/git-gc: fix minor rendering issue
      coccinelle: avoid wrong transformation suggestions from commit.cocci
      t6050-replace: don't disable stdin for the whole test script
      t5310-pack-bitmaps: make JGit tests work with GIT_TEST_SPLIT_INDEX
      t5516-fetch-push: fix 'push with dry-run' test
      t5516-fetch-push: fix broken &&-chain
      t7005-editor: get rid of the SPACES_IN_FILENAMES prereq
      completion: don't return with error from __gitcomp_file_direct()
      t9902-completion: exercise __git_complete_index_file() directly
      completion: correct zsh detection when run from git-completion.zsh
      t7406-submodule-update: fix broken &&-chains
      RelNotes 2.18: minor fix to entry about dynamically loading completions

Sergey Organov (1):
      glossary: substitute "ancestor" for "direct ancestor" in 'push' description.

Stefan Agner (1):
      send-email: avoid duplicate In-Reply-To/References

Stefan Beller (82):
      repository: introduce raw object store field
      object-store: migrate alternates struct and functions from cache.h
      object-store: move alt_odb_list and alt_odb_tail to object store
      object-store: free alt_odb_list
      object-store: move packed_git and packed_git_mru to object store
      object-store: close all packs upon clearing the object store
      pack: move prepare_packed_git_run_once to object store
      pack: move approximate object count to object store
      sha1_file: add raw_object_store argument to alt_odb_usable
      sha1_file: add repository argument to link_alt_odb_entry
      sha1_file: add repository argument to read_info_alternates
      sha1_file: add repository argument to link_alt_odb_entries
      sha1_file: add repository argument to prepare_alt_odb
      sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
      sha1_file: allow prepare_alt_odb to handle arbitrary repositories
      sha1_file: add repository argument to sha1_file_name
      sha1_file: add repository argument to stat_sha1_file
      sha1_file: add repository argument to open_sha1_file
      sha1_file: add repository argument to map_sha1_file_1
      sha1_file: add repository argument to map_sha1_file
      sha1_file: add repository argument to sha1_loose_object_info
      sha1_file: allow sha1_file_name to handle arbitrary repositories
      sha1_file: allow stat_sha1_file to handle arbitrary repositories
      sha1_file: allow open_sha1_file to handle arbitrary repositories
      sha1_file: allow map_sha1_file to handle arbitrary repositories
      packfile: allow prepare_packed_git_mru to handle arbitrary repositories
      packfile: allow rearrange_packed_git to handle arbitrary repositories
      packfile: allow install_packed_git to handle arbitrary repositories
      packfile: add repository argument to prepare_packed_git_one
      packfile: add repository argument to prepare_packed_git
      packfile: add repository argument to reprepare_packed_git
      packfile: allow prepare_packed_git_one to handle arbitrary repositories
      packfile: allow prepare_packed_git to handle arbitrary repositories
      packfile: allow reprepare_packed_git to handle arbitrary repositories
      packfile: add repository argument to find_pack_entry
      packfile: allow find_pack_entry to handle arbitrary repositories
      submodule.h: drop declaration of connect_work_tree_and_git_dir
      submodule-config: allow submodule_free to handle arbitrary repositories
      submodule-config: add repository argument to submodule_from_{name, path}
      submodule-config: remove submodule_from_cache
      submodule: fixup nested submodules after moving the submodule
      write_or_die.c: rename to use dashes in file name
      unicode_width.h: rename to use dash in file name
      exec_cmd: rename to use dash in file name
      sha1_name.c: rename to use dash in file name
      sha1_file.c: rename to use dash in file name
      replace_object.c: rename to use dash in file name
      replace-object: move replace_map to object store
      object-store: move lookup_replace_object to replace-object.h
      replace-object: eliminate replace objects prepared flag
      replace-object: check_replace_refs is safe in multi repo environment
      refs: add repository argument to get_main_ref_store
      refs: add repository argument to for_each_replace_ref
      replace-object: add repository argument to prepare_replace_object
      replace-object: add repository argument to do_lookup_replace_object
      replace-object: add repository argument to lookup_replace_object
      refs: store the main ref store inside the repository struct
      refs: allow for_each_replace_ref to handle arbitrary repositories
      replace-object: allow prepare_replace_object to handle arbitrary repositories
      replace-object: allow do_lookup_replace_object to handle arbitrary repositories
      replace-object: allow lookup_replace_object to handle arbitrary repositories
      worktree: accept -f as short for --force for removal
      builtin/blame: dim uninteresting metadata lines
      builtin/blame: highlight recently changed lines
      builtin/blame: add new coloring scheme config
      cache.h: add repository argument to oid_object_info_extended
      cache.h: add repository argument to oid_object_info
      packfile: add repository argument to retry_bad_packed_offset
      packfile: add repository argument to packed_to_object_type
      packfile: add repository argument to read_object
      packfile: add repository argument to unpack_entry
      packfile: add repository argument to cache_or_unpack_entry
      cache.h: allow oid_object_info to handle arbitrary repositories
      git-rebase--interactive: clarify arguments
      object.c: free replace map in raw_object_store_clear
      replace-object.c: remove the_repository from prepare_replace_object
      grep: handle corrupt index files early
      git-submodule.sh: try harder to fetch a submodule
      submodule.c: move submodule merging to merge-recursive.c
      merge-recursive: i18n submodule merge output and respect verbosity
      object.c: clear replace map before freeing it
      t7400: encapsulate setup code in test_expect_success

Takuto Ikuta (1):
      fetch-pack.c: use oidset to check existence of loose object

Tao Qingyun (1):
      t1510-repo-setup.sh: remove useless mkdir

Taylor Blau (5):
      builtin/config.c: treat type specifiers singularly
      builtin/config.c: support `--type=<type>` as preferred alias for `--<type>`
      builtin/config: introduce `--default`
      config.c: introduce 'git_config_color' to parse ANSI colors
      builtin/config: introduce `color` type specifier

Thomas Gummerer (12):
      stash push: avoid printing errors
      stash push -u: don't create empty stash
      stash: drop superfluos pathspec parameter
      SubmittingPatches: mention the git contacts command
      completion: stop showing 'save' for stash by default
      completion: make stash -p and alias for stash push -p
      worktree: remove extra members from struct add_opts
      worktree: improve message when creating a new worktree
      worktree: factor out dwim_branch function
      worktree: teach "add" to check out existing branches
      SubmittingPatches: replace numbered attributes with names
      note git-security@googlegroups.com in more places

Todd Zullinger (3):
      doc/clone: update caption for GIT URLS cross-reference
      rebase --root: demonstrate a bug while amending root commit messages
      t3404: check root commit in 'rebase -i --root reword root commit'

Torsten Bögershausen (1):
      test: correct detection of UTF8_NFD_TO_NFC for APFS

Trần Ngọc Quân (3):
      l10n: vi(3470t): Updated Vietnamese translation for v2.18.0
      l10n: vi.po(3608t): Update Vietnamese translation for v2.18.0 round2
      l10n: vi.po(3608t): Update Vietnamese translation for v2.18.0 round 3

Wink Saville (8):
      rebase-interactive: simplify pick_on_preserving_merges
      rebase: update invocation of rebase dot-sourced scripts
      rebase: reindent function git_rebase__interactive
      rebase: extract functions out of git_rebase__interactive
      rebase: add and use git_rebase__interactive__preserve_merges
      rebase: remove unused code paths from git_rebase__interactive
      rebase: remove unused code paths from git_rebase__interactive__preserve_merges
      rebase: remove merges_option and a blank line

Yuki Kokubun (1):
      filter-branch: fix errors caused by refs that point at non-committish

brian m. carlson (123):
      bulk-checkin: convert index_bulk_checkin to struct object_id
      builtin/write-tree: convert to struct object_id
      cache-tree: convert write_*_as_tree to object_id
      cache-tree: convert remnants to struct object_id
      resolve-undo: convert struct resolve_undo_info to object_id
      tree: convert read_tree_recursive to struct object_id
      ref-filter: convert grab_objectname to struct object_id
      strbuf: convert strbuf_add_unique_abbrev to use struct object_id
      wt-status: convert struct wt_status_state to object_id
      Convert find_unique_abbrev* to struct object_id
      http-walker: convert struct object_request to use struct object_id
      send-pack: convert remaining functions to struct object_id
      replace_object: convert struct replace_object to object_id
      builtin/mktag: convert to struct object_id
      archive: convert write_archive_entry_fn_t to object_id
      archive: convert sha1_file_to_archive to struct object_id
      builtin/index-pack: convert struct ref_delta_entry to object_id
      sha1_file: convert read_loose_object to use struct object_id
      sha1_file: convert check_sha1_signature to struct object_id
      streaming: convert open_istream to use struct object_id
      builtin/mktree: convert to struct object_id
      sha1_file: convert assert_sha1_type to object_id
      sha1_file: convert retry_bad_packed_offset to struct object_id
      packfile: convert unpack_entry to struct object_id
      Convert remaining callers of sha1_object_info_extended to object_id
      sha1_file: convert sha1_object_info* to object_id
      builtin/fmt-merge-msg: convert remaining code to object_id
      builtin/notes: convert static functions to object_id
      tree-walk: convert get_tree_entry_follow_symlinks internals to object_id
      streaming: convert istream internals to struct object_id
      tree-walk: convert tree entry functions to object_id
      sha1_file: convert read_object_with_reference to object_id
      sha1_file: convert read_sha1_file to struct object_id
      Convert lookup_replace_object to struct object_id
      sha1_file: introduce a constant for max header length
      convert: convert to struct object_id
      sha1_name: convert struct min_abbrev_data to object_id
      t1011: abstract away SHA-1-specific constants
      t1304: abstract away SHA-1-specific constants
      t1300: abstract away SHA-1-specific constants
      t1405: sort reflog entries in a hash-independent way
      t1411: abstract away SHA-1-specific constants
      t1507: abstract away SHA-1-specific constants
      t2020: abstract away SHA-1 specific constants
      t2101: modernize test style
      t2101: abstract away SHA-1-specific constants
      t2107: abstract away SHA-1-specific constants
      format-patch: make cover letters always text/plain
      cache: add a function to read an object ID from a buffer
      server-info: remove unused members from struct pack_info
      Remove unused member in struct object_context
      packfile: remove unused member from struct pack_entry
      packfile: convert has_sha1_pack to object_id
      sha1-file: convert freshen functions to object_id
      packfile: convert find_pack_entry to object_id
      packfile: abstract away hash constant values
      pack-objects: abstract away hash algorithm
      pack-redundant: abstract away hash algorithm
      tree-walk: avoid hard-coded 20 constant
      tree-walk: convert get_tree_entry_follow_symlinks to object_id
      fsck: convert static functions to struct object_id
      submodule-config: convert structures to object_id
      split-index: convert struct split_index to object_id
      Update struct index_state to use struct object_id
      pack-redundant: convert linked lists to use struct object_id
      index-pack: abstract away hash function constant
      commit: convert uses of get_sha1_hex to get_oid_hex
      dir: convert struct untracked_cache_dir to object_id
      http: eliminate hard-coded constants
      revision: replace use of hard-coded constants
      upload-pack: replace use of several hard-coded constants
      diff: specify abbreviation size in terms of the_hash_algo
      builtin/receive-pack: avoid hard-coded constants for push certs
      sha1-file: add functions for hex empty tree and blob OIDs
      builtin/am: convert uses of EMPTY_TREE_SHA1_BIN to the_hash_algo
      builtin/merge: switch tree functions to use object_id
      merge: convert empty tree constant to the_hash_algo
      sequencer: convert one use of EMPTY_TREE_SHA1_HEX
      submodule: convert several uses of EMPTY_TREE_SHA1_HEX
      wt-status: convert two uses of EMPTY_TREE_SHA1_HEX
      builtin/receive-pack: convert one use of EMPTY_TREE_SHA1_HEX
      builtin/reset: convert use of EMPTY_TREE_SHA1_BIN
      sha1_file: convert cached object code to struct object_id
      cache-tree: use is_empty_tree_oid
      sequencer: use the_hash_algo for empty tree object ID
      dir: use the_hash_algo for empty blob object ID
      sha1_file: only expose empty object constants through git_hash_algo
      Update shell scripts to compute empty tree object ID
      add--interactive: compute the empty tree value
      merge-one-file: compute empty blob object ID
      Documentation: use 8-space tabs with Asciidoctor
      Documentation: render revisions correctly under Asciidoctor
      mailmap: update brian m. carlson's email address
      t/test-lib: add an SHA1 prerequisite
      t/test-lib: introduce ZERO_OID
      t: switch $_z40 to $ZERO_OID
      t/test-lib: introduce OID_REGEX
      t: switch $_x40 to $OID_REGEX
      t0000: annotate with SHA1 prerequisite
      t1007: annotate with SHA1 prerequisite
      t1512: skip test if not using SHA-1
      t4044: skip test if not using SHA-1
      t: skip pack tests if not using SHA-1
      t2203: abstract away SHA-1-specific constants
      t3103: abstract away SHA-1-specific constants
      t3702: abstract away SHA-1-specific constants
      t3905: abstract away SHA-1-specific constants
      t4007: abstract away SHA-1-specific constants
      t4008: abstract away SHA-1-specific constants
      t4014: abstract away SHA-1-specific constants
      t4020: abstract away SHA-1-specific constants
      t4022: abstract away SHA-1-specific constants
      t4029: fix test indentation
      t4029: abstract away SHA-1-specific constants
      t4030: abstract away SHA-1-specific constants
      t/lib-diff-alternative: abstract away SHA-1-specific constants
      t4205: sort log output in a hash-independent way
      t4042: abstract away SHA-1-specific constants
      t4045: abstract away SHA-1-specific constants
      t4208: abstract away SHA-1-specific constants
      t5300: abstract away SHA-1-specific constants
      sequencer: ensure labels that are object IDs are rewritten
      t3430: test clean-up

Ævar Arnfjörð Bjarmason (22):
      configure: fix a regression in PCRE v1 detection
      configure: detect redundant --with-libpcre & --with-libpcre1
      Makefile: make USE_LIBPCRE=YesPlease mean v2, not v1
      Makefile: fix broken bindir_relative variable
      Makefile: add a gitexecdir_relative variable
      Makefile: optionally symlink libexec/git-core binaries to bin/git
      Remove contrib/examples/*
      doc hash-function-transition: clarify how older gits die on NewHash
      doc hash-function-transition: clarify what SHAttered means
      git-svn: avoid warning on undef readline()
      Makefile: add a DEVOPTS to suppress -Werror under DEVELOPER
      Makefile: add a DEVOPTS to get all of -Wextra
      git{,-blame}.el: remove old bitrotting Emacs code
      .gitattributes: add *.pl extension for Perl
      .gitattributes: use the "perl" differ for Perl
      .gitattributes: add a diff driver for Python
      sha1-name.c: remove stray newline
      sha1-array.h: align function arguments
      git-p4: change "commitish" typo to "committish"
      sha1-name.c: move around the collect_ambiguous() function
      get_short_oid: sort ambiguous objects by type, then SHA-1
      git-credential-netrc: remove use of "autodie"

