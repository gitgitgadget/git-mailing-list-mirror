From: Sascha Peilicke <saschpe@gmx.de>
Subject: Re: [PATCH] No color diff when redirecting to file
Date: Mon, 24 Jan 2011 09:59:02 +0100
Message-ID: <201101240959.02852.saschpe@gmx.de>
References: <201101231410.48528.saschpe@gmx.de> <201101231547.18529.j6t@kdbg.org> <vpq39oj4jfz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1562656.AF6jn7qKtq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 24 09:59:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhIHA-0006uc-3y
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 09:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab1AXI7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 03:59:46 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:45271 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751214Ab1AXI7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 03:59:46 -0500
Received: (qmail invoked by alias); 24 Jan 2011 08:59:44 -0000
Received: from charybdis-ext.suse.de (EHLO bort.localnet) [195.135.221.2]
  by mail.gmx.net (mp064) with SMTP; 24 Jan 2011 09:59:44 +0100
X-Authenticated: #30943063
X-Provags-ID: V01U2FsdGVkX190u9QWXw10PxOSztBCoK08h0D/826qIF9jYtgiLj
	X/jNtc0gQO+7kx
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.95; x86_64; ; )
In-Reply-To: <vpq39oj4jfz.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165441>

--nextPart1562656.AF6jn7qKtq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday 23 January 2011 18:29:52 you wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > That said, I cannot reproduce. Perhaps your configuration says
> > color.ui=3Dalways? If so, then this is expected behavior and not a bug,
> > IMO.
>=20
> I think you're right.
>=20
> I tested this (without the patch):
>=20
> git diff
> =3D> I get color, because I have color.ui =3D auto
>=20
> git diff | cat
> =3D> I don't get color
>=20
> git diff --color=3Dauto | cat
> =3D> no color
>=20
> git diff --color=3Dalways | cat
> =3D> colors, because I've asked
>=20
> this seems to be just the right behavior.

try the same with

git diff > foo

works when

git diff --no-color > foo
=2D-=20
Mit freundlichen Gr=FC=DFen,
Sascha Peilicke
http://saschpe.wordpress.com

--nextPart1562656.AF6jn7qKtq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAk09P1YACgkQDq/ykSrZt1W2MgCfbdyzRQjxoMTp25wYZD3+fOyz
SiYAni4GTadOUZwxvSrgVrRzJCBzLozc
=CbeV
-----END PGP SIGNATURE-----

--nextPart1562656.AF6jn7qKtq--
