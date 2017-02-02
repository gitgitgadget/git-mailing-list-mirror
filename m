Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01701F9AF
	for <e@80x24.org>; Thu,  2 Feb 2017 23:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbdBBXF0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 18:05:26 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34722 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbdBBXFY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 18:05:24 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so211658pgv.1;
        Thu, 02 Feb 2017 15:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=w7/6a/VifniKWCbtKb4PvsKP16Q0ndKLeEK9z2KeiaA=;
        b=DLYuHAkCj/F4q100zXpNdmTEmGd6CjV4ycqrUdneteBlmnOypFfZWVjI5vDQGjgnZJ
         7zGAYWZzdkpZg/fwcKE6dLR2d4lhvAEC1a8CQsZYEOf3RJ8PTGbIDn4yAqThK/7zr8Y7
         BP3zFXiRytMqKI49OArh+uswY3WLGoJ18mzSJcU1Mnw/1uRniVVSspGrVNo4cXHKDn2j
         r8M9/NEQJ79qKhlycjJm/AK2g0pr4aH3GBQc2234moW/UxM88pipLQ3YFx3fJEsVY6fz
         Eic4hwRqpSB2Vwhfut7+WMfdhYOcn+0Im9fPw1YnCiCujApEifzyuAOpo5BMGzRDnrXY
         /I/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=w7/6a/VifniKWCbtKb4PvsKP16Q0ndKLeEK9z2KeiaA=;
        b=a47RxcmYAUpbisbpduOHGwM0/bz9dwW2Ve3fgZuWtoAF05tvjPhzGjjm6QCiZ9EdAJ
         Sl25gakfn1zXQlCByIpfEXCfchx0EfZ9utdBDo01ZaYc0iAjC7SrpxfYKlYp7VKL2jAQ
         mptU/yNtpezt4aqE4pXKJnbJ+0fWU006g16dctLGLPjUzPrbBh4pRKwEPtYojXATBLjh
         uYRJbg+IfgZ6iAwtmX+dSf2+IPexMGw3b19ynAt2Qq2AnI8nB+f1W+pzk4USmw8bkjRB
         e5ijbvytNTlvE1AtR5WNiO1ynYS+neS8drD2uOIhAJ/cqOH7J4VhNB4+0uNmGDUYmCbZ
         U/gA==
X-Gm-Message-State: AIkVDXIIHVUMnHqnTUgw+SQCXk6oOTs8T9jYMr+4MbsfvABPH2vpxjo+bG9/Gs6WVQeIRQ==
X-Received: by 10.84.133.163 with SMTP id f32mr16145221plf.64.1486076723492;
        Thu, 02 Feb 2017 15:05:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:358d:de5e:fbec:baab])
        by smtp.gmail.com with ESMTPSA id b83sm61177534pfe.12.2017.02.02.15.05.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 15:05:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.11.1
Date:   Thu, 02 Feb 2017 15:05:21 -0800
Message-ID: <xmqq8tpory6m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.11.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.11.1'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.11.1 Release Notes
=========================

Fixes since v2.11
-----------------

 * The default Travis-CI configuration specifies newer P4 and GitLFS.

 * The character width table has been updated to match Unicode 9.0

 * Update the isatty() emulation for Windows by updating the previous
   hack that depended on internals of (older) MSVC runtime.

 * "git rev-parse --symbolic" failed with a more recent notation like
   "HEAD^-1" and "HEAD^!".

 * An empty directory in a working tree that can simply be nuked used
   to interfere while merging or cherry-picking a change to create a
   submodule directory there, which has been fixed..

 * The code in "git push" to compute if any commit being pushed in the
   superproject binds a commit in a submodule that hasn't been pushed
   out was overly inefficient, making it unusable even for a small
   project that does not have any submodule but have a reasonable
   number of refs.

 * "git push --dry-run --recurse-submodule=on-demand" wasn't
   "--dry-run" in the submodules.

 * The output from "git worktree list" was made in readdir() order,
   and was unstable.

 * mergetool.<tool>.trustExitCode configuration variable did not apply
   to built-in tools, but now it does.

 * "git p4" LFS support was broken when LFS stores an empty blob.

 * Fix a corner case in merge-recursive regression that crept in
   during 2.10 development cycle.

 * Update the error messages from the dumb-http client when it fails
   to obtain loose objects; we used to give sensible error message
   only upon 404 but we now forbid unexpected redirects that needs to
   be reported with something sensible.

 * When diff.renames configuration is on (and with Git 2.9 and later,
   it is enabled by default, which made it worse), "git stash"
   misbehaved if a file is removed and another file with a very
   similar content is added.

 * "git diff --no-index" did not take "--no-abbrev" option.

 * "git difftool --dir-diff" had a minor regression when started from
   a subdirectory, which has been fixed.

 * "git commit --allow-empty --only" (no pathspec) with dirty index
   ought to be an acceptable way to create a new commit that does not
   change any paths, but it was forbidden, perhaps because nobody
   needed it so far.

 * A pathname that begins with "//" or "\\" on Windows is special but
   path normalization logic was unaware of it.

 * "git pull --rebase", when there is no new commits on our side since
   we forked from the upstream, should be able to fast-forward without
   invoking "git rebase", but it didn't.

 * The way to specify hotkeys to "xxdiff" that is used by "git
   mergetool" has been modernized to match recent versions of xxdiff.

 * Unlike "git am --abort", "git cherry-pick --abort" moved HEAD back
   to where cherry-pick started while picking multiple changes, when
   the cherry-pick stopped to ask for help from the user, and the user
   did "git reset --hard" to a different commit in order to re-attempt
   the operation.

 * Code cleanup in shallow boundary computation.

 * A recent update to receive-pack to make it easier to drop garbage
   objects made it clear that GIT_ALTERNATE_OBJECT_DIRECTORIES cannot
   have a pathname with a colon in it (no surprise!), and this in turn
   made it impossible to push into a repository at such a path.  This
   has been fixed by introducing a quoting mechanism used when
   appending such a path to the colon-separated list.

 * The function usage_msg_opt() has been updated to say "fatal:"
   before the custom message programs give, when they want to die
   with a message about wrong command line options followed by the
   standard usage string.

 * "git index-pack --stdin" needs an access to an existing repository,
   but "git index-pack file.pack" to generate an .idx file that
   corresponds to a packfile does not.

 * Fix for NDEBUG builds.

 * A lazy "git push" without refspec did not internally use a fully
   specified refspec to perform 'current', 'simple', or 'upstream'
   push, causing unnecessary "ambiguous ref" errors.

 * "git p4" misbehaved when swapping a directory and a symbolic link.

 * Even though an fix was attempted in Git 2.9.3 days, but running
   "git difftool --dir-diff" from a subdirectory never worked. This
   has been fixed.

 * "git p4" that tracks multile p4 paths imported a single changelist
   that touches files in these multiple paths as one commit, followed
   by many empty commits.  This has been fixed.

 * A potential but unlikely buffer overflow in Windows port has been
   fixed.

 * When the http server gives an incomplete response to a smart-http
   rpc call, it could lead to client waiting for a full response that
   will never come.  Teach the client side to notice this condition
   and abort the transfer.

 * Some platforms no longer understand "latin-1" that is still seen in
   the wild in e-mail headers; replace them with "iso-8859-1" that is
   more widely known when conversion fails from/to it.

 * Update the procedure to generate "tags" for developer support.

 * Update the definition of the MacOSX test environment used by
   TravisCI.

 * A few git-svn updates.

 * Compression setting for producing packfiles were spread across
   three codepaths, one of which did not honor any configuration.
   Unify these so that all of them honor core.compression and
   pack.compression variables the same way.

 * "git fast-import" sometimes mishandled while rebalancing notes
   tree, which has been fixed.

 * Recent update to the default abbreviation length that auto-scales
   lacked documentation update, which has been corrected.

 * Leakage of lockfiles in the config subsystem has been fixed.

 * It is natural that "git gc --auto" may not attempt to pack
   everything into a single pack, and there is no point in warning
   when the user has configured the system to use the pack bitmap,
   leading to disabling further "gc".

 * "git archive" did not read the standard configuration files, and
   failed to notice a file that is marked as binary via the userdiff
   driver configuration.

 * "git blame --porcelain" misidentified the "previous" <commit, path>
   pair (aka "source") when contents came from two or more files.

 * "git rebase -i" with a recent update started showing an incorrect
   count when squashing more than 10 commits.

 * "git <cmd> @{push}" on a detached HEAD used to segfault; it has
   been corrected to error out with a message.

 * Tighten a test to avoid mistaking an extended ERE regexp engine as
   a PRE regexp engine.

 * Typing ^C to pager, which usually does not kill it, killed Git and
   took the pager down as a collateral damage in certain process-tree
   structure.  This has been fixed.

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.11.0 are as follows:

Alan Davies (1):
      mingw: fix colourization on Cygwin pseudo terminals

Andreas Krey (2):
      commit: make --only --allow-empty work without paths
      commit: remove 'Clever' message for --only --amend

Beat Bolli (6):
      update_unicode.sh: move it into contrib/update-unicode
      update_unicode.sh: remove an unnecessary subshell level
      update_unicode.sh: pin the uniset repo to a known good commit
      update_unicode.sh: automatically download newer definition files
      update_unicode.sh: remove the plane filter
      unicode_width.h: update the width tables to Unicode 9.0

Brandon Williams (2):
      push: --dry-run updates submodules when --recurse-submodules=on-demand
      push: fix --dry-run to not push submodules

Christian Couder (1):
      Documentation/bisect: improve on (bad|new) and (good|bad)

David Aguilar (8):
      mergetool: honor mergetool.$tool.trustExitCode for built-in tools
      mergetools/vimdiff: trust Vim's exit code
      difftool: fix dir-diff index creation when in a subdirectory
      difftool: fix dir-diff index creation when in a subdirectory
      difftool: sanitize $workdir as early as possible
      difftool: chdir as early as possible
      difftool: rename variables for consistency
      mergetools: fix xxdiff hotkeys

David Turner (5):
      submodules: allow empty working-tree dirs in merge/cherry-pick
      remote-curl: don't hang when a server dies before any output
      upload-pack: optionally allow fetching any sha1
      auto gc: don't write bitmaps for incremental repacks
      repack: die on incremental + write-bitmap-index

Dennis Kaarsemaker (1):
      push: test pushing ambiguously named branches

Eric Wong (2):
      git-svn: allow "0" in SVN path components
      git-svn: document useLogAuthor and addAuthorFrom config keys

George Vanburgh (1):
      git-p4: fix multi-path changelist empty commits

Heiko Voigt (4):
      serialize collection of changed submodules
      serialize collection of refs that contain submodule changes
      batch check whether submodule needs pushing into one call
      submodule_needs_pushing(): explain the behaviour when we cannot answer

Jack Bates (1):
      diff: handle --no-abbrev in no-index case

Jeff Hostetler (1):
      mingw: replace isatty() hack

Jeff King (32):
      rev-parse: fix parent shorthands with --symbolic
      t7610: clean up foo.XXXXXX tmpdir
      http: simplify update_url_from_redirect
      http: always update the base URL for redirects
      remote-curl: rename shadowed options variable
      http: make redirects more obvious
      http: treat http-alternates like redirects
      http-walker: complain about non-404 loose object errors
      stash: prefer plumbing over git-diff
      alternates: accept double-quoted paths
      tmp-objdir: quote paths we add to alternates
      Makefile: reformat FIND_SOURCE_FILES
      Makefile: exclude test cruft from FIND_SOURCE_FILES
      Makefile: match shell scripts in FIND_SOURCE_FILES
      Makefile: exclude contrib from FIND_SOURCE_FILES
      parse-options: print "fatal:" before usage_msg_opt()
      README: replace gmane link with public-inbox
      t5000: extract nongit function to test-lib-functions.sh
      index-pack: complain when --stdin is used outside of a repo
      t: use nongit() function where applicable
      index-pack: skip collision check when not in repository
      archive-zip: load userdiff config
      rebase--interactive: count squash commits above 10 correctly
      blame: fix alignment with --abbrev=40
      blame: handle --no-abbrev
      blame: output porcelain "previous" header for each file
      git_exec_path: do not return the result of getenv()
      execv_dashed_external: use child_process struct
      execv_dashed_external: stop exiting with negative code
      execv_dashed_external: wait for child on signal death
      t7810: avoid assumption about invalid regex syntax
      CodingGuidelines: clarify multi-line brace style

Johannes Schindelin (6):
      cherry-pick: demonstrate a segmentation fault
      merge-recursive: handle NULL in add_cacheinfo() correctly
      mingw: intercept isatty() to handle /dev/null as Git expects it
      mingw: adjust is_console() to work with stdin
      git_exec_path: avoid Coverity warning about unfree()d result
      mingw: follow-up to "replace isatty() hack"

Johannes Sixt (3):
      t5547-push-quarantine: run the path separator test on Windows, too
      normalize_path_copy(): fix pushing to //server/share/dir on Windows
      t5615-alternate-env: double-quotes in file names do not work on Windows

Jonathan Tan (1):
      fetch: do not redundantly calculate tag refmap

Junio C Hamano (11):
      utf8: refactor code to decide fallback encoding
      utf8: accept "latin-1" as ISO-8859-1
      push: do not use potentially ambiguous default refspec
      compression: unify pack.compression configuration parsing
      pull: fast-forward "pull --rebase=true"
      preparing for 2.10.3
      Revert "sequencer: remove useless get_dir() function"
      config.abbrev: document the new default that auto-scales
      Almost ready for 2.11.1
      Ready for 2.11.1
      Git 2.11.1

Kristoffer Haugsbakk (4):
      doc: add articles (grammar)
      doc: add verb in front of command to run
      doc: make the intent of sentence clearer
      doc: omit needless "for"

Kyle J. McKay (1):
      mailinfo.c: move side-effects outside of assert

Kyle Meyer (1):
      branch_get_push: do not segfault when HEAD is detached

Lars Schneider (6):
      travis-ci: update P4 to 16.2 and GitLFS to 1.5.2 in Linux build
      git-p4: fix empty file processing for large file system backend GitLFS
      t0021: minor filter process test cleanup
      docs: warn about possible '=' in clean/smudge filter process values
      t0021: fix flaky test
      travis-ci: fix Perforce install on macOS

Luis Ressel (1):
      date-formats.txt: Typo fix

Luke Diamand (1):
      git-p4: avoid crash adding symlinked directory

Matt McCutchen (2):
      doc: mention transfer data leaks in more places
      git-gc.txt: expand discussion of races with other processes

Max Kirillov (1):
      mingw: consider that UNICODE_STRING::Length counts bytes

Mike Hommey (1):
      fast-import: properly fanout notes when tree is imported

Nguyễn Thái Ngọc Duy (13):
      worktree.c: zero new 'struct worktree' on allocation
      worktree: reorder an if statement
      get_worktrees() must return main worktree as first item even on error
      worktree.c: get_worktrees() takes a new flag argument
      worktree list: keep the list sorted
      merge-recursive.c: use string_list_sort instead of qsort
      shallow.c: rename fields in paint_info to better express their purposes
      shallow.c: stop abusing COMMIT_SLAB_SIZE for paint_info's memory pools
      shallow.c: make paint_alloc slightly more robust
      shallow.c: remove useless code
      config.c: handle error case for fstat() calls
      config.c: rename label unlock_and_out
      config.c: handle lock file in error case in git_config_rename_...

Rasmus Villemoes (2):
      shallow.c: avoid theoretical pointer wrap-around
      shallow.c: bit manipulation tweaks

Stefan Beller (7):
      unpack-trees: fix grammar for untracked files in directories
      t3600: remove useless redirect
      t3600: slightly modernize style
      cache.h: document index_name_pos
      cache.h: document remove_index_entry_at
      cache.h: document add_[file_]to_index
      documentation: retire unfinished documentation

Stephan Beyer (5):
      am: fix filename in safe_to_abort() error message
      am: change safe_to_abort()'s not rewinding error into a warning
      t3510: test that cherry-pick --abort does not unsafely change HEAD
      sequencer: make sequencer abort safer
      sequencer: remove useless get_dir() function

Torsten Bögershausen (1):
      convert: git cherry-pick -Xrenormalize did not work

Wolfram Sang (1):
      request-pull: drop old USAGE stuff

