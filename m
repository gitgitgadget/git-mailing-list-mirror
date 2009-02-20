From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Fri, 20 Feb 2009 17:46:10 +0100
Message-ID: <200902201746.15242.trast@student.ethz.ch>
References: <499EC48B.9070004@trolltech.com> <alpine.DEB.1.00.0902201734450.6302@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1953073.lJ4iU23Hj7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>, spearce@spearce.org,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 17:48:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYXd-0004Ap-Ma
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 17:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZBTQq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 11:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbZBTQq3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 11:46:29 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:55188 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbZBTQq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 11:46:28 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 17:46:26 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 17:46:26 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0902201734450.6302@intel-tinevez-2-302>
X-OriginalArrivalTime: 20 Feb 2009 16:46:26.0360 (UTC) FILETIME=[C5620B80:01C9937A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110863>

--nextPart1953073.lJ4iU23Hj7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 20 Feb 2009, Marius Storm-Olsen wrote:
>=20
> > +		local c
> > +		+		if test "$(git config --bool core.bare)" =3D=3D
> > "true"; then
>=20
> Indeed, it seems that this got mangled, unfortunately.

Actually it seems the patch itself is fine, but the mail is still
flagged format=3Dflowed, so f=3Df-aware readers will mangle it on display.

It conflicts with e5dd864 (completion: Better __git_ps1 support when
not in working directory, 2009-02-11) however, which is on next.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1953073.lJ4iU23Hj7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkme3lcACgkQqUud07tmzP1KswCfZtFDOUulQyFw10zsdC/FdVyO
GvEAnRYjAgpevNgG0/UiTVHC7GnKgpkk
=x2iH
-----END PGP SIGNATURE-----

--nextPart1953073.lJ4iU23Hj7--
