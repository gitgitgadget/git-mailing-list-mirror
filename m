From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Jul 2009, #01; Sun, 26)
Date: Sun, 26 Jul 2009 01:17:40 -0700
Message-ID: <7vr5w3rh7f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 26 10:18:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUyvy-0002Tu-Gp
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 10:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbZGZIRv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Jul 2009 04:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbZGZIRu
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 04:17:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZGZIRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 04:17:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C532014F95;
	Sun, 26 Jul 2009 04:17:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EA26214F94; Sun,
 26 Jul 2009 04:17:41 -0400 (EDT)
X-maint-at: 54bc13ce5300bf7c2237aba3fd123dd587e56d31
X-master-at: d8f7be2ebcb7e3ec40269080a9ab9a28bc06ba17
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB384320-79BC-11DE-917E-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124109>

The tip of 'master' is 1.6.4-rc3 and it should be the last -rc before t=
he
1.6.4 final.

* The 'maint' branch has these fixes since the last announcement.

Brandon Casey (2):
  refs.c: release file descriptor on error return
  sha1_name.c: avoid unnecessary strbuf_release

Chris Frey (1):
  git-remote: fix missing .uploadpack usage for show command

Clemens Buchacher (1):
  fetch: do not create ref from empty name

Giuseppe Bilotta (1):
  gitweb/README: fix AliasMatch in example

Johannes Sixt (1):
  Makefile: git.o depends on library headers

Junio C Hamano (8):
  request-pull: really disable pager
  checkout -f: deal with a D/F conflict entry correctly
  combine-diff.c: fix performance problem when folding common deleted l=
ines
  diff --cc: a lost line at the beginning of the file is shown incorrec=
tly
  do_one_ref(): null_sha1 check is not about broken ref
  SunOS grep does not understand -C<n> nor -e
  Fix severe breakage in "git-apply --whitespace=3Dfix"
  t8005: Nobody writes Russian in shift_jis

Linus Torvalds (3):
  git branch: fix performance problem
  git branch: avoid unnecessary object lookups
  git branch: clean up detached branch handling

Matthias Andree (1):
  Fix export_marks() error handling.

Michal Marek (1):
  request-pull: really really disable pager

Miklos Vajna (1):
  git-submodule documentation: fix foreach example

Ren=C3=A9 Scharfe (1):
  attr: plug minor memory leak

Roel Kluin (1):
  fread does not return negative on error

SZEDER G=C3=A1bor (1):
  Trailing whitespace and no newline fix

Sitaram Chamarty (1):
  Documentation: update description of shell aliases

Thadeu Lima de Souza Cascardo (1):
  Makes some cleanup/review in gittutorial

Thomas Rast (2):
  Test git archive --remote
  Test grep --and/--or/--not


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Vandiver (2):
  Make section_name_match start on '[', and return the length on succes=
s
  After renaming a section, print any trailing variable definitions

Andreas Ericsson (1):
  mailinfo: Remove only one set of square brackets

Ben Jackson (3):
  Add 'git svn help [cmd]' which works outside a repo.
  git-svn: speed up find_rev_before
  Add 'git svn reset' to unwind 'git svn fetch'

Bert Wesarg (1):
  builtin-remote: (get_one_entry): use strbuf

Bj=C3=B6rn Steinbrink (1):
  Add a test showing that 'git repack' throws away grafted-away parents

Brandon Casey (10):
  Makefile: Solaris needs HAVE_ALLOCA_H for alloca()
  t/t9001-send-email.sh: ensure generated script is executed with
    $SHELL_PATH
  git.c: avoid allocating one-too-many elements for new argv array
  unpack-trees.c: work around run-time array initialization flaw on IRI=
X
    6.5
  git-compat-util.h: adjust for SGI IRIX 6.5
  Makefile: add NEEDS_LIBGEN to optionally add -lgen to compile argumen=
ts
  Makefile: add section for SGI IRIX 6.5
  Makefile: update IRIX64 section
  configure.ac: rework/fix the NEEDS_RESOLV and NEEDS_LIBGEN tests
  configure.ac: properly unset NEEDS_SSL_WITH_CRYPTO when sha1 func is
    missing

Christian Couder (2):
  bisect: use a PRNG with a bias when skipping away from untestable com=
mits
  Documentation: remove warning saying that "git bisect skip" may slow
    bisection

Daniel Trstenjak (1):
  Show the presence of untracked files in the bash prompt.

Eric Wong (12):
  git-svn: convert globs to regexps for branch destinations
  t9138: remove stray dot in test which broke bash
  Allow the Unix epoch to be a valid commit date
  git svn: allow uppercase UUIDs from SVN
  git svn: rename tests that had conflicting numbers
  git svn: fix reparenting when ugly http(s) URLs are used
  git svn: fix shallow clone when upstream revision is too new
  git svn: revert default behavior for --minimize-url
  git svn: the branch command no longer needs the full path
  t9142: stop httpd after the test
  git svn: avoid escaping '/' when renaming/copying files
  git svn: make minimize URL more reliable over http(s)

Giuseppe Bilotta (11):
  git-am foreign patch support: introduce patch_format
  git-am foreign patch support: autodetect some patch formats
  git-am foreign patch support: StGIT support
  git-am: refactor 'cleaning up and aborting'
  gitweb: refactor author name insertion
  gitweb: uniform author info for commit and commitdiff
  gitweb: use git_print_authorship_rows in 'tag' view too
  gitweb: (gr)avatar support
  gitweb: gravatar url cache
  gitweb: picon avatar provider
  gitweb: add empty alt text to avatar img

Hunter, D. Seth (1):
  http-push: fix xml_entities() string parsing overrun

Jeff King (5):
  Makefile: refactor regex compat support
  Makefile: use compat regex on Solaris
  log-tree: fix confusing comment
  Makefile: install 'git' in execdir
  send-email: detect cycles in alias expansion

Johan Herland (1):
  quickfetch(): Prevent overflow of the rev-list command line

Johannes Schindelin (1):
  git repack: keep commits hidden by a graft

Johannes Sixt (5):
  daemon: send stderr of service programs to the syslog
  upload-pack: squelch progress indicator if client cannot see it
  receive-pack: do not send error details to the client
  git-mv: fix directory separator treatment on Windows
  MinGW: truncate exit()'s argument to lowest 8 bits

Junio C Hamano (7):
  die_errno(): double % in strerror() output just in case
  Makefile: keep "git" when bindir is execdir
  Revert "mailinfo: Remove only one set of square brackets"
  push: do not give big warning when no preference is configured
  Updates to draft release notes to 1.6.4
  Update release notes for 1.6.4
  GIT 1.6.4-rc3

Larry D'Anna (1):
  add --porcelain option to git-push

Linus Torvalds (11):
  git log: add '--merges' flag to match '--no-merges'
  Add 'fill_directory()' helper function for directory traversal
  Simplify read_directory[_recursive]() arguments
  Avoid doing extra 'lstat()'s for d_type if we have an up-to-date cach=
e
    entry
  Avoid using 'lstat()' to figure out directories
  Prepare symlink caching for thread-safety
  Export thread-safe version of 'has_symlink_leading_path()'
  Make index preloading check the whole path to the file
  Make 'git show' more useful
  Improve on the 'invalid object' error message at commit time
  Fix extraneous lstat's in 'git checkout -f'

Marc Branchaud (3):
  git svn: Support multiple branch and tag paths in the svn repository.
  git svn: cleanup t9138-multiple-branches
  git svn: Doc update for multiple branch and tag paths

Mark Lodato (2):
  http.c: prompt for SSL client certificate password
  http.c: add http.sslCertPasswordProtected option

Martin Koegler (1):
  git stash: modernize use of "dashed" git-XXX calls

Martin Renold (1):
  Remove filename from conflict markers

Mattias Nissler (2):
  git-svn: Always duplicate paths returned from get_log
  git-svn: Fix branch detection when repository root is inaccessible

Michael J Gruber (1):
  t4202-log.sh: Test git log --no-walk sort order

Mike Ralphson (1):
  cvsexportcommit: reorder tests to quiet intermittent failure

Nanako Shiraishi (1):
  Documentation/config.txt: a variable can be defined on the section he=
ader
    line

Nick Edelen (1):
  diff-tree -r -t: include added/removed directories in the output

Nick Woolley (2):
  Remove archaic use of regex capture \1 in favour of $1
  Avoid generating a warning if $fullname{$file} is undefined

Pierre Habouzit (4):
  janitor: use NULL and not 0 for pointers.
  refactor: use bitsizeof() instead of 8 * sizeof()
  janitor: add DIV_ROUND_UP and use it.
  janitor: useless checks before free

Ren=C3=A9 Scharfe (7):
  userdiff: add xdiff_clear_find_func()
  grep: move context hunk mark handling into show_line()
  grep: print context hunk marks between files
  grep: handle pre context lines on demand
  grep: add option -p/--show-function
  grep -p: support user defined regular expressions
  grep: simplify -p output

Robert Allan Zeh (1):
  git svn: add gc command

SZEDER G=C3=A1bor (2):
  Document 'git (rev-list|log) --merges'
  bash: add '--merges' to common 'git log' options

Stephen Boyd (9):
  t4150: test applying with a newline in subject
  am: suppress apply errors when using 3-way
  git-sh-setup: introduce say() for quiet options
  submodule, repack: migrate to git-sh-setup's say()
  am, rebase: teach quiet option
  stash: teach quiet option
  show-ref: migrate to parse-options
  completion: add missing config variables
  completion: __git_config_get_set_variables() handle values with space=
s

Thomas Rast (5):
  git-svn: let 'dcommit $rev' work on $rev instead of HEAD
  Introduce die_errno() that appends strerror(errno) to die()
  Convert existing die(..., strerror(errno)) to die_errno()
  Use die_errno() instead of die() when checking syscalls
  Disable asciidoc 8.4.1+ semantics for `{plus}` and friends

Todd Zullinger (1):
  completion: Add --full-diff to log options

Ulrich Dangel (1):
  git-svn: Canonicalize svn urls to prevent libsvn assertion

Uwe Kleine-K=C3=B6nig (2):
  more tests for git rev-parse --parse-opt
  parse-opt: make PARSE_OPT_STOP_AT_NON_OPTION available to git rev-par=
se

Wincent Colaiuta (1):
  gitweb: update Git homepage URL

Yann Dirson (6):
  git-svn.txt: stop using dash-form of commands.
  git-svn.txt: make formatting more consistent.
  git-svn.txt: fix fetch flags incorrectly documented as init flags.
  git-svn.txt: fix description of fetch flags accepted by clone.
  List send-email config options in config.txt.
  Improve doc for format-patch threading options.
