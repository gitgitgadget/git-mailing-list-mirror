From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] cherry-pick ignores some arguments
Date: Thu, 14 Jun 2012 18:29:49 +0200
Message-ID: <1339691389.4625.9.camel@beez.lab.cmartin.tk>
References: <20120614114415.39cbb64c@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-dLv17qyw5UgP38DaaL2Y"
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Thu Jun 14 18:30:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfCvs-0002l8-AJ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 18:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab2FNQ3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 12:29:53 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:54870 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106Ab2FNQ3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 12:29:51 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 3F2A546149;
	Thu, 14 Jun 2012 18:29:44 +0200 (CEST)
In-Reply-To: <20120614114415.39cbb64c@chalon.bertin.fr>
X-Mailer: Evolution 3.2.2-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200018>


--=-dLv17qyw5UgP38DaaL2Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-14 at 11:44 +0200, Yann Dirson wrote:
> Hello list,
>=20
> I just did a "git cherry-pick AAA BBB..CCC" using 1.7.10.3, and was surpr=
ised
> that only the BBB..CCC range got picked - AAA was silently ignored.
>=20

There is no way to know whether this is a bug without knowing how AAA,
BBB and ccc are related? From the names, can we assume that AAA is a
(grand)parent of BBB? If that is the case, cherry-pick is behaving as
expected.

See the DESCRIPTION in http://git-scm.com/docs/git-rev-list for further
explanation, but the short of the story is that the second argument told
it to ignore any commit before BBB, so AAA is not in the list of commits
to be applied.

   cmn


--=-dLv17qyw5UgP38DaaL2Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJP2hF9AAoJEHKRP1jG7ZzT46sH/jcCD89Ydg2LBpFxR6VE0QSw
8f9JQwsI4gGHf+LF3cYoA5T318KKanThXTYT1MSRizXHptf1kF8aLEvZEj0njN7y
nAeK4DY0TtrwKkWkfjEU8y1pvnDDikKw3IT6bw6dFC14SkKGAmYcl0eHYHeG37ya
Sik35C6zFCF7HM36prze5rrr87QnP3OpbeA5ZeJrOwHeaxbIJGlZiUe80GUbAdGW
oGSyoFmkRUtJsZ8v6DhrUpVtIdgnizhBA2WTfwVdUHFMgmScltp9eymBC0nZulaV
CMFND+Wthg/w8q9ls6EByFOyhx2XFVYl+xYTINwMKyctZe820aL4yFxmfHf8q9w=
=JCuo
-----END PGP SIGNATURE-----

--=-dLv17qyw5UgP38DaaL2Y--
