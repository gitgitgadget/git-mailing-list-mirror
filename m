From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Sun, 18 Jan 2009 17:49:51 +0100
Message-ID: <200901181749.52896.trast@student.ethz.ch>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com> <20090118153928.GA16664@coredump.intra.peff.net> <alpine.DEB.1.00.0901181711090.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1448677.W4paMlByGm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonas =?utf-8?q?Flod=C3=A9n?= <jonas@floden.nu>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 17:51:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOarq-0005Px-PK
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 17:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760369AbZARQt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 11:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759718AbZARQt5
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 11:49:57 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:4133 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914AbZARQt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 11:49:56 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 18 Jan 2009 17:49:54 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 18 Jan 2009 17:49:54 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.18-0.2-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0901181711090.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 18 Jan 2009 16:49:54.0253 (UTC) FILETIME=[C9AA3FD0:01C9798C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106240>

--nextPart1448677.W4paMlByGm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Sun, 18 Jan 2009, Jeff King wrote:
> > On Sun, Jan 18, 2009 at 10:41:13AM +0100, Stephan Beyer wrote:
> > > Hmm, IIRC if $FIRSTLINE contains \n or something like that, it will
> > > interpret this as newline in some shell/echo implementations.
> > >=20
> > > So printf "...%s..." "$FOO" is always sane for user input.
>=20
> But you are wrong.  And Stephan is wrong, too.
>=20
> The name "FIRSTLINE" suggests that it is indeed a first line, and=20
> consequently cannot contain a newline.

I think the point was that $FIRSTLINE can contain a backslash sequence
such as (literally) \n or \r.  Indeed 'man 1p echo' on my system says

  _string_  A string to be written to standard output. If the first
            operand is -n, or if any of the operands contain a
            backslash ( '\' ) character, the results are
            implementation- defined.

(Those POSIX manpages are really useful!)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1448677.W4paMlByGm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklzXbAACgkQqUud07tmzP0tfQCePUABHzxYX4useTckpc38muqt
AcsAmgM548wO0zlRCN/uyvdbbtkkWhV7
=J/r6
-----END PGP SIGNATURE-----

--nextPart1448677.W4paMlByGm--
