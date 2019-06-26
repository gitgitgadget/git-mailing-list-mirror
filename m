Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5391F461
	for <e@80x24.org>; Wed, 26 Jun 2019 22:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFZW3p (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 18:29:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53143 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZW3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 18:29:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82A2C75D96;
        Wed, 26 Jun 2019 18:29:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=5
        0SpRLI61wCW2pKoIBYUFmOyQEY=; b=FZxtkyflvH6KX+xtllyYAw+XAYFZbA9Gl
        R8MQKMS0IYijwBtjaXL/uOfZyVtkdw6BpX0oqnGNb36yIPN2Y3n4yqaH9/YSIagp
        06i0pfz82bgxc7o3KCBCWz6W198ZVGGYk0Pasr1EB/lYk7k/Ea+GICV87NVYYgsH
        fwHLVk0p7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=SZ6
        QcTukfUjoiY0ZjZZ0hhv3XDOPAhPthdEmpK13+R4JNNDegHsTMfpMGBoKPW/ad+k
        9o7+OjOVQUJG0gPw2VR3BXuLuztuLhuuVxdoZUG/xiWiOiSvC3ZE88dboWx1k3BR
        YTsASW8FOmBOuXYawpUVqTyGyEENbJfDsliex/68=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78D4C75D95;
        Wed, 26 Jun 2019 18:29:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B8F675D94;
        Wed, 26 Jun 2019 18:29:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2019, #06; Wed, 26)
X-master-at: 8dca754b1e874719a732bc9ab7b0e14b21b1bc10
X-next-at: ee2e6308ae95ce7ba2fabedcc43f5f741e71c152
Importance: high
Date:   Wed, 26 Jun 2019 15:29:29 -0700
Message-ID: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDFEA89A-9861-11E9-B639-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The third batch of topics post 2.22 are now in 'master', and the tip
of 'next' has been rewound.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/hash-object-doc (2019-05-28) 1 commit
  (merged to 'next' on 2019-06-06 at 8e4d85b906)
 + hash-object doc: stop mentioning git-cvsimport

 Doc update.


* an/ignore-doc-update (2019-06-04) 1 commit
  (merged to 'next' on 2019-06-06 at 8579d82c0d)
 + gitignore.txt: make slash-rules more readable

 The description about slashes in gitignore patterns (used to
 indicate things like "anchored to this level only" and "only
 matches directories") has been revamped.


* cm/send-email-document-req-modules (2019-05-31) 1 commit
  (merged to 'next' on 2019-06-06 at acf1c2fc96)
 + send-email: update documentation of required Perl modules

 A doc update.


* jt/partial-clone-missing-ref-delta-base (2019-06-11) 4 commits
  (merged to 'next' on 2019-06-12 at 95628af9bb)
 + t5616: cover case of client having delta base
 + t5616: use correct flag to check object is missing
  (merged to 'next' on 2019-05-29 at 5d7573a151)
 + index-pack: prefetch missing REF_DELTA bases
 + t5616: refactor packfile replacement

 "git fetch" into a lazy clone forgot to fetch base objects that are
 necessary to complete delta in a thin packfile, which has been
 corrected.


* md/list-objects-filter-memfix (2019-05-31) 1 commit
  (merged to 'next' on 2019-06-06 at 80f0187cef)
 + list-objects-filter: correct usage of ALLOC_GROW

 The filter_data used in the list-objects-filter (which manages a
 lazily sparse clone repository) did not use the dynamic array API
 correctly---'nr' is supposed to point at one past the last element
 of the array in use.  This has been corrected.


* md/list-objects-filter-parse-msgfix (2019-05-31) 1 commit
  (merged to 'next' on 2019-06-06 at 736f3c175b)
 + list-objects-filter-options: error is localizeable

 Make an end-user facing message localizable.


* md/url-parse-harden (2019-06-04) 2 commits
  (merged to 'next' on 2019-06-06 at b187c3dbfe)
 + url: do not allow %00 to represent NUL in URLs
 + url: do not read past end of buffer

 The URL decoding code has been updated to avoid going past the end
 of the string while parsing %-<hex>-<hex> sequence.


* ml/userdiff-rust (2019-05-30) 2 commits
  (merged to 'next' on 2019-06-12 at 33b88fa9e5)
 + userdiff: two simplifications of patterns for rust
  (merged to 'next' on 2019-05-19 at 1266fddce5)
 + userdiff: add built-in pattern for rust

 The pattern "git diff/grep" use to extract funcname and words
 boundary for Rust has been added.


* mo/clang-format-for-each-update (2019-06-04) 1 commit
  (merged to 'next' on 2019-06-06 at ee3066bb65)
 + clang-format: use git grep to generate the ForEachMacros list

 The list of for-each like macros used by clang-format has been
 updated.

--------------------------------------------------
[New Topics]

* ab/test-env (2019-06-21) 8 commits
 - tests: make GIT_TEST_FAIL_PREREQS a boolean
 - tests: replace test_tristate with "git env--helper"
 - tests README: re-flow a previously changed paragraph
 - tests: make GIT_TEST_GETTEXT_POISON a boolean
 - t6040 test: stop using global "script" variable
 - config.c: refactor die_bad_number() to not call gettext() early
 - env--helper: new undocumented builtin wrapping git_env_*()
 - config tests: simplify include cycle test

 Many GIT_TEST_* environment variables control various aspects of
 how our tests are run, but a few followed "non-empty is true, empty
 or unset is false" while others followed the usual "there are a few
 ways to spell true, like yes, on, etc., and also ways to spell
 false, like no, off, etc." convention.


* cc/first-contrib-tutorial (2019-06-24) 1 commit
 - doc: improve usage string in MyFirstContribution

 Update docs used in a tutorial.

 Will merge to 'next'.


* ds/early-access (2019-06-20) 3 commits
 - repo-settings: pack.useSparse=true
 - repo-settings: use index.version=4 by default
 - repo-settings: create core.featureAdoptionRate setting

 A mechanism to enable newish configuration settings in bulk has
 been invented.


* jh/msvc (2019-06-25) 20 commits
 - msvc: ignore .dll and incremental compile output
 - msvc: avoid debug assertion windows in Debug Mode
 - msvc: do not pretend to support all signals
 - msvc: add pragmas for common warnings
 - msvc: add a compile-time flag to allow detailed heap debugging
 - msvc: support building Git using MS Visual C++
 - msvc: update Makefile to allow for spaces in the compiler path
 - msvc: fix detect_msys_tty()
 - msvc: define ftello()
 - msvc: do not re-declare the timespec struct
 - msvc: mark a variable as non-const
 - msvc: define O_ACCMODE
 - msvc: include sigset_t definition
 - msvc: fix dependencies of compat/msvc.c
 - mingw: replace mingw_startup() hack
 - obstack: fix compiler warning
 - cache-tree/blame: avoid reusing the DEBUG constant
 - t0001 (mingw): do not expect a specific order of stdout/stderr
 - Mark .bat files as requiring CR/LF endings
 - mingw: fix a typo in the msysGit-specific section

 Support to build with MSVC has been updated.

 Will merge to 'next'.


* jk/delta-islands-progress-fix (2019-06-20) 1 commit
 - delta-islands: respect progress flag

 The codepath to compute delta islands used to spew progress output
 without giving the callers any way to squelch it, which has been
 fixed.

 Will merge to 'next'.


* jk/oidhash (2019-06-20) 17 commits
 - hashmap: convert sha1hash() to oidhash()
 - hash.h: move object_id definition from cache.h
 - khash: rename oid helper functions
 - khash: drop sha1-specific map types
 - pack-bitmap: convert khash_sha1 maps into kh_oid_map
 - delta-islands: convert island_marks khash to use oids
 - khash: rename kh_oid_t to kh_oid_set
 - khash: drop broken oid_map typedef
 - object: convert create_object() to use object_id
 - object: convert internal hash_obj() to object_id
 - object: convert lookup_object() to use object_id
 - object: convert lookup_unknown_object() to use object_id
 - pack-objects: convert locate_object_entry_hash() to object_id
 - pack-objects: convert packlist_find() to use object_id
 - pack-bitmap-write: convert some helpers to use object_id
 - upload-pack: rename a "sha1" variable to "oid"
 - describe: fix accidental oid/hash type-punning

 Code clean-up to remove hardcoded SHA-1 hash from manty places.

 Will merge to 'next'.


* nd/fetch-capability-tweak (2019-06-20) 3 commits
 - fetch-pack: print server version at the top in -v -v
 - fetch-pack: print all relevant supported capabilities with -v -v
 - fetch-pack: move capability names out of i18n strings

 Protocol capabilities that go over wire should never be translated,
 but it was incorrectly marked for translation, which has been
 corrected.  The output of protocol capabilities for debugging has
 been tweaked a bit.

 Will merge to 'next'.


* nd/index-dump-in-json (2019-06-26) 11 commits
 - SQUASH???
 - t3008: use the new SINGLE_CPU prereq
 - read-cache.c: dump "IEOT" extension as json
 - read-cache.c: dump "EOIE" extension as json
 - resolve-undo.c: dump "REUC" extension as json
 - fsmonitor.c: dump "FSMN" extension as json
 - split-index.c: dump "link" extension as json
 - dir.c: dump "UNTR" extension as json
 - cache-tree.c: dump "TREE" extension as json
 - read-cache.c: dump common extension info in json
 - ls-files: add --json to dump the index

 "ls-files" learned "--debug-json" option to dump the contents and
 the extensions of the index file.


* nd/switch-and-restore-more (2019-06-20) 2 commits
 - completion: disable dwim on "git switch -d"
 - switch: allow to switch in the middle of bisect
 (this branch is used by jl/status-reduce-vertical-blank; uses nd/switch-and-restore.)

 (this topic is just bits and pieces out of 4 patches)


* rs/config-unit-parsing (2019-06-24) 3 commits
 - config: simplify parsing of unit factors
 - config: don't multiply in parse_unit_factor()
 - config: use unsigned_mult_overflows to check for overflows
 (this branch uses js/gcc-8-and-9.)

 The code to parse scaled numbers out of configuration files has
 been made more robust and also easier to follow.

 Will merge to 'next'.


* ab/fail-prereqs-in-test (2019-06-21) 1 commit
 - tests: mark two failing tests under FAIL_PREREQS

 Test updates.

 Will merge to 'next'.


* ds/fetch-disable-force-notice (2019-06-21) 3 commits
 - pull: add --[no-]show-forced-updates passthrough
 - fetch: warn about forced updates in branch listing
 - fetch: add --[no-]show-forced-updates argument

 "git fetch" and "git pull" reports when a fetch results in
 non-fast-forward updates to let the user notice unusual situation.
 The commands learned "--no-shown-forced-updates" option to disable
 this safety feature.

 Will merge to 'next'.


* jh/status-aheadbehind (2019-06-21) 3 commits
 - status: ignore status.aheadbehind in porcelain formats
 - status: warn when a/b calculation takes too long
 - status: add status.aheadbehind setting

 "git status" can be told a non-standard default value for the
 "--[no-]ahead-behind" option with a new configuration variable
 status.aheadBehind.

 Will merge to 'next'.


* js/t0001-case-insensitive (2019-06-24) 1 commit
 - t0001: fix on case-insensitive filesystems

 Test update.

 Will merge to 'next'.


* dr/progress-i18n (2019-06-24) 1 commit
 - l10n: localizable upload progress messages

 Progress messages have been made localizable.

 Not quite with the code duplication...


* jw/gitweb-sample-update (2019-06-24) 1 commit
 - doc: don't use git.kernel.org as example gitweb URL

 Doc update.

 Will merge to 'next'.


* ms/submodule-foreach-fix (2019-06-25) 1 commit
 - submodule foreach: fix recursion of options

 "git submodule foreach" did not protect command line options passed
 to the command to be run in each submodule correctly, when the
 "--recursive" option was in use.

 Will merge to 'next'.


* pw/status-with-corrupt-sequencer-state (2019-06-25) 3 commits
 - status: do not report errors in sequencer/todo
 - sequencer: factor out todo command name parsing
 - sequencer: always allow tab after command name

 The code to read state files used by the sequencer machinery for
 "git status" has been made more robust against a corrupt or stale
 state files.


* sg/t5551-fetch-smart-error-is-translated (2019-06-25) 1 commit
 - t5551: use 'test_i18ngrep' to check translated output

 Test update.

 Will merge to 'next'.


* ab/no-kwset (2019-06-26) 7 commits
 - grep: use PCRE v2 for optimized fixed-string search
 - grep: remove the kwset optimization
 - grep: drop support for \0 in --fixed-strings <pattern>
 - grep: make the behavior for \0 in patterns sane
 - grep tests: move binary pattern tests into their own file
 - grep tests: move "grep binary" alongside the rest
 - grep: inline the return value of a function call used only once

 Retire use of kwset library, which is an optimization for looking
 for fixed strings, with use of pcre2 JIT.

 Will merge to 'next'.


* mt/dir-iterator-updates (2019-06-25) 10 commits
 - clone: replace strcmp by fspathcmp
 - clone: use dir-iterator to avoid explicit dir traversal
 - clone: extract function from copy_or_link_directory
 - clone: copy hidden paths at local clone
 - dir-iterator: add flags parameter to dir_iterator_begin
 - dir-iterator: refactor state machine model
 - dir-iterator: use warning_errno when possible
 - dir-iterator: add tests for dir-iterator API
 - clone: better handle symlinked files at .git/objects/
 - clone: test for our behavior on odd objects/* content

 Adjust the dir-iterator API and apply it to the local clone
 optimization codepath.

 Is this ready for 'next'?


* nd/tree-walk-with-repo (2019-06-26) 6 commits
 - Use the right 'struct repository' instead of the_repository
 - match-trees.c: remove the_repo from shift_tree*()
 - tree-walk.c: remove the_repo from get_tree_entry_follow_symlinks()
 - tree-walk.c: remove the_repo from get_tree_entry()
 - tree-walk.c: remove the_repo from fill_tree_descriptor()
 - sha1-file.c: remove the_repo from read_object_with_reference()

 The tree-walk API learned to pass an in-core repository
 instance throughout more codepaths.


* jh/trace2-sid-fix (2019-06-26) 1 commit
 - trace2: correct typo in technical documentation

 Typofix.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 - SQUASH???
 - upload-pack: send part of packfile response as uri
 - fetch-pack: support more than one pack lockfile
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http: improve documentation of http_pack_request
 - http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).

 Stalled


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.

--------------------------------------------------
[Cooking]

* cb/fsmonitor-intfix (2019-06-17) 1 commit
  (merged to 'next' on 2019-06-26 at bed7c7e78b)
 + fsmonitor: avoid signed integer overflow / infinite loop

 Variable type fix.

 Will merge to 'master'.


* es/rev-list-no-object-names (2019-06-20) 1 commit
 - rev-list: teach --no-object-names to enable piping

 "git rev-list --objects" learned with "--no-object-names" option to
 squelch the path to the object that is used as a grouping hint for
 pack-objects.

 Will merge to 'next'.


* md/list-objects-filter-combo (2019-06-17) 10 commits
 - list-objects-filter-options: make parser void
 - list-objects-filter-options: clean up use of ALLOC_GROW
 - list-objects-filter-options: allow mult. --filter
 - strbuf: give URL-encoding API a char predicate fn
 - list-objects-filter-options: make filter_spec a string_list
 - list-objects-filter-options: move error check up
 - list-objects-filter: implement composite filters
 - list-objects-filter-options: always supply *errbuf
 - list-objects-filter: put omits set in filter struct
 - list-objects-filter: make API easier to use

 The list-objects-filter API (used to create a sparse/lazy clone)
 learned to take a combined filter specification.

 Will merge to 'next'.


* pw/doc-synopsis-markup-opmode-options (2019-06-17) 1 commit
  (merged to 'next' on 2019-06-26 at 4258eddd2d)
 + show --continue/skip etc. consistently in synopsis

 Docfix.

 Will merge to 'master'.


* rs/copy-array (2019-06-17) 2 commits
  (merged to 'next' on 2019-06-26 at dfaa162f88)
 + use COPY_ARRAY for copying arrays
 + coccinelle: use COPY_ARRAY for copying arrays

 Code clean-up.

 Will merge to 'master'.


* cb/mkstemps-uint-type-fix (2019-06-19) 1 commit
  (merged to 'next' on 2019-06-26 at df44db4a69)
 + wrapper: avoid undefined behaviour in macOS

 Variable type fix.

 Will merge to 'master'.


* cb/xdiff-no-system-includes-in-dot-c (2019-06-19) 1 commit
 - xdiff: avoid accidental redefinition of LFS feature in OpenIndiana

 Compilation fix.

 Will be rerolled together with patches from the
 jk/no-system-includes-in-dot-c topic.


* jk/no-system-includes-in-dot-c (2019-06-19) 2 commits
 - wt-status.h: drop stdio.h include
 - verify-tag: drop signal.h include

 Compilation fix.

 Will be rerolled with the above.


* jk/trailers-use-config (2019-06-19) 1 commit
  (merged to 'next' on 2019-06-26 at 1ba8a7c2dd)
 + interpret-trailers: load default config

 "git interpret-trailers" always treated '#' as the comment
 character, regardless of core.commentChar setting, which has been
 corrected.

 Will merge to 'master'.


* nd/fetch-multi-gc-once (2019-06-19) 1 commit
 - fetch: only run 'gc' once when fetching multiple remotes

 "git fetch" that grabs from a group of remotes learned to run the
 auto-gc only once at the very end.

 Will merge to 'next'.


* ra/cherry-pick-revert-skip (2019-06-24) 6 commits
 - cherry-pick/revert: advise using --skip
 - cherry-pick/revert: add --skip option
 - sequencer: use argv_array in reset_merge
 - sequencer: rename reset_for_rollback to reset_merge
 - sequencer: add advice for revert
 - advice: add sequencerInUse config variable

 "git cherry-pick/revert" learned a new "--skip" action.

 Is this one ready for 'next'?


* tg/stash-ref-by-index-fix (2019-06-19) 1 commit
  (merged to 'next' on 2019-06-26 at ee2e6308ae)
 + stash: fix show referencing stash index

 "git stash show 23" used to work, but no more after getting
 rewritten in C; this regression has been corrected.

 Will merge to 'master'.


* js/gcc-8-and-9 (2019-06-13) 4 commits
 - config: avoid calling `labs()` on too-large data type
 - winansi: simplify loading the GetCurrentConsoleFontEx() function
 - kwset: allow building with GCC 8
 - poll (mingw): allow compiling with GCC 8 and DEVELOPER=1
 (this branch is used by rs/config-unit-parsing.)

 Code clean-up for new compilers.

 Will merge to 'next'.
 The 'kwset' one may get a wholesale replacement, either with new
 version of kwset from upstream or removal of its users, but in the
 meantime, it is probably OK to merge it down.


* pw/add-p-recount (2019-06-13) 1 commit
  (merged to 'next' on 2019-06-26 at 63e063d65d)
 + add -p: fix checkout -p with pathological context

 "git checkout -p" needs to selectively apply a patch in reverse,
 which did not work well.

 Will merge to 'master'.


* rs/avoid-overflow-in-midpoint-computation (2019-06-13) 1 commit
  (merged to 'next' on 2019-06-26 at e6bd5b496b)
 + cleanup: fix possible overflow errors in binary search, part 2

 Code clean-up to avoid signed integer overlaps during binary search.

 Will merge to 'master'.


* js/t3404-typofix (2019-06-14) 1 commit
  (merged to 'next' on 2019-06-26 at ba3fcc1fc1)
 + t3404: fix a typo

 Typofix.

 Will merge to 'master'.


* mo/hpux-dynpath (2019-06-07) 1 commit
  (merged to 'next' on 2019-06-26 at 5add3b28b2)
 + configure: Detect linking style for HP aCC on HP-UX

 Auto-detect how to tell HP-UX aCC where to use dynamically linked
 libraries from at runtime.

 Will merge to 'master'.


* js/mergetool-optim (2019-06-12) 4 commits
  (merged to 'next' on 2019-06-26 at 8ad650bfa8)
 + mergetool: use shell variable magic instead of `awk`
 + mergetool: dissect strings with shell variable magic instead of `expr`
 + t7610-mergetool: use test_cmp instead of test $(cat file) = $txt
 + t7610-mergetool: do not place pipelines headed by `yes` in subshells

 "git mergetool" and its tests now spawn fewer subprocesses.

 Will merge to 'master'.


* cc/test-oidmap (2019-06-17) 4 commits
 - test-hashmap: remove 'hash' command
 - oidmap: use sha1hash() instead of static hash() function
 - t: add t0016-oidmap.sh
 - t/helper: add test-oidmap.c

 Extend the test coverage a bit.

 Will merge to 'next'.


* ds/midx-expire-repack (2019-06-11) 11 commits
 - t5319-multi-pack-index.sh: test batch size zero
 - midx: add test that 'expire' respects .keep files
 - multi-pack-index: test expire while adding packs
 - midx: implement midx_repack()
 - multi-pack-index: prepare 'repack' subcommand
 - multi-pack-index: implement 'expire' subcommand
 - midx: refactor permutation logic and pack sorting
 - midx: simplify computation of pack name lengths
 - multi-pack-index: prepare for 'expire' subcommand
 - Docs: rearrange subcommands for multi-pack-index
 - repack: refactor pack deletion for future use

 "git multi-pack-index" learned expire and repack subcommands.

 Will merge to 'next'.


* md/sort-detached-head-first (2019-06-19) 1 commit
 - ref-filter: sort detached HEAD lines firstly

 "git branch --list" learned to always output the detached HEAD as
 the first item (when the HEAD is detached, of course), regardless
 of the locale.

 Will merge to 'next'.


* nd/completion-no-cache-failure (2019-06-12) 1 commit
  (merged to 'next' on 2019-06-26 at f7b5a0a622)
 + completion: do not cache if --git-completion-helper fails

 An incorrect list of options was cached after command line
 completion failed (e.g. trying to complete a command that requires
 a repository outside one), which has been corrected.

 Will merge to 'master'.


* sg/rebase-progress (2019-06-24) 5 commits
 - progress: use term_clear_line()
 - rebase: fix garbled progress display with '-x'
 - pager: add a helper function to clear the last line in the terminal
 - t3404: make the 'rebase.missingCommitsCheck=ignore' test more focused
 - t3404: modernize here doc style

 Use "Erase in Line" CSI sequence that is already used in the editor
 support to clear cruft in the progress output.

 Will merge to 'next'.


* sg/trace2-rename (2019-06-12) 1 commit
  (merged to 'next' on 2019-06-26 at 8ee228c455)
 + Revert "test-lib: whitelist GIT_TR2_* in the environment"

 Dev support update to help tracing out tests.

 Will merge to 'master'.


* fc/fetch-with-import-fix (2019-06-04) 5 commits
  (merged to 'next' on 2019-06-26 at b7e7f359a9)
 + fetch: fix regression with transport helpers
 + fetch: make the code more understandable
 + fetch: trivial cleanup
 + t5801 (remote-helpers): add test to fetch tags
 + t5801 (remote-helpers): cleanup refspec stuff

 Code restructuring during 2.20 period broke fetching tags via
 "import" based transports.

 Will merge to 'master'.


* jl/status-reduce-vertical-blank (2019-06-21) 1 commit
 - status: remove the empty line after hints
 (this branch uses nd/switch-and-restore and nd/switch-and-restore-more.)

 Extra blank lines in "git status" output have been reduced.

 Needs to wait on nd/switch-and-restore to stabilize.


* dl/config-alias-doc (2019-06-06) 2 commits
  (merged to 'next' on 2019-06-26 at 3776902022)
 + config/alias.txt: document alias accepting non-command first word
 + config/alias.txt: change " and ' to `

 Doc update.

 Will merge to 'master'.


* dl/includeif-onbranch (2019-06-05) 1 commit
 - config: learn the "onbranch:" includeIf condition

 The conditional inclusion mechanism learned to base the choice on
 the branch the HEAD currently is on.

 Will merge to 'next'.


* ds/commit-graph-incremental (2019-06-19) 18 commits
 - commit-graph: test verify across alternates
 - commit-graph: normalize commit-graph filenames
 - commit-graph: test --split across alternate without --split
 - commit-graph: test octopus merges with --split
 - commit-graph: clean up chains after flattened write
 - commit-graph: verify chains with --shallow mode
 - commit-graph: create options for split files
 - commit-graph: expire commit-graph files
 - commit-graph: allow cross-alternate chains
 - commit-graph: merge commit-graph chains
 - commit-graph: add --split option to builtin
 - commit-graph: write commit-graph chains
 - commit-graph: rearrange chunk count logic
 - commit-graph: add base graphs chunk
 - commit-graph: load commit-graph chains
 - commit-graph: rename commit_compare to oid_compare
 - commit-graph: prepare for commit-graph chains
 - commit-graph: document commit-graph chains
 (this branch uses ds/close-object-store and ds/commit-graph-write-refactor.)

 The commits in a repository can be described by multiple
 commit-graph files now, which allows the commit-graph files to be
 updated incrementally.

 Will merge to 'next'.


* tm/tag-gpgsign-config (2019-06-05) 1 commit
  (merged to 'next' on 2019-06-26 at 015709def5)
 + tag: add tag.gpgSign config option to force all tags be GPG-signed

 A new tag.gpgSign configuration variable turns "git tag -a" into
 "git tag -s".

 Will merge to 'master'.


* po/doc-branch (2019-05-29) 1 commit
  (merged to 'next' on 2019-06-26 at 0debcb13e5)
 + doc branch: provide examples for listing remote tracking branches

 Doc update.

 Will merge to 'master'.


* ds/close-object-store (2019-06-12) 3 commits
  (merged to 'next' on 2019-06-26 at 86b60f2631)
 + packfile: rename close_all_packs to close_object_store
 + packfile: close commit-graph in close_all_packs
 + commit-graph: use raw_object_store when closing
 (this branch is used by ds/commit-graph-incremental; uses ds/commit-graph-write-refactor.)

 The commit-graph file is now part of the "files that the runtime
 may keep open file descriptors on, all of which would need to be
 closed when done with the object store", and the file descriptor to
 an existing commit-graph file now is closed before "gc" finalizes a
 new instance to replace it.

 Will merge to 'master'.


* pw/rebase-abort-clean-rewritten (2019-05-15) 4 commits
 - rebase --abort/--quit: cleanup refs/rewritten
 - sequencer: return errors from sequencer_remove_state()
 - rebase: warn if state directory cannot be removed
 - rebase: fix a memory leak

 "git rebase --abort" used to leave refs/rewritten/ when concluding
 "git rebase -r", which has been corrected.

 Will merge to 'next'.
 cf. <2a37d4c2-6eec-548d-0bd0-12bbd49c8071@gmail.com>


* nb/branch-show-other-worktrees-head (2019-05-07) 3 commits
  (merged to 'next' on 2019-06-26 at ae3b7a626d)
 + branch: add worktree info on verbose output
 + branch: update output to include worktree info
 + ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 Will merge to 'master'.


* cc/multi-promisor (2019-06-25) 15 commits
 - Move core_partial_clone_filter_default to promisor-remote.c
 - Move repository_format_partial_clone to promisor-remote.c
 - Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
 - remote: add promisor and partial clone config to the doc
 - partial-clone: add multiple remotes in the doc
 - t0410: test fetching from many promisor remotes
 - builtin/fetch: remove unique promisor remote limitation
 - promisor-remote: parse remote.*.partialclonefilter
 - Use promisor_remote_get_direct() and has_promisor_remote()
 - promisor-remote: use repository_format_partial_clone
 - promisor-remote: add promisor_remote_reinit()
 - promisor-remote: implement promisor_remote_get_direct()
 - Add initial support for many promisor remotes
 - fetch-object: make functions return an error code
 - t0410: remove pipes after git commands

 Teach the lazy clone machinery that there can be more than one
 promisor remote and consult them in order when downloading missing
 objects on demand.


* nd/switch-and-restore (2019-06-20) 44 commits
 - t2027: use test_must_be_empty
 - Declare both git-switch and git-restore experimental
 - help: move git-diff and git-reset to different groups
 - doc: promote "git restore"
 - user-manual.txt: prefer 'merge --abort' over 'reset --hard'
 - completion: support restore
 - t: add tests for restore
 - restore: support --patch
 - restore: replace --force with --ignore-unmerged
 - restore: default to --source=HEAD when only --staged is specified
 - restore: reject invalid combinations with --staged
 - restore: add --worktree and --staged
 - checkout: factor out worktree checkout code
 - restore: disable overlay mode by default
 - restore: make pathspec mandatory
 - restore: take tree-ish from --source option instead
 - checkout: split part of it to new command 'restore'
 - doc: promote "git switch"
 - completion: support switch
 - t: add tests for switch
 - switch: make --orphan switch to an empty tree
 - switch: reject if some operation is in progress
 - switch: no worktree status unless real branch switch happens
 - switch: implicit dwim, use --no-guess to disable it
 - switch: add short option for --detach
 - switch: only allow explicit detached HEAD
 - switch: reject "do nothing" case
 - switch: stop accepting pathspec
 - switch: remove -l
 - switch: add --discard-changes
 - switch: better names for -b and -B
 - checkout: split part of it to new command 'switch'
 - checkout: split options[] array in three pieces
 - checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 - checkout: make "opts" in cmd_checkout() a pointer
 - checkout: factor out some code in parse_branchname_arg()
 - checkout: keep most #include sorted
 - checkout: inform the user when removing branch state
 - checkout: advice how to get out of detached HEAD mode
 - t: rename t2014-switch.sh to t2014-checkout-switch.sh
 - git-checkout.txt: fix monospace typeset
 - doc: document --overwrite-ignore
 - git-checkout.txt: fix one syntax line
 - git-checkout.txt: spell out --no-option
 (this branch is used by jl/status-reduce-vertical-blank and nd/switch-and-restore-more.)

 Two new commands "git switch" and "git restore" are introduced to
 split "checking out a branch to work on advancing its history" and
 "checking out paths out of the index and/or a tree-ish to work on
 advancing the current history" out of the single "git checkout"
 command.

 Will merge to 'next'.
 cf. <20190329103919.15642-1-pclouds@gmail.com> (switch v6)
 cf. <20190425094600.15673-1-pclouds@gmail.com> (restore v3)


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Undecided but inclined to discard.


* am/p4-branches-excludes (2019-04-02) 8 commits
 - git-p4: respect excluded paths when detecting branches
 - git-p4: add failing test for "git-p4: respect excluded paths when detecting branches"
 - git-p4: don't exclude other files with same prefix
 - git-p4: add failing test for "don't exclude other files with same prefix"
 - git-p4: don't groom exclude path list on every commit
 - git-p4: match branches case insensitively if configured
 - git-p4: add failing test for "git-p4: match branches case insensitively if configured"
 - git-p4: detect/prevent infinite loop in gitCommitByP4Change()

 "git p4" update.

 Will merge to 'next'.


* dl/rebase-i-keep-base (2019-04-25) 6 commits
 - rebase: teach rebase --keep-base
 - rebase: fast-forward --fork-point in more cases
 - rebase: fast-forward --onto in more cases
 - rebase: refactor can_fast_forward into goto tower
 - t3432: test rebase fast-forward behavior
 - t3431: add rebase --fork-point tests

 "git rebase --keep-base <upstream>" tries to find the original base
 of the topic being rebased and rebase on top of that same base,
 which is useful when running the "git rebase -i" (and its limited
 variant "git rebase -x").

 The command also has learned to fast-forward in more cases where it
 can instead of replaying to recreate identical commits.

 On hold.
 cf. <20190508001252.15752-1-avarab@gmail.com>
 cf. <xmqqa7fxionx.fsf@gitster-ct.c.googlers.com>


* ds/commit-graph-write-refactor (2019-06-12) 11 commits
  (merged to 'next' on 2019-06-26 at 5430eafe51)
 + commit-graph: extract write_commit_graph_file()
 + commit-graph: extract copy_oids_to_commits()
 + commit-graph: extract count_distinct_commits()
 + commit-graph: extract fill_oids_from_all_packs()
 + commit-graph: extract fill_oids_from_commit_hex()
 + commit-graph: extract fill_oids_from_packs()
 + commit-graph: create write_commit_graph_context
 + commit-graph: remove Future Work section
 + commit-graph: collapse parameters into flags
 + commit-graph: return with errors during write
 + commit-graph: fix the_repository reference
 (this branch is used by ds/close-object-store and ds/commit-graph-incremental.)

 Renamed from commit-graph-format-v2 and changed scope.

 Will merge to 'master'.


* br/blame-ignore (2019-06-20) 9 commits
 - blame: add a test to cover blame_coalesce()
 - blame: use the fingerprint heuristic to match ignored lines
 - blame: add a fingerprint heuristic to match ignored lines
 - blame: optionally track line fingerprints during fill_blame_origin()
 - blame: add config options for the output of ignored or unblamable lines
 - blame: add the ability to ignore commits and their changes
 - blame: use a helper function in blame_chunk()
 - Move oidset_parse_file() to oidset.c
 - fsck: rename and touch up init_skiplist()

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Will merge to 'next'.
 cf. <20190620163820.231316-1-brho@google.com> (v9)
