Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC481F404
	for <e@80x24.org>; Tue, 20 Mar 2018 22:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeCTWT3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 18:19:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39194 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeCTWT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 18:19:26 -0400
Received: by mail-wr0-f194.google.com with SMTP id c24so3308966wrc.6
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=3mSdkLmIzVdw77VYdXgE2B5hm3BnqFu/7ej94LCMeaE=;
        b=peC65m/tZEKXdNR4vSFLByzBl+71Nb170d/V0d8bCfjFS5u8m5CBHRBVnpUkWxL+kJ
         Vm9KMlnGPlOD9HXmqeW+GD4KaY3Mwfv2LKwiDrKeixewk83Sx0A4Ms9C1ylTxepx8czJ
         tVBNx3bRGReL658ZE72+U5LVseQjXjkecApPJJLrg0IUeDbhQ+O17/JrxtI3gIFgV3pM
         QMbdUo9okjYmz645JOAtp1VWQOINbvy27I9m9PZZkpxWk6oNex9fAwZ1kfguJLV6KPWM
         fe/Z9yj7AMVlM6OU/Qiomz9B39hYGSwj16OvUNkOT6x4m3BrQpTfKoD9vjwAsKj3PRlR
         tvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=3mSdkLmIzVdw77VYdXgE2B5hm3BnqFu/7ej94LCMeaE=;
        b=l/MX1fmFnEzw0M2uV2cy3jY+7aIMu9ok4jpPcHZTioenmYZVfLY0uZH4USTvRcmxId
         xJOW1IbQWVL3yBFIOr9DbKZ5n9P0Q933lN8ODOQA4v162DRq7Br1sc8L10cJlsYHsZJm
         lhMAK1QNDQSfZT+jCuO5T4X7Qr75Z9q0163/2IWDRNTY15GcHhutqzzTlqp0CQ7ZtgNV
         Wlz/mTFIwudVuNzYtS65R8YPZXjbsLeFTtqFun55GuLMFgmpxZ8qNFQyUfozR/fx3Axy
         5282u/mGPKvyaIsq8uPFf6A6Bo34F93tZkdyC41Ymy7qIBLKfa3+TjHBqSXwnknfn2Tb
         ew4Q==
X-Gm-Message-State: AElRT7FXH4Ny+T/Lg4lCvENjoVplm7vf79u4OqBdySjP+5yrakUDmzwB
        Frzlj8sQ0YyF7tM1JgMkGl99kylJaUgpvQ==
X-Google-Smtp-Source: AG47ELv8TstJJu/NqynmQyXYlfcu5WUOg16AwEWf7QxMPkYZu4bw0E1eRLSNUSOqThSXPUWEfII36Q==
X-Received: by 10.223.182.2 with SMTP id f2mr13249591wre.117.1521584363717;
        Tue, 20 Mar 2018 15:19:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d85sm3179825wmi.23.2018.03.20.15.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Mar 2018 15:19:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2018, #04; Tue, 20)
X-master-at: 0afbf6caa5b16dcfa3074982e5b48e27d452dbbb
X-next-at: 9ac9d02b0bb5a12c247f9cbeaa8c30b8aed3f167
Date:   Tue, 20 Mar 2018 15:19:22 -0700
Message-ID: <xmqqlgemqtjp.fsf@gitster-ct.c.googlers.com>
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

Hopefully 2.17-rc1 can be tagged tomorrow, with a handful of topics
marked for 'master' in this issue of "What's cooking" report.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/man-sec-list (2018-03-08) 1 commit
  (merged to 'next' on 2018-03-09 at 9626b691e2)
 + git manpage: note git-security@googlegroups.com

 Doc update.


* ab/perl-fixes (2018-03-05) 13 commits
  (merged to 'next' on 2018-03-09 at 262d84c1ba)
 + perl Git::LoadCPAN: emit better errors under NO_PERL_CPAN_FALLBACKS
 + Makefile: add NO_PERL_CPAN_FALLBACKS knob
 + perl: move the perl/Git/FromCPAN tree to perl/FromCPAN
 + perl: generalize the Git::LoadCPAN facility
 + perl: move CPAN loader wrappers to another namespace
 + perl: update our copy of Mail::Address
 + perl: update our ancient copy of Error.pm
 + git-send-email: unconditionally use Net::{SMTP,Domain}
 + Git.pm: hard-depend on the File::{Temp,Spec} modules
 + gitweb: hard-depend on the Digest::MD5 5.8 module
 + Git.pm: add the "use warnings" pragma
 + Git.pm: remove redundant "use strict" from sub-package
 + perl: *.pm files should not have the executable bit

 Clean-up to various pieces of Perl code we have.


* cl/send-email-reply-to (2018-03-06) 2 commits
  (merged to 'next' on 2018-03-09 at 3d3c3ab441)
 + send-email: support separate Reply-To address
 + send-email: rename variable for clarity
 (this branch uses np/send-email-header-parsing.)

 "git send-email" learned "--reply-to=<address>" option.


* np/send-email-header-parsing (2017-12-15) 1 commit
  (merged to 'next' on 2018-03-09 at 91ef7216f7)
 + send-email: extract email-parsing code into a subroutine
 (this branch is used by cl/send-email-reply-to.)

 Code refactoring.


* sg/cvs-tests-with-x (2018-03-08) 2 commits
  (merged to 'next' on 2018-03-09 at 6ec749c7b7)
 + t9402-git-cvsserver-refs: don't check the stderr of a subshell
 + t9400-git-cvsserver-server: don't rely on the output of 'test_cmp'

 Allow running a couple of tests with "sh -x".


* tl/userdiff-csharp-async (2018-03-08) 1 commit
  (merged to 'next' on 2018-03-09 at 6dcf76e118)
 + userdiff.c: add C# async keyword in diff pattern

 Update funcname pattern used for C# to recognize "async" keyword.

--------------------------------------------------
[New Topics]

* bp/refresh-cache-ent-rehash-fix (2018-03-15) 1 commit
  (merged to 'next' on 2018-03-15 at bac8745f08)
 + Fix bugs preventing adding updated cache entries to the name hash

 The codepath to replace an existing entry in the index had a bug in
 updating the name hash structure, which has been fixed.

 Will merge to 'master'.


* jt/transfer-fsck-with-promissor (2018-03-15) 2 commits
  (merged to 'next' on 2018-03-15 at 6d1ccc965b)
 + fetch-pack: do not check links for partial fetch
 + index-pack: support checking objects but not links

 The transfer.fsckobjects configuration tells "git fetch" to
 validate the data and connected-ness of objects in the received
 pack; the code to perform this check has been taught about the
 narrow clone's convention that missing objects that are reachable
 from objects in a pack that came from a promissor remote is OK.

 Will merge to 'master'.


* ml/filter-branch-no-op-error (2018-03-15) 1 commit
  (merged to 'next' on 2018-03-15 at ba8ac48dec)
 + filter-branch: return 2 when nothing to rewrite

 "git filter-branch" learned to use a different exit code to allow
 the callers to tell the case where there was no new commits to
 rewrite from other error cases.

 Will cook in 'next'.


* ab/install-symlinks (2018-03-15) 3 commits
  (merged to 'next' on 2018-03-15 at 99d6bd6cb3)
 + Makefile: optionally symlink libexec/git-core binaries to bin/git
 + Makefile: add a gitexecdir_relative variable
 + Makefile: fix broken bindir_relative variable

 The build procedure learned to optionally use symbolic links
 (instead of hardlinks and copies) to install "git-foo" for built-in
 commands, whose binaries are all identical.

 Will cook in 'next'.


* ks/t3200-typofix (2018-03-15) 1 commit
  (merged to 'next' on 2018-03-15 at 8b8d397787)
 + t/t3200: fix a typo in a test description

 Test typofix.

 Will merge to 'master'.


* rj/http-code-cleanup (2018-03-15) 1 commit
  (merged to 'next' on 2018-03-15 at 0dfd462ff8)
 + http: fix an unused variable warning for 'curl_no_proxy'

 There was an unused file-scope static variable left in http.c when
 building for versions of libCURL that is older than 7.19.4, which
 has been fixed.

 Will merge to 'master'.
 This will become unnecessary, when we follow-through the
 jk/drop-ancient-curl topic.


* tg/stash-untracked-with-pathspec-fix (2018-03-20) 3 commits
 - stash push -u: don't create empty stash
 - stash push: avoid printing errors
 - stash: fix nonsense pipeline

 "git stash push -u -- <pathspec>" gave an unnecessary and confusing
 error message when there was no tracked files that match the
 <pathspec>, which has been fixed.

 Will merge to 'next'.


* dp/merge-strategy-doc-fix (2018-03-19) 1 commit
  (merged to 'next' on 2018-03-20 at 317e077588)
 + Documentation/merge-strategies: typofix

 Doc fix.

 Will merge to 'master'.


* js/ming-strftime (2018-03-19) 1 commit
  (merged to 'next' on 2018-03-20 at a9ca8172c7)
 + mingw: abort on invalid strftime formats

 Will merge to 'master'.


* ml/filter-branch-portability-fix (2018-03-19) 1 commit
  (merged to 'next' on 2018-03-20 at c7c17cfc8b)
 + filter-branch: use printf instead of echo -e

 Shell script portability fix.

 Will merge to 'master'.


* rj/warning-uninitialized-fix (2018-03-20) 2 commits
  (merged to 'next' on 2018-03-20 at 9ac9d02b0b)
 + read-cache: fix an -Wmaybe-uninitialized warning
 + -Wuninitialized: remove some 'init-self' workarounds

 Compilation fix.

 Will merge to 'master'.


* tz/complete-tag-delete-tagname (2018-03-19) 1 commit
  (merged to 'next' on 2018-03-20 at d63d45ff16)
 + completion: complete tags with git tag --delete/--verify

 Will merge to 'master'.


* tz/relnotes-1.7-on-perl (2018-03-16) 1 commit
  (merged to 'next' on 2018-03-20 at ed4b26e581)
 + RelNotes: add details on Perl module changes

 Will merge to 'master'.


* jk/attributes-path-doc (2018-03-20) 1 commit
  (merged to 'next' on 2018-03-20 at e965f0c68c)
 + doc/gitattributes: mention non-recursive behavior

 Doc update.

 Will merge to 'master'.


* pw/rebase-keep-empty-fixes (2018-03-20) 4 commits
 - SQUASH???
 - rebase: respect --no-keep-empty
 - rebase -i --keep-empty: don't prune empty commits
 - rebase --root: stop assuming squash_onto is unset
 (this branch is used by pw/rebase-signoff.)

 "git rebase --keep-empty" still removed an empty commit if the
 other side contained an empty commit (due to the "does an
 equivalent patch exist already?" check), which has been corrected.


* pw/rebase-signoff (2018-03-20) 4 commits
 - rebase --keep-empty: always use interactive rebase
 - rebase -p: error out if --signoff is given
 - rebase: extend --signoff support
 - Merge branch 'pw/rebase-keep-empty-fixes' into pw/rebase-signoff
 (this branch uses pw/rebase-keep-empty-fixes.)

 "git rebase" has learned to honor "--signoff" option when using
 backends other than "am" (but not "--preserve-merges").

--------------------------------------------------
[Stalled]

* sb/blame-color (2018-02-13) 3 commits
 - builtin/blame: highlight recently changed lines
 - builtin/blame: add option to color metadata fields separately
 - builtin/blame: dim uninteresting metadata

 Expecting a reroll.
 cf. https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/#t
 error messages are funny, can segfault, ...


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

* dj/runtime-prefix (2018-03-19) 3 commits
 - exec_cmd: RUNTIME_PREFIX on some POSIX systems
 - Makefile: add Perl runtime prefix support
 - Makefile: generate Perl header from template file

 A build-time option has been added to allow Git to be told to refer
 to its associated files relative to the main binary, in the same
 way that has been possible on Windows for quite some time, for
 Linux, BSDs and Darwin.


* ti/fetch-everything-local-optim (2018-03-14) 1 commit
  (merged to 'next' on 2018-03-15 at 2be87aa7a7)
 + fetch-pack.c: use oidset to check existence of loose object

 A "git fetch" from a repository with insane number of refs into a
 repository that is already up-to-date still wasted too many cycles
 making many lstat(2) calls to see if these objects at the tips
 exist as loose objects locally.  These lstat(2) calls are optimized
 away by enumerating all loose objects beforehand.

 It is unknown if the new strategy negatively affects existing use
 cases, fetching into a repository with many loose objects from a
 repository with small number of refs.

 Will cook in 'next'.


* ab/nuke-emacs-contrib (2018-03-13) 1 commit
  (merged to 'next' on 2018-03-15 at 13eb4e2d8b)
 + git{,-blame}.el: remove old bitrotting Emacs code

 The scripts in contrib/emacs/ have outlived their usefulness and
 have been removed.

 Will cook in 'next'.


* bc/object-id (2018-03-14) 36 commits
  (merged to 'next' on 2018-03-20 at f1800a33ff)
 + convert: convert to struct object_id
 + sha1_file: introduce a constant for max header length
 + Convert lookup_replace_object to struct object_id
 + sha1_file: convert read_sha1_file to struct object_id
 + sha1_file: convert read_object_with_reference to object_id
 + tree-walk: convert tree entry functions to object_id
 + streaming: convert istream internals to struct object_id
 + tree-walk: convert get_tree_entry_follow_symlinks internals to object_id
 + builtin/notes: convert static functions to object_id
 + builtin/fmt-merge-msg: convert remaining code to object_id
 + sha1_file: convert sha1_object_info* to object_id
 + Convert remaining callers of sha1_object_info_extended to object_id
 + packfile: convert unpack_entry to struct object_id
 + sha1_file: convert retry_bad_packed_offset to struct object_id
 + sha1_file: convert assert_sha1_type to object_id
 + builtin/mktree: convert to struct object_id
 + streaming: convert open_istream to use struct object_id
 + sha1_file: convert check_sha1_signature to struct object_id
 + sha1_file: convert read_loose_object to use struct object_id
 + builtin/index-pack: convert struct ref_delta_entry to object_id
 + archive: convert sha1_file_to_archive to struct object_id
 + archive: convert write_archive_entry_fn_t to object_id
 + builtin/mktag: convert to struct object_id
 + replace_object: convert struct replace_object to object_id
 + send-pack: convert remaining functions to struct object_id
 + http-walker: convert struct object_request to use struct object_id
 + Convert find_unique_abbrev* to struct object_id
 + wt-status: convert struct wt_status_state to object_id
 + strbuf: convert strbuf_add_unique_abbrev to use struct object_id
 + ref-filter: convert grab_objectname to struct object_id
 + tree: convert read_tree_recursive to struct object_id
 + resolve-undo: convert struct resolve_undo_info to object_id
 + cache-tree: convert remnants to struct object_id
 + cache-tree: convert write_*_as_tree to object_id
 + builtin/write-tree: convert to struct object_id
 + bulk-checkin: convert index_bulk_checkin to struct object_id

 Conversion from uchar[20] to struct object_id continues.

 Will cook in 'next'.


* jh/fsck-promisors (2018-03-13) 1 commit
  (merged to 'next' on 2018-03-15 at 0c283dbe5e)
 + sha1_file: restore OBJECT_INFO_QUICK functionality

 A hotfix to a topic that graduated recently.

 Will merge to 'master'.


* ma/shortlog-revparse (2018-03-15) 3 commits
  (merged to 'next' on 2018-03-15 at 2c2de7eb95)
 + shortlog: disallow left-over arguments outside repo
 + shortlog: add usage-string for stdin-reading
 + git-shortlog.txt: reorder usages

 "git shortlog cruft" aborted with a BUG message when run outside a
 Git repository.  The command has been taught to complain about
 extra and unwanted arguments on its command line instead in such a
 case.

 Will cook in 'next'.


* ab/pcre-v2 (2018-03-14) 3 commits
  (merged to 'next' on 2018-03-15 at e77b116903)
 + Makefile: make USE_LIBPCRE=YesPlease mean v2, not v1
 + configure: detect redundant --with-libpcre & --with-libpcre1
 + configure: fix a regression in PCRE v1 detection

 Git can be built to use either v1 or v2 of the PCRE library, and so
 far, the build-time configuration USE_LIBPCRE=YesPlease instructed
 the build procedure to use v1, but now it means v2.  USE_LIBPCRE1
 and USE_LIBPCRE2 can be used to explicitly choose which version to
 use, as before.

 Will cook in 'next'.


* bb/git-gui-ssh-key-files (2018-03-02) 2 commits
 - Merge branch 'bb/ssh-key-files' of git-gui into bb/git-gui-ssh-key-files
 - git-gui: search for all current SSH key types

 "git gui" learned that "~/.ssh/id_ecdsa.pub" and
 "~/.ssh/id_ed25519.pub" are also possible SSH key files.


* bp/git-gui-bind-kp-enter (2018-03-02) 2 commits
 - Merge branch 'bp/bind-kp-enter' of git-gui into bp/git-gui-bind-kp-enter
 - git-gui: bind CTRL/CMD+numpad ENTER to do_commit

 "git gui" performs commit upon CTRL/CMD+ENTER but the
 CTRL/CMD+KP_ENTER (i.e. enter key on the numpad) did not have the
 same key binding.  It now does.


* cb/git-gui-ttk-style (2018-03-05) 2 commits
 - Merge branch 'cb/ttk-style' of git-gui into cb/git-gui-ttk-style
 - git-gui: workaround ttk:style theme use

 "git gui" has been taught to work with old versions of tk (like
 8.5.7) that do not support "ttk::style theme use" as a way to query
 the current theme.


* nd/pack-objects-pack-struct (2018-03-19) 11 commits
 . pack-objects: reorder members to shrink struct object_entry
 . pack-objects: shrink delta_size field in struct object_entry
 . pack-objects: shrink size field in struct object_entry
 . pack-objects: shrink z_delta_size field in struct object_entry
 . pack-objects: refer to delta objects by index instead of pointer
 . pack-objects: move in_pack out of struct object_entry
 . pack-objects: move in_pack_pos out of struct object_entry
 . pack-objects: use bitfield for object_entry::depth
 . pack-objects: use bitfield for object_entry::dfs_state
 . pack-objects: turn type and in_pack_type to bitfields
 . pack-objects: a bit of document about struct object_entry

 "git pack-objects" needs to allocate tons of "struct object_entry"
 while doing its work, and shrinking its size helps the performance
 quite a bit.


* nd/repack-keep-pack (2018-03-07) 6 commits
 - SQUASH???
 - pack-objects: display progress in get_object_details()
 - pack-objects: show some progress when counting kept objects
 - gc --auto: exclude base pack if not enough mem to "repack -ad"
 - repack: add --keep-pack option
 - t7700: have closing quote of a test at the beginning of line

 "git gc" in a large repository takes a lot of time as it considers
 to repack all objects into one pack by default.  The command has
 been taught to pretend as if the largest existing packfile is
 marked with ".keep" so that it is left untouched while objects in
 other packs and loose ones are repacked.

 Reroll exists, but it seems to be still slushy.
 cf. <20180316192745.19557-1-pclouds@gmail.com>


* nd/worktree-prune (2018-03-15) 3 commits
  (merged to 'next' on 2018-03-20 at e2d9677b20)
 + worktree prune: improve prune logic when worktree is moved
 + worktree: delete dead code
 + gc.txt: more details about what gc does

 The way "git worktree prune" worked internally has been simplified,
 by assuming how "git worktree move" moves an existing worktree to a
 different place.

 Will cook in 'next'.


* pw/add-p-select (2018-03-16) 3 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.


* ld/p4-unshelve (2018-02-22) 1 commit
 - git-p4: add unshelve command

 "git p4" learned to "unshelve" shelved commit from P4.

 Will hold, perhaps drop and use format-change that uses a proper "diff".
 cf. <CAE5ih7_ooDMqVtTMoQ70s5XCkncr04HY0JkqSp1UmKQeG81oaA@mail.gmail.com>


* ps/contains-id-error-message (2018-03-19) 1 commit
 - Make options that expect object ids less chatty if id is invalid

 "git tag --contains no-such-commit" gave a full list of options
 after giving an error message.


* nd/remove-ignore-env-field (2018-03-05) 5 commits
  (merged to 'next' on 2018-03-15 at 802b6ea1cb)
 + repository: delete ignore_env member
 + sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
 + repository.c: delete dead functions
 + repository.c: move env-related setup code back to environment.c
 + repository: initialize the_repository in main()
 (this branch is used by sb/object-store and sb/packfiles-in-repository.)

 Code clean-up for the "repository" abstraction.

 Will cook in 'next'.


* sb/object-store (2018-03-05) 27 commits
 - sha1_file: allow sha1_loose_object_info to handle arbitrary repositories
 - sha1_file: allow map_sha1_file to handle arbitrary repositories
 - sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
 - sha1_file: allow open_sha1_file to handle arbitrary repositories
 - sha1_file: allow stat_sha1_file to handle arbitrary repositories
 - sha1_file: allow sha1_file_name to handle arbitrary repositories
 - sha1_file: add repository argument to sha1_loose_object_info
 - sha1_file: add repository argument to map_sha1_file
 - sha1_file: add repository argument to map_sha1_file_1
 - sha1_file: add repository argument to open_sha1_file
 - sha1_file: add repository argument to stat_sha1_file
 - sha1_file: add repository argument to sha1_file_name
 - sha1_file: allow prepare_alt_odb to handle arbitrary repositories
 - sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
 - sha1_file: add repository argument to prepare_alt_odb
 - sha1_file: add repository argument to link_alt_odb_entries
 - sha1_file: add repository argument to read_info_alternates
 - sha1_file: add repository argument to link_alt_odb_entry
 - sha1_file: add raw_object_store argument to alt_odb_usable
 - pack: move approximate object count to object store
 - pack: move prepare_packed_git_run_once to object store
 - object-store: close all packs upon clearing the object store
 - object-store: move packed_git and packed_git_mru to object store
 - object-store: free alt_odb_list
 - object-store: move alt_odb_list and alt_odb_tail to object store
 - object-store: migrate alternates struct and functions from cache.h
 - repository: introduce raw object store field
 (this branch is used by sb/packfiles-in-repository; uses nd/remove-ignore-env-field.)

 Refactoring the internal global data structure to make it possible
 to open multiple repositories, work with and then close them.

 Rerolled by Duy on top of a separate preliminary clean-up topic.
 The resulting structure of the topics looked very sensible.

 Waiting for a follow-up discussion.


* sb/packfiles-in-repository (2018-03-05) 12 commits
 - packfile: keep prepare_packed_git() private
 - packfile: allow find_pack_entry to handle arbitrary repositories
 - packfile: add repository argument to find_pack_entry
 - packfile: allow reprepare_packed_git to handle arbitrary repositories
 - packfile: allow prepare_packed_git to handle arbitrary repositories
 - packfile: allow prepare_packed_git_one to handle arbitrary repositories
 - packfile: add repository argument to reprepare_packed_git
 - packfile: add repository argument to prepare_packed_git
 - packfile: add repository argument to prepare_packed_git_one
 - packfile: allow install_packed_git to handle arbitrary repositories
 - packfile: allow rearrange_packed_git to handle arbitrary repositories
 - packfile: allow prepare_packed_git_mru to handle arbitrary repositories
 (this branch uses nd/remove-ignore-env-field and sb/object-store.)

 Refactoring of the internal global data structure continues.

 Waiting for a follow-up discussion.


* ma/skip-writing-unchanged-index (2018-03-01) 1 commit
  (merged to 'next' on 2018-03-15 at cdbbc66464)
 + write_locked_index(): add flag to avoid writing unchanged index

 Internal API clean-up to allow write_locked_index() optionally skip
 writing the in-core index when it is not modified.

 Will merge to 'master'.


* ds/commit-graph (2018-03-14) 17 commits
 - SQUASH??? sparse fixes
 - commit-graph: implement "--additive" option
 - commit-graph: build graph from starting commits
 - commit-graph: read only from specific pack-indexes
 - commit: integrate commit graph with commit parsing
 - commit-graph: close under reachability
 - commit-graph: add core.commitGraph setting
 - commit-graph: implement git commit-graph read
 - commit-graph: implement 'git-commit-graph write'
 - commit-graph: implement write_commit_graph()
 - commit-graph: create git-commit-graph builtin
 - graph: add commit graph design document
 - commit-graph: add format document
 - csum-file: refactor finalize_hashfile() method
 - csum-file: rename hashclose() to finalize_hashfile()
 - Merge branch 'jk/cached-commit-buffer' into HEAD
 - Merge branch 'jt/binsearch-with-fanout' into HEAD

 Precompute and store information necessary for ancestry traversal
 in a separate file to optimize graph walking.

 It seems that this topic is getting there.


* ma/config-page-only-in-list-mode (2018-02-21) 3 commits
  (merged to 'next' on 2018-03-15 at 652430af12)
 + config: change default of `pager.config` to "on"
 + config: respect `pager.config` in list/get-mode only
 + t7006: add tests for how git config paginates

 In a way similar to how "git tag" learned to honor the pager
 setting only in the list mode, "git config" learned to ignore the
 pager setting when it is used for setting values (i.e. when the
 purpose of the operation is not to "show").

 Will merge to 'master'.


* pc/submodule-helper-foreach (2018-02-02) 5 commits
 - submodule: port submodule subcommand 'foreach' from shell to C
 - submodule foreach: document variable '$displaypath'
 - submodule foreach: clarify the '$toplevel' variable documentation
 - submodule foreach: document '$sm_path' instead of '$path'
 - submodule foreach: correct '$path' in nested submodules from a subdirectory

 Expecting a response to review comments
 e.g. cf. <20180206150044.1bffbb573c088d38c8e44bf5@google.com>


* tg/worktree-add-existing-branch (2018-03-19) 4 commits
 - worktree: teach "add" to check out existing branches
 - worktree: factor out dwim_branch function
 - worktree: be clearer when "add" dwim-ery kicks in
 - worktree: improve message when creating a new worktree

 "git worktree add" learned to check out an existing branch.


* js/rebase-recreate-merge (2018-02-23) 12 commits
  (merged to 'next' on 2018-03-15 at 3d1671756f)
 + rebase -i: introduce --recreate-merges=[no-]rebase-cousins
 + pull: accept --rebase=recreate to recreate the branch topology
 + sequencer: handle post-rewrite for merge commands
 + sequencer: make refs generated by the `label` command worktree-local
 + rebase: introduce the --recreate-merges option
 + rebase-helper --make-script: introduce a flag to recreate merges
 + sequencer: fast-forward merge commits, if possible
 + sequencer: introduce the `merge` command
 + sequencer: introduce new commands to reset the revision
 + git-rebase--interactive: clarify arguments
 + sequencer: make rearrange_squash() a bit more obvious
 + sequencer: avoid using errno clobbered by rollback_lock_file()

 "git rebase" learned "--recreate-merges" to transplant the whole
 topology of commit graph elsewhere.

 This serise has been reverted out of 'next', expecting that it will
 be replaced by a reroll on top of a couple of topics by Phillip.


* bw/protocol-v2 (2018-03-15) 35 commits
 - remote-curl: don't request v2 when pushing
 - remote-curl: implement stateless-connect command
 - http: eliminate "# service" line when using protocol v2
 - http: don't always add Git-Protocol header
 - http: allow providing extra headers for http requests
 - remote-curl: store the protocol version the server responded with
 - remote-curl: create copy of the service name
 - pkt-line: add packet_buf_write_len function
 - transport-helper: introduce stateless-connect
 - transport-helper: refactor process_connect_service
 - transport-helper: remove name parameter
 - connect: don't request v2 when pushing
 - connect: refactor git_connect to only get the protocol version once
 - fetch-pack: support shallow requests
 - fetch-pack: perform a fetch using v2
 - upload-pack: introduce fetch server command
 - push: pass ref prefixes when pushing
 - fetch: pass ref prefixes when fetching
 - ls-remote: pass ref prefixes when requesting a remote's refs
 - transport: convert transport_get_remote_refs to take a list of ref prefixes
 - transport: convert get_refs_list to take a list of ref prefixes
 - connect: request remote refs using v2
 - ls-refs: introduce ls-refs server command
 - serve: introduce git-serve
 - test-pkt-line: introduce a packet-line test helper
 - protocol: introduce enum protocol_version value protocol_v2
 - transport: store protocol version
 - connect: discover protocol version outside of get_remote_heads
 - connect: convert get_remote_heads to use struct packet_reader
 - transport: use get_refs_via_connect to get refs
 - upload-pack: factor out processing lines
 - upload-pack: convert to a builtin
 - pkt-line: add delim packet support
 - pkt-line: allow peeking a packet line without consuming it
 - pkt-line: introduce packet_read_with_status

 The beginning of the next-gen transfer protocol.

 Is everybody happy with this version?  One design decision with
 larger consequence "to or not to build in?" has been settled in
 favor of status quo, IIRC.


* ls/checkout-encoding (2018-03-16) 10 commits
 - convert: add round trip check based on 'core.checkRoundtripEncoding'
 - convert: add tracing for 'working-tree-encoding' attribute
 - convert: check for detectable errors in UTF encodings
 - convert: add 'working-tree-encoding' attribute
 - utf8: add function to detect a missing UTF-16/32 BOM
 - utf8: add function to detect prohibited UTF-16/32 BOM
 - utf8: teach same_encoding() alternative UTF encoding names
 - strbuf: add a case insensitive starts_with()
 - strbuf: add xstrdup_toupper()
 - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).


* en/rename-directory-detection (2018-02-27) 29 commits
  (merged to 'next' on 2018-03-06 at d42470f86e)
 + merge-recursive: ensure we write updates for directory-renamed file
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

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.  A bug causing dirty files involved in a rename
 to be overwritten during merge has also been fixed as part of this
 work.

 Will cook in 'next'.
