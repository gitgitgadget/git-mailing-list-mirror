From: Ximin Luo <infinity0@gmx.com>
Subject: [BUG] git-init does not respect existing separate-git-dir
Date: Thu, 29 Aug 2013 13:39:02 +0100
Message-ID: <521F40E6.4040102@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="----enig2XULBATUXOIKEOKGIRHQH"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 14:39:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF1VX-0002u1-RF
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 14:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340Ab3H2MjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 08:39:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:60133 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755756Ab3H2MjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 08:39:04 -0400
Received: from [192.168.1.101] ([86.163.191.255]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M8e5P-1W0gRZ3HVb-00wB6K for <git@vger.kernel.org>;
 Thu, 29 Aug 2013 14:39:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130630 Icedove/17.0.7
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:t9jeu6wflQyWCaoQqqOeYLVPpqn8M5g6NwbVqEEKouPz1XPaRuG
 ivWexoFoFZDUU5/RvJysOoMeGdBDAc0ypRSTib3OCZNB7fo2M9XMSBnHiMe207m0Pmk8fgj
 4gSi5gl0oEWMH/f7HlFkhXFRgoxCadZmGkXcPGdUfNy70hePM8g3ZmY3MTM6rQPdnzNmdQr
 vrKlV8UwNF27qkdWqDfCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233249>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XULBATUXOIKEOKGIRHQH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

It should not be necessary to re-specify --separate-git-dir when re-initi=
alising a git repo.

$ git init --separate-git-dir ../repo
Initialized empty Git repository in /home/infinity0/tmp/repo/

$ git init
/home/infinity0/tmp/wtree/.git/refs: Not a directory
1

One big motivation is so "git init" can be a good "fire-and-forget" invoc=
ation that should work anywhere. Currently, one has to do "git init --sep=
arate-git-dir $(git rev-parse --git-dir)" which is a lot less elegant.

(Please CC me as I am not subscribed.)

--=20
GPG: 4096R/1318EFAC5FBBDBCE
git://github.com/infinity0/pubkeys.git


------enig2XULBATUXOIKEOKGIRHQH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iQIcBAEBCAAGBQJSH0DmAAoJEIYN7zuPZQt5MDAP+gKn8x3j7NYLRx600lXqp3SJ
khE0LRl0ckQMWVjd0GBPM5tXyQPokCxkU57BJMYYeaL0DikH+DPz8BlZmeQFoC9k
KNxJHctm+wuC1PDrAqDe1VC5u+mGbyiUHOEDg0qQBWzLyPQpbMseLd6QbxRBGsN2
2uA+G7c53vqgUw060Ae2yBaykk161wP5M6DYvy7+i5JyK5mHIBFXY55kJObaz4wQ
pxS5l0r7cjTaSOnfLMpAfSC+W8aK4esZjA9+wuBioseJ8xptrXamQgWc7Z7ByWsr
rIGLOi8LmjKg4Vl97Y5TKftMkqvEQT4Ez38t10fCSzucyrzXARl8wCD9xnUFYweG
fRKB9R+LwNH55YJ/TAd1qHxKcWkwMrK27fFSKJT1W2iR7cwJ7qbldv0DPKiH76Mn
AYQbEIQbBMc50RwespyUP9E1e+/ZjH/hxQt0MLx049nqd/tvbzAYlx9jrE82x9Rg
tMd3iavvGZ1j1Bvq57zJZkjp4ybGNg8Kh5FI750quK/krVfmV8fDqmOH2yK777mu
ygnP5CLEu6dlCfsvPdg4pemR/e9bEzrQ1qk/Js+tJ1jWZKARF6JVlLDe2La4HzPo
HaMX+VB4e4lKr1G4GNJHLwDuoowQsTQo3ytbAa4HOt3deDE1dGXWQiFx4JUmMYfW
O9pC71bbphlQXmWCR+Va
=D8XM
-----END PGP SIGNATURE-----

------enig2XULBATUXOIKEOKGIRHQH--
