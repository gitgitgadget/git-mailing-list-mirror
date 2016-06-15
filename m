From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2013, #01; Wed, 4)
Date: Wed, 04 Dec 2013 17:23:20 -0800
Message-ID: <xmqqiov4hz07.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 02:23:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoNfD-0001cr-4S
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 02:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756488Ab3LEBXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 20:23:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756475Ab3LEBXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 20:23:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F8265866F;
	Wed,  4 Dec 2013 20:23:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=d
	K0myWWPlLExmQwj1h6/k3qbmPg=; b=U82SMo3bBKiCrE4mkAtEooK0gJdJWpSge
	wVpbccIOnFDwIOImbwHLkUQkaBLhthZwofoxeTn6oJ/SyKEsDxyX0b9lYVh8sA6K
	5bXz6R4lBoaVibkAQmkFnn7bJIvgrOOde5sqilQIKlLz8Fj3SKcn1mq+mi3Yt99d
	hPeX9DtqbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=PTP
	M6vjzJlV7WsCxmiffXWMtl0YtOWsR+qZYvU1918wdrO03QWpAld8FDjuqWowX9AT
	aZKQC+INB5cfdRMRk4ByQ/54UcZhE2lTJXkXgFMSuBrH1znZZTP4gGR7Wx9p5vbO
	lpgF+ocvNG90HY7N4CxFtnlsYqpK7XWgWAtPA3qA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC8E5866B;
	Wed,  4 Dec 2013 20:23:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A23758666;
	Wed,  4 Dec 2013 20:23:23 -0500 (EST)
X-master-at: daad3aa255ec5c08f95867feaaf8f4db03346e70
X-next-at: dd8f0929c2ec5ca88db21a610c529223e471ab6c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D52FAA9A-5D4B-11E3-A631-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238831>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

There are quite a many topics that have been left over from the
previous round.  I haven't rewound the tip of 'next' yet, but I am
planning to do so real soon now, kicking some topics out of it.

The next release has not been named yet. I do not think it will be
2.0 yet, but I am tempted to call it 1.9 (not 1.9.0) in preparation
for 2.0 sometime late spring or early summer.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jj/doc-markup-gitcli (2013-11-20) 1 commit
  (merged to 'next' on 2013-11-21 at 5e49fa8)
 + Documentation/gitcli.txt: fix double quotes


* jj/doc-markup-hints-in-coding-guidelines (2013-11-18) 1 commit
  (merged to 'next' on 2013-11-21 at 9c638a6)
 + State correct usage of literal examples in man pages in the coding standards


* jj/log-doc (2013-11-13) 2 commits
  (merged to 'next' on 2013-11-21 at cb0ddd2)
 + Documentation/git-log.txt: mark-up fix and minor rephasing
 + Documentation/git-log: update "--log-size" description


* jj/rev-list-options-doc (2013-11-18) 2 commits
  (merged to 'next' on 2013-11-20 at db975de)
 + Documentation/rev-list-options.txt: fix some grammatical issues and typos
 + Documentation/rev-list-options.txt: fix mark-up


* mi/typofixes (2013-11-12) 3 commits
  (merged to 'next' on 2013-11-13 at bb7c2eb)
 + contrib: typofixes
 + Documentation/technical/http-protocol.txt: typofixes
 + typofixes: fix misspelt comments


* nd/glossary-content-pathspec-markup (2013-11-21) 1 commit
  (merged to 'next' on 2013-11-21 at 6072636)
 + glossary-content.txt: fix documentation of "**" patterns


* tb/doc-fetch-pack-url (2013-11-11) 1 commit
  (merged to 'next' on 2013-11-13 at 90d6832)
 + git-fetch-pack uses URLs like git-fetch

--------------------------------------------------
[New Topics]

* cl/p4-use-diff-tree (2013-11-22) 1 commit
  (merged to 'next' on 2013-11-27 at 11926ce)
 + git p4: Use git diff-tree instead of format-patch

 Will merge to 'master'.


* jn/scripts-updates (2013-11-26) 11 commits
  (merged to 'next' on 2013-11-27 at 5056d4d)
 + Merge commit '0f2068c4cfb8bc84d338265f03c773e5559e761d' into jn/scripts-updates
 + gitk: chmod +x po2msg
 + Merge commit '688eb87c9444686180d8f379ab854bcbc34db4db' into jn/scripts-updates
 + git-gui: chmod +x po2msg, windows/git-gui.sh
 + remove #!interpreter line from shell libraries
 + test: replace shebangs with descriptions in shell libraries
 + test: make FILEMODE a lazy prereq
 + contrib: remove git-p4import
 + mark contributed hooks executable
 + mark perl test scripts executable
 + mark Windows build scripts executable

 Will drop the two merges at the tip to gitk and git-gui parts of
 the tree, as I've forwarded the relevant patches to the upstream
 and expect them to come back later from their respective trees.


* tr/commit-slab-cleanup (2013-12-02) 3 commits
  (merged to 'next' on 2013-12-02 at f545f4d)
 + commit-slab: sizeof() the right type in xrealloc
  (merged to 'next' on 2013-11-27 at 84d5a73)
 + commit-slab: declare functions "static inline"
 + commit-slab: document clear_$slabname()


* tr/doc-git-cherry (2013-11-27) 1 commit
  (merged to 'next' on 2013-11-27 at d37f520)
 + Documentation: revamp git-cherry(1)

 Will merge to 'master'.


* aa/transport-non-positive-depth-only (2013-11-26) 1 commit
  (merged to 'next' on 2013-11-27 at b01f05b)
 + transport: catch non positive --depth option value

 Will merge to 'master'.


* rs/doc-submitting-patches (2013-11-27) 1 commit
  (merged to 'next' on 2013-11-27 at f8886f4)
 + SubmittingPatches: document how to handle multiple patches

 Will merge to 'master'.


* cc/starts-n-ends-with (2013-12-04) 4 commits
 - replace {pre,suf}fixcmp() with {starts,ends}_with()
 - strbuf: introduce starts_with() and ends_with()
 - builtin/remote: remove postfixcmp() and use suffixcmp() instead
 - environment: normalize use of prefixcmp() by removing " != 0"
 (this branch is used by cc/starts-n-ends-with-endgame.)

 Remove a few duplicate implementations of prefix/suffix comparison
 functions, and rename them to starts_with and ends_with.

 This conflicts with a part of cc/remote-remove-redundant-postfixcmp
 topic (I think it actually subsumes it).


* cc/starts-n-ends-with-endgame (2013-12-04) 1 commit
 - strbuf: remove prefixcmp() and suffixcmp()
 (this branch uses cc/starts-n-ends-with.)

 Endgame for the above topic, that needs to be evil-merged with
 other topics that introduce new uses of prefix/suffix-cmp
 functions.


* jc/push-refmap (2013-12-04) 3 commits
 - push: also use "upstream" mapping when pushing a single ref
 - push: use remote.$name.push as a refmap
 - builtin/push.c: use strbuf instead of manual allocation

 Make "git push origin master" update the same ref that would be
 updated by our 'master' when "git push origin" (no refspecs) is run
 while the 'master' branch is checked out, which makes "git push"
 more symmetric to "git fetch" and more usable for the triangular
 workflow.


* jk/t5000-gzip-simplify (2013-12-04) 1 commit
 - t5000: simplify gzip prerequisite checks

 Test fix.


* js/gnome-keyring (2013-12-04) 1 commit
 - contrib/git-credential-gnome-keyring.c: small stylistic cleanups

 Style fix.


* kn/gitweb-extra-branch-refs (2013-12-04) 4 commits
 - gitweb: Denote non-heads, non-remotes branches
 - gitweb: Add a feature for adding more branch refs
 - gitweb: Return plain booleans in validation methods
 - gitweb: Move check-ref-format code into separate function

 Allow gitweb to be configured to show refs out of refs/heads/ as if
 they were branches.


* mm/mv-file-to-no-such-dir-with-slash (2013-12-04) 1 commit
 - mv: let 'git mv file no-such-dir/' error out


* nd/gettext-vsnprintf (2013-12-04) 1 commit
 - gettext.c: detect the vsnprintf bug at runtime


* tr/send-email-ssl (2013-12-04) 3 commits
 - send-email: set SSL options through IO::Socket::SSL::set_client_defaults
 - send-email: --smtp-ssl-cert-path takes an argument
 - send-email: pass Debug to Net::SMTP::SSL::new

--------------------------------------------------
[Stalled]

* jl/commit-v-strip-marker (2013-11-19) 1 commit
 - commit -v: strip diffs and submodule shortlogs from the commit message

 Perhaps another reroll for core.commentChar coming?


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

 The option name "--refspec" needs to be rethought. It does not mean
 what refspec usually means, even though it shares the same syntax
 with refspec; calling it --refspec only because it shares the same
 syntax is like calling it --asciistring and does not make sense.


* nv/commit-gpgsign-config (2013-11-06) 1 commit
 - Add the commit.gpgsign option to sign all commits

 Introduce commit.gpgsign configuration variable to force every
 commit to be GPG signed.

 Needs tests, perhaps?


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


* jk/pack-bitmap (2013-11-18) 22 commits
 - compat/mingw.h: Fix the MinGW and msvc builds
 - pack-bitmap: implement optional name_hash cache
 - t/perf: add tests for pack bitmaps
 - t: add basic bitmap functionality tests
 - count-objects: recognize .bitmap in garbage-checking
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

* tb/clone-ssh-with-colon-for-port (2013-12-04) 10 commits
 - git_connect(): use common return point
 - connect.c: refactor url parsing
 - git_connect(): refactor the port handling for ssh
 - git fetch: support host:/~repo
 - t5500: add test cases for diag-url
 - git fetch-pack: add --diag-url
 - git_connect: factor out discovery of the protocol and its parts
 - git_connect: remove artificial limit of a remote command
 - t5601: add tests for ssh
 - t5601: remove clear_ssh, refactor setup_ssh_wrapper



* cn/thin-push-capability (2013-11-25) 1 commit
 - send-pack: don't send a thin pack to a server which doesn't support it

 Allow receive-pack to insist on receiving a fat pack from "git
 push" clients.

 Will merge to 'next'.


* jn/perl-lib-extra (2013-11-18) 2 commits
  (merged to 'next' on 2013-11-20 at 8c90afae)
 + Makefile: add PERLLIB_EXTRA variable that adds to default perl path
 + Makefile: rebuild perl scripts when perl paths change

 Will merge to 'master'.


* jk/remove-experimental-loose-object-support (2013-11-21) 1 commit
  (merged to 'next' on 2013-11-21 at d37bab7)
 + drop support for "experimental" loose objects

 Will merge to 'master'.


* nd/magic-pathspec (2013-11-20) 1 commit
  (merged to 'next' on 2013-11-21 at f914a30)
 + diff: restrict pathspec limitations to diff b/f case only

 Will merge to 'master'.


* jc/bundle (2013-11-12) 1 commit
  (merged to 'next' on 2013-11-21 at 535b046)
 + bundle: use argv-array

 Code clean-up.

 Will merge to 'master'.


* jk/remove-deprecated (2013-12-03) 5 commits
  (merged to 'next' on 2013-12-03 at bc1da41)
 + stop installing git-tar-tree link
  (merged to 'next' on 2013-11-13 at c324792)
 + peek-remote: remove deprecated alias of ls-remote
 + lost-found: remove deprecated command
 + tar-tree: remove deprecated command
 + repo-config: remove deprecated alias for "git config"

 Will cook in 'next' until a distant future.


* rh/remote-hg-bzr-updates (2013-11-18) 8 commits
  (merged to 'next' on 2013-11-20 at a36f3c4)
 + remote-bzr, remote-hg: fix email address regular expression
 + test-hg.sh: help user correlate verbose output with email test
 + test-hg.sh: fix duplicate content strings in author tests
 + test-hg.sh: avoid obsolete 'test' syntax
 + test-hg.sh: eliminate 'local' bashism
 + test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
 + test-bzr.sh, test-hg.sh: allow running from any dir
 + test-lib.sh: convert $TEST_DIRECTORY to an absolute path

 The patch that used to be at the bottom of the series has been
 merged to v1.8.5, as it fixes a minor regression and has also been
 cherry-picked to 'maint'.

 Will merge to 'master'.


* tr/config-multivalue-lift-max (2013-11-13) 1 commit
  (merged to 'next' on 2013-11-20 at d18aac9)
 + config: arbitrary number of matches for --unset and --replace-all

 Will merge to 'master'.


* kb/doc-exclude-directory-semantics (2013-11-07) 1 commit
  (merged to 'next' on 2013-11-13 at 06e5645)
 + gitignore.txt: clarify recursive nature of excluded directories

 Will kick back to 'pu' to replace with a newer reroll ($gmane/237814
 looked OK but there seems to have some loose ends in the discussion).


* jc/create-directories-microopt (2013-11-11) 1 commit
 - checkout: most of the time we have good leading directories

 Of unknown value until tested on non-Linux platforms (especially
 Windows).

 Will hold.


* jl/submodule-update-retire-orig-flags (2013-11-11) 1 commit
  (merged to 'next' on 2013-11-13 at 4b70d15)
 + submodule update: remove unnecessary orig_flags variable

 Code clean-up.

 Will merge to 'master'.


* jn/mediawiki-makefile-updates (2013-11-11) 4 commits
  (merged to 'next' on 2013-11-13 at 71c8d20)
 + git-remote-mediawiki build: handle DESTDIR/INSTLIBDIR with whitespace
 + git-remote-mediawiki build: make 'install' command configurable
 + git-remote-mediawiki: honor DESTDIR in "make install"
 + git-remote-mediawiki: do not remove installed files in "clean" target

 Build and Installation procedure clean-up.

 Will merge to 'master'.


* cc/remote-remove-redundant-postfixcmp (2013-12-04) 3 commits
  (merged to 'next' on 2013-12-04 at dd8f092)
 + Revert 76e08227e5bc8b6e3d208da965d2421911d25ae3
  (merged to 'next' on 2013-11-06 at 7b45219)
 + Rename suffixcmp() to has_suffix() and invert its result
  (merged to 'next' on 2013-11-04 at 6408502)
 + builtin/remote: remove postfixcmp() and use suffixcmp() instead

 Minor code clean-up.

 Will drop, as cc/starts-n-ends-with contains the same.


* nd/wt-status-align-i18n (2013-11-06) 1 commit
  (merged to 'next' on 2013-11-13 at b033aa0)
 + wt-status: take the alignment burden off translators

 An attempt to automatically align the names in the "git status"
 output, taking the display width of (translated) section labels
 into account.

 Will merge to 'master'.


* sb/sha1-loose-object-info-check-existence (2013-11-06) 1 commit
  (merged to 'next' on 2013-11-06 at 1ea5b18)
 + sha1_loose_object_info(): do not return success on missing object

 "git cat-file --batch-check=ok" did not check the existence of the
 named object.

 Will merge to 'master'.


* gj/push-more-verbose-advice (2013-11-13) 2 commits
  (merged to 'next' on 2013-11-21 at df10213)
 + push: switch default from "matching" to "simple"
  (merged to 'next' on 2013-11-21 at 4ee3d4a)
 + push: enhance unspecified push default warning

 Explain 'simple' and 'matching' in "git push" advice message; the
 topmost patch is a rebase of jc/push-2.0-default-to-simple on top
 of it.

 Will merge the bottom to 'master' and cook the other in 'next'.


* rr/for-each-ref-decoration (2013-11-19) 6 commits
  (merged to 'next' on 2013-11-21 at ee7b0ed)
 + for-each-ref: avoid color leakage
 + for-each-ref: introduce %(color:...) for color
 + for-each-ref: introduce %(upstream:track[short])
 + for-each-ref: introduce %(HEAD) asterisk marker
 + t6300 (for-each-ref): don't hardcode SHA-1 hexes
 + t6300 (for-each-ref): clearly demarcate setup

 Will merge to 'master'.


* jk/two-way-merge-corner-case-fix (2013-11-04) 3 commits
  (merged to 'next' on 2013-11-04 at 79f4fb0)
 + t1005: add test for "read-tree --reset -u A B"
 + t1005: reindent
 + unpack-trees: fix "read-tree -u --reset A B" with conflicted index

 Fix a rather longstanding corner-case bug in twoway "reset to
 there" merge, which is most often seen in "git am --abort".

 Will merge to 'master'.


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

 Will merge to 'master'.


* jk/replace-perl-in-built-scripts (2013-10-29) 1 commit
  (merged to 'next' on 2013-11-01 at 2384e29)
 + use @@PERL@@ in built scripts

 Will merge to 'master'.


* jh/loose-object-dirs-creation-race (2013-10-28) 1 commit
  (merged to 'next' on 2013-11-01 at 3169b0f)
 + sha1_file.c:create_tmpfile(): Fix race when creating loose object dirs

 Will merge to 'master'.


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

 Will discard.


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

 Will merge to 'master'.


* jc/merge-base-reflog (2013-10-29) 2 commits
  (merged to 'next' on 2013-11-01 at 6114764)
 + merge-base: teach "--fork-point" mode
 + merge-base: use OPT_CMDMODE and clarify the command line parsing

 Code the logic in "pull --rebase" that figures out a fork point
 from reflog entries in C.

 Will merge to 'master'.


* jk/robustify-parse-commit (2013-10-24) 6 commits
  (merged to 'next' on 2013-11-01 at 2bfbaab)
 + checkout: do not die when leaving broken detached HEAD
 + use parse_commit_or_die instead of custom message
 + use parse_commit_or_die instead of segfaulting
 + assume parse_commit checks for NULL commit
 + assume parse_commit checks commit->object.parsed
 + log_tree_diff: die when we fail to parse a commit

 Will merge to 'master'.


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

 The "--tags" option to "git fetch" used to be literally a synonym to
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

 Will merge to 'master'.


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

 Will merge to 'master'.


* kb/fast-hashmap (2013-11-18) 14 commits
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

 Will merge to 'next'.


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
