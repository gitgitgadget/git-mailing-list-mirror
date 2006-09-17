From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: use correct mime type even if filename has multiple dots.
Date: Sun, 17 Sep 2006 09:51:57 +0200
Message-ID: <20060917075157.GY17042@admingilde.org>
References: <20060916210933.GX17042@admingilde.org> <eehr7e$5i0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nDmTXYS4kVhtHHfR"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 09:52:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOrRq-0006ya-0j
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 09:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWIQHv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 03:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWIQHv6
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 03:51:58 -0400
Received: from agent.admingilde.org ([213.95.21.5]:35984 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751085AbWIQHv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 03:51:58 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GOrRV-0004EC-As; Sun, 17 Sep 2006 09:51:57 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eehr7e$5i0$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27161>


--nDmTXYS4kVhtHHfR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Sep 16, 2006 at 11:44:52PM +0200, Jakub Narebski wrote:
> Martin Waitz wrote:
>=20
> > Match the last part of the filename agains the extention from the
> > mime database instead of insisting that it starts at the first dot.
> [...]
> > -     $filename =3D~ /\.(.*?)$/;
> > -     return $mimemap{$1};
>=20
> Actually, that is non-greedy match, so the above code insist that=20
> extension starts at the _last_ dot.

hmm, but it didn't work for me.
I had filenames like "man/program.8.html" which got served as
"text/html" with the old code.

Besides, the new code would cope with extentions that contain a
dot itself.

Looking at /etc/mime.types, it only contains pcf.Z but perhaps
it should also contain tar.gz or similiar.
>=20
> --=20
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Martin Waitz

--nDmTXYS4kVhtHHfR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFDP6dj/Eaxd/oD7IRAvXkAJ9Vz6rjcIxmSqY97BM1VX1/5aY2lwCeLyDq
remVY3mJvjJdIsG+aZ5CZ1A=
=a14A
-----END PGP SIGNATURE-----

--nDmTXYS4kVhtHHfR--
