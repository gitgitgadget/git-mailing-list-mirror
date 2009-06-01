From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (May 2009, #03; Sun, 31)
Date: Sun, 31 May 2009 18:25:06 -0700
Message-ID: <7vy6scoidp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 03:50:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAwfD-0000ww-0l
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 03:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbZFABuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 May 2009 21:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbZFABt7
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 21:49:59 -0400
Received: from fed1rmpop109.cox.net ([68.230.241.13]:47797 "EHLO
	fed1rmpop109.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbZFABt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 21:49:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090601012508.NWAB2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 31 May 2009 21:25:08 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id yRR71b0024aMwMQ04RR7MU; Sun, 31 May 2009 21:25:07 -0400
X-Authority-Analysis: v=1.0 c=1 a=_A0hQgEeTukA:10 a=VpRIGokqTj8A:10
 a=joD3RMtZyvqe7IAqmCIA:9 a=_vuyuJ-2lL2bKpSFvqsA:7
 a=mdOR74YvdzlOfFehvJOv4vvSgLIA:4
X-CM-Score: 0.00
X-maint-at: 6a01554e6350123c78de805d820e90f1c56e5fdc
X-master-at: f9275c68af58e0f65e1557b5109ccbfdbbbc384a
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120439>

A rather large-ish updates on the 'master' front.  The 'maint' has some
fixes that should eventually produce 1.6.3.2.

* The 'maint' branch has these fixes since the last announcement.

Alex Riesen (5):
  Introduce an unlink(2) wrapper which gives warning if unlink failed
  replace direct calls to unlink(2) with unlink_or_warn
  print unlink(2) errno in copy_or_link_directory
  Clarify kind of conflict in merge-one-file helper
  http-push.c::remove_locks(): fix use after free

Clemens Buchacher (1):
  fix segfault showing an empty remote

Dave Olszewski (1):
  merge-recursive: never leave index unmerged while recursing

Jeff King (5):
  fix GIT_TRACE segfault with shell-quoted aliases
  add: don't complain when adding empty project root
  lock_ref: inform callers of unavailable ref
  fetch: report ref storage DF errors more accurately
  fix cat-file usage message and documentation

Jim Meyering (1):
  format-patch let -k override a config-specified format.numbered

Johannes Schindelin (1):
  Add NO_CROSS_DIRECTORY_HARDLINKS support to the Makefile

Junio C Hamano (1):
  Prepare for 1.6.3.2

Linus Torvalds (2):
  Avoid unnecessary 'lstat()' calls in 'get_stat_data()'
  Teach 'git checkout' to preload the index contents

Michael J Gruber (1):
  merge-options.txt: Clarify merge --squash

Nicolas Pitre (1):
  allow OFS_DELTA objects during a push


* The 'master' branch has these since the last announcement
  in addition to the above.

Benjamin Kramer (1):
  imap-send: add support for IPv6

Bj=C3=B6rn Steinbrink (1):
  git-apply(1): Clarify that one can select where to apply the patch

Brandon Casey (11):
  t3900: use ancient iconv names for backward compatibility
  Use 'UTF-8' rather than 'utf-8' everywhere for backward compatibility
  builtin-mailinfo.c: compare character encodings case insensitively
  builtin-mailinfo.c: use "ISO8859-1" instead of "latin1" as fallback
    encoding
  t3901: avoid negation on right hand side of '|'
  t3901: Use ISO8859-1 instead of ISO-8859-1 for backward compatibility
  t9301: use ISO8859-1 rather than ISO-8859-1
  t5100: use ancient encoding syntax for backwards compatibility
  t8005: use more portable character encoding names
  t8005: convert CP1251 character set to ISO8859-5
  t8005: fix typo, it's ISO-8859-5, not KOI8-R

Christian Couder (3):
  bisect: rework some rev related functions to make them more reusable
  commit: add function to unparse a commit and its parents
  bisect: check ancestors without forking a "git rev-list" process

Clemens Buchacher (1):
  http-push: reuse existing is_null_ref

Eric Wong (1):
  git-svn: refuse to dcommit non-UTF-8 messages

Jeff King (2):
  convert bare readlink to strbuf_readlink
  git-add: no need for -f when resolving a conflict in already tracked =
path

Jim Meyering (1):
  post-receive-email: hooks.showrev: show how to include both web link =
and
    patch

Johannes Sixt (1):
  t3701: ensure correctly set up repository after skipped tests

Josh Micich (3):
  mktree --missing: updated usage message and man page
  mktree --batch: build more than one tree object
  mktree: validate entry type in input

Junio C Hamano (11):
  build-in git-mktree
  mktree: use parse-options
  builtin-mktree.c: use a helper function to handle one line of input
  mktree: do not barf on a submodule commit
  t1010: add mktree test
  mktree --missing: allow missing objects
  Revert "git-add--interactive: remove hunk coalescing"
  Teach Solaris that _XOPEN_SOURCE=3D600 really menas XPG6
  OpenSolaris 200811 (SunOS 5.11) does not want OLD_ICONV
  Update draft release notes to 1.6.4
  completion: fix PS1 display during an AM on detached HEAD

Matt Graham (1):
  Splitting a hunk that adds a line at the top fails in "add -p"

Michael Witten (6):
  Docs: send-email: Put options back into alphabetical order
  Docs: send-email: Refer to CONFIGURATION section for sendemail.multie=
dit
  Docs: send-email: --smtp-server-port can take symbolic ports
  send-email: Handle "GIT:" rather than "GIT: " during --compose
  send-email: 'References:' should only reference what is sent
  send-email: Remove superfluous `my $editor =3D ...'

Michal Marek (1):
  apply: handle filenames with double slashes better

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  t/t3400-rebase.sh: add more tests to help migrating git-rebase.sh to =
C

Ren=C3=A9 Scharfe (1):
  grep: fix word-regexp at the beginning of lines

SZEDER G=C3=A1bor (1):
  bash: remove always true if statement from __git_ps1()

Stephen Boyd (10):
  format-patch: migrate to parse-options API
  parse-options: add PARSE_OPT_LITERAL_ARGHELP for complicated argh's
  show-branch: migrate to parse-options API
  commit: -F overrides -t
  apply, fmt-merge-msg: use relative filenames
  parse-opts: prepare for OPT_FILENAME
  parse-opts: add OPT_FILENAME and transition builtins
  t5500: Modernize test style
  t9120: don't expect failure with SVN_HTTPD_PORT unset
  config.txt: document add.ignore-errors

Thomas Rast (1):
  Documentation: teach stash/pop workflow instead of stash/apply
