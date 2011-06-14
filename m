From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Objects deleted before first commit
Date: Tue, 14 Jun 2011 16:56:28 +0200
Message-ID: <20110614145628.GB30626@bee.lab.cmartin.tk>
References: <8269100C7056D24A91B672AF7E5E48492D959E@exchange.GottexBrokers.local>
 <BANLkTikSPNVbGFRUVh5eSFsxabVWT7SVVA@mail.gmail.com>
 <8269100C7056D24A91B672AF7E5E48492D95BB@exchange.GottexBrokers.local>
 <BANLkTik1jTq6otRvHwbo342oH7Dwy+vs_w@mail.gmail.com>
 <BANLkTin9_jfvtYdCsJLiWAoOvO2e1f=9SA@mail.gmail.com>
 <8269100C7056D24A91B672AF7E5E48492D963B@exchange.GottexBrokers.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Cc: PJ Weisberg <pjweisberg@gmail.com>,
	David Barr <davidbarr@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Edmondo Porcu <Edmondo.Porcu@gottexbrokers.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 16:56:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWV2j-0004PG-Cf
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 16:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab1FNO4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 10:56:32 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:57827 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab1FNO4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 10:56:31 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 1166A461E5;
	Tue, 14 Jun 2011 16:55:59 +0200 (CEST)
Received: (nullmailer pid 11041 invoked by uid 1000);
	Tue, 14 Jun 2011 14:56:28 -0000
Content-Disposition: inline
In-Reply-To: <8269100C7056D24A91B672AF7E5E48492D963B@exchange.GottexBrokers.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175776>


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2011 at 02:46:00PM +0000, Edmondo Porcu wrote:
> Dear all,
> I have tried to copy my objects folder into my git root folder.
>=20
> D:\vce\GottwareNet>git cat-file -p 00\1cd91a8a3a3c99ca7aea73c96b3d2174430=
947
> fatal: Not a valid object name 00\1cd91a8a3a3c99ca7aea73c96b3d2174430947
>=20

git cat-file -p 001cd91a8a3a3c99ca7aea73c96b3d2174430947

You need to specify the object name. In .git/, they're in different
folders for speed purposes, but that's an implementation detail.

Cheers,
   cmn

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN93acAAoJEHKRP1jG7ZzT7zwH/Rhs2E+QVzP8Q8ew2Z4B2ANf
lJnLn31DKODQrPmRpab724/Esn180qqvHCTy57ewAif666gqhguyFGMjhg+gSzul
JYXgsv5xqQzrGJtUpM8jpG5C/NFR/D+LC2pTov29z6/jargLKUhWUvDbW3PneGni
X8HrarIazjjYUXDnV65Y4+cNVBkZsUAE8A7nEAuvqDOYYbeigypVAhflEsfEA2zd
5kG+KEWkn5Mz72cQN/AnW8tCW1KkcafS23OlWNnjFbg90q+ynYXzdgl5BKnZGo4z
TVJ/DVm9CQcx7ekKHiFzjMG49gXFnOwl0VMwl/ip4AvUsP6LzfRqCD+yBD5nG2w=
=NttT
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
