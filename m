From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Apr 2009, #02; Wed, 29)
Date: Wed, 29 Apr 2009 22:33:25 -0700
Message-ID: <7v4ow6wvru.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 07:33:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzOu1-0005tK-Bu
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 07:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbZD3Fdb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 01:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbZD3Fdb
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 01:33:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbZD3Fda convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 01:33:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 44578AF686;
	Thu, 30 Apr 2009 01:33:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0F878AF684; Thu,
 30 Apr 2009 01:33:26 -0400 (EDT)
X-maint-at: a2dc04ba159def766ee17db00c60bdbda477955d
X-master-at: 6ffd567bec439e7809ee0966556bd5e72fb78de4
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6F847250-3548-11DE-A69D-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117989>

It's been a while since I sent the "What's in" report.  Hopefully we ca=
n
do an -rc4 this weekend and then 1.6.3 final next week.

* The 'maint' branch has these fixes since 1.6.2.3

Allan Caffee (2):
  builtin-merge: fix a typo in an error message
  Documentation: fix a grammatical error in api-builtin.txt

Bj=C3=B6rn Steinbrink (1):
  tree_entry_interesting: a pathspec only matches at directory boundary

Clemens Buchacher (3):
  add tests for merging with submodules
  update cache for conflicting submodule entries
  simplify output of conflicting merge

Erik Faye-Lund (4):
  test-suite: adding a test for fast-export with tag variants
  builtin-fast-export.c: turn error into warning
  builtin-fast-export.c: fix crash on tagged trees
  builtin-fast-export.c: handle nested tags

=46rank Lichtenheld (2):
  init: Do not segfault on big GIT_TEMPLATE_DIR environment variable
  gitcvs-migration: Link to git-cvsimport documentation

Jeff King (2):
  doc/gitattributes: clarify location of config text
  add-interactive: refactor mode hunk handling

Johan Herland (1):
  Update docs on behaviour of 'core.sharedRepository' and 'git init
    --shared'

Johannes Schindelin (2):
  Fix 'git checkout <submodule>' to update the index
  Fix off-by-one in read_tree_recursive

Johannes Sixt (1):
  t1301-shared-repo: fix forced modes test

Junio C Hamano (4):
  match_tree_entry(): a pathspec only matches at directory boundaries
  Describe fixes since 1.6.2.3
  GIT 1.6.2.4
  diff -c -p: do not die on submodules

Junio Hamano (1):
  Speed up reflog pruning of unreachable commits

Linus Torvalds (2):
  Clean up reflog unreachability pruning decision
  grep: fix segfault when "git grep '('" is given

Markus Heidelberg (2):
  doc/git-daemon: add missing arguments to options
  doc/git-daemon: add missing arguments to max-connections option

Matthieu Moy (2):
  git add -p: new "quit" command at the prompt.
  Update git-add.txt according to the new possibilities of 'git add -p'=
=2E

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  Makefile: remove {fetch,send}-pack from PROGRAMS as they are builtins

Paul Bolle (1):
  imap-send: use correct configuration variable in documentation

Stephen Boyd (1):
  test-genrandom: Add newline to usage string

Thomas Jarosch (1):
  Fix buffer overflow in config parser

Ulrich Windl (1):
  git-apply: fix option description


* The 'master' branch has these since 1.6.3-rc0
  in addition to the above.

Alex Riesen (3):
  Wait for git diff to finish in git difftool
  Explain seemingly pointless use of system in difftool
  improve error message in config.c

Allan Caffee (4):
  graph API: Added logic for colored edges
  t4202-log: extend test coverage of graphing
  graph API: fix extra space during pre_commit_line state
  graph API: fix a bug in the rendering of octopus merges

Ben Jackson (1):
  Work around ash "alternate value" expansion bug

Benjamin Kramer (2):
  connect: replace inet_ntop with getnameinfo
  daemon.c: fix segfault on OS X

Bert Wesarg (3):
  shorten_unambiguous_ref(): add strict mode
  for-each-ref: utilize core.warnAmbiguousRefs for :short-format
  rev-parse: --abbrev-ref option to shorten ref name

Bill Pemberton (1):
  Add parsing of elm aliases to git-send-email

Brandon Casey (2):
  t9001: use older Getopt::Long boolean prefix '--no' rather than '--no=
-'
  t7700-repack: repack -a now works properly, expect success from test

Dan Loewenherz (1):
  Convert to use quiet option when available

David Aguilar (11):
  difftool: remove merge options for opendiff, tkdiff, kdiff3 and xxdif=
f
  difftool: remove the backup file feature
  difftool: use perl built-ins when testing for msys
  difftool: add a -y shortcut for --no-prompt
  difftool: move 'git-difftool' out of contrib
  difftool: add various git-difftool tests
  difftool: add support for a difftool.prompt config variable
  bash completion: add git-difftool
  mergetool: use $( ... ) instead of `backticks`
  difftool/mergetool: refactor commands to use git-mergetool--lib
  mergetool--lib: simplify API usage by removing more global variables

Eric Blake (2):
  Makefile: installing git in cygwin 1.7.0
  doc: consistently use ASCIIDOC_EXTRA

Erik Broes (1):
  git-shell: Add 'git-upload-archive' to allowed commands.

=46elipe Contreras (1):
  git config: error when editing a repo config and not being in one

=46erry Huberts (1):
  Fix misspelled mergetool.keepBackup

Holger Wei=C3=9F (1):
  gitweb: Fix snapshots requested via PATH_INFO

Jeff King (8):
  doc: clarify --no-track option
  doc: refer to tracking configuration as "upstream"
  doc/checkout: refer to git-branch(1) as appropriate
  doc/checkout: split checkout and branch creation in synopsis
  docs/checkout: clarify what "non-branch" means
  add-interactive: refactor mode hunk handling
  t7800: respect NO_PERL
  Makefile: fix NO_PERL bug with gitweb

Johannes Schindelin (3):
  Add an option not to use link(src, dest) && unlink(src) when that is
    unreliable
  t5701: do not get stuck in empty-push/
  Rename core.unreliableHardlinks to core.createObject

Johannes Sixt (5):
  Windows: Work around intermittent failures in mingw_rename
  Windows: Skip fstat/lstat optimization in write_entry()
  builtin-help: silently tolerate unknown keys
  remote.c: do not trigger remote.<name>.<var> codepath for two-level n=
ames
  prune-packed: advanced progress even for non-existing fan-out directo=
ries

Junio C Hamano (11):
  gitignore git-bisect--helper
  unpack-trees: do not muck with attributes when we are not checking ou=
t
  Update draft release notes to 1.6.3
  read-tree A B: do not corrupt cache-tree
  Move prime_cache_tree() to cache-tree.c
  read-tree -m A B: prime cache-tree from the switched-to tree
  checkout branch: prime cache-tree fully
  Revert "stat_tracking_info(): only count real commits"
  Makefile: ignore perl/ subdirectory under NO_PERL
  GIT 1.6.3-rc2
  merge-recursive: do not die on a conflicting submodule

Linus Torvalds (4):
  Allow users to un-configure rename detection
  process_{tree,blob}: show objects without buffering
  show_object(): push path_name() call further down
  t4202: fix typo

Mark Drago (1):
  Add semicolon to curly brace group in main Makefile

Markus Heidelberg (4):
  doc/merge-config: list ecmerge as a built-in merge tool
  git-mergetool/difftool: make (g)vimdiff workable under Windows
  git-mergetool: add new merge tool TortoiseMerge
  grep: don't support "grep.color"-like config options

Matthieu Moy (3):
  git add -p: new "quit" command at the prompt.
  Update git-add.txt according to the new possibilities of 'git add -p'=
=2E
  clone: add test for push on an empty clone.

Michael J Gruber (3):
  remote.c: use shorten_unambiguous_ref
  test-lib.sh: Help test_create_repo() find the templates dir
  Fix more typos/spelling in comments

Micha=C5=82 Kiedrowicz (6):
  tests: test applying criss-cross rename patch
  builtin-apply: keep information about files to be deleted
  Documentation: boolean value may be given by on/off
  tests: test applying criss-cross rename patch
  builtin-apply: keep information about files to be deleted
  tests: make test-apply-criss-cross-rename more robust

Mike Ralphson (3):
  builtin-remote: fix typo in option description
  Documentation: fix typos / spelling mistakes
  Fix typos / spelling in comments

Nanako Shiraishi (1):
  git-am: teach git-am to apply a patch to an unborn branch

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  get_local_heads(): do not return random pointer if there is no head
  attr: add GIT_ATTR_INDEX "direction"
  archive: do not read .gitattributes in working directory

Nicolas Pitre (1):
  progress bar: round to the nearest instead of truncating down

Patrick Welche (1):
  NetBSD compilation fix

Pierre Habouzit (1):
  hook/update: example of how to prevent branch creation

Ren=C3=A9 Scharfe (2):
  archive tests: do not use .gitattributes in working directory
  archive test: attributes

Sam Vilain (1):
  SubmittingPatches: itemize and reflect upon well written changes

Sebastian Pipping (1):
  difftool/mergetool: add diffuse as merge and diff tool

Sitaram Chamarty (1):
  Remove obsolete bug warning in man git-update-server-info

Stephen Boyd (7):
  config.txt: add missing format.{subjectprefix,cc,attach} variables
  Documentation: use lowercase for shallow and deep threading
  git-show-branch.txt: cleanup example description
  git-format-patch.txt: general rewordings and cleanups
  config.txt: add missing 'the's and make words plural
  config.txt: clarify sentences in the configuration and syntax section=
s
  config.txt: Make configuration paragraph more consistent

Uwe Kleine-K=C3=B6nig (1):
  parseopt: fix documentation for --keep-dashdash

Wesley J. Landaker (4):
  Documentation: git-svn: fix spurious bolding that mangles the output
  Documentation: git-svn: fix a grammatical error without awkwardness
  Documentation: git-clean: fix minor grammatical errors
  Documentation: git-clean: make description more readable

Wincent Colaiuta (1):
  git add -p: add missing "q" to patch prompt
