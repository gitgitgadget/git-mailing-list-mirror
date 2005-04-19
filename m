From: Martin Uecker <muecker@gmx.de>
Subject: Re: space compression (again)
Date: Tue, 19 Apr 2005 14:39:35 +0200
Message-ID: <20050419123935.GA8091@macavity>
References: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu> <Pine.LNX.4.58.0504151117360.7211@ppc970.osdl.org> <Pine.LNX.4.61.0504151437100.27637@cag.csail.mit.edu> <Pine.LNX.4.58.0504151210590.7211@ppc970.osdl.org> <20050416143905.GA10370@macavity> <Pine.LNX.4.61.0504161101470.29343@cag.csail.mit.edu> <20050416173702.GA12605@macavity>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Cc: Martin Uecker <muecker@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 19 14:39:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNryb-0008Co-Te
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 14:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVDSMlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 08:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVDSMlQ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 08:41:16 -0400
Received: from dialin-145-254-144-080.arcor-ip.net ([145.254.144.80]:12928
	"EHLO macavity") by vger.kernel.org with ESMTP id S261481AbVDSMlA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 08:41:00 -0400
Received: from martin by macavity with local (Exim 4.34)
	id 1DNs0t-0002AP-Js; Tue, 19 Apr 2005 14:39:35 +0200
To: git@vger.kernel.org
Mail-Followup-To: Martin Uecker <muecker@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050416173702.GA12605@macavity>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 16, 2005 at 07:37:02PM +0200, Martin Uecker wrote:
> On Sat, Apr 16, 2005 at 11:11:00AM -0400, C. Scott Ananian wrote:
=20
> > The rsync approach does not use fixed chunk boundaries; this is necessa=
ry=20
> > to ensure good storage reuse for the expected case (ie; inserting a sin=
gle=20
> > line at the start or in the middle of the file, which changes all the=
=20
> > chunk boundaries).
>=20
> Yes. The chunk boundaries should be determined deterministically
> from local properties of the data. Use a rolling checksum over
> some small window and split the file it it hits a special value (0).
> This is what the rsyncable patch to zlib does.

This is certainly uninteresting for source code repositories
but for people who manage repositories of rsyncable binary
packages this would save a lot of space, bandwidth and
cpu time (compared to rsync because the scanning phase is
not necessary anymore).=20

Martin

--=20
One night, when little Giana from Milano was fast asleep,
she had a strange dream.


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCZPwHYDJInvULMKYRAgaVAJ9GQgJcTOB9vbhg02e7ySxeL2ffrwCeOtUK
Y1FPMpl6BfqhaoKzTgSaxas=
=E6lz
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
