From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.5.1
Date: Mon, 21 Apr 2008 15:48:59 -0700
Message-ID: <7vej8yako4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:50:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo4pm-0000p5-Km
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 00:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbYDUWtP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Apr 2008 18:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbYDUWtP
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 18:49:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbYDUWtO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Apr 2008 18:49:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6125F3F2A;
	Mon, 21 Apr 2008 18:49:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 40E013F29; Mon, 21 Apr 2008 18:49:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80042>

The latest maintenance release GIT 1.5.5.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.5.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.5.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.5.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.5.1-1.$arch.rpm	(RPM)

=46ortunately there weren't many brown paper bag breakages we needed to=
 fix
immediately after releasing 1.5.5, but there do exist some usability an=
d
documentation fixes accumulated on the maintenance branch.  This releas=
e
delibers them.

----------------------------------------------------------------

Changes since v1.5.5 are as follows:

Alberto Bertogli (1):
      builtin-apply: Show a more descriptive error on failure when open=
ing a patch

Bj=C3=B6rn Steinbrink (1):
      Fix section about backdating tags in the git-tag docs

Carlos Rica (2):
      Fix documentation syntax of optional arguments in short options.
      core-tutorial.txt: Fix showing the current behaviour.

Christian Couder (4):
      bisect: fix bad rev checking in "git bisect good"
      bisect: report bad rev better
      bisect: squelch "fatal: ref HEAD not a symref" misleading message
      git-bisect: make "start", "good" and "skip" succeed or fail atomi=
cally

Clifford Caoile (1):
      Docs gitk: Explicitly mention the files that gitk uses (~/.gitk)

Daniel Barkalow (1):
      Fix config key miscount in url.*.insteadOf

Dirk Suesserott (1):
      Documentation/git-request-pull: Fixed a typo ("send" -> "end")

Jakub Narebski (1):
      gitweb: Fix 'history' view for deleted files with history

Jeff King (1):
      git-fetch: fix status output when not storing tracking ref

Johannes Sixt (1):
      Document option --only of git commit

Jon Loeliger (1):
      Clarify and fix English in "git-rm" documentation

Jonas Fonseca (1):
      git-remote: reject adding remotes with invalid names

Junio C Hamano (7):
      Document -w option to shortlog
      Documentation/git-submodule: typofix
      t7401: squelch garbage output
      rebase: do not munge commit log message
      git-am: minor cleanup
      am: POSIX portability fix
      GIT 1.5.5.1

Linus Torvalds (2):
      Ignore leading empty lines while summarizing merges
      git-am: cope better with an empty Subject: line

Mark Levedahl (1):
      git-submodule - possibly use branch name to describe a module

Matthieu Moy (1):
      Document that WebDAV doesn't need git on the server, and works ov=
er SSL

Michele Ballabio (1):
      revision.c: make --date-order overriddable

Pedro Melo (1):
      Force the medium pretty format on calls to git log

Ping Yin (1):
      git-submodule: Avoid 'fatal: cannot describe' message

Ren=C3=A9 Scharfe (1):
      git-archive: ignore prefix when checking file attribute

Scott Collins (1):
      Clarify documentation of git-cvsserver, particularly in relation =
to git-shell

Shawn Bohrer (2):
      git clean: Don't automatically remove directories when run within=
 subdirectory
      git clean: Add test to verify directories aren't removed with a p=
refix
