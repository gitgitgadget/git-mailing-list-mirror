From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] config: if mtime (or size) of the config file changed since last read, reread it
Date: Sun, 7 May 2006 09:30:52 +0200
Message-ID: <20060507073052.GC17031@lug-owl.de>
References: <Pine.LNX.4.63.0605070125010.6597@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0605070144530.7578@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 09:30:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcdjF-0000o7-9h
	for gcvg-git@gmane.org; Sun, 07 May 2006 09:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWEGHay (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 03:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWEGHay
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 03:30:54 -0400
Received: from lug-owl.de ([195.71.106.12]:26535 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751164AbWEGHax (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 03:30:53 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id A902FF003F; Sun,  7 May 2006 09:30:52 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0605070144530.7578@wbgn013.biozentrum.uni-wuerzburg.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19693>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-05-07 01:45:22 +0200, Johannes Schindelin <Johannes.Schindelin=
@gmx.de> wrote:
> diff --git a/config.c b/config.c
> index 6765186..452b587 100644
> --- a/config.c
> +++ b/config.c
> @@ -261,6 +261,10 @@ int git_config_from_file(config_fn_t fn,
>  	config_offset =3D 0;
> =20
>  	in_fd =3D open(filename, O_RDONLY);
> +	if (in_fd < 0 && ENOENT !=3D errno )

I admit that I don't like the (constant -operator- variable) notation,
but mixing both in one line..?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEXaIsHb1edYOZ4bsRAvB6AJ9R1C74XO9Z3RxTsF5jjYsNrZTNUwCeJQO/
rLIrHmCRALb9gFGHfora1As=
=EXRq
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
