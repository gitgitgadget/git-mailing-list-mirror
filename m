From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 10:56:26 +0200
Message-ID: <20050510085626.GC8176@lug-owl.de>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <20050510083609.GF11221@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Cc: Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 10:50:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVQQW-0002BO-3v
	for gcvg-git@gmane.org; Tue, 10 May 2005 10:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVEJI4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 04:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVEJI4d
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 04:56:33 -0400
Received: from lug-owl.de ([195.71.106.12]:54763 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261586AbVEJI41 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 04:56:27 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 524E3190208; Tue, 10 May 2005 10:56:26 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050510083609.GF11221@kiste.smurf.noris.de>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-10 10:36:09 +0200, Matthias Urlichs <smurf@smurf.noris.de> =
wrote:
> Jan-Benedict Glaw:
> > > 	find * \( -type f -o tyle l \) -print0 | ...
> >=20
> > Btw, this won't find dot files, so using "." as the path list (instead
> > of "*") might be wise...
> >=20
> git doesn't want to handle dot files anyway.

=2E..which I actually consider to be a bug. Why should git care about the
filename, as long as it doesn't clash with ".git"?  After all, it's just
a plumbing mechanism designed to locate file contents by SHA-1 hashes.
It shouldn't deal with file names at all, really:-)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgHc6Hb1edYOZ4bsRAq1SAJ9RsPr+BeyD9UI9pDZ0jnuK0m/EHgCdEa+G
qtVTmk4ANTpicEq1+0NvEjQ=
=JFCY
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
