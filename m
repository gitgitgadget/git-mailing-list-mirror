From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Mar 2009, #06; Mon, 30)
Date: Mon, 30 Mar 2009 15:47:31 -0700
Message-ID: <7vy6umaarg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 00:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoQIN-0007QR-H6
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 00:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760787AbZC3Wrs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 18:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZC3Wrr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 18:47:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760787AbZC3Wrn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 18:47:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B8E02A66D2;
	Mon, 30 Mar 2009 18:47:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9F646A66CE; Mon,
 30 Mar 2009 18:47:33 -0400 (EDT)
X-maint-at: 8c7f78823888306c1cceafcf5fd26739eef99ce3
X-master-at: 442dd42d6d4903640b0dc5561481a77c88dcea90
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C6462CA2-1D7C-11DE-B46E-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115197>

Many small updates on the 'master' front.  I think we can declare featu=
re
freeze for 1.6.3 in about a week, tag -rc0, and keep topics that are st=
ill
in 'pu' cooking for 1.6.4 (there are some good ones).

* The 'maint' branch has these fixes since the last announcement.

Allan Caffee (1):
  Documentation: update graph api example.

Carlo Marcelo Arenas Belon (1):
  documentation: update cvsimport description of "-r" for recent clone

Daniel Barkalow (1):
  Give error when no remote is configured

Daniel Cheng (aka SDiZ) (1):
  Fix bash completion in path with spaces

David Aguilar (1):
  everyday: use the dashless form of git-init

Emil Sit (1):
  test-lib: Clean up comments and Makefile.

Eric Wong (1):
  git-svn: fix ls-tree usage with dash-prefixed paths

Jeff King (2):
  doc: clarify how -S works
  ls-files: require worktree when --deleted is given

Johannes Schindelin (2):
  rsync transport: allow local paths, and fix tests
  import-zips: fix thinko

Johannes Sixt (1):
  diff --no-index: Do not generate patch output if other output is
    requested

Junio C Hamano (5):
  read-tree A B C: do not create a bogus index and do not segfault
  GIT 1.6.2.1
  Remove total confusion from git-fetch and git-push
  Update draft release notes to 1.6.2.2
  Update draft release notes to 1.6.2.2

Linus Torvalds (1):
  close_sha1_file(): make it easier to diagnose errors

Michael J Gruber (2):
  git submodule: Add test cases for git submodule add
  git submodule: Fix adding of submodules at paths with ./, .. and //

Nico -telmich- Schottelius (1):
  git-tag(1): add hint about commit messages

Nicolas Pitre (1):
  avoid possible overflow in delta size filtering computation

Ren=C3=A9 Scharfe (3):
  diffcore-pickaxe: use memmem()
  optimize compat/ memmem()
  pickaxe: count regex matches only once

Shawn O. Pearce (1):
  Increase the size of the die/warning buffer to avoid truncation

Stephen Boyd (1):
  format-patch: --numbered-files and --stdout aren't mutually exclusive

Thomas Rast (3):
  send-email: respect in-reply-to regardless of threading
  send-email: test --no-thread --in-reply-to combination
  bash completion: only show 'log --merge' if merging


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (4):
  disable post-checkout test on Cygwin
  Produce a nicer output in case of sha1_object_info failures in ls-tre=
e -l
  Microoptimize strbuf_cmp
  Improve error message about fetch into current branch

Amos King (2):
  Do not name "repo" struct "remote" in push_http.c
  http-push.c: use a faux remote to pass to http_init

Arto Jonsson (1):
  bash completion: add options for 'git fsck'

Ben Walton (7):
  configure: ensure settings from user are also usable in the script
  configure: reorganize flow of argument checks
  configure: add macros to stash FLAG variables
  configure: wrap some library tests with GIT_STASH_FLAGS
  configure: asciidoc version test cleanup
  configure: make iconv tests aware of user arguments
  configure: rework pthread handling to allow for user defined flags

Benjamin Kramer (1):
  Fix various dead stores found by the clang static analyzer

Brandon Casey (2):
  git-branch: display "was sha1" on branch deletion rather than just "s=
ha1"
  builtin-send-pack.c: avoid empty structure initialization

Brian Gernhardt (2):
  Create USE_ST_TIMESPEC and turn it on for Darwin
  Makefile: Set compiler switch for USE_NSEC

Carlos Rica (1):
  config: test for --replace-all with one argument and fix documentatio=
n.

Chris Johnsen (2):
  git-push.txt: describe how to default to pushing only current branch
  Documentation: remove extra quoting/emphasis around literal texts

Daniel Barkalow (7):
  Make clone parse the default refspec with the normal code
  Use a single function to match names against patterns
  Use the matching function to generate the match results
  Keep '*' in pattern refspecs
  Support '*' in the middle of a refspec
  Use a common function to get the pretty name of refs
  Move push matching and reporting logic into transport.c

David J. Mellor (12):
  Documentation: minor grammatical fixes in git-archive.txt.
  Documentation: reword the "Description" section of git-bisect.txt.
  Documentation: minor grammatical fixes in git-blame.txt.
  Documentation: minor grammatical fixes in git-branch.txt.
  Documentation: reworded the "Description" section of git-bisect.txt.
  Documentation: reword example text in git-bisect.txt.
  Documentation: remove some uses of the passive voice in git-bisect.tx=
t
  Documentation: minor grammatical fixes and rewording in git-bundle.tx=
t
  Documentation: minor grammatical fixes in git-cat-file.txt
  Documentation: minor grammatical fixes in git-check-attr.txt
  Documentation: minor grammatical fix in git-check-ref-format.txt
  Documentation: Remove spurious uses of "you" in git-bisect.txt.

Elijah Newren (3):
  git-filter-branch: avoid collisions with variables in eval'ed command=
s
  Correct missing SP characters in grammar comment at top of fast-impor=
t.c
  fast-export: Avoid dropping files from commits

Emil Sit (1):
  config.txt: Describe special 'none' handling in core.gitProxy.

Eric Wong (1):
  git-svn: fix ls-tree usage with dash-prefixed paths

=46elipe Contreras (8):
  git_config(): not having a per-repo config file is not an error
  git config: trivial rename in preparation for parseopt
  git config: reorganize get_color*
  git config: reorganize to use parseopt
  git config: don't allow multiple config file locations
  git config: don't allow multiple variable types
  git config: don't allow extra arguments for -e or -l.
  git config: don't allow --get-color* and variable type

=46inn Arne Gangstad (2):
  New config push.default to decide default behavior for push
  Display warning for default git push with no push.default config

Giuseppe Bilotta (1):
  import-tars: separate author from committer

Heiko Voigt (1):
  Add warning about known issues to documentation of cvsimport

Janos Laube (1):
  MinGW: implement mmap

Jay Soffian (20):
  move duplicated get_local_heads() to remote.c
  move duplicated ref_newer() to remote.c
  move locate_head() to remote.c
  remote: simplify guess_remote_head()
  remote: make copy_ref() perform a deep copy
  remote: let guess_remote_head() optionally return all matches
  remote: make match_refs() copy src ref before assigning to peer_ref
  remote: make match_refs() not short-circuit
  string-list: new for_each_string_list() function
  builtin-remote: refactor duplicated cleanup code
  builtin-remote: remove unused code in get_ref_states
  builtin-remote: rename variables and eliminate redundant function cal=
l
  builtin-remote: make get_remote_ref_states() always populate
    states.tracked
  builtin-remote: fix two inconsistencies in the output of "show <remot=
e>"
  builtin-remote: teach show to display remote HEAD
  builtin-remote: add set-head subcommand
  builtin-remote: new show output style
  builtin-remote: new show output style for push refspecs
  send-email: refactor and ensure prompting doesn't loop forever
  send-email: add tests for refactored prompting

Jeff King (12):
  test scripts: refactor start_httpd helper
  add basic http clone/fetch tests
  refactor find_ref_by_name() to accept const list
  remote: make guess_remote_head() use exact HEAD lookup if it is avail=
able
  config: set help text for --bool-or-int
  t3000: use test_cmp instead of diff
  ls-files: fix broken --no-empty-directory
  ls-files: require worktree when --deleted is given
  make oneline reflog dates more consistent with multiline format
  remote: improve sorting of "configure for git push" list
  Makefile: turn on USE_ST_TIMESPEC for FreeBSD
  t0060: fix whitespace in "wc -c" invocation

Jens Lehmann (1):
  githooks documentation: post-checkout hook is also called after clone

Johannes Schindelin (7):
  Turn the flags in struct dir_struct into a single variable
  rebase -i: avoid 'git reset' when possible
  winansi: support ESC [ K (erase in line)
  gc --aggressive: make it really aggressive
  t7300: fix clean up on Windows
  Smudge the files fed to external diff and textconv
  Guard a few Makefile variables against user environments

Johannes Sixt (30):
  recv_sideband: Bands #2 and #3 always go to stderr
  t9400, t9401: Do not force hard-linked clone
  test suite: Use 'say' to say something instead of 'test_expect_succes=
s'
  Call 'say' outside test_expect_success
  test-lib: Replace uses of $(expr ...) by POSIX shell features.
  test-lib: Simplify test counting.
  test-lib: Introduce test_chmod and use it instead of update-index --c=
hmod
  t2200, t7004: Avoid glob pattern that also matches files
  t5300, t5302, t5303: Do not use /dev/zero
  t5602: Work around path mangling on MSYS
  test-lib: Work around incompatible sort and find on Windows
  test-lib: Work around missing sum on Windows
  Tests on Windows: $(pwd) must return Windows-style paths
  t0050: Check whether git init detected symbolic link support correctl=
y
  test-lib: Infrastructure to test and check for prerequisites
  Propagate --exec-path setting to external commands via GIT_EXEC_PATH
  t3600: Use test prerequisite tags
  Skip tests that fail if the executable bit is not handled by the
    filesystem
  t5302: Use prerequisite tags to skip 64-bit offset tests
  t9100, t9129: Use prerequisite tags for UTF-8 tests
  Use prerequisite tags to skip tests that depend on symbolic links
  t0060: Fix tests on Windows
  Skip tests that require a filesystem that obeys POSIX permissions
  t3700: Skip a test with backslashes in pathspec
  Use prerequisites to skip tests that need unzip
  t7004: Use prerequisite tags to skip tests that need gpg
  t5503: GIT_DEBUG_SEND_PACK is not supported on MinGW
  MinGW: Quote arguments for subprocesses that contain a single-quote
  t7005-editor: Use $SHELL_PATH in the editor scripts
  t7502-commit: Skip SIGTERM test on Windows

Junio C Hamano (15):
  Make git-clone respect branch.autosetuprebase
  builtin-remote.c: no "commented out" code, please
  Not all systems use st_[cm]tim field for ns resolution file timestamp
  grep: cast printf %.*s "precision" argument explicitly to int
  http.c: style cleanups
  Improve "git branch --tracking" output
  http_init(): Fix config file parsing
  http authentication via prompts
  http.c: CURLOPT_NETRC_OPTIONAL is not available in ancient versions o=
f
    cURL
  Read attributes from the index that is being checked out
  Update draft release notes to 1.6.3
  blame: read custom grafts given by -S before calling setup_revisions(=
)
  http tests: Darwin is not that special
  diff --cached: do not borrow from a work tree when a path is marked a=
s
    assume-unchanged
  Update draft release notes to 1.6.3

Kevin Ballard (1):
  builtin-push.c: Fix typo: "anythig" -> "anything"

Kevin McConnell (1):
  Add --staged to bash completion for git diff

Kjetil Barvik (17):
  lstat_cache(): small cleanup and optimisation
  lstat_cache(): generalise longest_match_lstat_cache()
  lstat_cache(): swap func(length, string) into func(string, length)
  unlink_entry(): introduce schedule_dir_for_removal()
  create_directories(): remove some memcpy() and strchr() calls
  write_entry(): cleanup of some duplicated code
  write_entry(): use fstat() instead of lstat() when file is open
  show_patch_diff(): remove a call to fstat()
  lstat_cache(): print a warning if doing ping-pong between cache types
  check_updates(): effective removal of cache entries marked CE_REMOVE
  fix compile error when USE_NSEC is defined
  make USE_NSEC work as expected
  verify_uptodate(): add ce_uptodate(ce) test
  write_index(): update index_state->timestamp after flushing to disk
  Record ns-timestamps if possible, but do not use it without USE_NSEC
  checkout bugfix: use stat.mtime instead of stat.ctime in two places
  Revert "lstat_cache(): print a warning if doing ping-pong between cac=
he
    types"

Kristian Amlie (1):
  Add a test for checking whether gitattributes is honored by checkout.

Michael J Gruber (3):
  test-lib.sh: Test for presence of git-init in the right path.
  test-lib.sh: Allow running the test suite against installed git
  git-branch.txt: document -f correctly

Michele Ballabio (6):
  apply: consistent spelling of "don't"
  apply: hide unused options from short help
  git log: avoid segfault with --all-match
  document --force-rebase
  rebase: add options passed to git-am
  rebase: fix typo (force_rebas -> force-rebas)

Miklos Vajna (11):
  parse-opt: migrate builtin-ls-files.
  Tests: use test_cmp instead of diff where possible
  http-push: using error() and warning() as appropriate
  builtin-apply: use warning() instead of fprintf(stderr, "warning: ")
  builtin-checkout: use warning() instead of fprintf(stderr, "warning: =
")
  builtin-fetch-pack: use warning() instead of fprintf(stderr, "warning=
: ")
  builtin-init-db: use warning() instead of fprintf(stderr, "warning: "=
)
  builtin-rm: use warning() instead of fprintf(stderr, "warning: ")
  builtin-show-branch: use warning() instead of fprintf(stderr, "warnin=
g:
    ")
  builtin-show-ref: use warning() instead of fprintf(stderr, "warning: =
")
  refs: use warning() instead of fprintf(stderr, "warning: ")

Nate Case (1):
  format-patch: Respect --quiet option

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  grep: prefer builtin over external one when coloring results

Petr Kodl (2):
  MinGW: a helper function that translates Win32 API error codes
  MinGW: a hardlink implementation

Ren=C3=A9 Scharfe (6):
  grep: micro-optimize hit collection for AND nodes
  grep: remove grep_opt argument from match_expr_eval()
  grep: add pmatch and eflags arguments to match_one_pattern()
  grep: color patterns in output
  grep: add support for coloring with external greps
  pickaxe: count regex matches only once

Santi B=C3=A9jar (2):
  Documentation: enhance branch.<name>.{remote,merge}
  Documentation: push.default applies to all remotes

Simon Arlott (1):
  git-svn: don't output git commits in quiet mode

Stephen Boyd (4):
  git-send-email.txt: describe --compose better
  completion: add --annotate option to send-email
  completion: add --cc and --no-attachment option to format-patch
  completion: add --thread=3Ddeep/shallow to format-patch

Wincent Colaiuta (2):
  Grammar fixes to "merge" and "patch-id" docs
  Grammar fix for "git merge" man page
