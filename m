From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 10:04:45 +0200
Message-ID: <20050510080445.GB8176@lug-owl.de>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 09:58:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVPcx-0004B7-5w
	for gcvg-git@gmane.org; Tue, 10 May 2005 09:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVEJIFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 04:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVEJIFU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 04:05:20 -0400
Received: from lug-owl.de ([195.71.106.12]:23786 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261572AbVEJIEq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 04:04:46 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 8196D1901D6; Tue, 10 May 2005 10:04:45 +0200 (CEST)
To: Brian Gerst <bgerst@didntduck.org>
Content-Disposition: inline
In-Reply-To: <20050510075227.GA8176@lug-owl.de>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-10 09:52:27 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de> wr=
ote:
> On Tue, 2005-05-10 01:17:31 -0400, Brian Gerst <bgerst@didntduck.org> wro=
te:
> > But it can handle symlinks:
> >=20
> > 	find * -type f -o -type l -print0 | xargs -0r cg-add
>=20
> This won't work because the explicit OR (-o) lower precedence compared
> to the implicit AND between "-type l" and "-print0", thus this find
> command will do print0 IFF the matched entry is a symlink. Use something
> like this instead:
>=20
> 	find * \( -type f -o tyle l \) -print0 | ...

Btw, this won't find dot files, so using "." as the path list (instead
of "*") might be wise...

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

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgGsdHb1edYOZ4bsRAqzgAJ43uePvPsmCMZxCzKDLLPHxTFMQeQCfX3NO
/yJKVNlNpjB3oKNAPfXr//Q=
=mmAf
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
