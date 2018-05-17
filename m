Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987B71F406
	for <e@80x24.org>; Thu, 17 May 2018 06:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeEQGBu (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 02:01:50 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35088 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeEQGBp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 02:01:45 -0400
Received: by mail-wr0-f181.google.com with SMTP id i14-v6so4291938wre.2
        for <git@vger.kernel.org>; Wed, 16 May 2018 23:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=WHz4e48UdJOu2M0Q2jfUApKvIPXe5Ne8lLMxtX3qTFc=;
        b=FBT8uG3BvCyyWWjeOoUxmS4FzsZDhuk6gvnwpOHVaUk0FuWV37JxT/cVA69cJE3B3+
         ugkKnZmjqjsNe4VWUqkKlfsJFUhgNmOwoG8kt29ZV+5RUysIJxC2ZFN9v++kRjRJ8Yuo
         1KZURJtk+NqPTK2Ve3WDrvTRiQ0/ODaLMjeIDx4F0yAJ1Tyi1u985c+ZxBBg/ydgoJ9s
         f4PbWgs265BrZ8zfCQVbpWG6mgBkCMXTpl4YO88bbej6/XU3ThbZWwUPJH3iyTxJQpCG
         anRRpbyQ+79Bpka14Nekw+my1zaypESz+RHw54TJ1y5Ybeop/JVCBmRnGGaqiDa4jUtv
         1HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=WHz4e48UdJOu2M0Q2jfUApKvIPXe5Ne8lLMxtX3qTFc=;
        b=ph8doLap8Obw8FYUzfZ24dttYqERu/znbqVgd7uzDfKRzm5SsdCWbzfLGJJmKZJuKw
         ydZZM/z8RoTY8kD8SmchIEOLIdfB9zUi5ws/022Bnd5bm9cTxJjo+rdZeigmirhJFP00
         zZtcnpss88UCMbblnypPSr8O70SmUJZii/WiFPKuLgNkJDcMAJYRHJKy4nCQXtdxPpqT
         pd/roo6tkQN01jmrPf9iWZ+sOj5uVNZZWFXBoYfYbUI3Rp7tQMsXjLsVGu4EWCdSPT9F
         r7wnEijSxekrdfAUPxqbfIo6xyEhwQS/HmmzC+QCvCo/ngPkflYhnvrCkQHTeuo1t5iG
         42ig==
X-Gm-Message-State: ALKqPwdt9qrax0teB9eBLc4HQ0Q8KwEXrXU4LzwPgGFN/rTWjFs6Ct6C
        5Tc3jBAEIS0AGx2t4jW1DRnBE3xM
X-Google-Smtp-Source: AB8JxZp51U7g76xRFr+dYEmwp+Cwr8puwiafu7577ANjdGZra8MX1SWGqSLW4/9cgV3WSZ623DLzaQ==
X-Received: by 2002:adf:94a5:: with SMTP id 34-v6mr529029wrr.43.1526536901821;
        Wed, 16 May 2018 23:01:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w5-v6sm4681352wmd.26.2018.05.16.23.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 23:01:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2018, #02; Thu, 17)
X-master-at: ccdcbd54c4475c2238b310f7113ab3075b5abc9c
X-next-at: 5d83f92caf205e137a75902ff5658d2d82c898c5
Date:   Thu, 17 May 2018 15:01:40 +0900
Message-ID: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* hn/sort-ls-remote (2018-04-09) 1 commit
  (merged to 'next' on 2018-04-30 at 244ca5d30a)
 + ls-remote: create '--sort' option

 "git ls-remote" learned an option to allow sorting its output based
 on the refnames being shown.


* sb/object-store-replace (2018-04-12) 15 commits
  (merged to 'next' on 2018-04-25 at 9a213fb505)
 + replace-object: allow lookup_replace_object to handle arbitrary repositories
 + replace-object: allow do_lookup_replace_object to handle arbitrary repositories
 + replace-object: allow prepare_replace_object to handle arbitrary repositories
 + refs: allow for_each_replace_ref to handle arbitrary repositories
 + refs: store the main ref store inside the repository struct
 + replace-object: add repository argument to lookup_replace_object
 + replace-object: add repository argument to do_lookup_replace_object
 + replace-object: add repository argument to prepare_replace_object
 + refs: add repository argument to for_each_replace_ref
 + refs: add repository argument to get_main_ref_store
 + replace-object: check_replace_refs is safe in multi repo environment
 + replace-object: eliminate replace objects prepared flag
 + object-store: move lookup_replace_object to replace-object.h
 + replace-object: move replace_map to object store
 + replace_object: use oidmap
 (this branch is used by sb/object-store-alloc and sb/oid-object-info.)

 The effort to pass the repository in-core structure throughout the
 API continues.  This round deals with the code that implements the
 refs/replace/ mechanism.


* ab/git-svn-get-record-typofix (2018-04-09) 1 commit
  (merged to 'next' on 2018-04-30 at 23f875f6b9)
 + git-svn: avoid warning on undef readline()

 "git svn" had a minor thinko/typo which has been fixed.


* ab/nuke-emacs-contrib (2018-04-16) 1 commit
  (merged to 'next' on 2018-04-25 at 9b133d8a65)
 + git{,-blame}.el: remove old bitrotting Emacs code

 The scripts in contrib/emacs/ have outlived their usefulness and
 have been replaced with a stub that errors out and tells the user
 there are replacements.


* ab/simplify-perl-makefile (2018-04-19) 2 commits
  (merged to 'next' on 2018-04-25 at 906cf21682)
 + Makefile: mark perllibdir as a .PHONY target
  (merged to 'next' on 2018-04-17 at 4448756934)
 + perl: fix installing modules from contrib

 Recent simplification of build procedure forgot a bit of tweak to
 the build procedure of contrib/mw-to-git/


* bt/gpg-interface (2018-04-16) 7 commits
  (merged to 'next' on 2018-04-30 at 50c507b7d8)
 + gpg-interface: find the last gpg signature line
 + gpg-interface: extract gpg line matching helper
 + gpg-interface: fix const-correctness of "eol" pointer
 + gpg-interface: use size_t for signature buffer size
 + gpg-interface: modernize function declarations
 + gpg-interface: handle bool user.signingkey
 + t7004: fix mistaken tag name

 What is queued here is only the obviously correct and
 uncontroversial code clean-up part, which is an earlier 7 patches,
 of a larger series.

 The remainder that is not queued introduces a few configuration
 variables to deal with e-signature backends with different
 signature format.


* bw/protocol-v2 (2018-03-15) 35 commits
  (merged to 'next' on 2018-04-11 at 23ee234a2c)
 + remote-curl: don't request v2 when pushing
 + remote-curl: implement stateless-connect command
 + http: eliminate "# service" line when using protocol v2
 + http: don't always add Git-Protocol header
 + http: allow providing extra headers for http requests
 + remote-curl: store the protocol version the server responded with
 + remote-curl: create copy of the service name
 + pkt-line: add packet_buf_write_len function
 + transport-helper: introduce stateless-connect
 + transport-helper: refactor process_connect_service
 + transport-helper: remove name parameter
 + connect: don't request v2 when pushing
 + connect: refactor git_connect to only get the protocol version once
 + fetch-pack: support shallow requests
 + fetch-pack: perform a fetch using v2
 + upload-pack: introduce fetch server command
 + push: pass ref prefixes when pushing
 + fetch: pass ref prefixes when fetching
 + ls-remote: pass ref prefixes when requesting a remote's refs
 + transport: convert transport_get_remote_refs to take a list of ref prefixes
 + transport: convert get_refs_list to take a list of ref prefixes
 + connect: request remote refs using v2
 + ls-refs: introduce ls-refs server command
 + serve: introduce git-serve
 + test-pkt-line: introduce a packet-line test helper
 + protocol: introduce enum protocol_version value protocol_v2
 + transport: store protocol version
 + connect: discover protocol version outside of get_remote_heads
 + connect: convert get_remote_heads to use struct packet_reader
 + transport: use get_refs_via_connect to get refs
 + upload-pack: factor out processing lines
 + upload-pack: convert to a builtin
 + pkt-line: add delim packet support
 + pkt-line: allow peeking a packet line without consuming it
 + pkt-line: introduce packet_read_with_status
 (this branch is used by bw/server-options and jt/partial-clone-proto-v2.)

 The beginning of the next-gen transfer protocol.


* dj/runtime-prefix (2018-04-24) 7 commits
  (merged to 'next' on 2018-04-25 at e7e635a70e)
 + Makefile: quote $INSTLIBDIR when passing it to sed
 + Makefile: remove unused @@PERLLIBDIR@@ substitution variable
  (merged to 'next' on 2018-04-17 at a69aaa7a22)
 + mingw/msvc: use the new-style RUNTIME_PREFIX helper
 + exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
 + exec_cmd: RUNTIME_PREFIX on some POSIX systems
 + Makefile: add Perl runtime prefix support
 + Makefile: generate Perl header from template file
 (this branch is tangled with js/runtime-prefix.)

 A build-time option has been added to allow Git to be told to refer
 to its associated files relative to the main binary, in the same
 way that has been possible on Windows for quite some time, for
 Linux, BSDs and Darwin.


* ds/commit-graph (2018-04-11) 16 commits
  (merged to 'next' on 2018-04-25 at 18af3d28d9)
 + commit-graph: implement "--append" option
 + commit-graph: build graph from starting commits
 + commit-graph: read only from specific pack-indexes
 + commit: integrate commit graph with commit parsing
 + commit-graph: close under reachability
 + commit-graph: add core.commitGraph setting
 + commit-graph: implement git commit-graph read
 + commit-graph: implement git-commit-graph write
 + commit-graph: implement write_commit_graph()
 + commit-graph: create git-commit-graph builtin
 + graph: add commit graph design document
 + commit-graph: add format document
 + csum-file: refactor finalize_hashfile() method
 + csum-file: rename hashclose() to finalize_hashfile()
 + Merge branch 'jk/cached-commit-buffer' into HEAD
 + Merge branch 'jt/binsearch-with-fanout' into HEAD
 (this branch is used by ds/generation-numbers and ds/lazy-load-trees.)

 Precompute and store information necessary for ancestry traversal
 in a separate file to optimize graph walking.

 Will merge to 'master'.


* jc/parseopt-expiry-errors (2018-04-23) 2 commits
  (merged to 'next' on 2018-04-30 at 637085f3d8)
 + parseopt: handle malformed --expire arguments more nicely
 + gc: do not upcase error message shown with die()

 "git gc --prune=nonsense" spent long time repacking and then
 silently failed when underlying "git prune --expire=nonsense"
 failed to parse its command line.  This has been corrected.


* js/colored-push-errors (2018-04-24) 4 commits
  (merged to 'next' on 2018-04-30 at 31076c52a2)
 + config: document the settings to colorize push errors/hints
 + push: test to verify that push errors are colored
 + push: colorize errors
 + color: introduce support for colorizing stderr

 Error messages from "git push" can be painted for more visibility.


* js/empty-config-section-fix (2018-04-09) 15 commits
  (merged to 'next' on 2018-04-25 at 1690df3e5f)
 + git_config_set: reuse empty sections
 + git config --unset: remove empty sections (in the common case)
 + git_config_set: make use of the config parser's event stream
 + git_config_set: do not use a state machine
 + config_set_store: rename some fields for consistency
 + config: avoid using the global variable `store`
 + config: introduce an optional event stream while parsing
 + t1300: `--unset-all` can leave an empty section behind (bug)
 + t1300: add a few more hairy examples of sections becoming empty
 + t1300: remove unreasonable expectation from TODO
 + t1300: avoid relying on a bug
 + config --replace-all: avoid extra line breaks
 + t1300: demonstrate that --replace-all can "invent" newlines
 + t1300: rename it to reflect that `repo-config` was deprecated
 + git_config_set: fix off-by-two

 "git config --unset a.b", when "a.b" is the last variable in an
 otherwise empty section "a", left an empty section "a" behind, and
 worse yet, a subsequent "git config a.c value" did not reuse that
 empty shell and instead created a new one.  These have been
 (partially) corrected.


* js/ident-date-fix (2018-04-19) 1 commit
  (merged to 'next' on 2018-04-30 at d50ec2f4c1)
 + sequencer: reset the committer date before commits

 During a "rebase -i" session, the code could give older timestamp
 to commits created by later "pick" than an earlier "reword", which
 has been corrected.


* js/runtime-prefix (2018-04-24) 8 commits
  (merged to 'next' on 2018-04-30 at c6cfccf40e)
 + Avoid multiple PREFIX definitions
 + git_setup_gettext: plug memory leak
 + gettext: avoid initialization if the locale dir is not present
  (merged to 'next' on 2018-04-17 at a69aaa7a22)
 + mingw/msvc: use the new-style RUNTIME_PREFIX helper
 + exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
 + exec_cmd: RUNTIME_PREFIX on some POSIX systems
 + Makefile: add Perl runtime prefix support
 + Makefile: generate Perl header from template file
 (this branch is tangled with dj/runtime-prefix.)


* ls/checkout-encoding (2018-04-16) 10 commits
  (merged to 'next' on 2018-04-25 at e0f8554b2a)
 + convert: add round trip check based on 'core.checkRoundtripEncoding'
 + convert: add tracing for 'working-tree-encoding' attribute
 + convert: check for detectable errors in UTF encodings
 + convert: add 'working-tree-encoding' attribute
 + utf8: add function to detect a missing UTF-16/32 BOM
 + utf8: add function to detect prohibited UTF-16/32 BOM
 + utf8: teach same_encoding() alternative UTF encoding names
 + strbuf: add a case insensitive starts_with()
 + strbuf: add xstrdup_toupper()
 + strbuf: remove unnecessary NUL assignment in xstrdup_tolower()

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).


* ma/double-dashes-in-docs (2018-04-18) 4 commits
  (merged to 'next' on 2018-04-25 at aaac2dc63c)
 + git-submodule.txt: quote usage in monospace, drop backslash
 + git-[short]log.txt: unify quoted standalone --
 + doc: convert [\--] to [--]
 + doc: convert \--option to --option

 Doc formatting updates.


* ma/fast-export-skip-merge-fix (2018-04-21) 1 commit
  (merged to 'next' on 2018-04-30 at f7fca02ab1)
 + fast-export: fix regression skipping some merge-commits

 "git fast-export" had a regression in v2.15.0 era where it skipped
 some merge commits in certain cases, which has been corrected.


* ma/http-walker-no-partial (2018-04-24) 2 commits
  (merged to 'next' on 2018-04-30 at 4582c99ba8)
 + walker: drop fields of `struct walker` which are always 1
 + http-fetch: make `-a` standard behavior

 "git http-fetch" (deprecated) had an optional and experimental
 "feature" to fetch only commits and/or trees, which nobody used.
 This has been removed.


* nd/submodule-status-fix (2018-04-19) 1 commit
  (merged to 'next' on 2018-04-30 at 34d1f9ca83)
 + submodule--helper: don't print null in 'submodule status'

 "git submodule status" did not check the symbolic revision name it
 computed for the submodule HEAD is not the NULL, and threw it at
 printf routines, which has been corrected.


* nd/warn-more-for-devs (2018-04-16) 4 commits
  (merged to 'next' on 2018-04-25 at 2978e61414)
 + Makefile: add a DEVOPTS to get all of -Wextra
 + Makefile: add a DEVOPTS to suppress -Werror under DEVELOPER
 + Makefile: detect compiler and enable more warnings in DEVELOPER=1
 + connect.c: mark die_initial_contact() NORETURN

 The build procedure "make DEVELOPER=YesPlease" learned to enable a
 bit more warning options depending on the compiler used to help
 developers more.  There also is "make DEVOPTS=tokens" knob
 available now, for those who want to help fixing warnings we
 usually ignore, for example.


* ot/libify-get-ref-atom-value (2018-03-29) 6 commits
  (merged to 'next' on 2018-04-25 at 056bcaa69c)
 + ref-filter: libify get_ref_atom_value()
 + ref-filter: add return value to parsers
 + ref-filter: change parsing function error handling
 + ref-filter: add return value && strbuf to handlers
 + ref-filter: start adding strbufs with errors
 + ref-filter: add shortcut to work with strbufs

 Code restructuring, in preparation for further work.


* sa/send-email-dedup-some-headers (2018-04-19) 1 commit
  (merged to 'next' on 2018-04-30 at 2a1fd8217e)
 + send-email: avoid duplicate In-Reply-To/References

 When fed input that already has In-Reply-To: and/or References:
 headers and told to add the same information, "git send-email"
 added these headers separately, instead of appending to an existing
 one, which is a violation of the RFC.  This has been corrected.


* sb/submodule-move-nested (2018-03-29) 6 commits
  (merged to 'next' on 2018-04-25 at 86b177433a)
 + submodule: fixup nested submodules after moving the submodule
 + submodule-config: remove submodule_from_cache
 + submodule-config: add repository argument to submodule_from_{name, path}
 + submodule-config: allow submodule_free to handle arbitrary repositories
 + grep: remove "repo" arg from non-supporting funcs
 + submodule.h: drop declaration of connect_work_tree_and_git_dir

 Moving a submodule that itself has submodule in it with "git mv"
 forgot to make necessary adjustment to the nested sub-submodules;
 now the codepath learned to recurse into the submodules.


* sb/worktree-remove-opt-force (2018-04-18) 1 commit
  (merged to 'next' on 2018-04-25 at 0367d52a4b)
 + worktree: accept -f as short for --force for removal

 "git worktree remove" learned that "-f" is a shorthand for
 "--force" option, just like for "git worktree add".


* sg/completion-clear-cached (2018-04-18) 1 commit
  (merged to 'next' on 2018-04-25 at 9178da6c3d)
 + completion: reduce overhead of clearing cached --options

 The completion script (in contrib/) learned to clear cached list of
 command line options upon dot-sourcing it again in a more efficient
 way.


* sg/doc-gc-quote-mismatch-fix (2018-04-18) 1 commit
  (merged to 'next' on 2018-04-25 at bc3d1abf45)
 + docs/git-gc: fix minor rendering issue

 Doc formatting fix.


* so/glossary-ancestor (2018-04-17) 1 commit
  (merged to 'next' on 2018-04-25 at 0a849fee00)
 + glossary: substitute "ancestor" for "direct ancestor" in 'push' description.

 Docfix.


* tb/config-default (2018-04-23) 3 commits
  (merged to 'next' on 2018-04-25 at 59bb6beb2a)
 + builtin/config: introduce `color` type specifier
 + config.c: introduce 'git_config_color' to parse ANSI colors
 + builtin/config: introduce `--default`
 (this branch uses tb/config-type.)

 "git config --get" learned the "--default" option, to help the
 calling script.  Building on top of the tb/config-type topic, the
 "git config" learns "--type=color" type.  Taken together, you can
 do things like "git config --get foo.color --default blue" and get
 the ANSI color sequence for the color given to foo.color variable,
 or "blue" if the variable does not exist.


* tb/config-type (2018-04-19) 2 commits
  (merged to 'next' on 2018-04-25 at fe69e93c82)
 + builtin/config.c: support `--type=<type>` as preferred alias for `--<type>`
 + builtin/config.c: treat type specifiers singularly
 (this branch is used by tb/config-default.)

 The "git config" command uses separate options e.g. "--int",
 "--bool", etc. to specify what type the caller wants the value to
 be interpreted as.  A new "--type=<typename>" option has been
 introduced, which would make it cleaner to define new types.


* tg/demote-stash-save-in-completion (2018-04-20) 2 commits
  (merged to 'next' on 2018-04-30 at 93d0af5375)
 + completion: make stash -p and alias for stash push -p
 + completion: stop showing 'save' for stash by default

 The command line completion (in contrib/) has been taught that "git
 stash save" has been deprecated ("git stash push" is the preferred
 spelling in the new world) and does not offer it as a possible
 completion candidate when "git stash push" can be.


* tq/t1510 (2018-04-17) 1 commit
  (merged to 'next' on 2018-04-25 at 5710c81979)
 + t1510-repo-setup.sh: remove useless mkdir

 Test cleanup.


* tz/doc-git-urls-reference (2018-04-20) 1 commit
  (merged to 'next' on 2018-04-30 at 39926c99fd)
 + doc/clone: update caption for GIT URLS cross-reference

 Doc fix.

--------------------------------------------------
[New Topics]

* hn/sort-ls-remote (2018-05-14) 1 commit
  (merged to 'next' on 2018-05-16 at 64336850f2)
 + t5512: run git fetch inside test

 Hotfix.

 Will merge to 'master'.


* sb/object-store-replace (2018-05-10) 2 commits
  (merged to 'next' on 2018-05-16 at 41bbedcc81)
 + replace-object.c: remove the_repository from prepare_replace_object
 + object.c: free replace map in raw_object_store_clear

 Hotfix.

 Will merge to 'master'.


* sg/t6500-no-redirect-of-stdin (2018-05-09) 1 commit
 - t6050-replace: don't disable stdin for the whole test script

 Test cleanup.

 Will merge to 'next'.


* ao/config-api-doc (2018-05-11) 1 commit
 - doc: fix config API documentation about config_with_options

 Doc update.

 Will merge to 'next'.


* bc/hash-independent-tests (2018-05-16) 28 commits
 - t5300: abstract away SHA-1-specific constants
 - t4208: abstract away SHA-1-specific constants
 - t4045: abstract away SHA-1-specific constants
 - t4042: abstract away SHA-1-specific constants
 - t4205: sort log output in a hash-independent way
 - t/lib-diff-alternative: abstract away SHA-1-specific constants
 - t4030: abstract away SHA-1-specific constants
 - t4029: abstract away SHA-1-specific constants
 - t4029: fix test indentation
 - t4022: abstract away SHA-1-specific constants
 - t4020: abstract away SHA-1-specific constants
 - t4014: abstract away SHA-1-specific constants
 - t4008: abstract away SHA-1-specific constants
 - t4007: abstract away SHA-1-specific constants
 - t3905: abstract away SHA-1-specific constants
 - t3702: abstract away SHA-1-specific constants
 - t3103: abstract away SHA-1-specific constants
 - t2203: abstract away SHA-1-specific constants
 - t: skip pack tests if not using SHA-1
 - t4044: skip test if not using SHA-1
 - t1512: skip test if not using SHA-1
 - t1007: annotate with SHA1 prerequisite
 - t0000: annotate with SHA1 prerequisite
 - t: switch $_x40 to $OID_REGEX
 - t/test-lib: introduce OID_REGEX
 - t: switch $_z40 to $ZERO_OID
 - t/test-lib: introduce ZERO_OID
 - t/test-lib: add an SHA1 prerequisite

 Many tests hardcode the raw object names, which would change once
 we migrate away from SHA-1.  While some of them must test against
 exact object names, most of them do not have to use hardcoded
 constants in the test.  The latter kind of tests have been updated
 to test the moral equivalent of the original without hardcoding the
 actual object names.

 Will merge to 'next'.


* bp/status-rename-config (2018-05-13) 1 commit
 - add status config and command line options for rename detection
 (this branch uses em/status-rename-config.)

 "git status" learned to honor a new status.renames configuration to
 skip rename detection, which could be useful for those who want to
 do so without disabling the default rename detection done by the
 "git diff" command.

 Will merge to 'next'.


* bw/refspec-api (2018-05-16) 35 commits
 - submodule: convert push_unpushed_submodules to take a struct refspec
 - remote: convert check_push_refs to take a struct refspec
 - remote: convert match_push_refs to take a struct refspec
 - http-push: store refspecs in a struct refspec
 - transport: remove transport_verify_remote_names
 - send-pack: store refspecs in a struct refspec
 - transport: convert transport_push to take a struct refspec
 - push: convert to use struct refspec
 - push: check for errors earlier
 - remote: convert match_explicit_refs to take a struct refspec
 - remote: convert get_ref_match to take a struct refspec
 - remote: convert query_refspecs to take a struct refspec
 - remote: convert apply_refspecs to take a struct refspec
 - remote: convert get_stale_heads to take a struct refspec
 - fetch: convert prune_refs to take a struct refspec
 - fetch: convert get_ref_map to take a struct refspec
 - fetch: convert do_fetch to take a struct refspec
 - refspec: remove the deprecated functions
 - fetch: convert refmap to use struct refspec
 - fetch: convert fetch_one to use struct refspec
 - transport-helper: convert to use struct refspec
 - remote: convert fetch refspecs to struct refspec
 - remote: convert push refspecs to struct refspec
 - fast-export: convert to use struct refspec
 - clone: convert cmd_clone to use refspec_item_init
 - remote: convert match_push_refs to use struct refspec
 - remote: convert check_push_refs to use struct refspec
 - transport: convert transport_push to use struct refspec
 - pull: convert get_tracking_branch to use refspec_item_init
 - submodule--helper: convert push_check to use struct refspec
 - refspec: convert valid_fetch_refspec to use parse_refspec
 - refspec: introduce struct refspec
 - refspec: rename struct refspec to struct refspec_item
 - refspec: factor out parsing a single refspec
 - refspec: move refspec parsing logic into its own file

 An API update for handling of refspecs used by fetch & push
 codepath.

 Will merge to 'next'.


* ds/commit-graph-lockfile-fix (2018-05-11) 1 commit
 - commit-graph: fix UX issue when .lock file exists
 (this branch uses ds/generation-numbers and ds/lazy-load-trees.)

 Update to ds/generation-numbers topic.


* jk/apply-p-doc (2018-05-11) 1 commit
 - apply: clarify "-p" documentation

 Doc update.

 Will merge to 'next'.


* jk/unavailable-can-be-missing (2018-05-13) 4 commits
 - mark_parents_uninteresting(): avoid most allocation
 - mark_parents_uninteresting(): replace list with stack
 - mark_parents_uninteresting(): drop missing object check
 - mark_tree_contents_uninteresting(): drop missing object check

 Code clean-up to turn history traversal more robust in a
 semi-corrupt repository.

 Will merge to 'next'.


* lm/credential-netrc (2018-05-14) 2 commits
 - git-credential-netrc: accept gpg option
 - git-credential-netrc: adapt to test framework for git

 Update credential-netrc helper (in contrib/) to allow customizing
 the GPG used to decrypt the encrypted .netrc file.

 Will merge to 'next'.


* ma/create-pseudoref-with-null-old-oid (2018-05-13) 3 commits
 - refs: handle zero oid for pseudorefs
 - t1400: add tests around adding/deleting pseudorefs
 - refs.c: refer to "object ID", not "sha1", in error messages

 "git update-ref A B" is supposed to ensure that ref A does not yet
 exist when B is a NULL OID, but this check was not done correctly
 for pseudo-refs outside refs/ hierarchy, e.g. MERGE_HEAD.

 Will merge to 'next'.


* ma/lockfile-cleanup (2018-05-10) 5 commits
 - lock_file: move static locks into functions
 - lock_file: make function-local locks non-static
 - refs.c: do not die if locking fails in `delete_pseudoref()`
 - refs.c: do not die if locking fails in `write_pseudoref()`
 - t/helper/test-write-cache: clean up lock-handling

 Code clean-up to adjust to a more recent lockfile API convention that
 allows lockfile instances kept on the stack.

 Will merge to 'next'.


* nd/commit-util-to-slab (2018-05-14) 14 commits
 - commit.h: delete 'util' field in struct commit
 - merge: use commit-slab in merge remote desc instead of commit->util
 - log: use commit-slab in prepare_bases() instead of commit->util
 - show-branch: use commit-slab for commit-name instead of commit->util
 - name-rev: use commit-slab for rev-name instead of commit->util
 - bisect.c: use commit-slab for commit weight instead of commit->util
 - revision.c: use commit-slab for show_source
 - sequencer.c: use commit-slab to associate todo items to commits
 - sequencer.c: use commit-slab to mark seen commits
 - shallow.c: use commit-slab for commit depth instead of commit->util
 - describe: use commit-slab for commit names instead of commit->util
 - blame: use commit-slab for blame suspects instead of commit->util
 - commit-slab: support shared commit-slab
 - commit-slab.h: code split

 The in-core "commit" object had an all-purpose "void *util" field,
 which was tricky to use especially in library-ish part of the
 code.  All of the existing uses of the field has been migrated to a
 more dedicated "commit-slab" mechanism and the field is eliminated.

 Will merge to 'next'.


* nd/diff-apply-ita (2018-05-14) 2 commits
 - apply: add --intent-to-add
 - diff: turn --ita-invisible-in-index on by default

 "git diff" compares the index and the working tree.  For paths
 added with intent-to-add bit, the command shows the full contents
 of them as added, but the paths themselves were not marked as new
 files.  They are now shown as new by default.

 "git apply" learned the "--intent-to-add" option so that an
 otherwise working-tree-only application of a patch will add new
 paths to the index marked with the "intent-to-add" bit.

 Will merge to and cook in 'next'.


* nd/pack-format-doc (2018-05-13) 1 commit
 - pack-format.txt: more details on pack file format

 Doc update.

 Will merge to 'next'.


* nd/pack-struct-commit (2018-05-13) 1 commit
 - commit.h: rearrange 'index' to shrink struct commit

 Memory optimization.

 Will merge to 'next'.


* nd/repo-clear-keep-the-index (2018-05-10) 1 commit
 - repository: fix free problem with repo_clear(the_repository)

 the_repository->index is not a allocated piece of memory but
 repo_clear() indiscriminately attempted to free(3) it, which has
 been corrected.

 Will merge to 'next'.


* nd/term-columns (2018-05-13) 2 commits
 - column: fix off-by-one default width
 - pager: set COLUMNS to term_columns()

 The code did not propagate the terminal width to subprocesses via
 COLUMNS environment variable, which it now does.  This caused
 trouble to "git column" helper subprocess when "git tag --column=row"
 tried to list the existing tags on a display with non-default width.

 Will merge to 'next'.


* nd/travis-gcc-7 (2018-05-14) 1 commit
 - travis-ci: run gcc-7 on linux-gcc jobs

 Developer support.  Use newer GCC on one of the builds done at
 TravisCI.org to get more warnings and errors diagnosed.

 Will merge to 'next'.


* rs/no-null-ptr-arith-in-fast-export (2018-05-10) 1 commit
 - fast-export: avoid NULL pointer arithmetic

 Code clean-up to avoid non-standard-conformant pointer arithmetic.

 Will merge to 'next'.


* sb/grep-die-on-unreadable-index (2018-05-16) 1 commit
 - grep: handle corrupt index files early


* sb/object-store-grafts (2018-05-16) 19 commits
 - commit: allow lookup_commit_graft to handle arbitrary repositories
 - commit: allow prepare_commit_graft to handle arbitrary repositories
 - shallow: migrate shallow information into the object parser
 - path.c: migrate git_path_ to take a repository argument
 - cache: convert get_graft_file to handle arbitrary repositories
 - commit: convert read_graft_file to handle arbitrary repositories
 - commit: convert register_commit_graft to handle arbitrary repositories
 - commit: convert commit_graft_pos() to handle arbitrary repositories
 - shallow: add repository argument to is_repository_shallow
 - shallow: add repository argument to check_shallow_file_for_update
 - shallow: add repository argument to register_shallow
 - shallow: add repository argument to set_alternate_shallow_file
 - commit: add repository argument to lookup_commit_graft
 - commit: add repository argument to prepare_commit_graft
 - commit: add repository argument to read_graft_file
 - commit: add repository argument to register_commit_graft
 - commit: add repository argument to commit_graft_pos
 - object: move grafts to object parser
 - object-store: move object access functions to object-store.h
 (this branch uses sb/object-store-alloc and sb/oid-object-info.)


* sb/submodule-merge-in-merge-recursive (2018-05-16) 3 commits
 - merge-recursive: give notice when submodule commit gets fast-forwarded
 - merge-recursive: i18n submodule merge output and respect verbosity
 - submodule.c: move submodule merging to merge-recursive.c

 By code restructuring of submodule merge in merge-recursive,
 informational messages from the codepath are now given using the
 same mechanism as other output, and honor the merge.verbosity
 configuration.  The code also learned to give a few new messages
 when a submodule three-way merge resolves cleanly when one side
 records a descendant of the commit chosen by the other side.

 Will merge to 'next'.


* sb/submodule-update-try-harder (2018-05-16) 1 commit
 - git-submodule.sh: try harder to fetch a submodule

 "git submodule update" attempts two different kinds of "git fetch"
 against the upstream repository to grab a commit bound at the
 submodule's path, but it incorrectly gave up if the first kind
 (i.e. a normal fetch) failed, making the second "last resort" one
 (i.e. fetching an exact commit object by object name) ineffective.
 This has been corrected.

 Will merge to 'next'.


* sg/t5310-jgit-bitmap-test (2018-05-11) 1 commit
 - t5310-pack-bitmaps: make JGit tests work with GIT_TEST_SPLIT_INDEX

 Test update.

 Will merge to 'next'.


* sg/t5516-fixes (2018-05-11) 2 commits
 - t5516-fetch-push: fix broken &&-chain
 - t5516-fetch-push: fix 'push with dry-run' test

 Test fixes.

 Will merge to 'next'.


* sg/t7005-spaces-in-filenames-cleanup (2018-05-15) 1 commit
 - t7005-editor: get rid of the SPACES_IN_FILENAMES prereq

 Test update.

 Will merge to 'next'.


* tb/grep-only-matching (2018-05-14) 2 commits
 - builtin/grep.c: teach '-o', '--only-matching' to 'git-grep'
 - grep.c: extract show_line_header()
 (this branch uses tb/grep-column.)

--------------------------------------------------
[Stalled]

* jm/cache-entry-from-mem-pool (2018-05-02) 5 commits
 - block alloc: add validations around cache_entry lifecyle
 - block alloc: allocate cache entries from mem_pool
 - mem-pool: fill out functionality
 - block alloc: add lifecycle APIs for cache_entry structs
 - read-cache: teach refresh_cache_entry() to take istate

 For a large tree, the index needs to hold many cache entries
 allocated on heap.  These cache entries are now allocated out of a
 dedicated memory pool to amortize malloc(3) overhead.

 Needs review.
 Is the "caller always knows which pool an entry came from and calls
 the right kind of free" a feasible approach?
 Oh, another thing, there is "lifecyle" typo in the title.


* ab/fetch-tags-noclobber (2018-05-16) 9 commits
 - fixup! push tests: assert re-pushing annotated tags
 - fetch: stop clobbering existing tags without --force
 - fetch tests: add a test clobbering tag behavior
 - fetch tests: correct a comment "remove it" -> "remove them"
 - push doc: correct lies about how push refspecs work
 - push tests: assert re-pushing annotated tags
 - push tests: add more testing for forced tag pushing
 - push tests: fix logic error in "push" test assertion
 - push tests: remove redundant 'git push' invocation

 Expecting a reboot of the discussion to take it to some conclusion
 and then a reroll.
 cf. <f3b891c3-381f-de42-51d8-24fdfbca91d2@gmail.com>
 cf. <xmqq603yn50l.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqzi1alodz.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqvabylnbi.fsf@gitster-ct.c.googlers.com>


* pw/add-p-select (2018-03-16) 3 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Expecting a reroll to reignite the discussion.
 cf. <9895c7b7-eac4-28c1-90c6-443acd1131b7@talktalk.net>


* jh/json-writer (2018-03-28) 1 commit
 - json_writer: new routines to create data in JSON format

 Preparatory code to later add json output for unspecified telemetry
 data.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


* hn/bisect-first-parent (2018-04-21) 1 commit
 - bisect: create 'bisect_flags' parameter in find_bisection()

 Preliminary code update to allow passing more flags down the
 bisection codepath in the future.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


* is/parsing-line-range (2018-04-27) 2 commits
 . log: prevent error if line range ends past end of file
 . blame: prevent error if range ends past end of file

 Parsing of -L[<N>][,[<M>]] parameters "git blame" and "git log"
 take has been tweaked.

 Seems to break a few tests.


* av/fsmonitor-updates (2018-01-04) 6 commits
 - fsmonitor: use fsmonitor data in `git diff`
 - fsmonitor: remove debugging lines from t/t7519-status-fsmonitor.sh
 - fsmonitor: make output of test-dump-fsmonitor more concise
 - fsmonitor: update helper tool, now that flags are filled later
 - fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
 - dir.c: update comments to match argument name

 Code clean-up on fsmonitor integration, plus optional utilization
 of the fsmonitor data in diff-files.

 Waiting for an update.
 cf. <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>


* pb/bisect-helper-2 (2017-10-28) 8 commits
 - t6030: make various test to pass GETTEXT_POISON tests
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C

 Expecting a reroll.
 cf. <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>


* mk/http-backend-content-length (2017-11-27) 4 commits
 - SQUASH???
 - t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
 - SQUASH???
 - http-backend: respect CONTENT_LENGTH as specified by rfc3875

 The http-backend (used for smart-http transport) used to slurp the
 whole input until EOF, without paying attention to CONTENT_LENGTH
 that is supplied in the environment and instead expecting the Web
 server to close the input stream.  This has been fixed.

 Expecting a reroll.
 Suggested fixes to be used when rerolling is queued, but I'd
 prefer _not_ squashing them myself.

 Also, it may be too complex solution for the problem.
 cf. <20171204171308.GA13332@sigill.intra.peff.net>


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Expecting a reroll.


* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).

--------------------------------------------------
[Cooking]

* ld/p4-unshelve (2018-05-16) 1 commit
 - git-p4: add unshelve command

 "git p4" learned to "unshelve" shelved commit from P4.

 Will merge to 'next'.


* pc/submodule-helper-foreach (2018-05-11) 4 commits
 - submodule: port submodule subcommand 'foreach' from shell to C
 - submodule foreach: document variable '$displaypath'
 - submodule foreach: document '$sm_path' instead of '$path'
 - submodule foreach: correct '$path' in nested submodules from a subdirectory

 The bulk of "git submodule foreach" has been rewritten in C.

 Will merge to and cook in 'next'.


* tb/test-apfs-utf8-normalization (2018-05-02) 1 commit
  (merged to 'next' on 2018-05-16 at feabe72b42)
 + test: correct detection of UTF8_NFD_TO_NFC for APFS

 A test to see if the filesystem normalizes UTF-8 filename has been
 updated to check what we need to know in a more direct way, i.e. a
 path created in NFC form can be accessed with NFD form (or vice
 versa) to cope with APFS as well as HFS.

 Will merge to 'master'.


* ab/get-short-oid (2018-05-11) 5 commits
 - get_short_oid: sort ambiguous objects by type, then SHA-1
 - sha1-name.c: move around the collect_ambiguous() function
 - git-p4: change "commitish" typo to "committish"
 - sha1-array.h: align function arguments
 - sha1-name.c: remove stray newline

 When a short hexadecimal string is used to name an object but there
 are multiple objects that share the string as the prefix of their
 names, the code lists these ambiguous candidates in a help message.
 These object names are now sorted according to their types for
 easier eyeballing.

 Will merge to 'next'.


* ah/misc-doc-updates (2018-05-06) 7 commits
  (merged to 'next' on 2018-05-16 at e2e3b68a66)
 + doc: normalize [--options] to [options] in git-diff
 + doc: add note about shell quoting to revision.txt
 + git-svn: remove ''--add-author-from' for 'commit-diff'
 + doc: add '-d' and '-o' for 'git push'
 + doc: clarify ignore rules for git ls-files
 + doc: align 'diff --no-index' in text and synopsis
 + doc: improve formatting in githooks.txt

 Misc doc fixes.

 Will merge to 'master'.


* bc/format-patch-cover-no-attach (2018-05-02) 1 commit
  (merged to 'next' on 2018-05-16 at fa1ffeb3fe)
 + format-patch: make cover letters always text/plain

 "git format-patch --cover --attach" created a broken MIME multipart
 message for the cover letter, which has been fixed by keeping the
 cover letter as plain text file.

 Will merge to 'master'.


* bp/test-drop-caches (2018-05-04) 1 commit
  (merged to 'next' on 2018-05-16 at 0e40ab2408)
 + test-drop-caches: simplify delay loading of NtSetSystemInformation

 Code simplification.

 Will merge to 'master'.


* cc/perf-bisect (2018-05-06) 1 commit
  (merged to 'next' on 2018-05-16 at 5a078a2fdf)
 + perf/bisect_run_script: disable codespeed

 Performance test updates.

 Will merge to 'master'.


* cf/submodule-progress-dissociate (2018-05-04) 3 commits
 - submodule: add --dissociate option to add/update commands
 - submodule: add --progress option to add command
 - submodule: clean up subsititions in script

 "git submodule update" and "git submodule add" supported the
 "--reference" option to borrow objects from a neighbouring local
 repository like "git clone" does, but lacked the more recent
 invention "--dissociate".  Also "git submodule add" has been taught
 to take the "--progress" option.

 Will merge to 'next'..
 "subsititions" needs to be typofixed ;-)
 


* dd/send-email-reedit (2018-05-06) 1 commit
 - git-send-email: allow re-editing of message

 "git send-email" can sometimes offer confirmation dialog "Send this
 email?" with choices 'Yes', 'No', 'Quit', and 'All'.  A new action
 'Edit' has been added to this dialog's choice.

 Will merge to 'next'.


* em/status-rename-config (2018-05-06) 1 commit
  (merged to 'next' on 2018-05-16 at 33c1cc093c)
 + wt-status: use settings from git_diff_ui_config
 (this branch is used by bp/status-rename-config.)

 "git status" learned to pay attention to UI related diff
 configuration variables such as diff.renames.

 Will merge to 'master'.


* js/branch-diff (2018-05-16) 19 commits
 - fixup! Add a function to solve least-cost assignment problems
 - completion: support branch-diff
 - branch-diff: add a man page
 - branch-diff --dual-color: work around bogus white-space warning
 - branch-diff: offer to dual-color the diffs
 - diff: add an internal option to dual-color diffs of diffs
 - color: provide inverted colors, too
 - branch-diff: use color for the commit pairs
 - branch-diff: add tests
 - branch-diff: do not show "function names" in hunk headers
 - branch-diff: adjust the output of the commit pairs
 - branch-diff: suppress the diff headers
 - branch-diff: indent the diffs just like tbdiff
 - branch-diff: right-trim commit messages
 - branch-diff: also show the diff between patches
 - branch-diff: improve the order of the shown commits
 - branch-diff: first rudimentary implementation
 - Add a new builtin: branch-diff
 - Add a function to solve least-cost assignment problems

 "git tbdiff" that lets us compare individual patches in two
 iterations of a topic has been rewritten and made into a built-in
 command.

 Expecting a reroll.
 cf. <nycvar.QRO.7.76.6.1805052351560.77@tvgsbejvaqbjf.bet>


* js/sequencer-and-root-commits (2018-05-06) 6 commits
 - rebase --rebase-merges: root commits can be cousins, too
 - rebase --rebase-merges: a "merge" into a new root is a fast-forward
 - sequencer: allow introducing new root commits
 - rebase -i --root: let the sequencer handle even the initial part
 - sequencer: learn about the special "fake root commit" handling
 - sequencer: extract helper to update active_cache_tree
 (this branch uses js/rebase-recreate-merge.)

 The implementation of "git rebase -i --root" has been updated to use
 the sequencer machinery more.

 Will merge to 'next'.


* js/use-bug-macro (2018-05-10) 5 commits
 - BUG_exit_code: fix sparse "symbol not declared" warning
 - Convert remaining die*(BUG) messages
 - Replace all die("BUG: ...") calls by BUG() ones
 - run-command: use BUG() to report bugs, not die()
 - test-tool: help verifying BUG() code paths

 Developer support update, by using BUG() macro instead of die() to
 mark codepaths that should not happen more clearly.

 Will merge to 'next'.
 Further updates can come on top later.
 cf. <20180507090109.GA367@sigill.intra.peff.net>


* jt/partial-clone-proto-v2 (2018-05-06) 4 commits
 - {fetch,upload}-pack: support filter in protocol v2
 - upload-pack: read config when serving protocol v2
 - upload-pack: fix error message typo
 - Merge branch 'bw/protocol-v2' into jt/partial-clone-proto-v2

 Transfer protocol v2 learned to support the partial clone.

 Will merge to 'next'.


* ma/doc-expand-tabs (2018-05-02) 1 commit
 - revisions.txt: expand tabs to spaces in diagram

 Fix one instance of asciidoctor's misformatting by expanding a tab
 into spaces in a literal block.

 Will discard.  This approach is less maintainable than the approach
 taken by bc/asciidoctor-tab-width topic.


* nd/completion-aliasfiletype-typofix (2018-05-06) 1 commit
  (merged to 'next' on 2018-05-16 at 045e4ac190)
 + completion: fix misspelled config key aliasesfiletype

 Typofix.

 Will merge to 'master'.


* nd/doc-header (2018-05-02) 1 commit
  (merged to 'next' on 2018-05-16 at 0599eb3ec9)
 + doc: keep first level section header in upper case

 Doc formatting fix.

 Will merge to 'master'.


* nd/pack-unreachable-objects-doc (2018-05-06) 1 commit
  (merged to 'next' on 2018-05-16 at c4bf977564)
 + pack-objects: validation and documentation about unreachable options

 Doc update.

 Will merge to 'master'.


* sb/object-store-alloc (2018-05-16) 13 commits
 - alloc: allow arbitrary repositories for alloc functions
 - object: allow create_object to handle arbitrary repositories
 - object: allow grow_object_hash to handle arbitrary repositories
 - alloc: add repository argument to alloc_commit_index
 - alloc: add repository argument to alloc_report
 - alloc: add repository argument to alloc_object_node
 - alloc: add repository argument to alloc_tag_node
 - alloc: add repository argument to alloc_commit_node
 - alloc: add repository argument to alloc_tree_node
 - alloc: add repository argument to alloc_blob_node
 - object: add repository argument to grow_object_hash
 - object: add repository argument to create_object
 - repository: introduce parsed objects field
 (this branch is used by sb/object-store-grafts; uses sb/oid-object-info.)

 The conversion to pass "the_repository" and then "a_repository"
 throughout the object access API continues.


* tb/grep-column (2018-05-14) 7 commits
 - contrib/git-jump/git-jump: jump to match column in addition to line
 - grep.c: add configuration variables to show matched option
 - builtin/grep.c: add '--column' option to 'git-grep(1)'
 - grep.c: display column number of first match
 - grep.[ch]: extend grep_opt to allow showing matched column
 - grep.c: expose matched column in match_line()
 - Documentation/config.txt: camel-case lineNumber for consistency
 (this branch is used by tb/grep-only-matching.)

 "git grep" learned the "--column" option that gives not just the
 line number but the column number of the hit.


* bc/asciidoctor-tab-width (2018-05-07) 2 commits
  (merged to 'next' on 2018-05-16 at be2a42c473)
 + Documentation: render revisions correctly under Asciidoctor
 + Documentation: use 8-space tabs with Asciidoctor

 Asciidoctor gives a reasonable imitation for AsciiDoc, but does not
 render illustration in a literal block correctly when indented with
 HT by default. The problem is fixed by forcing 8-space tabs.

 Will merge to 'master'.


* bc/mailmap-self (2018-05-08) 1 commit
  (merged to 'next' on 2018-05-16 at a009c64bd2)
 + mailmap: update brian m. carlson's email address

 Will merge to 'master'.


* cc/perf-aggregate-unknown-option (2018-04-26) 1 commit
  (merged to 'next' on 2018-05-08 at db7d2870f8)
 + perf/aggregate: use Getopt::Long for option parsing

 Perf-test helper updates.

 Will merge to 'master'.


* ab/perl-python-attrs (2018-04-27) 3 commits
  (merged to 'next' on 2018-05-08 at b440e9bbb9)
 + .gitattributes: add a diff driver for Python
 + .gitattributes: use the "perl" differ for Perl
 + .gitattributes: add *.pl extension for Perl

 We learned that our source files with ".pl" and ".py" extensions
 are Perl and Python files respectively and changes to them are
 better viewed as such with appropriate diff drivers.

 Will merge to 'master'.


* js/test-unset-prereq (2018-04-30) 1 commit
  (merged to 'next' on 2018-05-08 at 3aecbf25a3)
 + tests: introduce test_unset_prereq, for debugging

 Test debugging aid.

 Will merge to 'master'.
 cf. <20180507115950.3887-1-szeder.dev@gmail.com>


* fg/completion-external (2018-05-07) 1 commit
  (merged to 'next' on 2018-05-16 at 5d83f92caf)
 + completion: load completion file for external subcommand

 The command line completion mechanism (in contrib/) learned to load
 custom completion file for "git $command" where $command is a
 custom "git-$command" that the end user has on the $PATH when using
 newer version of bash.

 Will merge to 'master'.
 cf. <CAM0VKjkTu+OkLM3gvX73mWugxArCVmqRBmWGHiKuLiLRNkkNow@mail.gmail.com>


* js/deprecate-grafts (2018-04-30) 12 commits
  (merged to 'next' on 2018-05-08 at 1d7b31d179)
 + Remove obsolete script to convert grafts to replace refs
 + technical/shallow: describe why shallow cannot use replace refs
 + technical/shallow: stop referring to grafts
 + filter-branch: stop suggesting to use grafts
 + Deprecate support for .git/info/grafts
 + Add a test for `git replace --convert-graft-file`
 + replace: introduce --convert-graft-file
 + replace: prepare create_graft() for converting graft files wholesale
 + replace: "libify" create_graft() and callees
 + replace: avoid using die() to indicate a bug
 + commit: Let the callback of for_each_mergetag return on error
 + argv_array: offer to split a string by whitespace

 The functionality of "$GIT_DIR/info/grafts" has been superseded by
 the "refs/replace/" mechanism for some time now, but the internal
 code had support for it in many places, which has been cleaned up
 in order to drop support of the "grafts" mechanism.

 Will merge to 'master'.


* js/rebase-i-clean-msg-after-fixup-continue (2018-05-02) 4 commits
  (merged to 'next' on 2018-05-08 at 7e684c153d)
 + rebase --skip: clean up commit message after a failed fixup/squash
 + sequencer: always commit without editing when asked for
 + rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
 + rebase -i: demonstrate bugs with fixup!/squash! commit messages

 "git rebase -i" sometimes left intermediate "# This is a
 combination of N commits" message meant for the human consumption
 inside an editor in the final result in certain corner cases, which
 has been fixed.

 Will merge to 'master'.


* bw/server-options (2018-04-24) 4 commits
  (merged to 'next' on 2018-05-08 at a18ce56f3c)
 + fetch: send server options when using protocol v2
 + ls-remote: send server options when using protocol v2
 + serve: introduce the server-option capability
 + Merge branch 'bw/protocol-v2' into HEAD

 The transport protocol v2 is getting updated further.

 Will merge to 'master'.


* bc/object-id (2018-05-02) 42 commits
 - merge-one-file: compute empty blob object ID
 - add--interactive: compute the empty tree value
 - Update shell scripts to compute empty tree object ID
 - sha1_file: only expose empty object constants through git_hash_algo
 - dir: use the_hash_algo for empty blob object ID
 - sequencer: use the_hash_algo for empty tree object ID
 - cache-tree: use is_empty_tree_oid
 - sha1_file: convert cached object code to struct object_id
 - builtin/reset: convert use of EMPTY_TREE_SHA1_BIN
 - builtin/receive-pack: convert one use of EMPTY_TREE_SHA1_HEX
 - wt-status: convert two uses of EMPTY_TREE_SHA1_HEX
 - submodule: convert several uses of EMPTY_TREE_SHA1_HEX
 - sequencer: convert one use of EMPTY_TREE_SHA1_HEX
 - merge: convert empty tree constant to the_hash_algo
 - builtin/merge: switch tree functions to use object_id
 - builtin/am: convert uses of EMPTY_TREE_SHA1_BIN to the_hash_algo
 - sha1-file: add functions for hex empty tree and blob OIDs
 - builtin/receive-pack: avoid hard-coded constants for push certs
 - diff: specify abbreviation size in terms of the_hash_algo
 - upload-pack: replace use of several hard-coded constants
 - revision: replace use of hard-coded constants
 - http: eliminate hard-coded constants
 - dir: convert struct untracked_cache_dir to object_id
 - commit: convert uses of get_sha1_hex to get_oid_hex
 - index-pack: abstract away hash function constant
 - pack-redundant: convert linked lists to use struct object_id
 - Update struct index_state to use struct object_id
 - split-index: convert struct split_index to object_id
 - submodule-config: convert structures to object_id
 - fsck: convert static functions to struct object_id
 - tree-walk: convert get_tree_entry_follow_symlinks to object_id
 - tree-walk: avoid hard-coded 20 constant
 - pack-redundant: abstract away hash algorithm
 - pack-objects: abstract away hash algorithm
 - packfile: abstract away hash constant values
 - packfile: convert find_pack_entry to object_id
 - sha1-file: convert freshen functions to object_id
 - packfile: convert has_sha1_pack to object_id
 - packfile: remove unused member from struct pack_entry
 - Remove unused member in struct object_context
 - server-info: remove unused members from struct pack_info
 - cache: add a function to read an object ID from a buffer

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'next'.


* sb/oid-object-info (2018-04-26) 9 commits
  (merged to 'next' on 2018-05-08 at f3c08f298e)
 + cache.h: allow oid_object_info to handle arbitrary repositories
 + packfile: add repository argument to cache_or_unpack_entry
 + packfile: add repository argument to unpack_entry
 + packfile: add repository argument to read_object
 + packfile: add repository argument to packed_object_info
 + packfile: add repository argument to packed_to_object_type
 + packfile: add repository argument to retry_bad_packed_offset
 + cache.h: add repository argument to oid_object_info
 + cache.h: add repository argument to oid_object_info_extended
 (this branch is used by sb/object-store-alloc and sb/object-store-grafts.)

 The codepath around object-info API has been taught to take the
 repository object (which in turn tells the API which object store
 the objects are to be located).

 Will merge to 'master'.


* en/unpack-trees-split-index-fix (2018-05-02) 1 commit
  (merged to 'next' on 2018-05-16 at 1adff065b2)
 + unpack_trees: fix breakage when o->src_index != o->dst_index

 The split-index feature had a long-standing and dormant bug in
 certain use of the in-core merge machinery, which has been fixed.

 Will merge to 'master'.
 cf. <CACsJy8CeDhrT9GXe9q5gqsAeq_sSQ8jyF2nMOFxzjwKtE31oPQ@mail.gmail.com>


* bp/merge-rename-config (2018-05-08) 3 commits
 - merge: pass aggressive when rename detection is turned off
 - merge: add merge.renames config setting
 - merge: update documentation for {merge,diff}.renameLimit
 (this branch uses en/rename-directory-detection-reboot.)

 With merge.renames configuration set to false, the recursive merge
 strategy can be told not to spend cycles trying to find renamed
 paths and merge them accordingly.

 Will merge to 'next'.


* en/git-debugger (2018-04-25) 1 commit
  (merged to 'next' on 2018-05-08 at 73369cd1e5)
 + Make running git under other debugger-like programs easy

 Dev support.

 Will merge to 'master'.


* js/no-pager-shorthand (2018-05-04) 1 commit
  (merged to 'next' on 2018-05-08 at 10e6031dd1)
 + git: add -P as a short option for --no-pager

 "git --no-pager cmd" did not have short-and-sweet single letter
 option. Now it does.

 Will merge to 'master'.


* sb/diff-color-move-more (2018-04-25) 7 commits
 - diff.c: add --color-moved-ignore-space-delta option
 - diff.c: decouple white space treatment from move detection algorithm
 - diff.c: add a blocks mode for moved code detection
 - diff.c: adjust hash function signature to match hashmap expectation
 - diff.c: do not pass diff options as keydata to hashmap
 - xdiff/xdiffi.c: remove unneeded function declarations
 - xdiff/xdiff.h: remove unused flags

 "git diff --color-moved" feature has further been tweaked.

 Will merge to 'next'.


* ds/generation-numbers (2018-05-02) 11 commits
 - commit-graph.txt: update design document
 - merge: check config before loading commits
 - commit: use generation number in remove_redundant()
 - commit: add short-circuit to paint_down_to_common()
 - commit: use generation numbers for in_merge_bases()
 - ref-filter: use generation number for --contains
 - commit-graph: always load commit-graph information
 - commit: use generations in paint_down_to_common()
 - commit-graph: compute generation numbers
 - commit: add generation number to struct commmit
 - ref-filter: fix outdated comment on in_commit_list
 (this branch is used by ds/commit-graph-lockfile-fix; uses ds/lazy-load-trees.)

 A recently added "commit-graph" datafile has learned to store
 pre-computed generation numbers to speed up the decisions to stop
 history traversal.

 Is this ready for 'next' with ds/commit-graph-lockfile-fix?
 A commit with triple 'm' needs its title amended, though.


* en/rename-directory-detection-reboot (2018-05-08) 36 commits
  (merged to 'next' on 2018-05-08 at be350ebc17)
 + merge-recursive: fix check for skipability of working tree updates
 + merge-recursive: make "Auto-merging" comment show for other merges
 + merge-recursive: fix remainder of was_dirty() to use original index
 + merge-recursive: fix was_tracked() to quit lying with some renamed paths
 + t6046: testcases checking whether updates can be skipped in a merge
 + merge-recursive: avoid triggering add_cacheinfo error with dirty mod
 + merge-recursive: move more is_dirty handling to merge_content
 + merge-recursive: improve add_cacheinfo error handling
 + merge-recursive: avoid spurious rename/rename conflict from dir renames
 + directory rename detection: new testcases showcasing a pair of bugs
 + merge-recursive: fix remaining directory rename + dirty overwrite cases
 + merge-recursive: fix overwriting dirty files involved in renames
 + merge-recursive: avoid clobbering untracked files with directory renames
 + merge-recursive: apply necessary modifications for directory renames
 + merge-recursive: when comparing files, don't include trees
 + merge-recursive: check for file level conflicts then get new name
 + merge-recursive: add computation of collisions due to dir rename & merging
 + merge-recursive: check for directory level conflicts
 + merge-recursive: add get_directory_renames()
 + merge-recursive: make a helper function for cleanup for handle_renames
 + merge-recursive: split out code for determining diff_filepairs
 + merge-recursive: make !o->detect_rename codepath more obvious
 + merge-recursive: fix leaks of allocated renames and diff_filepairs
 + merge-recursive: introduce new functions to handle rename logic
 + merge-recursive: move the get_renames() function
 + directory rename detection: tests for handling overwriting dirty files
 + directory rename detection: tests for handling overwriting untracked files
 + directory rename detection: miscellaneous testcases to complete coverage
 + directory rename detection: testcases exploring possibly suboptimal merges
 + directory rename detection: more involved edge/corner testcases
 + directory rename detection: testcases checking which side did the rename
 + directory rename detection: files/directories in the way of some renames
 + directory rename detection: partially renamed directory testcase/discussion
 + directory rename detection: testcases to avoid taking detection too far
 + directory rename detection: directory splitting testcases
 + directory rename detection: basic testcases
 (this branch is used by bp/merge-rename-config.)

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.  A bug causing dirty files involved in a rename
 to be overwritten during merge has also been fixed as part of this
 work.  Incidentally, this also avoids updating a file in the
 working tree after a (non-trivial) merge whose result matches what
 our side originally had.

 Will merge to 'master'.


* nd/command-list (2018-05-10) 13 commits
 - completion: allow to customize the completable command list
 - completion: let git provide the completable command list
 - command-list.txt: documentation and guide line
 - help: use command-list.txt for the source of guides
 - help: add "-a --verbose" to list all commands with synopsis
 - git: support --list-cmds=list-<category>
 - completion: implement and use --list-cmds=main,others
 - git --list-cmds: collect command list in a string_list
 - git.c: convert --list-* to --list-cmds=*
 - Remove common-cmds.h
 - help: use command-list.h for common command list
 - generate-cmds.sh: export all commands to command-list.h
 - generate-cmds.sh: factor out synopsis extract code

 The list of commands with their various attributes were spread
 across a few places in the build procedure, but it now is getting a
 bit more consolidated to allow more automation.

 Will merge to 'next'.


* sg/complete-paths (2018-04-17) 11 commits
  (merged to 'next' on 2018-05-08 at 2a11444f90)
 + completion: fill COMPREPLY directly when completing paths
 + completion: improve handling quoted paths in 'git ls-files's output
 + completion: remove repeated dirnames with 'awk' during path completion
 + t9902-completion: ignore COMPREPLY element order in some tests
 + completion: use 'awk' to strip trailing path components
 + completion: let 'ls-files' and 'diff-index' filter matching paths
 + completion: improve handling quoted paths on the command line
 + completion: support completing non-ASCII pathnames
 + completion: simplify prefix path component handling during path completion
 + completion: move __git_complete_index_file() next to its helpers
 + t9902-completion: add tests demonstrating issues with quoted pathnames

 Command line completion (in contrib/) learned to complete pathnames
 for various commands better.

 Will merge to 'master'.


* sb/blame-color (2018-04-24) 3 commits
 - builtin/blame: add new coloring scheme config
 - builtin/blame: highlight recently changed lines
 - builtin/blame: dim uninteresting metadata lines

 "git blame" learns to unhighlight uninteresting metadata from the
 originating commit on lines that are the same as the previous one,
 and also paint lines in different colors depending on the age of
 the commit.

 Will merge to 'next'.


* ds/lazy-load-trees (2018-05-02) 6 commits
  (merged to 'next' on 2018-05-02 at d54016d9e3)
 + coccinelle: avoid wrong transformation suggestions from commit.cocci
  (merged to 'next' on 2018-04-25 at b90813f421)
 + commit-graph: lazy-load trees for commits
 + treewide: replace maybe_tree with accessor methods
 + commit: create get_commit_tree() method
 + treewide: rename tree to maybe_tree
 + Merge branch 'bw/c-plus-plus' into ds/lazy-load-trees
 (this branch is used by ds/commit-graph-lockfile-fix and ds/generation-numbers.)

 The code has been taught to use the duplicated information stored
 in the commit-graph file to learn the tree object name for a commit
 to avoid opening and parsing the commit object when it makes sense
 to do so.

 Will merge to 'master'.


* jk/branch-l-0-deprecation (2018-03-26) 3 commits
  (merged to 'next' on 2018-04-11 at 9b2b0305dd)
 + branch: deprecate "-l" option
 + t: switch "branch -l" to "branch --create-reflog"
 + t3200: unset core.logallrefupdates when testing reflog creation
 (this branch is used by jk/branch-l-1-removal and jk/branch-l-2-reincarnation.)

 The "-l" option in "git branch -l" is an unfortunate short-hand for
 "--create-reflog", but many users, both old and new, somehow expect
 it to be something else, perhaps "--list".  This step deprecates
 the short-hand and warns about the future removal of the it when it
 is used.

 Will cook in 'next'.
 Perhaps merge to 'master' immediately after 2.18 release?


* jk/branch-l-1-removal (2018-03-26) 1 commit
 - branch: drop deprecated "-l" option
 (this branch is used by jk/branch-l-2-reincarnation; uses jk/branch-l-0-deprecation.)

 Following the "git branch -l" deprecation, the short-hand is removed.

 Will keep in 'pu'.


* jk/branch-l-2-reincarnation (2018-03-26) 1 commit
 - branch: make "-l" a synonym for "--list"
 (this branch uses jk/branch-l-0-deprecation and jk/branch-l-1-removal.)

 Following the "git branch -l" removal, "-l" is resurrected as a
 short-hand for "--list".

 Will keep in 'pu'.


* nd/pack-objects-pack-struct (2018-04-16) 15 commits
  (merged to 'next' on 2018-05-16 at 171459475d)
 + ci: exercise the whole test suite with uncommon code in pack-objects
 + pack-objects: reorder members to shrink struct object_entry
 + pack-objects: shrink delta_size field in struct object_entry
 + pack-objects: shrink size field in struct object_entry
 + pack-objects: clarify the use of object_entry::size
 + pack-objects: don't check size when the object is bad
 + pack-objects: shrink z_delta_size field in struct object_entry
 + pack-objects: refer to delta objects by index instead of pointer
 + pack-objects: move in_pack out of struct object_entry
 + pack-objects: move in_pack_pos out of struct object_entry
 + pack-objects: use bitfield for object_entry::depth
 + pack-objects: use bitfield for object_entry::dfs_state
 + pack-objects: turn type and in_pack_type to bitfields
 + pack-objects: a bit of document about struct object_entry
 + read-cache.c: make $GIT_TEST_SPLIT_INDEX boolean

 "git pack-objects" needs to allocate tons of "struct object_entry"
 while doing its work, and shrinking its size helps the performance
 quite a bit.

 Will merge to 'master'.
 cf. <CACsJy8CuVRy4UPEwXJJYAjePEz5zjKMLhRjh9UFw0DPYTzobkw@mail.gmail.com>


* nd/repack-keep-pack (2018-04-16) 7 commits
  (merged to 'next' on 2018-05-08 at ab906be358)
 + pack-objects: show some progress when counting kept objects
 + gc --auto: exclude base pack if not enough mem to "repack -ad"
 + gc: handle a corner case in gc.bigPackThreshold
 + gc: add gc.bigPackThreshold config
 + gc: add --keep-largest-pack option
 + repack: add --keep-pack option
 + t7700: have closing quote of a test at the beginning of line

 "git gc" in a large repository takes a lot of time as it considers
 to repack all objects into one pack by default.  The command has
 been taught to pretend as if the largest existing packfile is
 marked with ".keep" so that it is left untouched while objects in
 other packs and loose ones are repacked.

 Will merge to 'master'.
 cf. <CACsJy8CuVRy4UPEwXJJYAjePEz5zjKMLhRjh9UFw0DPYTzobkw@mail.gmail.com>


* tg/worktree-add-existing-branch (2018-04-30) 4 commits
  (merged to 'next' on 2018-05-08 at 8b76505192)
 + worktree: teach "add" to check out existing branches
 + worktree: factor out dwim_branch function
 + worktree: improve message when creating a new worktree
 + worktree: remove extra members from struct add_opts

 "git worktree add" learned to check out an existing branch.

 Will merge to 'master'.


* js/rebase-recreate-merge (2018-04-26) 17 commits
  (merged to 'next' on 2018-05-16 at f1aeea2879)
 + rebase -i --rebase-merges: add a section to the man page
 + rebase -i: introduce --rebase-merges=[no-]rebase-cousins
 + pull: accept --rebase=merges to recreate the branch topology
 + rebase --rebase-merges: avoid "empty merges"
 + sequencer: handle post-rewrite for merge commands
 + sequencer: make refs generated by the `label` command worktree-local
 + rebase --rebase-merges: add test for --keep-empty
 + rebase: introduce the --rebase-merges option
 + rebase-helper --make-script: introduce a flag to rebase merges
 + sequencer: fast-forward `merge` commands, if possible
 + sequencer: introduce the `merge` command
 + sequencer: introduce new commands to reset the revision
 + git-rebase--interactive: clarify arguments
 + sequencer: offer helpful advice when a command was rescheduled
 + sequencer: refactor how original todo list lines are accessed
 + sequencer: make rearrange_squash() a bit more obvious
 + sequencer: avoid using errno clobbered by rollback_lock_file()
 (this branch is used by js/sequencer-and-root-commits.)

 "git rebase" learned "--rebase-merges" to transplant the whole
 topology of commit graph elsewhere.

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

* js/runtime-prefix-windows (2018-03-27) 5 commits
 . mingw/msvc: use the new-style RUNTIME_PREFIX helper
 . exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
 . exec_cmd: RUNTIME_PREFIX on some POSIX systems
 . Makefile: add Perl runtime prefix support
 . Makefile: generate Perl header from template file

 The Windows port was the first that allowed Git to be installed
 anywhere by having its components refer to each other with relative
 pathnames.  The recent dj/runtime-prefix topic extends the idea to
 other platforms, and its approach has been adopted back in the
 Windows port.

 Ejected, as the parent topic dj/runtime-prefix covers Windows now.


* bp/fsexcludes (2018-04-16) 2 commits
 . fsmonitor: switch to use new fsexcludes logic and remove unused untracked cache based logic
 . fsexcludes: add a programmatic way to exclude files from git's working directory traversal logic

 Can we have a few lines summary here, just like we have for other
 topic ;-) I personally take the overlong title of these commits as
 a sign that they can further be simplified and cleaned up by
 splitting, focusing the scope, etc.

 Retracted.
 cf. <0de30972-b0a2-67e8-7cff-c19daf9ece8b@gmail.com>
