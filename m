From: Krzysiek Pawlik <krzysiek.pawlik@people.pl>
Subject: Re: Recoding of {git,cg}-log output
Date: Mon, 27 Feb 2006 01:50:14 +0100
Message-ID: <44024CC6.8010401@people.pl>
References: <44024384.4060406@people.pl> <Pine.LNX.4.63.0602270133330.5275@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAA39EEE998226C99B43F37DA"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 01:50:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDWaj-0002tq-E4
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 01:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWB0AuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 19:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWB0AuQ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 19:50:16 -0500
Received: from people.pl ([212.85.96.54]:13273 "HELO v00054.home.net.pl")
	by vger.kernel.org with SMTP id S1751468AbWB0AuO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 19:50:14 -0500
Received: from localhost (HELO ?192.168.1.1?) (krzysiek.pawlik.people@home@127.0.0.1)
  by matrix01.home.net.pl with SMTP; Mon, 27 Feb 2006 00:50:09 -0000
User-Agent: Mail/News 1.5 (X11/20060206)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602270133330.5275@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=BC555551
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16815>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA39EEE998226C99B43F37DA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> Of course, you could always set up a script doing the recoding and
> the paging, like

No.

> The advantage of this approach compared to adjusting git is that
> other programs use PAGER, too.

Passing code (web pages, etc) throught iconv is not a good idea -
{git,cg}-diff should show the file content as it is, not altered by iconv=
=2E

Changing PAGER is a bit... ugly and messy way of doing it. Assume that I
work on some files and want to look at some unversioned files outside
the tree (like docs, man pages, whatever) and the $PAGER passes the
legitimate ISO8859-2 files through iconv, what gives us garbage. And we
end up changing pager very often - Bad Idea (TM).

--=20
Krzysiek Pawlik (Nelchael)
RLU #322999 GPG Key ID: 0xBC555551


--------------enigAA39EEE998226C99B43F37DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEAkzGgo/w9rxVVVERAhVxAKCCjy8I/X8MKSB7yWK6B4EM92cLdgCfZtaG
ucQr8vj6arSBNNDPqYA7egk=
=xsq/
-----END PGP SIGNATURE-----

--------------enigAA39EEE998226C99B43F37DA--
