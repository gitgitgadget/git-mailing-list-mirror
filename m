From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Sep 2008, #03; Mon, 22)
Date: Mon, 22 Sep 2008 12:40:31 -0700
Message-ID: <7vy71kvuj4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 22 21:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhrIA-0008A2-Is
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 21:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbYIVTkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Sep 2008 15:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbYIVTkp
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 15:40:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbYIVTkp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2008 15:40:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FDC76302A;
	Mon, 22 Sep 2008 15:40:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A99E363021; Mon, 22 Sep 2008 15:40:40 -0400 (EDT)
X-maint-at: 8b4eb6b6cd65042c6ecb4f06f19c1f2441899ed6
X-master-at: c76dc9592d1c770212d50ee7a7028a74f472f23b
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58373AFE-88DE-11DD-B83B-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96507>

I think 'maint' has all the known fixes and is ready to become 1.6.0.3
(but I may not have enough time or energy to do the release engineering
before I leave for two weeks).

* The 'maint' branch has these fixes since the last announcement.

Alec Berryman (2):
  git-svn: factor out svnserve test code for later use
  git-svn: Always create a new RA when calling do_switch for svn://

Brandon Casey (2):
  t9700/test.pl: avoid bareword 'STDERR' in 3-argument open()
  t9700/test.pl: remove File::Temp requirement

Charles Bailey (2):
  Add new test to demonstrate git archive core.autocrlf inconsistency
  Make git archive respect core.autocrlf when creating zip format archi=
ves

Dmitry Potapov (2):
  git-rebase-interactive: do not squash commits on abort
  git-rebase--interactive: auto amend only edited commit

Eric Raible (1):
  completion: git commit should list --interactive

Eric Wong (1):
  git-svn: fix handling of even funkier branch names

=46abrizio Chiarello (1):
  builtin-clone: fix typo

Garry Dolley (1):
  Clarified gitattributes documentation regarding custom hunk header.

Heikki Orsila (3):
  Start conforming code to "git subcmd" style part 2
  Start conforming code to "git subcmd" style part 3
  Cosmetical command name fix

Jeff King (1):
  Use compatibility regex library also on FreeBSD

Joey Hess (1):
  gitweb: avoid warnings for commits without body

Johannes Sixt (2):
  Use compatibility regex library also on AIX
  git-remote: do not use user input in a printf format string

Junio C Hamano (9):
  discard_cache: reset lazy name_hash bit
  diff Porcelain: do not disable auto index refreshing on -C -C
  diff --quiet: make it synonym to --exit-code >/dev/null
  Don't verify host name in SSL certs when GIT_SSL_NO_VERIFY is set
  Fix permission bits on sources checked out with an overtight umask
  checkout: do not lose staged removal
  GIT 1.6.0.2
  diff/diff-files: do not use --cc too aggressively
  Start draft release notes for 1.6.0.3

Mikael Magnusson (2):
  Typo "bogos" in format-patch error message.
  git-repack uses --no-repack-object, not --no-repack-delta.

Petr Baudis (1):
  Do not perform cross-directory renames when creating packs

Ralf Wildenhues (1):
  Fix some manual typos.

Thomas Rast (1):
  sha1_file: link() returns -1 on failure, not errno

Todd Zullinger (1):
  Use dashless git commands in setgitperms.perl

Yann Dirson (1):
  Bust the ghost of long-defunct diffcore-pathspec.


* The 'master' branch has these since the last announcement
  in addition to the above.

Bert Wesarg (1):
  for-each-ref: `:short` format for `refname`

Christian Couder (3):
  bisect: test merge base if good rev is not an ancestor of bad rev
  bisect: only check merge bases when needed
  bisect: remove "checkout_done" variable used when checking merge base=
s

Daniel Barkalow (1):
  Check early that a new branch is new and valid

Deskin Miler (1):
  git-svn: testcase for partial rebuild

Deskin Miller (1):
  git-svn: do a partial rebuild if rev_map is out-of-date

Junio C Hamano (4):
  diff: vary default prefix depending on what are compared
  daemon.c: avoid setlinebuf()
  Update draft release notes to 1.6.1
  t5510: test "git fetch" following tags minimally

Nicolas Pitre (3):
  sha1write: don't copy full sized buffers
  pack-objects: don't include missing preferred base objects
  t5300: improve SHA1 collision test

Quy Tonthat (1):
  Update RPM spec for the new location of git-cvsserver.

Ren=C3=A9 Scharfe (3):
  log: add load_ref_decorations()
  move load_ref_decorations() to log-tree.c and export it
  add '%d' pretty format specifier to show decoration

SZEDER G=C3=A1bor (1):
  bash: use for-each-ref format 'refname:short'

Thomas Rast (2):
  rev-list: fix --reverse interaction with --parents
  t6013: replace use of 'tac' with equivalent Perl
