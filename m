From: Junio C Hamano <gitster@pobox.com>
Subject: Unresolved issues
Date: Sat, 19 Apr 2008 01:19:22 -0700
Message-ID: <7vbq46fe9h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 18:00:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn8Ix-0001kr-Iw
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 10:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbYDSITd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Apr 2008 04:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbYDSITb
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 04:19:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbYDSIT2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 04:19:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3DB636E9;
	Sat, 19 Apr 2008 04:19:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E328036E8; Sat, 19 Apr 2008 04:19:24 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79898>

Here is an "issues" list I am keeping track of on the back of my head (=
and
in "TODO" file on 'todo' branch, which is not updated often enough).

The tail end of this list is probably a bit stale, as I am running out =
of
time tonight and did not have enough time to check the current status.
Please spot issues that have been resolved and report them.

----------------------------------------------------------------

Possible bug not diagnosed yet

* "git commit --interactive" allows same tree as parent to be recorded

Message-ID: <slrng059n3.nd8.joerg@alea.gnuu.de>

----------------------------------------------------------------

Issues that are unconcluded or need a fresh infusion of kerosene to
firestart them again.

* adding across symlinks (me)

Message-ID: <7vd4oppllw.fsf@gitster.siamese.dyndns.org>

* cvsserver improvements (Fredrik Noring)

Needs third-party confirmation and then properly applicable patches.

* reworking rebase interactive (J=C3=B6rg Sommer)

Message-Id: <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
Message-Id: <1208169584-15931-1-git-send-email-joerg@alea.gnuu.de>

* log --graph (Adam Simpkins)

Message-ID: <20080406214445.GA5822@adamsimpkins.net>

* --pretty=3Dformat:%d (Dscho)

* SP in path to $GIT_DIR breaks some scripts and many tests (Bryan Donl=
an)

Message-ID: <20080410084820.GA1904@shion.is.fushizen.net>

* Prepare cvsimport for fixed cvsps (David Mansfield)

Message-Id: <1207100091.10532.64.camel@gandalf.cobite.com>

* ff=3Donly (Sverre Hvammen Johansen)
  $gmane/78250

* more help backends (Christian Couder)
  $gmane/78150

* cvsserver updates (Damien Diederen with help by Frank Lichtenheld)
  $gmane/78188

* rewriting annotated tags in filter-branch (Brandon Casey)
  $gmane/78286

* fsck --lost-found (me)
  $gmane/78267

* core.inithook (Dscho)
  $gmane/78123

* receive.localBranches =3D { refuse | allow } (Dscho)
  $gmane/78065

* autosetting core.ignorecase (Dmitry Potapov)
  $gmane/78176

* mailinfo extention to extract Message-ID and others (Anton Gladkov)
  $gmane/78006

* rebase -p
  $gmane/78074

  There is a quite well done series from J=C3=B6rg Sommer I have to que=
ue but
  I am getting the feeling that it did not get enough review from the
  list.  I am reading it through (slowly) myself, but I'd appreciate mo=
re
  review comments on the list (not limited to this series).

* synopsys: use {} instead of () for grouping alternatives (Jari Aalto)
  $gmane/72243

* "[alias] st =3D status" and "cd .git && git st" (Jeff King)
  $gmane/72327

* "git fetch" does not exit with non-zero status when it failed to upda=
te
  some refs due to non-ffness (Daniel)
  $gmane/77178

* use "assume unchanged" bit to implement narrow checkout
  $gmane/77046

* zlib abstraction (Marco)
  $gmane/72262

* git --index-file=3D<foo> <cmd> (Linus)
  $gmane/77332

* git lost-found vs git fsck --lost-found
  $gmane/78267
