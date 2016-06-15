From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2013, #02; Mon, 9)
Date: Mon, 09 Sep 2013 15:53:09 -0700
Message-ID: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 00:53:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAKq-0001xi-DP
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913Ab3IIWx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:53:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850Ab3IIWxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:53:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD9EF40135;
	Mon,  9 Sep 2013 22:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=D
	THV3RW0bEdPPIktjkH7VrUBtzY=; b=aw7E+uCbMmFRWQzazjH54UtF0qRB7ySKT
	9+XPQXMNimCMHsYV4uMh2zfvMRmkQLA7BK0j53CKaGlzm2Qweuz8jUHW0ajWrq+j
	2+zo6t7vUqLcmcm1D3M154jonVQTQ2oLGxKvjXxbhnjkwk9HKiSA1ASjIMaO6b2+
	DCvnJoCZbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=qoP
	XGpsE1O25TrX4bSpT4BZz/tXL9JV3VXbXTPcyfrNRQPutL5So7IPPnxgBuRb0INp
	BtncU6rNDM0dUOnz5hV3BBjtBY5wPC2h+Q/q1zX1vBvxuNjK5K3k3gHRj2Mxrg7T
	vb6fEY6dDmA4NxjJUlt0H/JMtr7z98c3Z7DEPMt0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79F134012F;
	Mon,  9 Sep 2013 22:53:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8DF340111;
	Mon,  9 Sep 2013 22:53:20 +0000 (UTC)
X-master-at: bb80ee09974667a1db6bbc5e33574ed869b76a88
X-next-at: 117d2e3ab92364a7d246c98cc5b71f2b751600e6
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9FEB3D96-19A2-11E3-B4E7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234390>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The second batch of topics are now in 'master'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* aj/p4-symlink-lose-nl (2013-08-12) 1 commit
  (merged to 'next' on 2013-08-28 at 5ce9ceb)
 + git-p4: Fix occasional truncation of symlink contents.

 Originally merged to 'next' on 2013-08-14


* ap/remote-hg-tilde-is-home-directory (2013-08-09) 1 commit
  (merged to 'next' on 2013-08-28 at 9bfc430)
 + remote-hg: fix path when cloning with tilde expansion

 Originally merged to 'next' on 2013-08-14


* bc/unuse-packfile (2013-08-02) 2 commits
  (merged to 'next' on 2013-08-28 at 9029801)
 + Don't close pack fd when free'ing pack windows
 + sha1_file: introduce close_one_pack() to close packs on fd pressure

 Originally merged to 'next' on 2013-08-06

 Handle memory pressure and file descriptor pressure separately when
 deciding to release pack windows to honor resource limits.


* da/darwin (2013-08-05) 3 commits
  (merged to 'next' on 2013-08-28 at 6e4c5ae)
 + OS X: Fix redeclaration of die warning
 + Makefile: Fix APPLE_COMMON_CRYPTO with BLK_SHA1
 + imap-send: use Apple's Security framework for base64 encoding

 Originally merged to 'next' on 2013-08-05


* db/http-savecookies (2013-08-05) 2 commits
  (merged to 'next' on 2013-08-28 at 22a8464)
 + t5551: Remove header from curl cookie file
 + http: add http.savecookies option to write out HTTP cookies

 Originally merged to 'next' on 2013-08-05


* es/blame-L-more (2013-08-05) 11 commits
  (merged to 'next' on 2013-08-28 at b73cdc9)
 + blame: reject empty ranges -L,+0 and -L,-0
 + t8001/t8002: blame: demonstrate acceptance of bogus -L,+0 and -L,-0
 + blame: reject empty ranges -LX,+0 and -LX,-0
 + t8001/t8002: blame: demonstrate acceptance of bogus -LX,+0 and -LX,-0
 + log: fix -L bounds checking bug
 + t4211: retire soon-to-be unimplementable tests
 + t4211: log: demonstrate -L bounds checking bug
 + blame: fix -L bounds checking bug
 + t8001/t8002: blame: add empty file & partial-line tests
 + t8001/t8002: blame: demonstrate -L bounds checking bug
 + t8001/t8002: blame: decompose overly-large test
 (this branch is used by es/blame-L-twice and es/contacts-blame-L-multi.)

 Originally merged to 'next' on 2013-08-06

 More fixes to the code to parse the "-L" option in "log" and "blame".


* es/blame-L-twice (2013-08-06) 16 commits
  (merged to 'next' on 2013-08-28 at e83ae2e)
 + line-range: reject -L line numbers less than 1
 + t8001/t8002: blame: add tests of -L line numbers less than 1
 + line-range: teach -L^:RE to search from start of file
 + line-range: teach -L:RE to search from end of previous -L range
 + line-range: teach -L^/RE/ to search from start of file
 + line-range-format.txt: document -L/RE/ relative search
 + log: teach -L/RE/ to search from end of previous -L range
 + blame: teach -L/RE/ to search from end of previous -L range
 + line-range: teach -L/RE/ to search relative to anchor point
 + blame: document multiple -L support
 + t8001/t8002: blame: add tests of multiple -L options
 + blame: accept multiple -L ranges
 + blame: inline one-line function into its lone caller
 + range-set: publish API for re-use by git-blame -L
 + line-range-format.txt: clarify -L:regex usage form
 + git-log.txt: place each -L option variation on its own line
 (this branch is used by es/contacts-blame-L-multi; uses es/blame-L-more.)

 Originally merged to 'next' on 2013-08-08

 Teaches "git blame" to take more than one -L ranges.


* es/contacts-blame-L-multi (2013-08-13) 3 commits
  (merged to 'next' on 2013-08-28 at 24ff8b4)
 + contacts: reduce git-blame invocations
 + contacts: gather all blame sources prior to invoking git-blame
 + contacts: validate hunk length earlier
 (this branch uses es/blame-L-more and es/blame-L-twice.)

 Originally merged to 'next' on 2013-08-14


* fc/remote-hg-shared-setup (2013-08-11) 2 commits
  (merged to 'next' on 2013-08-28 at 41ee3fe)
 + remote-hg: add shared repo upgrade
 + remote-hg: ensure shared repo is initialized

 Originally merged to 'next' on 2013-08-14


* fc/unpack-trees-leakfix (2013-08-13) 1 commit
  (merged to 'next' on 2013-08-28 at 3ad1f21)
 + unpack-trees: plug a memory leak

 Originally merged to 'next' on 2013-08-14


* jc/check-x-z (2013-07-11) 4 commits
  (merged to 'next' on 2013-08-28 at a7670ce)
 + check-attr -z: a single -z should apply to both input and output
 + check-ignore -z: a single -z should apply to both input and output
 + check-attr: the name of the character is NUL, not NULL
 + check-ignore: the name of the character is NUL, not NULL

 Originally merged to 'next' on 2013-07-15

 "git check-ignore -z" applied the NUL termination to both its input
 (with --stdin) and its output, but "git check-attr -z" ignored the
 option on the output side.

 This is potentially a backward incompatible fix.  Let's see if
 anybody screams before deciding if we want to do anything to help
 existing users (there may be none).


* jc/diff-filter-negation (2013-07-19) 6 commits
  (merged to 'next' on 2013-08-28 at 5cc7720)
 + diff: deprecate -q option to diff-files
 + diff: allow lowercase letter to specify what change class to exclude
 + diff: reject unknown change class given to --diff-filter
 + diff: preparse --diff-filter string argument
 + diff: factor out match_filter()
 + diff: pass the whole diff_options to diffcore_apply_filter()
 (this branch is used by jc/hold-diff-remove-q-synonym-for-no-deletion.)

 Originally merged to 'next' on 2013-07-22

 Teach "git diff --diff-filter" to express "I do not want to see
 these classes of changes" more directly by listing only the
 unwanted ones in lowercase (e.g. "--diff-filter=d" will show
 everything but deletion) and deprecate "diff-files -q" which did
 the same thing as "--diff-filter=d".


* jc/parseopt-command-modes (2013-07-30) 2 commits
  (merged to 'next' on 2013-08-28 at 738b399)
 + tag: use OPT_CMDMODE
 + parse-options: add OPT_CMDMODE()
 (this branch is used by sb/parseopt-boolean-removal.)

 Many commands use --dashed-option as a operation mode selector
 (e.g. "git tag --delete") that the user can use at most one
 (e.g. "git tag --delete --verify" is a nonsense) and you cannot
 negate (e.g. "git tag --no-delete" is a nonsense).  Make it easier
 for users of parse_options() to enforce these restrictions.


* jc/push-cas (2013-08-02) 9 commits
  (merged to 'next' on 2013-08-28 at 784281f)
 + push: teach --force-with-lease to smart-http transport
 + send-pack: fix parsing of --force-with-lease option
 + t5540/5541: smart-http does not support "--force-with-lease"
 + t5533: test "push --force-with-lease"
 + push --force-with-lease: tie it all together
 + push --force-with-lease: implement logic to populate old_sha1_expect[]
 + remote.c: add command line option parser for "--force-with-lease"
 + builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
 + cache.h: move remote/connect API out of it

 Originally merged to 'next' on 2013-08-05

 Allow a safer "rewind of the remote tip" push than blind "--force",
 by requiring that the overwritten remote ref to be unchanged since
 the new history to replace it was prepared.

 The machinery is more or less ready.  The "--force" option is again
 the big red button to override any safety, thanks to J6t's sanity
 (the original round allowed --lockref to defeat --force).

 The logic to choose the default implemented here is fragile
 (e.g. "git fetch" after seeing a failure will update the
 remote-tracking branch and will make the next "push" pass,
 defeating the safety pretty easily).  It is suitable only for the
 simplest workflows, and it may hurt users more than it helps them.


* jc/transport-do-not-use-connect-twice-in-fetch (2013-08-28) 6 commits
  (merged to 'next' on 2013-08-29 at f88a6da)
 + builtin/fetch.c: Fix a sparse warning
  (merged to 'next' on 2013-08-28 at 2ed86df)
 + fetch: work around "transport-take-over" hack
 + fetch: refactor code that fetches leftover tags
 + fetch: refactor code that prepares a transport
 + fetch: rename file-scope global "transport" to "gtransport"
 + t5802: add test for connect helper

 Originally merged to 'next' on 2013-08-20

 The auto-tag-following code in "git fetch" tries to reuse the same
 transport twice when the serving end does not cooperate and does
 not give tags that point to commits that are asked for as part of
 the primary transfer.  Unfortunately, Git-aware transport helper
 interface is not designed to be used more than once, hence this
 does not work over smart-http transfer.


* jc/url-match (2013-08-09) 7 commits
  (merged to 'next' on 2013-08-28 at 2a9fd23)
 + builtin/config.c: compilation fix
 + config: "git config --get-urlmatch" parses section.<url>.key
 + builtin/config: refactor collect_config()
 + config: parse http.<url>.<variable> using urlmatch
 + config: add generic callback wrapper to parse section.<url>.key
 + config: add helper to normalize and match URLs
 + http.c: fix parsing of http.sslCertPasswordProtected variable

 Originally merged to 'next' on 2013-08-12

 Allow section.<urlpattern>.var configuration variables to be
 treated as a "virtual" section.var given a URL, and use the
 mechanism to enhance http.* configuration variables.

 This is a reroll of Kyle J. McKay's work.


* jk/cat-file-batch-optim (2013-08-05) 1 commit
  (merged to 'next' on 2013-08-28 at 624e60d)
 + cat-file: only split on whitespace when %(rest) is used

 Originally merged to 'next' on 2013-08-06

 Rework the reverted change to `cat-file --batch-check`.


* jk/fast-import-empty-ls (2013-06-23) 4 commits
  (merged to 'next' on 2013-08-28 at 876a39d)
 + fast-import: allow moving the root tree
 + fast-import: allow ls or filecopy of the root tree
 + fast-import: set valid mode on root tree in "ls"
 + t9300: document fast-import empty path issues

 Originally merged to 'next' on 2013-07-22


* jk/mailmap-incomplete-line (2013-08-28) 1 commit
  (merged to 'next' on 2013-09-04 at e77e887)
 + mailmap: handle mailmap blobs without trailing newlines

 Will merge later to 'maint'.


* jl/some-submodule-config-are-not-boolean (2013-08-19) 1 commit
  (merged to 'next' on 2013-08-28 at 7fabc3e)
 + avoid segfault on submodule.*.path set to an empty "true"

 Originally merged to 'next' on 2013-08-20


* jl/submodule-mv (2013-08-06) 5 commits
  (merged to 'next' on 2013-08-28 at 4ec6b41)
 + rm: delete .gitmodules entry of submodules removed from the work tree
 + mv: update the path entry in .gitmodules for moved submodules
 + submodule.c: add .gitmodules staging helper functions
 + mv: move submodules using a gitfile
 + mv: move submodules together with their work trees
 (this branch is tangled with nd/magic-pathspec.)

 Originally merged to 'next' on 2013-08-08

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.


* km/svn-1.8-serf-only (2013-07-18) 3 commits
  (merged to 'next' on 2013-08-28 at 1119134)
 + Git.pm: revert _temp_cache use of temp_is_locked
 + git-svn: allow git-svn fetching to work using serf
 + Git.pm: add new temp_is_locked function

 Originally merged to 'next' on 2013-07-19

 Subversion 1.8.0 that was recently released breaks older subversion
 clients coming over http/https in various ways.


* mm/no-shell-escape-in-die-message (2013-08-07) 1 commit
  (merged to 'next' on 2013-08-28 at 86b300f)
 + die_with_status: use "printf '%s\n'", not "echo"

 Originally merged to 'next' on 2013-08-08

 Fixes a minor bug in "git rebase -i" (there could be others, as the
 root cause is pretty generic) where the code feeds a random, data
 dependeant string to 'echo' and expects it to come out literally.


* ms/fetch-prune-configuration (2013-07-18) 1 commit
  (merged to 'next' on 2013-08-28 at fa6ffc7)
 + fetch: make --prune configurable

 Originally merged to 'next' on 2013-07-21

 Allow fetch.prune and remote.*.prune configuration variables to be set,
 and "git fetch" to behave as if "--prune" is given.

 "git fetch" that honors remote.*.prune is fine, but I wonder if we
 should somehow make "git push" aware of it as well.  Perhaps
 remote.*.prune should not be just a boolean, but a 4-way "none",
 "push", "fetch", "both"?


* nd/clone-connectivity-shortcut (2013-07-23) 1 commit
  (merged to 'next' on 2013-08-28 at d227f9f)
 + smart http: use the same connectivity check on cloning

 Originally merged to 'next' on 2013-07-30


* nd/gc-lock-against-each-other (2013-08-09) 1 commit
  (merged to 'next' on 2013-08-28 at 46e072b)
 + gc: reject if another gc is running, unless --force is given

 Originally merged to 'next' on 2013-08-14


* nd/magic-pathspec (2013-09-05) 50 commits
  (merged to 'next' on 2013-09-05 at b832b8d)
 + add: lift the pathspec magic restriction on "add -p"
 + pathspec: catch prepending :(prefix) on pathspec with short magic
  (merged to 'next' on 2013-08-28 at 305c6e9)
 + rm: do not set a variable twice without intermediate reading.
 + t6131 - skip tests if on case-insensitive file system
 + parse_pathspec: accept :(icase)path syntax
 + pathspec: support :(glob) syntax
 + pathspec: make --literal-pathspecs disable pathspec magic
 + pathspec: support :(literal) syntax for noglob pathspec
 + kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 + parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 + parse_pathspec: make sure the prefix part is wildcard-free
 + rename field "raw" to "_raw" in struct pathspec
 + tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 + remove match_pathspec() in favor of match_pathspec_depth()
 + remove init_pathspec() in favor of parse_pathspec()
 + remove diff_tree_{setup,release}_paths
 + convert common_prefix() to use struct pathspec
 + convert add_files_to_cache to take struct pathspec
 + convert {read,fill}_directory to take struct pathspec
 + convert refresh_index to take struct pathspec
 + convert report_path_error to take struct pathspec
 + checkout: convert read_tree_some to take struct pathspec
 + convert unmerge_cache to take struct pathspec
 + convert run_add_interactive to use struct pathspec
 + convert read_cache_preload() to take struct pathspec
 + line-log: convert to use parse_pathspec
 + reset: convert to use parse_pathspec
 + add: convert to use parse_pathspec
 + check-ignore: convert to use parse_pathspec
 + archive: convert to use parse_pathspec
 + ls-files: convert to use parse_pathspec
 + rm: convert to use parse_pathspec
 + checkout: convert to use parse_pathspec
 + rerere: convert to use parse_pathspec
 + status: convert to use parse_pathspec
 + commit: convert to use parse_pathspec
 + clean: convert to use parse_pathspec
 + guard against new pathspec magic in pathspec matching code
 + parse_pathspec: support prefixing original patterns
 + parse_pathspec: support stripping/checking submodule paths
 + parse_pathspec: support stripping submodule trailing slashes
 + parse_pathspec: add special flag for max_depth feature
 + convert some get_pathspec() calls to parse_pathspec()
 + parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL} flags
 + parse_pathspec: save original pathspec for reporting
 + add parse_pathspec() that converts cmdline args to struct pathspec
 + pathspec: add copy_pathspec
 + pathspec: i18n-ize error strings in pathspec parsing code
 + move struct pathspec and related functions to pathspec.[ch]
 + clean: remove unused variable "seen"
 (this branch is tangled with jl/submodule-mv.)

 Originally merged to 'next' on 2013-07-23

 Use "struct pathspec" interface in more places, instead of array of
 characters, the latter of which cannot express magic pathspecs
 (e.g. ":(icase)makefile" that matches both Makefile and makefile).


* nd/sq-quote-buf (2013-07-30) 3 commits
  (merged to 'next' on 2013-08-28 at d0ffd55)
 + quote: remove sq_quote_print()
 + tar-tree: remove dependency on sq_quote_print()
 + for-each-ref, quote: convert *_quote_print -> *_quote_buf

 Originally merged to 'next' on 2013-08-01

 Code simplification as a preparatory step to something larger.


* rr/feed-real-path-to-editor (2013-07-29) 1 commit
  (merged to 'next' on 2013-08-28 at 7458fa4)
 + editor: use canonicalized absolute path

 Originally merged to 'next' on 2013-07-30


* sb/diff-delta-remove-needless-comparison (2013-08-18) 1 commit
  (merged to 'next' on 2013-08-28 at ba09c3f)
 + create_delta_index: simplify condition always evaluating to true

 Originally merged to 'next' on 2013-08-20


* sb/misc-cleanup (2013-08-09) 3 commits
  (merged to 'next' on 2013-08-28 at bc2045b)
 + rm: remove unneeded null pointer check
 + diff: fix a possible null pointer dereference
 + diff: remove ternary operator evaluating always to true

 Originally merged to 'next' on 2013-08-14


* sb/parseopt-boolean-removal (2013-08-07) 9 commits
  (merged to 'next' on 2013-08-28 at 2f3f21f)
 + revert: use the OPT_CMDMODE for parsing, reducing code
 + checkout-index: fix negations of even numbers of -n
 + config parsing options: allow one flag multiple times
 + hash-object: replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
 + branch, commit, name-rev: ease up boolean conditions
 + checkout: remove superfluous local variable
 + log, format-patch: parsing uses OPT__QUIET
 + Replace deprecated OPT_BOOLEAN by OPT_BOOL
 + Remove deprecated OPTION_BOOLEAN for parsing arguments
 (this branch uses jc/parseopt-command-modes.)

 Convert most uses of OPT_BOOLEAN/OPTION_BOOLEAN that can use
 OPT_BOOL/OPTION_BOOLEAN which have much saner semantics, and turn
 remaining ones into OPT_SET_INT, OPT_COUNTUP, etc. as necessary.


* sg/bash-prompt-lf-in-cwd-test (2013-08-18) 1 commit
  (merged to 'next' on 2013-08-28 at eb449b5)
 + bash prompt: test the prompt with newline in repository path

 Originally merged to 'next' on 2013-08-20


* sp/clip-read-write-to-8mb (2013-08-20) 2 commits
  (merged to 'next' on 2013-08-28 at c9840d7)
 + Revert "compat/clipped-write.c: large write(2) fails on Mac OS X/XNU"
 + xread, xwrite: limit size of IO to 8MB

 Originally merged to 'next' on 2013-08-22

 Send a large request to read(2)/write(2) as a smaller but still
 reasonably large chunks, which would improve the latency when the
 operation needs to be killed and incidentally works around broken
 64-bit systems that cannot take a 2GB write or read in one go.


* tg/index-struct-sizes (2013-08-20) 1 commit
  (merged to 'next' on 2013-08-28 at c815042)
 + read-cache: use fixed width integer types

 Originally merged to 'next' on 2013-08-22

 The code that reads from a region that mmaps an on-disk index
 assumed that "int"/"short" are always 32/16 bits.


* tr/fd-gotcha-fixes (2013-08-06) 1 commit
  (merged to 'next' on 2013-08-28 at 5305271)
 + t0070: test that git_mkstemps correctly checks return value of open()

 Originally merged to 'next' on 2013-08-08

 Finishing touches to an earlier fix already in 'master'.


* tr/log-full-diff-keep-true-parents (2013-08-05) 2 commits
  (merged to 'next' on 2013-08-28 at e86ec11)
 + log: use true parents for diff when walking reflogs
 + log: use true parents for diff even when rewriting

 Originally merged to 'next' on 2013-08-08

 Output from "git log --full-diff -- <pathspec>" looked strange,
 because comparison was done with the previous ancestor that touched
 the specified <pathspec>, causing the patches for paths outside the
 pathspec to show more than the single commit has changed.

 Tweak "git reflog -p" for the same reason using the same mechanism.

--------------------------------------------------
[New Topics]

* js/add-i-mingw (2013-09-04) 1 commit
 - add--interactive: fix external command invocation on Windows

 The implementation of "add -i" has a crippling code to work around
 ActiveState Perl limitation but it by mistake also triggered on Git
 for Windows where MSYS perl is used.

 Will merge to 'next'.


* rh/ishes-doc (2013-09-04) 7 commits
 - glossary: fix and clarify the definition of 'ref'
 - revisions.txt: fix and clarify <rev>^{<type>}
 - glossary: more precise definition of tree-ish (a.k.a. treeish)
 - use 'commit-ish' instead of 'committish'
 - use 'tree-ish' instead of 'treeish'
 - glossary: define commit-ish (a.k.a. committish)
 - glossary: mention 'treeish' as an alternative to 'tree-ish'

 We liberally use "committish" and "commit-ish" (and "treeish" and
 "tree-ish"); as these are non-words, let's unify these terms to
 their dashed form.  More importantly, clarify the documentation on
 object peeling using these terms.

 Will merge to 'next'.


* jc/commit-is-spelled-with-two-ems (2013-09-05) 2 commits
  (merged to 'next' on 2013-09-05 at 982aef2)
 + typofix: cherry is spelled with two ars
 + typofix: commit is spelled with two ems

 Will merge to 'master'.


* bc/http-backend-allow-405 (2013-09-09) 1 commit
 - http-backend: provide Allow header for 405

 When the webserver responds with "405 Method Not Allowed", it
 should tell the client what methods are allowed with the "Allow"
 header.

 Will merge to 'next'.


* dw/check-ignore-sans-index (2013-09-05) 2 commits
 - SQUASH??? do not let --no-index squat on short-and-sweet -i for now
 - check-ignore: Add option to ignore index contents

 "git check-ignore" follows the same rule as "git add" and "git
 status" in that the ignore/exclude mechanism does not take effect
 on paths that are already tracked.  With "--no-index" option, it
 can be used to diagnose which paths that should have been ignored
 have been mistakenly added to the index.

 Will squash the tip in and merge to 'next'.


* hu/cherry-pick-previous-branch (2013-09-09) 1 commit
 - cherry-pick: allow "-" as abbreviation of '@{-1}'

 Just like "git checkout -" knows to check out and "git merge -"
 knows to merge the branch you were previously on, teach "git
 cherry-pick" to understand "-" as the previous branch.

 Will merge to 'next'.


* jh/checkout-auto-tracking (2013-09-09) 5 commits
 - branch.c: Relax unnecessary requirement on upstream's remote ref name
 - t3200: Add test demonstrating minor regression in 41c21f2
 - Refer to branch.<name>.remote/merge when documenting --track
 - t3200: Minor fix when preparing for tracking failure
 - t2024: Fix &&-chaining and a couple of typos

 Fix a minor regression in v1.8.3.2 and later that made it
 impossible to base your local work on anything but a local branch
 of the upstream repository you are tracking from.

 Will merge to 'next'.


* jk/remove-remote-helpers-in-python (2013-09-09) 1 commit
 - git_remote_helpers: remove little used Python library

 Remove now disused remote-helpers framework for helpers written in
 Python.

 Will merge to 'next'.


* jk/upload-pack-keepalive (2013-09-09) 2 commits
 - upload-pack: bump keepalive default to 5 seconds
 - upload-pack: send keepalive packets during pack computation

 When running "fetch -q", a long silence while the sender side
 computes the set of objects to send can be mistaken by proxies as
 dropped connection.

 Will merge to 'next'.


* mm/rebase-continue-freebsd-WB (2013-09-09) 1 commit
 - rebase: fix run_specific_rebase's use of "return" on FreeBSD

 Work around a bug in FreeBSD shell that caused a regression to "git
 rebase" in v1.8.4.  It would be lovely to hear from FreeBSD folks a
 success report to make sure we didn't miss any other use of a bare
 "return" from dot-sourced script.

 Will merge to 'next'.


* ss/doclinks (2013-09-06) 1 commit
 - Documentation: make AsciiDoc links always point to HTML files

 When we converted many documents that were traditionally text-only
 to be formatted to AsciiDoc, we did not update links that point at
 them to refer to the formatted HTML files.

 Will merge to 'next'.


* uh/git-svn-serf-fix (2013-09-06) 1 commit
 - git-svn: fix termination issues for remote svn connections

 "git-svn" used with SVN 1.8.0 when talking over https:// connection
 dumped core due to a bug in the serf library that SVN uses.  Work
 it around on our side, even though the SVN side is being fixed.

--------------------------------------------------
[Stalled]

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


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


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

* fc/contrib-bzr-hg-fixes (2013-09-03) 10 commits
 - contrib/remote-helpers: quote variable references in redirection targets
 - contrib/remote-helpers: style updates for test scripts
 - remote-hg: use notes to keep track of Hg revisions
 - remote-helpers: cleanup more global variables
 - remote-helpers: trivial style fixes
 - remote-hg: improve basic test
 - remote-hg: add missing &&s in the test
 - remote-hg: fix test
 - remote-bzr: make bzr branches configurable per-repo
 - remote-bzr: fix export of utf-8 authors

 Will merge to 'next'.


* jc/pager-configuration-doc (2013-08-29) 1 commit
  (merged to 'next' on 2013-09-05 at 3169083)
 + config: rewrite core.pager documentation

 It was unclear in the documentation how various configurations and
 environment variables determine which pager is eventually used.

 Will merge to 'master'.


* np/pack-v4 (2013-09-03) 24 commits
 - Document pack v4 format
 - initial pack index v3 support on the read side
 - pack v4: add progress display
 - pack v4: normalize pack name to properly generate the pack index file name
 - pack index v3
 - pack v4: relax commit parsing a bit
 - pack v4: honor pack.compression config option
 - pack v4: load delta candidate for encoding tree objects
 - pack v4: tree object delta encoding
 - pack v4: object writing
 - pack v4: object data copy
 - pack v4: object headers
 - pack v4: creation code
 - pack v4: dictionary table output
 - pack v4: tree object encoding
 - pack v4: commit object encoding
 - pack v4: basic references encoding
 - pack v4: move to struct pack_idx_entry and get rid of our own struct idx_entry
 - pack v4: split the object list and dictionary creation
 - pack v4: add commit object parsing
 - pack v4: add tree entry mode support to dictionary entries
 - pack v4: scan tree objects
 - export packed_object_info()
 - pack v4: initial pack dictionary structure and code

 Will replace with a newer version of the series.


* jk/free-tree-buffer (2013-06-06) 1 commit
  (merged to 'next' on 2013-09-09 at 3576189)
 + clear parsed flag when we free tree buffers

 Will merge to 'master'.


* jk/has-sha1-file-retry-packed (2013-08-30) 1 commit
  (merged to 'next' on 2013-09-09 at fc42e9b)
 + has_sha1_file: re-check pack directory before giving up

 When an object is not found after checking the packfiles and then
 loose object directory, read_sha1_file() re-checks the packfiles to
 prevent racing with a concurrent repacker; teach the same logic to
 has_sha1_file().

 Will merge to 'master'.


* ab/gitweb-author-initials (2013-08-30) 1 commit
  (merged to 'next' on 2013-09-09 at ecb924d)
 + gitweb: Fix the author initials in blame for non-ASCII names

 Will merge to 'master'.


* bk/refs-multi-update (2013-09-09) 8 commits
 - update-ref: add test cases covering --stdin signature
 - update-ref: support multiple simultaneous updates
 - refs: add update_refs for multiple simultaneous updates
 - refs: add function to repack without multiple refs
 - refs: factor delete_ref loose ref step into a helper
 - refs: factor update_ref steps into helpers
 - refs: report ref type from lock_any_ref_for_update
 - reset: rename update_refs to reset_refs

 Give "update-refs" a "--stdin" option to read multiple update
 requests and perform them in an all-or-none fashion.

 Comments?


* fc/at-head (2013-09-09) 3 commits
 - SQUASH??? fixup
 - Add new @ shortcut for HEAD
 - sha1-name: pass len argument to interpret_branch_name()

 Attempt to resurrect "Type @ for HEAD"; the bottom one seems to be
 a genuine code improvement, but identifying cases where "@" means
 HEAD were harder than it should have been.  I think the result of
 squashing the tip one in covers all the necessary cases.

 Will squash the tip in and merge to 'next'.


* fc/fast-export (2013-09-03) 2 commits
  (merged to 'next' on 2013-09-09 at 8d5d396)
 + fast-export: refactor get_tags_and_duplicates()
 + fast-export: make extra_refs global

 Code simpification.

 Will merge to 'master'.


* fc/rev-parse-test-updates (2013-09-03) 4 commits
  (merged to 'next' on 2013-09-09 at 92c51ef)
 + rev-parse test: use standard test functions for setup
 + rev-parse test: use test_cmp instead of "test" builtin
 + rev-parse test: use test_must_fail, not "if <command>; then false; fi"
 + rev-parse test: modernize quoting and whitespace

 Modernize tests.

 Will merge to 'master'.


* fc/t3200-fixes (2013-09-03) 3 commits
  (merged to 'next' on 2013-09-09 at 3626363)
 + t: branch: fix broken && chains
 + t: branch: fix typo
 + t: branch: trivial style fix

 Will merge to 'master'.


* fc/trivial (2013-09-08) 5 commits
  (merged to 'next' on 2013-09-09 at a8ad2e1)
 + pull: use $curr_branch_short more
 + add: trivial style cleanup
 + reset: trivial style cleanup
 + branch: trivial style fix
 + reset: trivial refactoring

 Will merge to 'master'.


* jc/ref-excludes (2013-09-03) 2 commits
 - document --exclude option
 - revision: introduce --exclude=<glob> to tame wildcards

 People often wished a way to tell "git log --branches" (and "git
 log --remotes --not --branches") to exclude some local branches
 from the expansion of "--branches" (similarly for "--tags", "--all"
 and "--glob=<pattern>").  Now they have one.

 Will merge to 'next'.


* jk/pager-bypass-cat-for-default-pager (2013-09-03) 1 commit
  (merged to 'next' on 2013-09-09 at c9cfbaa)
 + pager: turn on "cat" optimization for DEFAULT_PAGER

 If a build-time fallback is set to "cat" instead of "less", we
 should apply the same "no subprocess or pipe" optimization as we
 apply to user-supplied GIT_PAGER=cat.

 Will merge to 'master'.


* nd/git-dir-pointing-at-gitfile (2013-09-03) 1 commit
  (merged to 'next' on 2013-09-09 at 5b0a4bf)
 + Make setup_git_env() resolve .git file when $GIT_DIR is not specified

 We made sure that we notice the user-supplied GIT_DIR is actually a
 gitfile, but failed to do so when the default ".git" is a gitfile.

 Will merge to 'master'.


* nr/git-cd-to-a-directory (2013-09-09) 1 commit
 - git: run in a directory given with -C option

 Just like "make -C <directory>", make "git -C <directory> ..." to
 go there before doing anything else.

 Will merge to 'next'.


* rh/peeling-tag-to-tag (2013-09-03) 2 commits
 - peel_onion: do not assume length of x_type globals
 - peel_onion(): add support for <rev>^{tag}

 Make "foo^{tag}" to peel a tag to itself, i.e. no-op., and fail if
 "foo" is not a tag.

 Will merge to 'next'.


* cc/replace-with-the-same-type (2013-09-09) 8 commits
 - Doc: 'replace' merge and non-merge commits
 - t6050-replace: use some long option names
 - replace: allow long option names
 - Documentation/replace: add Creating Replacement Objects section
 - t6050-replace: add test to clean up all the replace refs
 - t6050-replace: test that objects are of the same type
 - Documentation/replace: state that objects must be of the same type
 - replace: forbid replacing an object with one of a different type

 Using the replace mechanism to swap an object with another object
 of a different type can introduce inconsistency (e.g. a tree
 expects an object name to refer to a blob, but the blob object can
 be mistakenly or maliciously replaced with an object with a
 different type). Attempt to forbid such.

 Will merge to 'next'.


* jx/clean-interactive (2013-08-28) 1 commit
  (merged to 'next' on 2013-09-09 at 477fec6)
 + documentation: clarify notes for clean.requireForce

 Finishing touches to update the document to adjust to a new option
 "git clean" learned recently.

 Will merge to 'master'.


* mm/status-without-comment-char (2013-09-06) 6 commits
 - status: add missing blank line after list of "other" files
 - tests: don't set status.displayCommentPrefix file-wide
 - status: disable display of '#' comment prefix by default
 - submodule summary: ignore --for-status option
 - wt-status: use argv_array API
 - builtin/stripspace.c: fix broken indentation

 Allow "git status" to omit the prefix to make its output a comment
 in a commit log editor, which is not necessary for human
 consumption.

 We may want to tighten the output to omit unnecessary trailing
 blank lines, but that does not have to be in the scope of this
 series.

 Will merge to 'next'.


* js/xread-in-full (2013-08-20) 1 commit
  (merged to 'next' on 2013-09-04 at 5bfb049)
 + stream_to_pack: xread does not guarantee to read all requested bytes

 Originally merged to 'next' on 2013-08-20

 A call to xread() was used without a loop around to cope with short
 read in the codepath to stream new contents to a pack.

 Will merge to 'master' in the third batch.


* sb/mailmap-freeing-NULL-is-ok (2013-08-20) 1 commit
  (merged to 'next' on 2013-09-04 at c831015)
 + mailmap: remove redundant check for freeing memory

 Originally merged to 'next' on 2013-08-20

 Will merge to 'master' in the third batch.


* bc/submodule-status-ignored (2013-09-04) 2 commits
 - submodule: don't print status output with ignore=all
 - submodule: fix confusing variable name

 Originally merged to 'next' on 2013-08-22

 Will merge to 'next'.


* jk/config-int-range-check (2013-09-09) 5 commits
  (merged to 'next' on 2013-09-09 at 9ab779d)
 + git-config: always treat --int as 64-bit internally
 + config: make numeric parsing errors more clear
 + config: set errno in numeric git_parse_* functions
 + config: properly range-check integer values
 + config: factor out integer parsing from range checks

 Originally merged to 'next' on 2013-08-22

 "git config --int section.var 3g" should somehow diagnose that the
 number does not fit in "int" (on 32-bit platforms anyway) but it
 did not.

 Will merge to 'master'.


* jk/duplicate-objects-in-packs (2013-09-04) 5 commits
  (merged to 'next' on 2013-09-09 at 72f2c3d)
 + t5308: check that index-pack --strict detects duplicate objects
 + test index-pack on packs with recoverable delta cycles
 + add tests for indexing packs with delta cycles
 + sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP
 + test-sha1: add a binary output mode

 A packfile that stores the same object more than once is broken and
 will be rejected.

 Will merge to 'master'.


* mm/mediawiki-dumb-push-fix (2013-09-03) 4 commits
  (merged to 'next' on 2013-09-05 at f8313f4)
 + git-remote-mediawiki: no need to update private ref in non-dumb push
 + git-remote-mediawiki: use no-private-update capability on dumb push
 + transport-helper: add no-private-update capability
 + git-remote-mediawiki: add test and check Makefile targets

 Will merge to 'master'.


* rt/rebase-p-no-merge-summary (2013-08-21) 1 commit
  (merged to 'next' on 2013-09-04 at d8d89ee)
 + rebase --preserve-merges: ignore "merge.log" config

 Originally merged to 'next' on 2013-08-22

 "git rebase -p" internally used the merge machinery, but when
 rebasing, there should not be a need for merge summary.

 Will merge to 'master' in the third batch.


* dw/diff-no-index-doc (2013-08-28) 2 commits
 - diff --no-index: describe in a separate paragraph
 - diff --no-index: clarify operation when not inside a repository

 When the user types "git diff" outside a working tree, thinking he
 is inside one, the current error message that is a single-liner
 "usage: git diff --no-index <path> <path>" may not be sufficient to
 make him realize the mistake. Add "Not a git repository" to the
 error message when we fell into the "--no-index" mode without an
 explicit command line option to instruct us to do so.

 Will merge to 'next'.


* sb/repack-in-c (2013-08-30) 2 commits
 - repack: retain the return value of pack-objects
 - repack: rewrite the shell script in C

 Any further reviews?


* ap/commit-author-mailmap (2013-08-24) 1 commit
  (merged to 'next' on 2013-09-09 at 79d5a20)
 + commit: search author pattern against mailmap

 "git commit --author=$name", when $name is not in the canonical
 "A. U. Thor <au.thor@example.xz>" format, looks for a matching name
 from existing history, but did not consult mailmap to grab the
 preferred author name.

 Will merge to 'master'.


* jk/write-broken-index-with-nul-sha1 (2013-08-28) 1 commit
  (merged to 'next' on 2013-09-09 at 6953f27)
 + write_index: optionally allow broken null sha1s

 Earlier we started rejecting an attempt to add 0{40} object name to
 the index and to tree objects, but it sometimes is necessary to
 allow so to be able to use tools like filter-branch to correct such
 broken tree objects.

 Will merge to 'master'.


* kk/tests-with-no-perl (2013-08-24) 4 commits
  (merged to 'next' on 2013-09-09 at 67510b1)
 + reset test: modernize style
 + t/t7106-reset-unborn-branch.sh: Add PERL prerequisite
 + add -i test: use skip_all instead of repeated PERL prerequisite
 + Make test "using invalid commit with -C" more strict

 Some tests were not skipped under NO_PERL build.

 Will merge to 'master'.


* mm/fast-import-feature-doc (2013-08-25) 1 commit
  (merged to 'next' on 2013-09-05 at 83802e2)
 + Documentation/fast-import: clarify summary for `feature` command

 Will merge to 'master'.


* mm/remote-helpers-doc (2013-08-26) 1 commit
  (merged to 'next' on 2013-09-05 at c181b35)
 + Documentation/remote-helpers: document common use-case for private ref

 Will merge to 'master'.


* mn/doc-pack-heu-remove-dead-pastebin (2013-08-23) 1 commit
  (merged to 'next' on 2013-09-05 at 5caecec)
 + remove dead pastebin link from pack-heuristics document

 Will merge to 'master'.


* ta/user-manual (2013-08-27) 11 commits
 - "git prune" is safe
 - Remove irrelevant reference from "Tying it all together"
 - Remove unnecessary historical note from "Object storage format"
 - Improve section "Merging multiple trees"
 - Improve section "Manipulating branches"
 - Simplify "How to make a commit"
 - Fix some typos and improve wording
 - Use "git merge" instead of "git pull ."
 - Use current output for "git repack"
 - Use current "detached HEAD" message
 - Call it "Git User Manual" and remove reference to very old Git version

 Update the user's manual to more recent versions of Git.

 Will merge to 'next'.


* tb/precompose-autodetect-fix (2013-08-27) 1 commit
  (merged to 'next' on 2013-09-09 at 9bfdac1)
 + Set core.precomposeunicode to true on e.g. HFS+

 On MacOS X, we detected if the filesystem needs the "pre-composed
 unicode strings" workaround, but did not automatically enable it.
 Now we do.

 Will merge to 'master'.


* tf/gitweb-ss-tweak (2013-08-20) 4 commits
  (merged to 'next' on 2013-09-04 at 774bfbe)
 + gitweb: make search help link less ugly
 + gitweb: omit the repository owner when it is unset
 + gitweb: vertically centre contents of page footer
 + gitweb: ensure OPML text fits inside its box

 Originally merged to 'next' on 2013-08-22

 Tweak Gitweb CSS to layout some elements better.

 Will merge to 'master' in the third batch.


* es/rebase-i-respect-core-commentchar (2013-08-18) 1 commit
  (merged to 'next' on 2013-09-04 at 8c1ce68)
 + rebase -i: fix cases ignoring core.commentchar

 Originally merged to 'next' on 2013-08-20

 "rebase -i" forgot that the comment character can be configurable
 while reading its insn sheet.

 Will merge to 'master' in the third batch.


* jx/branch-vv-always-compare-with-upstream (2013-08-26) 2 commits
 - status: always show tracking branch even no change
 - branch: report invalid tracking branch as gone

 "git branch -v -v" (and "git status") did not distinguish among a
 branch that does not build on any other branch, a branch that is in
 sync with the branch it builds on, and a branch that is configured
 to build on some other branch that no longer exists.

 Will merge to 'next'.


* nd/fetch-into-shallow (2013-08-28) 7 commits
  (merged to 'next' on 2013-09-09 at 87a3b99)
 + Add testcase for needless objects during a shallow fetch
 + list-objects: mark more commits as edges in mark_edges_uninteresting
 + list-objects: reduce one argument in mark_edges_uninteresting
 + upload-pack: delegate rev walking in shallow fetch to pack-objects
 + shallow: add setup_temporary_shallow()
 + shallow: only add shallow graft points to new shallow file
 + move setup_alternate_shallow and write_shallow_commits to shallow.c

 When there is no sufficient overlap between old and new history
 during a fetch into a shallow repository, we unnecessarily sent
 objects the sending side knows the receiving end has.

 Will merge to 'master'.


* jc/ls-files-killed-optim (2013-08-23) 4 commits
  (merged to 'next' on 2013-09-04 at 20c2304)
 + dir.c::test_one_path(): work around directory_exists_in_index_icase() breakage
 + t3010: update to demonstrate "ls-files -k" optimization pitfalls
 + ls-files -k: a directory only can be killed if the index has a non-directory
 + dir.c: use the cache_* macro to access the current index

 Originally merged to 'next' on 2013-08-27

 "git ls-files -k" needs to crawl only the part of the working tree
 that may overlap the paths in the index to find killed files, but
 shared code with the logic to find all the untracked files, which
 made it unnecessarily inefficient.

 Will merge to 'master' in the third batch.


* es/rebase-i-no-abbrev (2013-08-25) 3 commits
  (merged to 'next' on 2013-09-04 at 6027805)
 + rebase -i: fix short SHA-1 collision
 + t3404: rebase -i: demonstrate short SHA-1 collision
 + t3404: make tests more self-contained

 Originally merged to 'next' on 2013-08-26

 The commit object names in the insn sheet that was prepared at the
 beginning of "rebase -i" session can become ambiguous as the
 rebasing progresses and the repository gains more commits. Make
 sure the internal record is kept with full 40-hex object names.

 Will merge to 'master' in the third batch.


* ks/p4-view-spec (2013-09-03) 2 commits
 - git p4: implement view spec wildcards with "p4 where"
 - git p4 test: sanitize P4CHARSET

 Replaced with a reroll that was whitespace damaged.

 Waiting for the final Ack.


* nd/push-no-thin (2013-08-13) 1 commit
  (merged to 'next' on 2013-09-04 at faa8c02)
 + push: respect --no-thin

 Originally merged to 'next' on 2013-08-14

 "git push --no-thin" was a no-op by mistake.

 Will merge to 'master' in the third batch.


* sh/pull-rebase-preserve (2013-09-04) 1 commit
  (merged to 'next' on 2013-09-04 at 32a93bb)
 + pull: allow pull to preserve merges when rebasing

 Originally merged to 'next' on 2013-08-14

 "git pull --rebase" always flattened the history; pull.rebase can
 now be set to "preserve" to invoke "rebase --preserve-merges".

 Will merge to 'master' in the third batch.


* jn/post-receive-utf8 (2013-08-05) 3 commits
  (merged to 'next' on 2013-09-04 at 3a3f480)
 + hooks/post-receive-email: set declared encoding to utf-8
 + hooks/post-receive-email: force log messages in UTF-8
 + hooks/post-receive-email: use plumbing instead of git log/show

 Originally merged to 'next' on 2013-08-20

 Update post-receive-email script to make sure the message contents
 and pathnames are encoded consistently in UTF-8.

 Will merge to 'master' in the third batch.


* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Will hold, until we get any user.


* jc/pull-training-wheel (2013-07-19) 1 commit
  (merged to 'next' on 2013-08-28 at c39bd15)
 + pull: require choice between rebase/merge on non-fast-forward pull

 Originally merged to 'next' on 2013-07-22

 Make "git pull" (without arguments that say what branch to
 integrate from where) refuse with "it does not fast forward; choose
 between 'pull --merge' and 'pull --rebase'".

 Will revert the merge, wait for the discussion to settle and
 produce a replacement to queue again. 

 http://thread.gmane.org/gmane.comp.version-control.git/233554/focus=234375


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
 - diff: remove "diff-files -q" in a version of Git in a distant future

 Will cook in 'next' until a distant future.
