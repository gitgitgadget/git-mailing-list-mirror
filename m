From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: "git apply" can't add new files to repo ?
Date: Fri, 15 Jul 2011 21:34:57 +0200
Message-ID: <1310758497.7308.20.camel@centaur.lab.cmartin.tk>
References: <CAAnh3_-ayozWnHR-ViJ3zjXQvPQA1kd9spGV_TEU=-kFzBytvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-sIEQmSIf5ZV2iapUEswn"
Cc: git@vger.kernel.org
To: Yang <teddyyyy123@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 21:35:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhoAC-00050N-2M
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 21:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425Ab1GOTe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 15:34:59 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:35875 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab1GOTe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 15:34:58 -0400
Received: from [192.168.1.17] (brln-d9ba3451.pool.mediaWays.net [217.186.52.81])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id F22B3461F5;
	Fri, 15 Jul 2011 21:34:56 +0200 (CEST)
In-Reply-To: <CAAnh3_-ayozWnHR-ViJ3zjXQvPQA1kd9spGV_TEU=-kFzBytvw@mail.gmail.com>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177216>


--=-sIEQmSIf5ZV2iapUEswn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-07-15 at 12:02 -0700, Yang wrote:
> I created a patch by "git format-patch", and this patch includes some
> newly-added files.
>=20
> when I got back to the original branch, and apply this patch, the new
> files appear, but they are not
> added to git repository, so I have to manually find all the new files
> and do "git add" for each of them.
>=20
>=20
> I guess there should have been a way to automatically do "git add" for
> all the new files in the patch,
> how could I do that?

git-apply is just a wrapper around the patch(1) utility. As you have
created a patch for use in an email (as that's the point of using
format-patch, so you have both the commit message and diff in one
place), you should use git-am, which takes care of all the "magic". If
you want to change what the patch does, you just need to use git commit
--amend

Cheers,
   cmn
--=20
Carlos Mart=C3=ADn Nieto        http://www.cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--=-sIEQmSIf5ZV2iapUEswn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOIJZhAAoJEHKRP1jG7ZzTYxIIAKN5jAN2u8LchZyzKrgMk8/S
QWkuyO6AB56/QDxC/7A9KGeY3UC+EmuXM3b9ho7B2a6eoYMIRMZ6luEFfsuMEQFg
klakoRGZHfEM1UGhJX2FwxQDoPQ1R6d7xNvWXrUr0EK6+RS08WUe41hvwCjLpENY
viyWH2Won8ggKftkJLreoskgawXjJhgu0NpqTfqTod4n9YClDoeGoK5yAqD5Kctz
q7auXtQ1dE2G3NL3Np/wGorfKrm6yZJKZdag4ctpS1ayQaXyCVZA3PTauvqFtq4x
VuOL+IL5DxwrWWeoRyYOQcklrvYZlBTIg/0lZbu+WeXVCEd2Pg0WeopZt5L/oGk=
=v3gD
-----END PGP SIGNATURE-----

--=-sIEQmSIf5ZV2iapUEswn--
