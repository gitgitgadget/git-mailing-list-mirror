From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable errors.
Date: Mon, 12 Jan 2009 14:35:35 -0600
Message-ID: <200901121435.35547.bss@iguanasuicide.net>
References: <496BA0E4.2040607@tedpavlic.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1324372.KjUFsTgATx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 21:36:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMTWE-0006IZ-G1
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 21:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbZALUey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 15:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbZALUey
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 15:34:54 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:55688 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbZALUey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 15:34:54 -0500
Received: from [63.167.79.33]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMTUq-0001iU-It; Mon, 12 Jan 2009 20:34:52 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <496BA0E4.2040607@tedpavlic.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105377>

--nextPart1324372.KjUFsTgATx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2009 January 12 13:58:28 you wrote:
>In bash, "set -u" gives an error when a variable is unbound. In this
>case, the bash completion script included in the git/contrib directory
>produces several errors.
>
>The attached patch replaces things like
>
>         if [ -z "$1" ]
>
>with
>
>         if [ -z "${1-}" ]

That looks ugly to me.  Any reason we shouldn't just "set +u" at the top of=
=20
the script?
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1324372.KjUFsTgATx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklrqZcACgkQdNbfk+86fC1k6wCfX2p4q63Bc2hRJDMg7wTFNyDz
AlwAniyipyxvzRzkF/MstAZRHbUdd3PJ
=Scoa
-----END PGP SIGNATURE-----

--nextPart1324372.KjUFsTgATx--
