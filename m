From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.1.3
Date: Sat, 07 Feb 2009 13:54:51 -0800
Message-ID: <7vprhtsyj8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 22:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVvA7-0001uS-HR
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121AbZBGVzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 16:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755014AbZBGVzA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:55:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770AbZBGVy6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2009 16:54:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 42C7D2AA73;
	Sat,  7 Feb 2009 16:54:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 188B52AA6F; Sat, 
 7 Feb 2009 16:54:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F6354A8A-F561-11DD-AAB5-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108893>

The latest maintenance release GIT 1.6.1.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.1.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.1.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.1.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  RPMS/$arch/git-*-1.6.1.3-1.fc9.$arch.rpm	(RPM)

GIT v1.6.1.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.1.2
--------------------

* "git diff --binary | git apply" pipeline did not work well when
  a binary blob is changed to a symbolic link.

* Some combinations of -b/-w/--ignore-space-at-eol to "git diff" did
  not work as expected.

* "git grep" did not pass the -I (ignore binary) option when
  calling out an external grep program.

* "git log" and friends include HEAD to the set of starting points
  when --all is given.  This makes a difference when you are not
  on any branch.

* "git mv" to move an untracked file to overwrite a tracked
  contents misbehaved.

* "git merge -s octopus" with many potential merge bases did not
  work correctly.

* RPM binary package installed the html manpages in a wrong place.

Also includes minor documentation fixes and updates.

----------------------------------------------------------------

Changes since v1.6.1.2 are as follows:

Anders Melchiorsen (2):
      Documentation: more git push examples
      Documentation: rework src/dst description in git push

David J. Mellor (1):
      Fixed broken git help -w when installing from RPM

Guanqun Lu (2):
      fix typo in Documentation
      add test-dump-cache-tree in Makefile

Johannes Schindelin (2):
      revision walker: include a detached HEAD in --all
      apply: fix access to an uninitialized mode variable, found by val=
grind

Junio C Hamano (6):
      bundle: allow the same ref to be given more than once
      Documentation: simplify refspec format description
      diff.c: output correct index lines for a split diff
      builtin-apply.c: do not set bogus mode in check_preimage() for de=
leted path
      grep: pass -I (ignore binary) down to external grep
      GIT 1.6.1.3

Keith Cascio (2):
      test more combinations of ignore-whitespace options to diff
      Fix combined use of whitespace ignore options to diff

Linus Torvalds (1):
      Wrap inflate and other zlib routines for better error reporting

Matthieu Moy (3):
      Missing && in t/t7001.sh.
      Add a testcase for "git mv -f" on untracked files.
      builtin-mv.c: check for unversionned files before looking at the =
destination.

Ren=C3=A9 Scharfe (1):
      merge: fix out-of-bounds memory access

SZEDER G=C3=A1bor (1):
      Fix gitdir detection when in subdir of gitdir

Stefan Naewe (1):
      urls.txt: document optional port specification in git URLS

William Pursell (1):
      User-manual: "git stash <comment>" form is long gone
