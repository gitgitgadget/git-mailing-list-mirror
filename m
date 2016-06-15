From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2010, #02; Wed, 16)
Date: Wed, 16 Jun 2010 19:03:50 -0700
Message-ID: <7viq5ict4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 04:04:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP4Sf-0006N6-Hb
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 04:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820Ab0FQCEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 22:04:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756755Ab0FQCD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 22:03:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C623BCBBA;
	Wed, 16 Jun 2010 22:03:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=OfHX
	9/GLqzJLgm40qCPaI5s6jKM=; b=YftP9CHPs5Sl9Y4qVfb/3AWpFdSx72TiP30b
	N1xovYSpFftn5Rr7wfOEwtvFRhKMKie+6SBYN9JfkjrOcZzIK9kfZuE6CgIqwh6T
	krdas5z4KyXrdZ0K957VQyj6uCUsmcVcJXpX7eq/m2W1J0J2hNHkra1XFNMKs6T4
	9czlJbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=yAx
	RFcLgZtR/19WCScfqPZ6mQnx8gQo8p+03nIhFzs8iciPSu31+m9AI3+r7BUaCqxh
	xfg3WZ2RxqBRDo0E2HefbgsGYenGrPPVN3ojQY+tsa/CZT9AjHFXOhAhchdXBfC7
	g5DTEaoNznDrPvyNJs8yaDBXOOuoICC2t30xpLWY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A932BCBB8;
	Wed, 16 Jun 2010 22:03:54 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 530D1BCBB7; Wed, 16 Jun
 2010 22:03:52 -0400 (EDT)
X-master-at: d0b8d79510cd9c45a4c6bc08a37c6348f8293e8a
X-next-at: b2df7f8c29b2dd50cec1b3a7b83887ad946e4685
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9501AE6A-79B4-11DF-AE19-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149283>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* ab/cvsserver (2010-05-15) 6 commits
  (merged to 'next' on 2010-06-03 at 9f66c99)
 + git-cvsserver: test for pserver authentication support
 + git-cvsserver: document making a password without htpasswd
 + git-cvsserver: Improved error handling for pserver
 + git-cvsserver: indent & clean up authdb code
 + git-cvsserver: use a password file cvsserver pserver
 + git-cvsserver: authentication support for pserver

* ab/submodule-foreach-toplevel (2010-05-21) 1 commit
  (merged to 'next' on 2010-06-03 at fff7253)
 + git-submodule foreach: Add $toplevel variable

* ab/test-cleanup (2010-05-07) 2 commits
  (merged to 'next' on 2010-05-21 at a3cbd67)
 + Turn setup code in t2007-checkout-symlink.sh into a test
 + Move t6000lib.sh to lib-*

* bs/userdiff-php (2010-05-23) 1 commit
  (merged to 'next' on 2010-06-03 at f1bc101)
 + diff: Support visibility modifiers in the PHP hunk header regexp

* bw/diff-metainfo-color (2010-05-04) 1 commit
  (merged to 'next' on 2010-05-21 at 3aa552e)
 + diff: fix coloring of extended diff headers

* cb/assume-unchanged-fix (2010-05-01) 2 commits
  (merged to 'next' on 2010-05-21 at bab2342)
 + Documentation: git-add does not update files marked "assume unchanged"
 + do not overwrite files marked "assume unchanged"

* jk/diff-m-doc (2010-05-08) 1 commit
  (merged to 'next' on 2010-06-03 at 4a86bbd)
 + docs: clarify meaning of -M for git-log

* jk/maint-pull-dry-run-noop (2010-05-25) 1 commit
  (merged to 'next' on 2010-06-03 at 45236e3)
 + pull: do nothing on --dry-run

* jk/maint-sha1-file-name-fix (2010-05-22) 1 commit
  (merged to 'next' on 2010-06-03 at f7dd263)
 + remove over-eager caching in sha1_file_name

* jn/fsck-ident (2010-05-26) 1 commit
  (merged to 'next' on 2010-06-03 at 5fc3811)
 + fsck: fix bogus commit header check

* jn/gitweb-syntax-highlight (2010-04-27) 2 commits
  (merged to 'next' on 2010-06-03 at 1685303)
 + gitweb: Refactor syntax highlighting support
 + gitweb: Syntax highlighting support

* jn/maint-amend-missing-name (2010-05-02) 1 commit
  (merged to 'next' on 2010-05-09 at 9023332)
 + commit --amend: cope with missing display name

* jn/maint-doc-ignore (2010-03-05) 1 commit
  (merged to 'next' on 2010-06-03 at 01b4f6a)
 + gitignore.5: Clarify matching rules

* jn/make-header-dependency (2010-05-08) 2 commits
  (merged to 'next' on 2010-05-21 at d4ed230)
 + Makefile: let header dependency checker override COMPUTE_HEADER_DEPENDENCIES
 + Makefile: fix header dependency checker to allow NO_CURL builds

* jn/notes-doc (2010-05-08) 8 commits
  (merged to 'next' on 2010-05-21 at 1c28059)
 + Documentation/notes: nitpicks
 + Documentation/notes: clean up description of rewriting configuration
 + Documentation/notes: simplify treatment of default display refs
 + Documentation/log: add a CONFIGURATION section
 + Documentation/notes: simplify treatment of default notes ref
 + Documentation/notes: add configuration section
 + Documentation/notes: describe content of notes blobs
 + Documentation/notes: document format of notes trees

* js/maint-windows (2009-07-20) 2 commits
  (merged to 'next' on 2010-05-21 at 16abe03)
 + Recent MinGW has a C99 implementation of snprintf functions
 + mingw: use _commit to implement fsync

* js/try-to-free-stackable (2010-05-08) 2 commits
  (merged to 'next' on 2010-05-21 at 4c1afcb)
 + Do not call release_pack_memory in malloc wrappers when GIT_TRACE is used
 + Have set_try_to_free_routine return the previous routine

* mc/maint-zoneparse (2010-05-17) 1 commit
  (merged to 'next' on 2010-06-03 at 2b6cc2e)
 + Add "Z" as an alias for the timezone "UTC"

* mg/notes-dry-run (2010-05-14) 1 commit
  (merged to 'next' on 2010-06-03 at eddf5f6)
 + notes: dry-run and verbose options for prune

* rs/diff-no-minimal (2010-05-02) 1 commit
  (merged to 'next' on 2010-05-09 at 6c74aa0)
 + git diff too slow for a file

* rs/grep-binary (2010-05-22) 8 commits
  (merged to 'next' on 2010-06-03 at 6ec4dfc)
 + grep: support NUL chars in search strings for -F
 + grep: use REG_STARTEND for all matching if available
 + grep: continue case insensitive fixed string search after NUL chars
 + grep: use memmem() for fixed string search
 + grep: --name-only over binary
 + grep: --count over binary
 + grep: grep: refactor handling of binary mode options
 + grep: add test script for binary file handling

* wp/pretty-enhancement (2010-05-08) 4 commits
  (merged to 'next' on 2010-05-09 at eeaa4dc)
 + pretty: initialize new cmt_fmt_map to 0
 + pretty: add aliases for pretty formats
 + pretty: add infrastructure for commit format aliases
 + pretty: make it easier to add new formats

--------------------------------------------------
[New Topics]

* ab/blame-textconv (2010-06-07) 3 commits
 - t/t8006: test textconv support for blame
 - textconv: support for blame
 - textconv: make the API public
 (this branch is used by cp/textconv-cat-file.)

* ab/i18n (2010-06-15) 3 commits
 . Add initial C, Shell and Perl gettext translations
 . fixup! Add infrastructure
 . Add infrastructure for translating Git with gettext

* ab/tap (2010-06-09) 4 commits
 - We use TAP so the Perl test can run without scaffolding
 - Skip tests in a way that makes sense under TAP
 - Merge branch 'jc/t9129-any-utf8' into ab/tap
 - Make test-lib.sh emit valid TAP format
 (this branch uses jc/t9129-any-utf8.)

* bd/maint-unpack-trees-parawalk-fix (2010-06-10) 1 commit
 - unpack-trees: Make index lookahead less pessimal

* ic/maint-rebase-i-abort (2010-06-08) 1 commit
 - rebase -i: Abort cleanly if new base cannot be checked out

* jk/maint-advice-empty-amend (2010-06-06) 1 commit
 - commit: give advice on empty amend

* jl/maint-diff-ignore-submodules (2010-06-08) 2 commits
 - Add optional parameters to the diff option "--ignore-submodules"
 - git diff: rename test that had a conflicting name

* jn/document-rebase-i-p-limitation (2010-05-31) 1 commit
 - rebase -i -p: document shortcomings

* jn/grep-open (2010-06-12) 4 commits
 - grep -O: allow optional argument specifying the pager (or editor)
 - grep: Add the option '--open-files-in-pager'
 - Unify code paths of threaded greps
 - grep: refactor grep_objects loop into its own function

* rr/parse-date-refactor (2010-06-03) 1 commit
 - Refactor parse_date for approxidate functions

* rr/svn-export (2010-06-10) 7 commits
 - Add LICENSE
 - Add SVN dump parser
 - Add infrastructure to write revisions in fast-export format
 - Add stream helper library
 - Add library for string-specific memory pool
 - Add cpp macro implementation of treaps
 - Add memory pool library

* sm/branch-broken-ref (2010-06-04) 2 commits
 - branch: don't fail listing branches if one of the commits wasn't found
 - branch: exit status now reflects if branch listing finds an error

* tr/receive-pack-aliased-update-fix (2010-06-10) 1 commit
  (merged to 'next' on 2010-06-14 at d3a3097)
 + check_aliased_update: strcpy() instead of strcat() to copy
 (this branch is used by js/maint-receive-pack-symref-alias.)

* cc/maint-commit-reflog-msg (2010-06-12) 1 commit
 - commit: use value of GIT_REFLOG_ACTION env variable as reflog message

* tr/rev-list-count (2010-06-12) 2 commits
 - bash completion: Support "divergence from upstream" warnings in __git_ps1
 - rev-list: introduce --count option

* tr/send-email-8bit (2010-06-12) 1 commit
 - send-email: ask about and declare 8bit mails

* cp/textconv-cat-file (2010-06-09) 4 commits
 - [DONTMERGE] git gui: use textconv filter for diff and blame
 - t/t8007: test textconv support for cat-file
 - textconv: support for cat_file
 - sha1_name: add get_sha1_with_context()
 (this branch uses ab/blame-textconv.)

* jn/gitweb-return-or-exit-cleanup (2010-06-13) 1 commit
 - gitweb: Return or exit after done serving request

* pb/maint-perl-errmsg-no-dir (2010-06-14) 1 commit
 - Git.pm: better error message

* zl/mailinfo-recode-patch (2010-06-14) 2 commits
 - add --recode-patch option to git-am
 - add --recode-patch option to git-mailinfo

* cc/cherry-pick-stdin (2010-06-14) 3 commits
 - revert: do not rebuild argv on heap
 - revert: accept arbitrary rev-list options
 - t3508 (cherry-pick): futureproof against unmerged files
 (this branch uses cc/cherry-pick-series.)

* eb/double-convert-before-merge (2010-06-16) 1 commit
 - ll-merge: Normalize files before merging

* jc/maint-simpler-common-prefix (2010-06-16) 1 commit
 - common_prefix: simplify and fix scanning for prefixes

* js/maint-am-rebase-invalid-author (2010-06-16) 1 commit
 - am: use get_author_ident_from_commit instead of mailinfo when rebasing

* js/maint-receive-pack-symref-alias (2010-06-16) 1 commit
 . Merge branch 'tr/receive-pack-aliased-update-fix' into js/maint-receive-pack-symref-alias
 (this branch uses tr/receive-pack-aliased-update-fix.)

* lt/extended-sha1-match-commit-with-regexp (2010-04-23) 1 commit
 - Make :/ accept a regex rather than a fixed pattern

* mg/pretty-magic-space (2010-06-14) 1 commit
 - pretty: Introduce ' ' modifier to add space if non-empty

* sb/format-patch-signature (2010-06-15) 2 commits
 - completion: Add --signature and format.signature
 - format-patch: Add a signature option (--signature)

--------------------------------------------------
[Stalled -- would discard unless there are some movements soon]

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

--------------------------------------------------
[Cooking]

* jc/rev-list-ancestry-path (2010-06-04) 5 commits
 - revision: Turn off history simplification in --ancestry-path mode
 - revision: Fix typo in --ancestry-path error message
 - Documentation/rev-list-options.txt: Explain --ancestry-path
 - Documentation/rev-list-options.txt: Fix missing line in example history graph
 - revision: --ancestry-path

* cc/maint-diff-CC-binary (2010-05-26) 1 commit
  (merged to 'next' on 2010-06-07 at 1a8bbbb)
 + diff: fix "git show -C -C" output when renaming a binary file

* jn/gitweb-plackup (2010-05-28) 3 commits
  (merged to 'next' on 2010-06-03 at c54f1bf)
 + git-instaweb: Add support for running gitweb via 'plackup'
 + git-instaweb: Wait for server to start before running web browser
 + git-instaweb: Remove pidfile after stopping web server
 (this branch uses ps/gitweb-soc.)

* mg/status-b (2010-05-25) 2 commits
  (merged to 'next' on 2010-06-07 at d1e3f9e)
 + Documentation+t5708: document and test status -s -b
 + Show branch information in short output of git status

* ps/gitweb-soc (2010-06-02) 6 commits
  (merged to 'next' on 2010-06-13 at 92245ae)
 + git-instaweb: Add option to reuse previous config file
 + Makefile: Use $(sharedir)/gitweb for target 'install-gitweb'
  (merged to 'next' on 2010-06-03 at 5db4adf)
 + git-instaweb: Configure it to work with new gitweb structure
 + git-instaweb: Put httpd logs in a "$httpd_only" subdirectory
 + gitweb: Set default destination directory for installing gitweb in Makefile
 + gitweb: Move static files into seperate subdirectory
 (this branch is used by jn/gitweb-plackup.)

* tc/commit-abbrev-fix (2010-06-12) 3 commits
  (merged to 'next' on 2010-06-16 at b2df7f8)
 + commit::print_summary(): don't use format_commit_message()
 + t7502-commit: add summary output tests for empty and merge commits
 + t7502-commit: add tests for summary output

* ab/maint-perl-use-instlibdir (2010-05-30) 1 commit
  (merged to 'next' on 2010-06-07 at 83cf3b8)
 + Makefile: remove redundant munging of @@INSTLIBDIR@@

* by/diff-graph (2010-05-29) 6 commits
  (merged to 'next' on 2010-06-07 at 8771aae)
 + Make --color-words work well with --graph
 + graph.c: register a callback for graph output
 + Emit a whole line in one go
 + diff.c: Output the text graph padding before each diff line
 + Output the graph columns at the end of the commit message
 + Add a prefix output callback to diff output

* cc/cherry-pick-series (2010-06-02) 8 commits
 - Documentation/revert: describe passing more than one commit
 - Documentation/cherry-pick: describe passing more than one commit
 - revert: add tests to check cherry-picking many commits
 - revert: allow cherry-picking more than one commit
 - revert: change help_msg() to take no argument
 - revert: refactor code into a do_pick_commit() function
 - revert: use run_command_v_opt() instead of execv_git_cmd()
 - revert: cleanup code for -x option
 (this branch is used by cc/cherry-pick-stdin.)

* gs/usage-to-stdout (2010-06-12) 2 commits
  (merged to 'next' on 2010-06-13 at e83c00f)
 + parseopt: wrap rev-parse --parseopt usage for eval consumption
  (merged to 'next' on 2010-06-03 at c81c783)
 + print the usage string on stdout instead of stderr

* gv/portable (2010-06-11) 20 commits
  (merged to 'next' on 2010-06-13 at 1add99c)
 + test-lib: use DIFF definition from GIT-BUILD-OPTIONS
  (merged to 'next' on 2010-06-07 at 1796035)
 + build: propagate $DIFF to scripts
  (merged to 'next' on 2010-06-03 at 41ae9cb)
 + Makefile: Tru64 portability fix
 + Makefile: HP-UX 10.20 portability fixes
 + Makefile: HPUX11 portability fixes
 + Makefile: SunOS 5.6 portability fix
 + inline declaration does not work on AIX
 + Allow disabling "inline"
 + Some platforms lack socklen_t type
 + Make NO_{INET_NTOP,INET_PTON} configured independently
 + Makefile: some platforms do not have hstrerror anywhere
 + git-compat-util.h: some platforms with mmap() lack MAP_FAILED definition
 + test_cmp: do not use "diff -u" on platforms that lack one
 + fixup: do not unconditionally disable "diff -u"
 + tests: use "test_cmp", not "diff", when verifying the result
 + Do not use "diff" found on PATH while building and installing
 + enums: omit trailing comma for portability
 + Makefile: -lpthread may still be necessary when libc has only pthread stubs
 + Rewrite dynamic structure initializations to runtime assignment
 + Makefile: pass CPPFLAGS through to fllow customization

* jh/diff-index-line-abbrev (2010-05-30) 1 commit
  (merged to 'next' on 2010-06-07 at 194e9a9)
 + diff.c: Ensure "index $from..$to" line contains unambiguous SHA1s

* jk/am-skip-hint (2010-05-30) 1 commit
  (merged to 'next' on 2010-06-07 at f49577f)
 + git-am: suggest what to do with superfluous patches

* jn/checkout-doc (2010-06-01) 2 commits
  (merged to 'next' on 2010-06-13 at d01c620)
 + Documentation/checkout: clarify description
  (merged to 'next' on 2010-06-07 at 93cc6a9)
 + Documentation/checkout: clarify description

* jn/rebase-cmdline-fix (2010-05-31) 1 commit
  (merged to 'next' on 2010-06-07 at 5e6cffe)
 + rebase: improve error message when upstream argument is missing

* ps/gitweb--browse-chrome (2010-05-30) 1 commit
  (merged to 'next' on 2010-06-07 at a0fef35)
 + git-web--browse: Add support for google chrome and chromium

* bc/portable (2010-06-09) 7 commits
  (merged to 'next' on 2010-06-13 at a423055)
 + Remove python 2.5'isms
 + Makefile: add PYTHON_PATH to GIT-BUILD-OPTIONS
  (merged to 'next' on 2010-06-07 at 27a57c9)
 + t/aggregate-results: accomodate systems with small max argument list length
 + t/t7006: ignore return status of shell's unset builtin
 + t/t5150: remove space from sed script
 + git-request-pull.sh: remove -e switch to shell interpreter which breaks ksh
 + t/t5800: skip if python version is older than 2.5

* jn/show-num-walks (2010-06-01) 1 commit
 - DWIM 'git show -5' to 'git show --do-walk -5'

* rr/am-help (2010-06-02) 3 commits
  (merged to 'next' on 2010-06-07 at 12383bc)
 + git am: Remove stray error message from sed
 + git am: Display some help text when patch is empty
 + git am: Set cmdline globally

* jc/t9129-any-utf8 (2010-06-02) 1 commit
  (merged to 'next' on 2010-06-07 at 6f53da4)
 + t9129: fix UTF-8 locale detection
 (this branch is used by ab/tap.)

* em/checkout-orphan (2010-06-10) 6 commits
  (merged to 'next' on 2010-06-12 at 2f531d5)
 + log_ref_setup: don't return stack-allocated array
  (merged to 'next' on 2010-06-07 at 23b4607)
 + bash completion: add --orphan to 'git checkout'
 + t3200: test -l with core.logAllRefUpdates options
 + checkout --orphan: respect -l option always
 + refs: split log_ref_write logic into log_ref_setup
 + Documentation: alter checkout --orphan description

In <4BFE2461.5080501@drmicha.warpmail.net>, Michael J Gruber raised a
valid request for a better explanation of superfluous files left behind
and then are cleaned.  Other than that I think this is a sane thing to
do.

* ec/diff-noprefix-config (2010-05-02) 1 commit
  (merged to 'next' on 2010-06-03 at 75fefba)
 + diff: add configuration option for disabling diff prefixes.

* mg/rev-parse-lrbranches-locals (2010-05-14) 1 commit
 - revlist: Introduce --lrbranches and --locals revision specifiers
 (this branch uses mg/rev-parse-option-sifter-deprecation.)

* mg/rev-parse-option-sifter-deprecation (2010-05-14) 3 commits
 - t6018: make sure all tested symbolic names are different revs
 - t6018: add tests for rev-list's --branches and --tags
 - rev-parse: deprecate use as an option sifter
 (this branch is used by mg/rev-parse-lrbranches-locals.)

Some people might interpret "Deprecate" too strongly; the intent is that
we shouldn't keep piling parsing of new rev-list options to it and
discourage the use of "option sifter" in new programs.

* eb/core-eol (2010-06-04) 4 commits
 - Add "core.eol" config variable
 - Rename the "crlf" attribute "text"
 - Add per-repository eol normalization
 - Add tests for per-repository eol normalization
 (this branch uses fg/autocrlf.)

* jn/remote-set-branches (2010-05-19) 1 commit
  (merged to 'next' on 2010-06-03 at 54a1755)
 + Add git remote set-branches

* cb/ls-files-cdup (2010-06-03) 2 commits
  (merged to 'next' on 2010-06-07 at 89277b8)
 + ls-files: allow relative pathspec
 + quote.c: separate quoting and relative path generation

* jk/url-decode (2010-05-23) 2 commits
  (merged to 'next' on 2010-06-03 at 0d8a51e)
 + decode file:// and ssh:// URLs
 + make url-related functions reusable

* ph/clone-message-reword (2010-05-09) 1 commit
  (merged to 'next' on 2010-05-21 at 1785bd0)
 + clone: reword messages to match the end-user perception

* rc/ls-remote-default (2010-05-12) 1 commit
  (merged to 'next' on 2010-06-03 at 8d505fb)
 + ls-remote: print URL when no repo is specified

* fg/autocrlf (2010-05-12) 1 commit
  (merged to 'next' on 2010-05-21 at 5f43b66)
 + autocrlf: Make it work also for un-normalized repositories
 (this branch is used by eb/core-eol.)

* tc/merge-m-log (2010-05-11) 8 commits
  (merged to 'next' on 2010-05-21 at e889876)
 + merge: --log appends shortlog to message if specified
 + fmt-merge-msg: add function to append shortlog only
 + fmt-merge-msg: refactor merge title formatting
 + fmt-merge-msg: minor refactor of fmt_merge_msg()
 + merge: rename variable
 + merge: update comment
 + t7604-merge-custom-message: show that --log doesn't append to -m
 + t7604-merge-custom-message: shift expected output creation

* jn/gitweb-fastcgi (2010-06-05) 3 commits
  (merged to 'next' on 2010-06-13 at 6d1fdd6)
 + gitweb: Run in FastCGI mode if gitweb script has .fcgi extension
  (merged to 'next' on 2010-05-21 at cb1724f)
 + gitweb: Add support for FastCGI, using CGI::Fast
 + gitweb: Put all per-connection code in run() subroutine

* hg/id-munging (2010-04-06) 2 commits
  (merged to 'next' on 2010-06-03 at b045725)
 + convert: Keep foreign $Id$ on checkout.
 + convert: Safer handling of $Id$ contraction.

* js/async-thread (2010-06-11) 8 commits
  (merged to 'next' on 2010-06-13 at bf7457c)
 + fast-import: die_nicely() back to vsnprintf (reverts part of ebaa79f)
  (merged to 'next' on 2010-05-21 at 9d31940)
 + Enable threaded async procedures whenever pthreads is available
  (merged to 'next' on 2010-05-04 at 2644e74)
 + Dying in an async procedure should only exit the thread, not the process.
 + Reimplement async procedures using pthreads
 + Windows: more pthreads functions
 + Fix signature of fcntl() compatibility dummy
 + Make report() from usage.c public as vreportf() and use it.
 + Modernize t5530-upload-pack-error.

--------------------------------------------------
[Discarded]

* ld/discovery-limit-to-fs (2010-06-12) 2 commits
  (merged to 'next' on 2010-06-11 at 9c3410c)
 + Revert "write-index: check and warn when worktree crosses a filesystem
  boundary"
  (merged to 'next' on 2010-06-07 at 9780e62)
 + write-index: check and warn when worktree crosses a filesystem
  boundary

These are "let's try this" followed by "oops, let's not".
