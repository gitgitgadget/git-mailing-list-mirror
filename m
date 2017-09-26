Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A68D20A3C
	for <e@80x24.org>; Tue, 26 Sep 2017 06:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754154AbdIZGJj (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 02:09:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36708 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdIZGJg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 02:09:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id f84so4618869pfj.3;
        Mon, 25 Sep 2017 23:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=q5+rmcqqGGr0Dkf8gU23w840E6JdAbOcwj7ZQanUK94=;
        b=D7oFLybuk4hMRBgwmFURqE66f8Rr0mulKajDzxm9J2D2W9kTgj7177j85hpAep/49q
         RIepXIIVWMFiYOW8cEFPfPK0VjrunMcmgfFX70bXz3RU96ZPmrbd3a08Wfm0AQPD7UKh
         jW9AoSkVP1kM796544Fe3gfRoHGd7sPsKQYGmzwpQ89MmWVuoMsjqiaKJPy3ejbNU7eb
         GO/gl62ZrLdOnr4PM1hwA+x2tg7eQZrYDIHXgjuslt4tJDjx6p9soZfC/fD8HhQimqsO
         t1zs2fhUyllpcdAlO7rtLmtrUn9veG8Syc566ljFIOeX7nOmoxM62XfRpQG6H3zQ8jd5
         phxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=q5+rmcqqGGr0Dkf8gU23w840E6JdAbOcwj7ZQanUK94=;
        b=KLUPi3IYMyl/b30zve0FNleK+eQbmoADyskhmrxhDLNo9Hz3oYsFCkILK/ecSKJvvQ
         l0KYC8/Jn/V1cj9IMyrgANtGRQMKQo9I0TzsxRhKagSaVqg1p/tQY75UyLZmWS0RD2N8
         A9Z9FXr3gGEwoSQtXh+dFlSqcMTq5MkHM7j39D7omTsG2jVERwTSR1cOyzmDOWYVKY7s
         8XcaQ5FLHQDStrspGC4z2eXTJb3l+ap6waRqidnEobrL0Ga2Cna0lnPFxYTvzZR0BK8T
         mR/Vazz8JwwGcDP61YF0uePeZx7Q2yGx54cdE16qudHo7dgDvq+/dCHx8BwnH/9imWtb
         64HA==
X-Gm-Message-State: AHPjjUh50fLUKbl/Ou2WOshJ3qLYl7XrbsY4yvcqkNTebeIlfYmzl9K7
        q+rCnuW+DZJlKAkaYHqh7wntp++Y
X-Google-Smtp-Source: AOwi7QA1TINGlmOLWVp8GVIQDhswrpkjFwo29bpUFwxmGKuEC0MdFcr6MCBgtUUhzyljZSws3AgHPw==
X-Received: by 10.99.96.133 with SMTP id u127mr10038187pgb.237.1506406175289;
        Mon, 25 Sep 2017 23:09:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id m87sm13436816pfi.122.2017.09.25.23.09.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 23:09:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.14.2
Date:   Tue, 26 Sep 2017 15:09:34 +0900
Message-ID: <xmqqwp4m9ejl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.14.2 is now available at the
usual places.  In addition to the cvsserver related fixes that
appear in 2.10.5, 2.11.4, 2.12.5 and 2.13.6 announced separately,
this also includes various fixes that were merged already to the
'master' branch.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.14.2'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.14.2 Release Notes
=========================

Fixes since v2.14.1
-------------------

 * Because recent Git for Windows do come with a real msgfmt, the
   build procedure for git-gui has been updated to use it instead of a
   hand-rolled substitute.

 * "%C(color name)" in the pretty print format always produced ANSI
   color escape codes, which was an early design mistake.  They now
   honor the configuration (e.g. "color.ui = never") and also tty-ness
   of the output medium.

 * The http.{sslkey,sslCert} configuration variables are to be
   interpreted as a pathname that honors "~[username]/" prefix, but
   weren't, which has been fixed.

 * Numerous bugs in walking of reflogs via "log -g" and friends have
   been fixed.

 * "git commit" when seeing an totally empty message said "you did not
   edit the message", which is clearly wrong.  The message has been
   corrected.

 * When a directory is not readable, "gitweb" fails to build the
   project list.  Work this around by skipping such a directory.

 * A recently added test for the "credential-cache" helper revealed
   that EOF detection done around the time the connection to the cache
   daemon is torn down were flaky.  This was fixed by reacting to
   ECONNRESET and behaving as if we got an EOF.

 * Some versions of GnuPG fail to kill gpg-agent it auto-spawned
   and such a left-over agent can interfere with a test.  Work it
   around by attempting to kill one before starting a new test.

 * "git log --tag=no-such-tag" showed log starting from HEAD, which
   has been fixed---it now shows nothing.

 * The "tag.pager" configuration variable was useless for those who
   actually create tag objects, as it interfered with the use of an
   editor.  A new mechanism has been introduced for commands to enable
   pager depending on what operation is being carried out to fix this,
   and then "git tag -l" is made to run pager by default.

 * "git push --recurse-submodules $there HEAD:$target" was not
   propagated down to the submodules, but now it is.

 * Commands like "git rebase" accepted the --rerere-autoupdate option
   from the command line, but did not always use it.  This has been
   fixed.

 * "git clone --recurse-submodules --quiet" did not pass the quiet
   option down to submodules.

 * "git am -s" has been taught that some input may end with a trailer
   block that is not Signed-off-by: and it should refrain from adding
   an extra blank line before adding a new sign-off in such a case.

 * "git svn" used with "--localtime" option did not compute the tz
   offset for the timestamp in question and instead always used the
   current time, which has been corrected.

 * Memory leaks in a few error codepaths have been plugged.

 * bash 4.4 or newer gave a warning on NUL byte in command
   substitution done in "git stash"; this has been squelched.

 * "git grep -L" and "git grep --quiet -L" reported different exit
   codes; this has been corrected.

 * When handshake with a subprocess filter notices that the process
   asked for an unknown capability, Git did not report what program
   the offending subprocess was running.  This has been corrected.

 * "git apply" that is used as a better "patch -p1" failed to apply a
   taken from a file with CRLF line endings to a file with CRLF line
   endings.  The root cause was because it misused convert_to_git()
   that tried to do "safe-crlf" processing by looking at the index
   entry at the same path, which is a nonsense---in that mode, "apply"
   is not working on the data in (or derived from) the index at all.
   This has been fixed.

 * Killing "git merge --edit" before the editor returns control left
   the repository in a state with MERGE_MSG but without MERGE_HEAD,
   which incorrectly tells the subsequent "git commit" that there was
   a squash merge in progress.  This has been fixed.

 * "git archive" did not work well with pathspecs and the
   export-ignore attribute.

 * "git cvsserver" no longer is invoked by "git shell" by default,
   as it is old and largely unmaintained.

 * Various Perl scripts did not use safe_pipe_capture() instead of
   backticks, leaving them susceptible to end-user input.  They have
   been corrected.

Also contains various documentation updates and code clean-ups.

Credits go to joernchen <joernchen@phenoelit.de> for finding the
unsafe constructs in "git cvsserver", and to Jeff King at GitHub for
finding and fixing instances of the same issue in other scripts.

----------------------------------------------------------------

Changes since v2.14.1 are as follows:

Andreas Heiduk (2):
      doc: add missing values "none" and "default" for diff.wsErrorHighlight
      doc: clarify "config --bool" behaviour with empty string

Anthony Sottile (1):
      git-grep: correct exit code with --quiet and -L

Brandon Williams (2):
      submodule--helper: teach push-check to handle HEAD
      clone: teach recursive clones to respect -q

Christian Couder (2):
      refs: use skip_prefix() in ref_is_hidden()
      sub-process: print the cmd when a capability is unsupported

Dimitrios Christidis (1):
      fmt-merge-msg: fix coding style

Heiko Voigt (1):
      t5526: fix some broken && chains

Hielke Christian Braun (1):
      gitweb: skip unreadable subdirectories

Jeff King (32):
      t1414: document some reflog-walk oddities
      revision: disallow reflog walking with revs->limited
      log: clarify comment about reflog cycles
      log: do not free parents when walking reflog
      get_revision_1(): replace do-while with an early return
      rev-list: check reflog_info before showing usage
      reflog-walk: stop using fake parents
      reflog-walk: apply --since/--until to reflog dates
      check return value of verify_ref_format()
      docs/for-each-ref: update pointer to color syntax
      t: use test_decode_color rather than literal ANSI codes
      ref-filter: simplify automatic color reset
      ref-filter: abstract ref format into its own struct
      ref-filter: move need_color_reset_at_eol into ref_format
      ref-filter: provide a function for parsing sort options
      ref-filter: make parse_ref_filter_atom a private function
      ref-filter: factor out the parsing of sorting atoms
      ref-filter: pass ref_format struct to atom parsers
      color: check color.ui in git_default_config()
      for-each-ref: load config earlier
      rev-list: pass diffopt->use_colors through to pretty-print
      pretty: respect color settings for %C placeholders
      ref-filter: consult want_color() before emitting colors
      t6018: flesh out empty input/output rev-list tests
      revision: add rev_input_given flag
      rev-list: don't show usage when we see empty ref patterns
      revision: do not fallback to default when rev_input_given is set
      hashcmp: use memcmp instead of open-coded loop
      doc: fix typo in sendemail.identity
      shell: drop git-cvsserver support by default
      archimport: use safe_pipe_capture for user input
      cvsimport: shell-quote variable used in backticks

Johannes Schindelin (2):
      run_processes_parallel: change confusing task_cb convention
      git-gui (MinGW): make use of MSys2's msgfmt

Jonathan Nieder (4):
      vcs-svn: remove more unused prototypes and declarations
      vcs-svn: remove custom mode constants
      vcs-svn: remove repo_delete wrapper function
      vcs-svn: move remaining repo_tree functions to fast_export.h

Jonathan Tan (7):
      fsck: remove redundant parse_tree() invocation
      object: remove "used" field from struct object
      fsck: cleanup unused variable
      Documentation: migrate sub-process docs to header
      sub-process: refactor handshake to common function
      tests: ensure fsck fails on corrupt packfiles
      Doc: clarify that pack-objects makes packs, plural

Junio C Hamano (11):
      http.c: http.sslcert and http.sslkey are both pathnames
      perl/Git.pm: typofix in a comment
      Prepare for 2.14.2
      RelNotes: further fixes for 2.14.2 from the master front
      cvsserver: move safe_pipe_capture() to the main package
      cvsserver: use safe_pipe_capture for `constant commands` as well
      Git 2.10.5
      Git 2.11.4
      Git 2.12.5
      Git 2.13.6
      Git 2.14.2

Kaartic Sivaraam (1):
      commit: check for empty message before the check for untouched template

Kevin Daudt (1):
      stash: prevent warning about null bytes in input

Lars Schneider (7):
      t0021: keep filter log files on comparison
      t0021: make debug log file name configurable
      t0021: write "OUT <size>" only on success
      convert: put the flags field before the flag itself for consistent style
      convert: move multiple file filter error handling to separate function
      convert: refactor capabilities negotiation
      convert: add "status=delayed" to filter process protocol

Martin Ågren (7):
      builtin.h: take over documentation from api-builtin.txt
      git.c: let builtins opt for handling `pager.foo` themselves
      git.c: provide setup_auto_pager()
      t7006: add tests for how git tag paginates
      tag: respect `pager.tag` in list-mode only
      tag: change default of `pager.tag` to "on"
      git.c: ignore pager.* when launching builtin as dashed external

Michael Forney (1):
      scripts: use "git foo" not "git-foo"

Michael J Gruber (6):
      Documentation: use proper wording for ref format strings
      Documentation/git-for-each-ref: clarify peeling of tags for --format
      Documentation/git-merge: explain --continue
      merge: clarify call chain
      merge: split write_merge_state in two
      merge: save merge state earlier

Philip Oakley (4):
      git-gui: remove duplicate entries from .gitconfig's gui.recentrepo
      git gui: cope with duplicates in _get_recentrepo
      git gui: de-dup selected repo from recentrepo history
      git gui: allow for a long recentrepo list

Phillip Wood (7):
      am: remember --rerere-autoupdate setting
      rebase: honor --rerere-autoupdate
      rebase -i: honor --rerere-autoupdate
      t3504: use test_commit
      cherry-pick/revert: remember --rerere-autoupdate
      cherry-pick/revert: reject --rerere-autoupdate when continuing
      am: fix signoff when other trailers are present

Ramsay Jones (2):
      credential-cache: interpret an ECONNRESET as an EOF
      builtin/add: add detail to a 'cannot chmod' error message

René Scharfe (23):
      bswap: convert to unsigned before shifting in get_be32
      bswap: convert get_be16, get_be32 and put_be32 to inline functions
      add MOVE_ARRAY
      use MOVE_ARRAY
      apply: use COPY_ARRAY and MOVE_ARRAY in update_image()
      ls-files: don't try to prune an empty index
      dir: support platforms that require aligned reads
      pack-objects: remove unnecessary NULL check
      t0001: skip test with restrictive permissions if getpwd(3) respects them
      test-path-utils: handle const parameter of basename and dirname
      t3700: fix broken test under !POSIXPERM
      t4062: use less than 256 repetitions in regex
      sha1_file: avoid comparison if no packed hash matches the first byte
      apply: remove prefix_length member from apply_state
      merge: use skip_prefix()
      win32: plug memory leak on realloc() failure in syslog()
      fsck: free buffers on error in fsck_obj()
      sha1_file: release delta_stack on error in unpack_entry()
      t1002: stop using sum(1)
      t5001: add tests for export-ignore attributes and exclude pathspecs
      archive: factor out helper functions for handling attributes
      archive: don't queue excluded directories
      commit: remove unused inline function single_parent()

Santiago Torres (1):
      t: lib-gpg: flush gpg agent on startup

Stefan Beller (3):
      t8008: rely on rev-parse'd HEAD instead of sha1 value
      sha1_file: make read_info_alternates static
      submodule.sh: remove unused variable

Torsten Bögershausen (2):
      convert: add SAFE_CRLF_KEEP_CRLF
      apply: file commited with CRLF should roundtrip diff and apply

Urs Thuermann (1):
      git svn fetch: Create correct commit timestamp when using --localtime

brian m. carlson (2):
      vcs-svn: remove unused prototypes
      vcs-svn: rename repo functions to "svn_repo"

joernchen (1):
      cvsserver: use safe_pipe_capture instead of backticks

Ævar Arnfjörð Bjarmason (1):
      tests: don't give unportable ">" to "test" built-in, use -gt


