From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] New test for preserve merges and squash
Date: Thu, 20 Mar 2008 11:18:09 +0100
Message-ID: <20080320101809.GA23108@alea.gnuu.de>
References: <1205971432-12641-1-git-send-email-joerg@alea.gnuu.de> <7v1w661bnx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Cc: Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:44:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcIFi-0007m3-3h
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 11:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbYCTKnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 06:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbYCTKnZ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 06:43:25 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2638 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbYCTKnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 06:43:24 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 2D63E488062; Thu, 20 Mar 2008 11:43:21 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JcHph-0000SB-6D; Thu, 20 Mar 2008 11:17:13 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JcHqb-00061M-D8; Thu, 20 Mar 2008 11:18:09 +0100
Content-Disposition: inline
In-Reply-To: <7v1w661bnx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77648>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Junio C Hamano schrieb am Wed 19. Mar, 17:28 (-0700):
> J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:
>=20
> > Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
> > ---
> >  t/t3404-rebase-interactive.sh |   20 ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> >
> > The current version of git fails this test. I think it's a bug, because
> > the patch is what I expect to happen. Or am I wrong?
>=20
> Please mark such tests with test_expect_fail.

No, I expect the test succeeds. Currently, it fails. This might be,
because my expectations are wrong or there's a bug.

> And also Cc: the guilty parties.

Okay, I've added Johannes the author of f09c9b8c5ff to the Cc: list.

Johannes, can you explain why this test fails?

Bye, J=C3=B6rg.
--=20
> Definiere =E2=80=9ADemokratie=E2=80=98 =E2=80=A6
=E2=80=A6 eine Mehrheit beweist einer Minderheit, dass Widerstand zwecklos =
ist.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH4jnhwe0mZwH1VIARAt+YAKDB/l3QwErVq4Gfz7bTRWvA+abHBgCdEy/N
uVn9nDS2ic+PdaZAmD3huL0=
=cGoV
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
