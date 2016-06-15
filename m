From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2013, #04; Wed, 13)
Date: Wed, 13 Nov 2013 15:07:54 -0800
Message-ID: <xmqqob5ndho5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 00:08:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgjXd-0004wO-Sk
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 00:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab3KMXID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 18:08:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62189 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab3KMXH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 18:07:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C908523E9;
	Wed, 13 Nov 2013 18:07:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=a
	m/UOYz7O5BYTlzXPjBMqwQhPgo=; b=X69g9OaS5+A+qygRN3nCxly+cNUxCknP0
	9xMmIi0FVrmedoAEc9hxSAd/6rxpmIsSegPfuCIU5lS3i8Tm78t7qUPLD8Wm6crs
	jhMjOKLcsjmm4wRxX/j3E3F4RqA4xzyartabkrNZq7W6CFP12wLb1OQ06vbD2RQ7
	RKhqc+4ITk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Eqj
	6IlhJHZadYIK9Q4ohG7DHxcgGqO16Rag5iwWGdCfSMbXZ0yf5FXATPk4eX/ybwCo
	eVX4aHGu1eL/5st6wHx6LefzUdPn6VC3ygGfYTcBORfBrcwUUw+nbQXKVVF5h6s1
	uXHpCygYLasmhoOtb2W95rtmNjAmGb+dTctXPH+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E988C523E7;
	Wed, 13 Nov 2013 18:07:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7A48523E6;
	Wed, 13 Nov 2013 18:07:57 -0500 (EST)
X-master-at: 03973056a08d1694cf1c819eb2e8b9557650f70e
X-next-at: 87216524bc6ef3cbd79ae913726957a0a7b5c236
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6F6B8236-4CB8-11E3-B3A1-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237805>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The second release candidate has been tagged.  Hopefully we can have
an uneventful 1.8.5 final next week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/bundle (2013-11-12) 1 commit
 - bundle: use argv-array

 Code clean-up.


* jj/log-doc (2013-11-13) 2 commits
 - Documentation/git-log.txt: mark-up fix and minor rephasing
 - Documentation/git-log: update "--log-size" description

 Mark-up fixes.
 Needs extra sets of eyeballs.


* jj/rev-list-options-doc (2013-11-13) 1 commit
 - Documentation/rev-list-options: fix mark-ups and typos

 Mark-up fixes.
 Needs extra sets of eyeballs.


* jk/remove-deprecated (2013-11-12) 4 commits
  (merged to 'next' on 2013-11-13 at c324792)
 + peek-remote: remove deprecated alias of ls-remote
 + lost-found: remove deprecated command
 + tar-tree: remove deprecated command
 + repo-config: remove deprecated alias for "git config"

 Will cook in 'next' until a distant future.


* mi/typofixes (2013-11-12) 3 commits
  (merged to 'next' on 2013-11-13 at bb7c2eb)
 + contrib: typofixes
 + Documentation/technical/http-protocol.txt: typofixes
 + typofixes: fix misspelt comments

 Can wait in 'next'.


* rh/remote-hg-bzr-updates (2013-11-12) 9 commits
 - remote-bzr, remote-hg: fix email address regular expression
 - test-hg.sh: help user correlate verbose output with email test
 - test-hg.sh: fix duplicate content strings in author tests
 - test-hg.sh: avoid obsolete 'test' syntax
 - test-hg.sh: eliminate 'local' bashism
 - test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
 - test-bzr.sh, test-hg.sh: allow running from any dir
 - test-lib.sh: convert $TEST_DIRECTORY to an absolute path
 - remote-hg: don't decode UTF-8 paths into Unicode objects

 Will merge to 'next'.


* tr/config-multivalue-lift-max (2013-11-13) 1 commit
 - config: arbitrary number of matches for --unset and --replace-all

 Will merge to 'next'.


--------------------------------------------------
[Stalled]

* tb/clone-ssh-with-colon-for-port (2013-11-04) 1 commit
 . git clone: is an URL local or ssh

 Still being reworked.


* cn/thin-push-capability (2013-11-06) 2 commits
 - send-pack: only send a thin pack if the server supports it
 - receive-pack: advertise thin-pack

 Peff had a good suggestion to control this by expressing what the
 receiving end wants in a more direct way, namely to advertise a
 'no-thin' trait in the capability list, which seems to be favored
 by Shawn, too.


* jt/commit-fixes-footer (2013-10-30) 1 commit
 - commit: Add -f, --fixes <commit> option to add Fixes: line

 There is an ongoing discussion around this topic; in general I am
 fairly negative on a new feature that is too narrow and prefer a
 more generic solution that can be tailored for specific needs, as
 many people stated in the thread.

 It appears that the discussion stalled.


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Temporarily ejected from 'pu', to try out jk/pack-bitmap, which
 this topic conflicts with.


* jk/pack-bitmap (2013-10-30) 20 commits
 - count-objects: recognize .bitmap in garbage-checking
 - pack-bitmap: implement optional name_hash cache
 - t: add basic bitmap functionality tests
 - repack: consider bitmaps when performing repacks
 - repack: handle optional files created by pack-objects
 - repack: turn exts array into array-of-struct
 - repack: stop using magic number for ARRAY_SIZE(exts)
 - pack-objects: implement bitmap writing
 - rev-list: add bitmap mode to speed up object lists
 - pack-objects: use bitmaps when packing objects
 - pack-bitmap: add support for bitmap indexes
 - documentation: add documentation for the bitmap format
 - ewah: compressed bitmap implementation
 - compat: add endianness helpers
 - sha1_file: export `git_open_noatime`
 - revision: allow setting custom limiter function
 - pack-objects: factor out name_hash
 - pack-objects: refactor the packing list
 - revindex: export new APIs
 - sha1write: make buffer const-correct

 Borrows the bitmap index into packfiles from JGit to speed up
 enumeration of objects involved in a commit range without having to
 fully traverse the history.

 Waiting for a reroll.


* mf/graph-show-root (2013-10-25) 1 commit
 . graph.c: mark root commit differently

 In a repository with multiple-roots, "log --graph", especially with
 "--oneline", does not give the reader enough visual cue to see
 where one line of history ended and a separate history began.

 This is the version that marks the roots 'x' when they would have
 been marked as '*'; Keshav Kini suggested an alternative of giving
 an extra blank line after every root, which I tend to think is a
 better approach to the problem.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Holding until needed.


* yt/shortened-rename (2013-10-18) 2 commits
 - SQUASH??? style fixes and s/omit/shorten/ where appropriate
 - diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible

 Attempts to give more weight on the fact that a filepair represents
 a rename than showing substring of the actual path when diffstat
 lines are not wide enough.

 I am not sure if that is solving a right problem, though.


* rv/send-email-cache-generated-mid (2013-08-21) 2 commits
 - git-send-email: Cache generated message-ids, use them when prompting
 - git-send-email: add optional 'choices' parameter to the ask sub


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* kb/doc-exclude-directory-semantics (2013-11-07) 1 commit
  (merged to 'next' on 2013-11-13 at 06e5645)
 + gitignore.txt: clarify recursive nature of excluded directories

 Can wait in 'next'.


* jc/create-directories-microopt (2013-11-11) 1 commit
 - checkout: most of the time we have good leading directories

 Of unknown value until tested on non-Linux platforms (especially
 Windows).

 Will hold.


* jl/submodule-update-retire-orig-flags (2013-11-11) 1 commit
  (merged to 'next' on 2013-11-13 at 4b70d15)
 + submodule update: remove unnecessary orig_flags variable

 Code clean-up.

 Can wait in 'next'.


* jn/mediawiki-makefile-updates (2013-11-11) 4 commits
  (merged to 'next' on 2013-11-13 at 71c8d20)
 + git-remote-mediawiki build: handle DESTDIR/INSTLIBDIR with whitespace
 + git-remote-mediawiki build: make 'install' command configurable
 + git-remote-mediawiki: honor DESTDIR in "make install"
 + git-remote-mediawiki: do not remove installed files in "clean" target

 Build and Installation procedure clean-up.

 Can wait in 'next'.


* tb/doc-fetch-pack-url (2013-11-11) 1 commit
  (merged to 'next' on 2013-11-13 at 90d6832)
 + git-fetch-pack uses URLs like git-fetch

 Can wait in 'next'.


* cc/remote-remove-redundant-postfixcmp (2013-11-06) 2 commits
  (merged to 'next' on 2013-11-06 at 7b45219)
 + Rename suffixcmp() to has_suffix() and invert its result
  (merged to 'next' on 2013-11-04 at 6408502)
 + builtin/remote: remove postfixcmp() and use suffixcmp() instead

 Minor code clean-up.

 Can wait in 'next'.


* nd/wt-status-align-i18n (2013-11-06) 1 commit
  (merged to 'next' on 2013-11-13 at b033aa0)
 + wt-status: take the alignment burden off translators

 An attempt to automatically align the names in the "git status"
 output, taking the display width of (translated) section labels
 into account.

 Can wait in 'next'.


* nv/commit-gpgsign-config (2013-11-06) 1 commit
 - Add the commit.gpgsign option to sign all commits

 Introduce commit.gpgsign configuration variable to force every
 commit to be GPG signed.

 Needs tests, perhaps?


* sb/sha1-loose-object-info-check-existence (2013-11-06) 1 commit
  (merged to 'next' on 2013-11-06 at 1ea5b18)
 + sha1_loose_object_info(): do not return success on missing object

 "git cat-file --batch-check=ok" did not check the existence of the
 named object.

 Will cook in 'next'.


* gj/push-more-verbose-advice (2013-11-13) 2 commits
 - push: switch default from "matching" to "simple"
 - push: enhance unspecified push default warning

 Explain 'simple' and 'matching' in "git push" advice message; the
 topmost patch is a rebase of jc/push-2.0-default-to-simple on top
 of it.

 Will cook in 'next'.

 The first one should be merged to 'master' soon after the next
 cycle opens; the other to replace jc/push-2.0-default-to-simple.


* rr/for-each-ref-decoration (2013-11-13) 5 commits
 - fixup! for-each-ref: introduce %(color:...) for color
 - for-each-ref: introduce %(color:...) for color
 - fixup! for-each-ref: introduce %(upstream:track[short])
 - for-each-ref: introduce %(upstream:track[short])
 - for-each-ref: introduce %(HEAD) asterisk marker

 Needs fix-ups, aut-reset, --color=auto support, and tests.
 but it is a good start.


* jk/two-way-merge-corner-case-fix (2013-11-04) 3 commits
  (merged to 'next' on 2013-11-04 at 79f4fb0)
 + t1005: add test for "read-tree --reset -u A B"
 + t1005: reindent
 + unpack-trees: fix "read-tree -u --reset A B" with conflicted index

 Fix a rather longstanding corner-case bug in twoway "reset to
 there" merge, which is most often seen in "git am --abort".

 Will cook in 'next'.


* jc/ref-excludes (2013-11-01) 5 commits
  (merged to 'next' on 2013-11-04 at fac1ed0)
 + rev-parse: introduce --exclude=<glob> to tame wildcards
 + rev-list --exclude: export add/clear-ref-exclusion and ref-excluded API
 + rev-list --exclude: tests
 + document --exclude option
 + revision: introduce --exclude=<glob> to tame wildcards

 People often wished a way to tell "git log --branches" (and "git
 log --remotes --not --branches") to exclude some local branches
 from the expansion of "--branches" (similarly for "--tags", "--all"
 and "--glob=<pattern>").  Now they have one.

 Can wait in 'next'.


* jk/replace-perl-in-built-scripts (2013-10-29) 1 commit
  (merged to 'next' on 2013-11-01 at 2384e29)
 + use @@PERL@@ in built scripts

 Can wait in 'next'.


* fc/transport-helper-fixes (2013-11-13) 12 commits
 - remote-bzr: support the new 'force' option
 - transport-helper: add support to delete branches
 - fast-export: add support to delete refs
 - fast-import: add support to delete refs
 - transport-helper: add support for old:new refspec
 - fast-export: add new --refspec option
 - fast-export: improve argument parsing
 - test-hg.sh: tests are now expected to pass
 - transport-helper: check for 'forced update' message
 - transport-helper: add 'force' to 'export' helpers
 - transport-helper: don't update refs in dry-run
 - transport-helper: mismerge fix

 Updates transport-helper, fast-import and fast-export to allow the
 ref mapping and ref deletion in a way similar to the natively
 supported transports.


* jh/loose-object-dirs-creation-race (2013-10-28) 1 commit
  (merged to 'next' on 2013-11-01 at 3169b0f)
 + sha1_file.c:create_tmpfile(): Fix race when creating loose object dirs

 Will cook in 'next'.


* nd/liteal-pathspecs (2013-10-28) 1 commit
  (merged to 'next' on 2013-11-01 at 1a91775)
 + pathspec: stop --*-pathspecs impact on internal parse_pathspec() uses

 Will cook in 'next'.


* th/reflog-annotated-tag (2013-10-28) 1 commit
  (merged to 'next' on 2013-11-01 at 8b154cc)
 + reflog: handle lightweight and annotated tags equally

 "git log -g $annotated_tag", when there is no reflog history, should
 have produced a single output entry (i.e. the ref creation event),
 but instead showed the history leading to the tag.

 Broken at the design level.  Any reflog entry that points at a non
 commit needs to be handled with new code that does not exist yet,
 and lifting the "this code handles only commits" without adding
 such code does not solve anything.


* tr/merge-recursive-index-only (2013-10-28) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 Will hold until using script appears.


* bc/http-100-continue (2013-10-31) 3 commits
  (merged to 'next' on 2013-11-01 at e12ae23)
 + remote-curl: fix large pushes with GSSAPI
 + remote-curl: pass curl slot_results back through run_slot
 + http: return curl's AUTHAVAIL via slot_results

 Issue "100 Continue" responses to help use of GSS-Negotiate
 authentication scheme over HTTP transport when needed.

 Will cook in 'next'.


* jc/merge-base-reflog (2013-10-29) 2 commits
  (merged to 'next' on 2013-11-01 at 6114764)
 + merge-base: teach "--fork-point" mode
 + merge-base: use OPT_CMDMODE and clarify the command line parsing

 Code the logic in "pull --rebase" that figures out a fork point
 from reflog entries in C.

 Will cook in 'next'.


* jk/robustify-parse-commit (2013-10-24) 6 commits
  (merged to 'next' on 2013-11-01 at 2bfbaab)
 + checkout: do not die when leaving broken detached HEAD
 + use parse_commit_or_die instead of custom message
 + use parse_commit_or_die instead of segfaulting
 + assume parse_commit checks for NULL commit
 + assume parse_commit checks commit->object.parsed
 + log_tree_diff: die when we fail to parse a commit

 Will cook in 'next'.


* mh/fetch-tags-in-addition-to-normal-refs (2013-10-30) 23 commits
  (merged to 'next' on 2013-11-06 at 6932893)
 + fetch: improve the error messages emitted for conflicting refspecs
 + handle_duplicate(): mark error message for translation
 + ref_remote_duplicates(): extract a function handle_duplicate()
 + ref_remove_duplicates(): simplify loop logic
 + t5536: new test of refspec conflicts when fetching
 + ref_remove_duplicates(): avoid redundant bisection
 + git-fetch.txt: improve description of tag auto-following
 + fetch-options.txt: simplify ifdef/ifndef/endif usage
 + fetch, remote: properly convey --no-prune options to subprocesses
 + builtin/remote.c:update(): use struct argv_array
 + builtin/remote.c: reorder function definitions
 + query_refspecs(): move some constants out of the loop
 + fetch --prune: prune only based on explicit refspecs
 + fetch --tags: fetch tags *in addition to* other stuff
 + fetch: only opportunistically update references based on command line
 + get_expanded_map(): avoid memory leak
 + get_expanded_map(): add docstring
 + builtin/fetch.c: reorder function definitions
 + get_ref_map(): rename local variables
 + api-remote.txt: correct section "struct refspec"
 + t5510: check that "git fetch --prune --tags" does not prune branches
 + t5510: prepare test refs more straightforwardly
 + t5510: use the correct tag name in test

 The "-tags" option to "git fetch" used to be literally a synonym to
 a "refs/tags/*:refs/tags/*" refspec, which meant that (1) as an
 explicit refspec given from the command line, it silenced the lazy
 "git fetch" default that is configured, and (2) also as an explicit
 refspec given from the command line, it interacted with "--prune"
 to remove any tag that the remote we are fetching from does not
 have.

 This demotes it to an option; with it, we fetch all tags in
 addition to what would be fetched without the option, and it does
 not interact with the decision "--prune" makes to see what
 remote-tracking refs the local has are missing the remote
 counterpart.

 Will cook in 'next'.


* nv/parseopt-opt-arg (2013-10-31) 2 commits
  (merged to 'next' on 2013-11-01 at cd2afd9)
 + rev-parse --parseopt: add the --stuck-long mode
 + Use the word 'stuck' instead of 'sticked'

 Enhance "rev-parse --parseopt" mode to help parsing options with
 an optional parameter.

 Will cook in 'next'.


* ak/submodule-foreach-quoting (2013-09-27) 1 commit
  (merged to 'next' on 2013-10-14 at d77c5f1)
 + submodule foreach: skip eval for more than one argument

 A behavior change, but a worthwhile one: "git submodule foreach"
 was treating its arguments as part of a single command to be
 concatenated and passed to a shell, making writing buggy
 scripts too easy.

 This patch preserves the old "just pass it to the shell" behavior
 when a single argument is passed to 'git submodule foreach' and
 moves to a new "skip the shell and use the arguments passed
 unmolested" behavior when more than one argument is passed.

 The old behavior (always concatenating and passing to the shell)
 was similar to the 'ssh' command, while the new behavior (switching
 on the number of arguments) is what 'xterm -e' does.

 May need more thought to make sure this change is advertised well
 so that scripts that used multiple arguments but added their own
 extra layer of quoting are not broken.

 Will cook in 'next'.


* kb/fast-hashmap (2013-11-07) 16 commits
 - fixup! builtin/update-index.c: cleanup update_one
 - fixup! read-cache.c: fix memory leaks caused by removed cache entries
 - read-cache.c: fix memory leaks caused by removed cache entries
 - builtin/update-index.c: cleanup update_one
 - fix 'git update-index --verbose --again' output
 - remove old hash.[ch] implementation
 - name-hash.c: remove cache entries instead of marking them CE_UNHASHED
 - name-hash.c: use new hash map implementation for cache entries
 - name-hash.c: remove unreferenced directory entries
 - name-hash.c: use new hash map implementation for directories
 - diffcore-rename.c: use new hash map implementation
 - diffcore-rename.c: simplify finding exact renames
 - diffcore-rename.c: move code around to prepare for the next patch
 - buitin/describe.c: use new hash map implementation
 - add a hashtable implementation that supports O(1) removal
 - submodule: don't access the .gitmodules cache entry after removing it

 Improvements to our hash table to get it to meet the needs of the
 msysgit fscache project, with some nice performance improvements.

 The preparatory clean-up to submodule from Jens is at the bottom. I
 also squashed in a fix-up by Karsten found at $gmane/236468 (please
 double-check the result).

 This is a reroll one after the valgrind breakage report ($gmane/236869).

 Waiting for a reroll.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
  (merged to 'next' on 2013-10-28 at d8cdf30)
 + git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
  (merged to 'next' on 2013-10-28 at f1bec96)
 + core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
  (merged to 'next' on 2013-10-28 at 3153a9e)
 + push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
  (merged to 'next' on 2013-10-28 at 5fd76ec)
 + git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
  (merged to 'next' on 2013-11-01 at 5fc26e4)
 + diff: remove "diff-files -q" in a version of Git in a distant future

 Will cook in 'next' until a distant future.
