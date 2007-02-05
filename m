From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: git should complain about seeked tree earlier
Date: Mon, 5 Feb 2007 09:33:54 +0100
Message-ID: <200702050933.57376.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2023015.UQKMz3BjLi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 09:34:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDzIh-0007Fe-67
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 09:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbXBEIeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 03:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbXBEIeG
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 03:34:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:47277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752149AbXBEIeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 03:34:05 -0500
Received: (qmail invoked by alias); 05 Feb 2007 08:34:03 -0000
Received: from blueice1n1.de.ibm.com (EHLO n22.hamburg.de.ibm.com) [195.212.29.163]
  by mail.gmx.net (mp039) with SMTP; 05 Feb 2007 09:34:03 +0100
X-Authenticated: #5108953
User-Agent: KMail/1.9.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38732>

--nextPart2023015.UQKMz3BjLi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It would be nice if git would complain earlier and not at the end of the pr=
ocess:


tfoerste@n22 ~ $ cd devel/bug_udp/
tfoerste@n22 ~/devel/bug_udp $ man git-bisect
tfoerste@n22 ~/devel/bug_udp $ git bisect start
won't bisect on seeked tree
tfoerste@n22 ~/devel/bug_udp $ git bisect good v2.6.18
You need to start by "git bisect start"
Do you want me to do it for you [Y/n]? n
tfoerste@n22 ~/devel/bug_udp $ git bisect bad
You need to start by "git bisect start"
Do you want me to do it for you [Y/n]?
won't bisect on seeked tree

=2D-=20
MfG/Sincerely

Toralf F=F6rster

--nextPart2023015.UQKMz3BjLi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFxuv1hyrlCH22naMRAhpvAJ4jFrKoaI8vjh3THJpnePV7AOzDqgCgkxmm
gLGjDLQPGmqRIHE4aU70oYk=
=eYOT
-----END PGP SIGNATURE-----

--nextPart2023015.UQKMz3BjLi--
