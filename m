From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.3.4
Date: Mon, 22 Jul 2013 15:01:57 -0700
Message-ID: <7vwqoib6ei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jul 23 00:02:20 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1V1OBN-0003AG-6m
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Jul 2013 00:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933450Ab3GVWCD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 22 Jul 2013 18:02:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932388Ab3GVWB7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jul 2013 18:01:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6012C335F5;
	Mon, 22 Jul 2013 22:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=n6YEGiqLHB4vsBikHneasMZ83
	G0=; b=N5xndhlW7u5mTXYnvtd1lismaAQzsupElsjIIqCYcR2f0O43kZboD2RSd
	cAQFox7JtcKwMVPwlut4D2Tu4nGWgaY/JMyshX6pDAoFQ0Twp+R3o5Cq0OeVht64
	24p5RnDz9ysTjuFZA27PWLgjy1bpUgYYEi62C2fB1VZ33/zl0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=pJMySu9NCi2FmBhcHyu
	1/k599W4nn9Q5gtrFqxwqZbGzd3+FGcOSkzFEj6WV0eAed92pg+Kck1lFEx3TuuC
	fc79rEQsLu/i/vmG5tgzEAVpXxuRLhWfuxEVO0Mhb/dKxjBJHNZv2BNs36B+dD+i
	3fySmBGTYfKbocdSXDxm1lEU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 578AD335F4;
	Mon, 22 Jul 2013 22:01:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82E00335F3;
	Mon, 22 Jul 2013 22:01:58 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5469D12E-F31A-11E2-8064-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230997>

The latest maintenance release Git v1.8.3.4 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

fe633d02f7d964842d7ea804278b75120fc60c11  git-1.8.3.4.tar.gz
1f1200515e1e7042bcbd4176ef76c58021cd9a83  git-htmldocs-1.8.3.4.tar.gz
04fe5a752234262d128220f09ea25c0faa447947  git-manpages-1.8.3.4.tar.gz

The following public repositories all have a copy of the v1.8.3.4
tag and the maint branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.3.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

This update is mostly to propagate documentation fixes and test
updates from the master front back to the maintenance track.

=46ixes since v1.8.3.3
--------------------

 * The bisect log listed incorrect commits when bisection ends with
   only skipped ones.

 * The test coverage framework was left broken for some time.

 * The test suite for HTTP transport did not run with Apache 2.4.

 * "git diff" used to fail when core.safecrlf is set and the working
   tree contents had mixed CRLF/LF line endings. Committing such a
   content must be prohibited, but "git diff" should help the user to
   locate and fix such problems without failing.

----------------------------------------------------------------

Changes since v1.8.3.3 are as follows:

Dennis Kaarsemaker (2):
      tests: allow sha1's as part of the path
      GIT-VERSION-GEN: support non-standard $GIT_DIR path

=46raser Tweedale (2):
      documentation: add git:// transport security notice
      diff-options: document default similarity index

Jeff King (5):
      t/lib-httpd/apache.conf: do not use LockFile in apache >=3D 2.4
      t/lib-httpd/apache.conf: load extra auth modules in apache 2.4
      t/lib-httpd/apache.conf: load compat access module in apache 2.4
      t/lib-httpd/apache.conf: configure an MPM module for apache 2.4
      lib-httpd/apache.conf: check version only after mod_version loads

Johannes Sixt (10):
      test-chmtime: Fix exit code on Windows
      t3010: modernize style
      tests: introduce test_ln_s_add
      tests: use test_ln_s_add to remove SYMLINKS prerequisite (trivial=
 cases)
      t0000: use test_ln_s_add to remove SYMLINKS prerequisite
      t3030: use test_ln_s_add to remove SYMLINKS prerequisite
      t3100: use test_ln_s_add to remove SYMLINKS prerequisite
      t3509, t4023, t4114: use test_ln_s_add to remove SYMLINKS prerequ=
isite
      t6035: use test_ln_s_add to remove SYMLINKS prerequisite
      t4011: remove SYMLINKS prerequisite

Junio C Hamano (7):
      fetch-options.txt: prevent a wildcard refspec from getting misfor=
matted
      diff: demote core.safecrlf=3Dtrue to core.safecrlf=3Dwarn
      t1512: correct leftover constants from earlier edition
      get_short_sha1(): correctly disambiguate type-limited abbreviatio=
n
      Start preparing for 1.8.3.4
      Update draft release notes to 1.8.3.4
      Git 1.8.3.4

Kevin Bracey (1):
      Documentation: Move "git diff <blob> <blob>"

Matthieu Moy (2):
      Documentation/git-push.txt: explain better cases where --force is=
 dangerous
      Documentation/git-merge.txt: weaken warning about uncommited chan=
ges

Michael Haggerty (1):
      lockfile: fix buffer overflow in path handling

Namhyung Kim (1):
      config: Add description of --local option

Ond=C5=99ej B=C3=ADlka (1):
      update URL to the marc.info mail archive

Phil Hord (1):
      fix "builtin-*" references to be "builtin/*"

Ramkumar Ramachandra (2):
      column doc: rewrite documentation for column.ui
      name-rev doc: rewrite --stdin paragraph

Ren=C3=A9 Scharfe (9):
      t5000: integrate export-subst tests into regular tests
      t5000, t5003: create directories for extracted files lazily
      t5000: factor out check_tar
      t5000: use check_tar for prefix test
      t5000: simplify tar-tree tests
      t5000: test long filenames
      read-cache: add simple performance test
      read-cache: free cache in discard_index
      use logical OR (||) instead of binary OR (|) in logical context

Stefan Beller (4):
      archive-zip:write_zip_entry: Remove second reset of size variable=
 to zero.
      Documentation: "git reset <tree-ish> <pathspec>" takes a tree-ish=
, not tree-sh
      http-push.c::add_send_request(): do not initialize transfer_reque=
st
      apply.c::find_name_traditional(): do not initialize len to the li=
ne's length

Thomas Rast (7):
      coverage: split build target into compile and test
      coverage: do not delete .gcno files before building
      coverage: set DEFAULT_TEST_TARGET to avoid using prove
      coverage: build coverage-untested-functions by default
      Test 'commit --only' after 'checkout --orphan'
      t9902: fix 'test A =3D=3D B' to use =3D operator
      test-lint: detect 'export FOO=3Dbar'

Torstein Hegge (1):
      bisect: Fix log output for multi-parent skip ranges

Veres Lajos (1):
      random typofixes (committed missing a 't', successful missing an =
's')

Vitor Antunes (1):
      t9801: git-p4: check ignore files with client spec

W. Trevor King (1):
      user-manual: Update download size for Git and the kernel

Yaakov Selkowitz (1):
      web--browse: support /usr/bin/cygstart on Cygwin
