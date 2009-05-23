From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (May 2009, #02; Sat, 23)
Date: Sat, 23 May 2009 03:02:41 -0700
Message-ID: <7vfxew2l32.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 12:05:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7o6c-0005wG-O1
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 12:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbZEWKCm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 May 2009 06:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbZEWKCm
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 06:02:42 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56484 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZEWKCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 06:02:41 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090523100243.QKWK20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Sat, 23 May 2009 06:02:43 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id uy2i1b0014aMwMQ04y2iFt; Sat, 23 May 2009 06:02:42 -0400
X-Authority-Analysis: v=1.0 c=1 a=orLKaKlIoGcA:10 a=VwDQwf0kWiEA:10
 a=VxeL-SudPsOz_yp-foUA:9 a=70s8c57AoK0kQDZ8AHkA:7
 a=P-2fcuZG8RuNhcXCp4ZKHh-n2cAA:4 a=6vqYnG2y7BJNHxUd:21 a=TRkT99JaTkeyZuRD:21
X-CM-Score: 0.00
X-maint-at: e701fadb9e0e51a6811690d95a53bd1f5b6fad86
X-master-at: b74d779bd90477f6514d0a9be4a75b4c40ed946c
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119773>

Many topics that have been cooking in 'next' are now in 'master'.
Numerous small-ish documentation and fixes have been queued in 'maint',
which may warrant 1.6.3.2.

* The 'maint' branch has these fixes since the last announcement.

Alex Riesen (2):
  ls-tree manpage: use "unless" instead of "when ... is not"
  ls-tree manpage: output of ls-tree is compatible with update-index

Dan McGee (1):
  Fix type-punning issues

Daniel Cordero (1):
  builtin-checkout: Don't tell user that HEAD has moved before it has

Giuseppe Bilotta (1):
  completion: use git rev-parse to detect bare repos

Jeff King (1):
  for-each-ref: fix segfault in copy_email

Jim Meyering (1):
  pre-commit.sample: don't print incidental SHA1

Johannes Schindelin (1):
  Cope better with a _lot_ of packs

Junio C Hamano (5):
  Revert "checkout branch: prime cache-tree fully"
  GIT 1.6.3.1
  completion: fix PS1 display during a merge on detached HEAD
  completion: simplify "current branch" in __git_ps1()
  completion: enhance "current branch" display

Linus Torvalds (1):
  dir.c: clean up handling of 'path' parameter in
    read_directory_recursive()

Nanako Shiraishi (1):
  test: checkout shouldn't say that HEAD has moved if it didn't

Ren=C3=A9 Scharfe (1):
  grep: fix word-regexp colouring

Stephen Boyd (4):
  api-parse-options.txt: use 'func' instead of 'funct'
  tests: Add tests for missing format-patch long options
  completion: add missing options to show-branch and show
  show-branch: Fix die message in parse_reflog_param()

Tony Kemp (1):
  Turn on USE_ST_TIMESPEC for OpenBSD


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (7):
  Introduce an unlink(2) wrapper which gives warning if unlink failed
  replace direct calls to unlink(2) with unlink_or_warn
  print unlink(2) errno in copy_or_link_directory
  Clarify kind of conflict in merge-one-file helper
  Quote LF in urls git fetch saves in FETCH_HEAD
  Use UTF-8 instead of utf8 for backward compatibility
  Improve the naming of guessed target repository for git clone

Alex Vandiver (3):
  git-svn: Fix for svn paths removed > log-window-size revisions ago
  git-svn: Correctly report max revision when following deleted paths
  git-svn: Set svn.authorsfile if it is passed to git svn clone

Allan Caffee (1):
  graph API: Use horizontal lines for more compact graphs

Andreas Ericsson (1):
  fetch: Strip usernames from url's before storing them

Christian Couder (20):
  rev-list: make "estimate_bisect_steps" non static
  rev-list: refactor printing bisect vars
  bisect: move common bisect functionality to "bisect_common"
  bisect--helper: add "--next-exit" to output bisect results
  bisect: use "git bisect--helper --next-exit" in "git-bisect.sh"
  bisect--helper: remove "--next-vars" option as it is now useless
  rev-list: remove stringed output flag from "show_bisect_vars"
  rev-parse: add --sq-quote to shell quote arguments
  bisect: use "git rev-parse --sq-quote" instead of a custom "sq" funct=
ion
  am: simplify "sq" function by using "git rev-parse --sq-quote"
  bisect: use "sha1_array" to store skipped revisions
  bisect: implement "rev_argv_push" to fill an argv with revs
  bisect: store good revisions in a "sha1_array"
  bisect: use new "struct argv_array" to prepare argv for "setup_revisi=
ons"
  bisect: remove too much function nesting
  bisect: make skipped array functions more generic
  bisect: automatically sort sha1_array if needed when looking it up
  bisect: implement the "check_merge_bases" function
  bisect: add "check_good_are_ancestors_of_bad" function
  bisect: make "git bisect" use new "--next-all" bisect-helper function

Dan McGee (1):
  Unify signedness in hashing calls

Dave Olszewski (1):
  merge-recursive: never leave index unmerged while recursing

David Aguilar (1):
  mergetool--lib: specialize diff options for emerge and ecmerge

Eric W. Biederman (1):
  git-send-email: Handle quotes when parsing .mailrc files

Eygene Ryabinkin (1):
  git-svn testsuite: use standard configuration for Subversion tools

=46elipe Contreras (2):
  Change prettify_ref to prettify_refname
  Prettify log decorations even more

=46rank Lichtenheld (2):
  Git.pm: Set GIT_WORK_TREE if we set GIT_DIR
  Git.pm: Always set Repository to absolute path if autodetecting

Heiko Voigt (2):
  Extend sample update hook, disable modifying of existing tags
  Extend sample pre-commit hook to check for non ascii filenames

Jakub Narebski (9):
  gitweb: Do not use bareword filehandles
  gitweb: Always use three argument form of open
  gitweb: Always use three argument form of open
  gitweb: Use block form of map/grep in a few cases more
  gitweb: Replace wrongly added tabs with spaces
  gitweb: Use capturing parentheses only when you intend to capture
  gitweb: Simplify snapshot format detection logic in evaluate_path_inf=
o
  gitweb: Remove unused $hash_base parameter from normalize_link_target
  gitweb: Sanitize title attribute in format_subject_html

Jeff King (3):
  parseopt: add OPT_NEGBIT
  fix GIT_TRACE segfault with shell-quoted aliases
  add: don't complain when adding empty project root

Jim Meyering (1):
  format-patch let -k override a config-specified format.numbered

Johannes Schindelin (7):
  git-add: introduce --edit (to edit the diff vs. the index)
  t3702: fix reliance on SHELL_PATH being '/bin/sh'
  Add NO_CROSS_DIRECTORY_HARDLINKS support to the Makefile
  MinGW: the path separator to split GITPERLLIB is ';' on Win32
  MinGW: use POSIX signature of waitpid()
  MinGW: Add a simple getpass()
  MinGW: Fix compiler warning in merge-recursive

Junio C Hamano (1):
  t3900: ISO-2022-JP has more than one popular variants

Linus Torvalds (2):
  Avoid unnecessary 'lstat()' calls in 'get_stat_data()'
  Teach 'git checkout' to preload the index contents

Mark Lodato (1):
  git-svn: add --authors-prog option

Markus Heidelberg (3):
  show-branch: color the commit status signs
  bash completion: show-branch color support
  diff: do not color --stat output like patch context

Michael J Gruber (3):
  Documentation: clarify / requirement in 'git check-ref-format'
  Test tracking of non-commit upstreams
  Fix behavior with non-commit upstream references

Michael S. Tsirkin (1):
  Add --reference option to git submodule.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  doc/git-rebase.txt: remove mention of multiple strategies
  Terminate argv with NULL before calling setup_revisions()

Nicolas Pitre (1):
  allow OFS_DELTA objects during a push

Peter Harris (1):
  MinGW: Scan for \r in addition to \n when reading shbang lines

Ren=C3=A9 Scharfe (6):
  parseopt: add OPT_NEGBIT
  parseopt: add OPT_NUMBER_CALLBACK
  parseopt: add PARSE_OPT_NODASH
  grep: remove global variable builtin_grep
  grep: use parseopt
  grep: make callback functions static

Robin Rosenberg (1):
  Disallow '\' in ref names

Stephen Boyd (1):
  bash completion: complete variable names for "git config" with option=
s

Trent Piepho (1):
  send-email: Add config option for sender address
