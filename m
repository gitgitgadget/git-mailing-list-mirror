From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2011, #10; Mon, 23)
Date: Mon, 23 May 2011 17:22:30 -0700
Message-ID: <7v8vtxrlq1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 02:22:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOfOV-0004Le-A8
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 02:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757665Ab1EXAWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 20:22:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab1EXAWg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 20:22:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1AA053A4;
	Mon, 23 May 2011 20:24:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=b
	WXB6gqhkQfOqSzTzRCp0U4jxlw=; b=cW1NRal06jM+XultJz2NQ0W0E4d8hbZQ2
	z/SnohLMRAnnTs/lC91Cy3+8JqObEqD+9HjEdkVkDXZTkrKk8RKVwTuataQuZErd
	tZG3DWdkS21YSUwjIEqLgp8dPL0w7qnHuJZc/Qh00kW+zQO3jiiDQw28X+jXbOjQ
	79BMWJRskE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=FzG
	QReW77CCmSas9/lvIqcRobjnWjnrRRel0pwRi8QHe7kggCsMnYvfVm/hYgGa59KK
	Inq77lWMzKSiELz+Al0VHtXiXd6Zj4AV32982fVXdTkntfCD+ApoBSLsXJ/p1Xia
	0UO9xNRWjrs0QQUBa4/DVujedllryIgMDC8vm1LA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 898B553A2;
	Mon, 23 May 2011 20:24:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 22D4E53A1; Mon, 23 May 2011
 20:24:39 -0400 (EDT)
X-master-at: 5df3e2b3ca5ebe8123927a81d682993ad597a584
X-next-at: fbd4877f301a9ed26bffbebd340b19d5a18c8573
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 381D78EC-859C-11E0-BE50-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174302>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

The main part of this cycle is expected to run thru May, aiming for a
feature freeze in early June.

We are at the beginning of week #5 of this cycle. Let's plan to tag -rc0
with what is in 'master' at the end of the month.

--------------------------------------------------
[New Topics]

* jc/notes-batch-removal (2011-05-19) 4 commits
  (merged to 'next' on 2011-05-23 at 5bd78a6)
 + show: --ignore-missing
 + notes remove: --stdin reads from the standard input
 + notes remove: --ignore-missing
 + notes remove: allow removing more than one

Will merge to "master" by the end of week #5.

* jk/fetch-mark-complete-optimization (2011-05-19) 1 commit
  (merged to 'next' on 2011-05-23 at b56fb81)
 + fetch: avoid repeated commits in mark_complete

Trivially correct.
Will merge to "master" by the end of week #5.

* jk/haves-from-alternate-odb (2011-05-19) 3 commits
  (merged to 'next' on 2011-05-23 at 53b4735)
 + receive-pack: eliminate duplicate .have refs
 + bisect: refactor sha1_array into a generic sha1 list
 + refactor refs_from_alternate_cb to allow passing extra data

Will merge to "master" by the end of week #5.

* rg/no-gecos-in-pwent (2011-05-19) 1 commit
  (merged to 'next' on 2011-05-23 at d2c4c33)
 + ident: add NO_GECOS_IN_PWENT for systems without pw_gecos in struct passwd

Trivially correct and not intrusive, but the real value unknown.
Will merge to "master" by the end of week #5.

* jc/streaming-filter (2011-05-21) 6 commits
 - streaming: filter cascading
 - streaming filter: ident filter
 - Add LF-to-CRLF streaming conversion
 - stream filter: add "no more input" to the filters
 - Add streaming filter API
 - convert.h: move declarations for conversion from cache.h
 (this branch uses jc/bigfile, jc/streaming and jc/streaming.)

Trivial lf-to-crlf and ident conversions can be performed without reading
everything in-core first. Cascading is probably still broken.  Will not
merge before 1.7.6.

* jn/userdiff-perl-updates (2011-05-23) 8 commits
  (merged to 'next' on 2011-05-23 at 2595ae1)
 + userdiff/perl: tighten BEGIN/END block pattern to reject here-doc delimiters
 + tests: make test_expect_code quieter on success
 + userdiff/perl: catch sub with brace on second line
 + userdiff/perl: match full line of POD headers
 + userdiff/perl: anchor "sub" and "package" patterns on the left
 + t4018 (funcname patterns): minor cleanups
 + t4018 (funcname patterns): make configuration easier to track
 + t4018 (funcname patterns): make .gitattributes state easier to track

Will merge to "master" by the end of week #5.

* da/git-prefix-everywhere (2011-05-23) 3 commits
 - git-mergetool--lib: Make vimdiff retain the current directory
 - git: Remove handling for GIT_PREFIX
 - setup: Provide GIT_PREFIX to built-ins

* jc/git-handle-options-miscount (2011-05-23) 1 commit
 - handle_options(): do not miscount how many arguments were used

* jk/combine-diff-binary-etc (2011-05-23) 5 commits
 - combine-diff: respect textconv attributes
 - refactor get_textconv to not require diff_filespec
 - combine-diff: handle binary files as binary
 - combine-diff: calculate mode_differs earlier
 - combine-diff: split header printing into its own function

--------------------------------------------------
[Graduated to "master"]

* ab/i18n-scripts-basic (2011-05-14) 4 commits
  (merged to 'next' on 2011-05-18 at 3dc69f0)
 + Makefile: add xgettext target for *.sh files
 + git-sh-i18n.sh: add GIT_GETTEXT_POISON support
 + git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers
 + git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
 (this branch is used by ab/i18n-scripts.)

* jc/magic-pathspec (2011-05-17) 14 commits
  (merged to 'next' on 2011-05-18 at d7180b9)
 + setup.c: Fix some "symbol not declared" sparse warnings
  (merged to 'next' on 2011-05-12 at 656c8b5)
 + t3703: Skip tests using directory name ":" on Windows
  (merged to 'next' on 2011-05-11 at 86d1d6d)
 + revision.c: leave a note for "a lone :" enhancement
 + Merge branch 'jc/maint-1.6.6-pathspec-stdin-and-cmdline'
  (merged to 'next' on 2011-05-11 at aaad95e)
 + t3703, t4208: add test cases for magic pathspec
 + rev/path disambiguation: further restrict "misspelled index entry" diag
 + fix overslow :/no-such-string-ever-existed diagnostics
 + fix overstrict :<path> diagnosis
 + grep: use get_pathspec() correctly
 + pathspec: drop "lone : means no pathspec" from get_pathspec()
 + Revert "magic pathspec: add ":(icase)path" to match case insensitively"
  (merged to 'next' on 2011-04-25 at 788cd46)
 + magic pathspec: add ":(icase)path" to match case insensitively
 + magic pathspec: futureproof shorthand form
 + magic pathspec: add tentative ":/path/from/top/level" pathspec support

* jc/maint-1.6.6-pathspec-stdin-and-cmdline (2011-05-11) 1 commit
 + setup_revisions(): take pathspec from command line and --stdin correctly
 (this branch is used by jc/magic-pathspec, jc/maint-1.7.4-pathspec-stdin-and-cmdline and jc/maint-pathspec-stdin-and-cmdline.)

* jc/maint-1.7.4-pathspec-stdin-and-cmdline (2011-05-11) 1 commit
 + Merge branch 'jc/maint-1.6.6-pathspec-stdin-and-cmdline'

* jc/maint-pathspec-stdin-and-cmdline (2011-05-11) 2 commits
  (merged to 'next' on 2011-05-15 at b4e3a75)
 + Merge branch 'jc/maint-1.7.4-pathspec-stdin-and-cmdline'
 + Merge branch 'jc/maint-1.6.6-pathspec-stdin-and-cmdline'
 (this branch uses jc/maint-1.6.6-pathspec-stdin-and-cmdline; is tangled with jc/magic-pathspec and jc/maint-1.7.4-pathspec-stdin-and-cmdline.)

These are to fix an ancient bug where feeding "git log --stdin path" with
an input that also has additional pathspec corrupted memory.

* jc/replacing (2011-05-15) 5 commits
  (merged to 'next' on 2011-05-16 at 5d0b584)
 + read_sha1_file(): allow selective bypassing of replacement mechanism
 + inline lookup_replace_object() calls
 + read_sha1_file(): get rid of read_sha1_file_repl() madness
 + t6050: make sure we test not just commit replacement
 + Declare lookup_replace_object() in cache.h, not in commit.h
 (this branch is used by jc/streaming.)

Code restructuring without much new feature.

* jk/blame-line-porcelain (2011-05-09) 3 commits
  (merged to 'next' on 2011-05-15 at 93232b3)
 + blame: add --line-porcelain output format
 + blame: refactor porcelain output
 + add tests for various blame formats

* jk/cherry-pick-root-with-resolve (2011-05-16) 3 commits
  (merged to 'next' on 2011-05-16 at 2a63845)
 + t3503: test cherry picking and reverting root commits
 + revert: allow reverting a root commit
 + cherry-pick: handle root commits with external strategies

* jk/git-connection-deadlock-fix (2011-05-18) 4 commits
  (merged to 'next' on 2011-05-18 at d4567da)
 + test core.gitproxy configuration
  (merged to 'next' on 2011-05-16 at 33e6c11)
 + send-pack: avoid deadlock on git:// push with failed pack-objects
 + connect: let callers know if connection is a socket
 + connect: treat generic proxy processes like ssh processes
 (this branch uses js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix; is tangled with js/maint-send-pack-stateless-rpc-deadlock-fix.)

* jl/submodule-conflicted-gitmodules (2011-05-14) 2 commits
  (merged to 'next' on 2011-05-16 at cc6c7e8)
 + Submodules: Don't parse .gitmodules when it contains, merge conflicts
 + test that git status works with merge conflict in, .gitmodules

* jm/maint-diff-words-with-sbe (2011-05-20) 1 commit
  (merged to 'next' on 2011-05-20 at c0db85c)
 + do not read beyond end of malloc'd buffer

* js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix (2011-05-16) 1 commit
 + sideband_demux(): fix decl-after-stmt
 (this branch is used by jk/git-connection-deadlock-fix and js/maint-send-pack-stateless-rpc-deadlock-fix.)

* js/maint-send-pack-stateless-rpc-deadlock-fix (2011-05-16) 1 commit
  (merged to 'next' on 2011-05-16 at ad83470)
 + Merge branch 'js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix' into js/maint-send-pack-stateless-rpc-deadlock-fix
 (this branch uses js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix; is tangled with jk/git-connection-deadlock-fix.)

* js/mingw-shutdown (2011-05-18) 1 commit
  (merged to 'next' on 2011-05-19 at c085b22)
 + Windows: add a wrapper for the shutdown() system call

* ld/p4-preserve-user-names (2011-05-13) 3 commits
  (merged to 'next' on 2011-05-15 at bdedb60)
 + git-p4: warn if git authorship won't be retained
  (merged to 'next' on 2011-05-11 at bc14314)
 + git-p4: small improvements to user-preservation
  (merged to 'next' on 2011-04-29 at 25116c8)
 + git-p4: add option to preserve user names

* mg/config-symbolic-constants (2011-05-17) 2 commits
  (merged to 'next' on 2011-05-19 at ac538c0)
 + config: Give error message when not changing a multivar
 + config: define and document exit codes

* ms/ls-remote-exit-with-status (2011-05-18) 1 commit
  (merged to 'next' on 2011-05-19 at c4238ce)
 + ls-remote: the --exit-code option reports "no matching refs"

* ms/tagname-does-not-begin-with-dash (2011-05-10) 1 commit
  (merged to 'next' on 2011-05-15 at 7df0461)
 + tag: disallow '-' as tag name

* nd/sparse-co-fix (2011-05-10) 2 commits
  (merged to 'next' on 2011-05-15 at 1a85791)
 + sparse checkout: do not eagerly decide the fate for whole directory
 + t1011: fix sparse-checkout initialization and add new file

* rg/copy-gecos-username (2011-05-17) 1 commit
  (merged to 'next' on 2011-05-17 at 6080944)
 + copy_gecos: fix not adding nlen to len when processing "&"

* tr/add-i-no-escape (2011-05-17) 1 commit
  (merged to 'next' on 2011-05-19 at d1c7a10)
 + add -i: ignore terminal escape sequences

--------------------------------------------------
[Stalled]

* hg/add-i-qq (2011-05-17) 1 commit
 - add-interactive: add 'Quit' shortcut to add hunk and quit

The question "why is y+q any more deserving for a short-cut than d+q" was
raised late in the discussion, and I think it a very valid concern.

May drop.

* jl/read-tree-m-dry-run (2011-05-11) 1 commit
 - Teach read-tree the -n|--dry-run option

Waiting for a reroll.

* mg/diff-stat-count (2011-05-03) 2 commits
 - diff-options.txt: describe --stat-{width,name-width,count}
 - diff: introduce --stat-count to limit the stat lines

There was a miscounting spotted.  Need another round.

* jn/gitweb-js (2011-04-28) 13 commits
 - gitweb: Make JavaScript ability to adjust timezones configurable
 - gitweb.js: Add UI for selecting common timezone to display dates
 - gitweb: JavaScript ability to adjust time based on timezone
 - gitweb: Unify the way long timestamp is displayed
 - gitweb: Refactor generating of long dates into format_timestamp_html
 - gitweb.js: Provide getElementsByClassName method (if it not exists)
 - gitweb.js: Introduce code to handle cookies from JavaScript
 - gitweb.js: Extract and improve datetime handling
 - gitweb.js: Provide default values for padding in padLeftStr and padLeft
 - gitweb.js: Update and improve comments in JavaScript files
 - gitweb: Split JavaScript for maintability, combining on build
 - Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
 - git-instaweb: Simplify build dependency on gitweb

Rerolled.  Waiting for comments.

* jn/ctags-more (2011-04-29) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Modularized git_get_project_description to be more generic
 - gitweb: Split git_project_list_body in two functions

Waiting for comments.

* jc/require-work-tree-exists (2011-05-08) 1 commit
 - require-work-tree wants more than what its name says

Make "git pull" run from a random place work as long as GIT_DIR and
GIT_WORK_TREE are set up correctly.  I am not absolutely sure if that
is a sane use case, though. May drop.

* jc/add-delete-default (2011-04-27) 1 commit
 - git add: notice removal of tracked paths by default

* jk/maint-merge-rename-create (2011-03-25) 3 commits
 - merge: turn on rewrite detection
 - merge: handle renames with replacement content
 - t3030: fix accidental success in symlink rename

Peff wanted to reroll this.

* jc/index-pack (2011-02-27) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP. Need to put histogram output into index-pack --verify to
really kill verify-pack.

* jc/dotdot-is-parent-directory (2011-05-04) 1 commit
 - specifying ranges: we did not mean to make ".." an empty set

Updated documentation, but I do not feel a strong enough annoyance to push
this forward. May drop.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* jc/advice-about-to-lose-commit (2011-05-06) 1 commit
 - checkout: honor advice.detachedHead when reattaching to a branch

Needs to tighten the advice to only govern the generic How-to part.

--------------------------------------------------
[Cooking]

* jh/receive-count-limit (2011-05-23) 10 commits
 - receive-pack: Allow server to refuse pushes with too many objects
 - pack-objects: Estimate pack size; abort early if pack size limit is exceeded
 - send-pack/receive-pack: Allow server to refuse pushing too large packs
 - pack-objects: Allow --max-pack-size to be used together with --stdout
 - send-pack/receive-pack: Allow server to refuse pushes with too many commits
 - pack-objects: Teach new option --max-commit-count, limiting #commits in pack
 - receive-pack: Prepare for addition of the new 'limit-*' family of capabilities
 - Tighten rules for matching server capabilities in server_supports()
 - send-pack: Attempt to retrieve remote status even if pack-objects fails
 - Update technical docs to reflect side-band-64k capability in receive-pack

* js/log-abbrev-commit-config (2011-05-18) 2 commits
  (merged to 'next' on 2011-05-23 at 4e7e932)
 + Add log.abbrevCommit config variable
 + "git log -h": typofix misspelled 'suppress'

Should be fine after several rounds of reviews.
Will merge to "master" by the middle of week #5.

* jc/streaming (2011-05-20) 13 commits
  (merged to 'next' on 2011-05-23 at 7fd0b52)
 + streaming: read loose objects incrementally
 + sha1_file.c: expose helpers to read loose objects
 + streaming: read non-delta incrementally from a pack
 + streaming_write_entry(): support files with holes
 + convert: CRLF_INPUT is a no-op in the output codepath
 + streaming_write_entry(): use streaming API in write_entry()
 + streaming: a new API to read from the object store
 + write_entry(): separate two helper functions out
 + unpack_object_header(): make it public
 + sha1_object_info_extended(): hint about objects in delta-base cache
 + sha1_object_info_extended(): expose a bit more info
 + packed_object_info_detail(): do not return a string
 + Merge branches 'jc/convert', 'jc/bigfile' and 'jc/replacing' into jc/streaming
 (this branch is used by jc/streaming-filter and jc/streaming-filter; uses jc/bigfile.)

* jc/bigfile (2011-05-13) 3 commits
  (merged to 'next' on 2011-05-15 at 0ee7144)
 + Bigfile: teach "git add" to send a large file straight to a pack
 + index_fd(): split into two helper functions
 + index_fd(): turn write_object and format_check arguments into one flag
 (this branch is used by jc/streaming and jc/streaming-filter.)

This covers the entry point for a big file to the system. Other parts that
need to know about them are the exit point (i.e. write_entry()), packing
and repacking (as long as bigfilethreshold is sane this should work),
diffs and status (avoid slurping large binary in core only to do nothing,
which we already should), and transport (receive-pack/fetch-pack call
either unpack-objects or index-pack, which still want to hold the full
object in-core and need to be fixed).

Will merge to "master" by the middle of week #5.

* ab/i18n-scripts (2011-05-21) 48 commits
  (merged to 'next' on 2011-05-23 at 69164a3)
 + i18n: git-bisect bisect_next_check "You need to" message
 + i18n: git-bisect [Y/n] messages
 + i18n: git-bisect bisect_replay + $1 messages
 + i18n: git-bisect bisect_reset + $1 messages
 + i18n: git-bisect bisect_run + $@ messages
 + i18n: git-bisect die + eval_gettext messages
 + i18n: git-bisect die + gettext messages
 + i18n: git-bisect echo + eval_gettext message
 + i18n: git-bisect echo + gettext messages
 + i18n: git-bisect gettext + echo message
 + i18n: git-bisect add git-sh-i18n
 + i18n: git-stash drop_stash say/die messages
 + i18n: git-stash "unknown option" message
 + i18n: git-stash die + eval_gettext $1 messages
 + i18n: git-stash die + eval_gettext $* messages
 + i18n: git-stash die + eval_gettext messages
 + i18n: git-stash die + gettext messages
 + i18n: git-stash say + gettext messages
 + i18n: git-stash echo + gettext message
 + i18n: git-stash add git-sh-i18n
 + i18n: git-submodule "blob" and "submodule" messages
 + i18n: git-submodule "path not initialized" message
 + i18n: git-submodule "[...] path is ignored" message
 + i18n: git-submodule "Entering [...]" message
 + i18n: git-submodule $errmsg messages
 + i18n: git-submodule "Submodule change[...]" messages
 + i18n: git-submodule "cached cannot be used" message
 + i18n: git-submodule $update_module say + die messages
 + i18n: git-submodule die + eval_gettext messages
 + i18n: git-submodule say + eval_gettext messages
 + i18n: git-submodule echo + eval_gettext messages
 + i18n: git-submodule add git-sh-i18n
 + i18n: git-pull eval_gettext + warning message
 + i18n: git-pull eval_gettext + die message
 + i18n: git-pull die messages
 + i18n: git-pull add git-sh-i18n
 + i18n: git-am printf(1) message to eval_gettext
 + i18n: git-am core say messages
 + i18n: git-am "Falling back" say message
 + i18n: git-am "Apply?" message
 + i18n: git-am clean_abort messages
 + i18n: git-am cannot_fallback messages
 + i18n: git-am die messages
 + i18n: git-am gettext + gettext to stderr message
 + i18n: git-am eval_gettext messages
 + i18n: git-am multi-line getttext $msg; echo
 + i18n: git-am one-line gettext $msg; echo
 + i18n: git-am add git-sh-i18n

Rerolled.

* mk/grep-pcre (2011-05-23) 13 commits
  (merged to 'next' on 2011-05-23 at fbd4877)
 + git-grep: Update tests (mainly for -P)
  (merged to 'next' on 2011-05-16 at 0c6c25e)
 + Makefile: Pass USE_LIBPCRE down in GIT-BUILD-OPTIONS
 + git-grep: update tests now regexp type is "last one wins"
  (merged to 'next' on 2011-05-15 at d110135)
 + git-grep: do not die upon -F/-P when grep.extendedRegexp is set.
 + git-grep: Bail out when -P is used with -F or -E
 + grep: Add basic tests
 + configure: Check for libpcre
 + git-grep: Learn PCRE
 + grep: Extract compile_regexp_failed() from compile_regexp()
 + grep: Fix a typo in a comment
  (merged to 'next' on 2011-05-08 at 5d3bede)
 + grep: Put calls to fixmatch() and regmatch() into patmatch()
 + contrib/completion: --line-number to git grep
 + Documentation: Add --line-number to git-grep synopsis

Will merge to "master" by the middle of week #5.
