From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] "git diff FILE BRANCH:FILE" erroneously report FILE does
 not exist in BRANCH
Date: Sat, 21 Jan 2012 22:33:28 +0100
Message-ID: <1327181608.31804.27.camel@centaur.lab.cmartin.tk>
References: <4F1B13BB.8070603@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-c48RplZH9VRDf9eKRMpT"
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 22:33:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoiZ9-0005HY-Te
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 22:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab2AUVde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 16:33:34 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:56890 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab2AUVda (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 16:33:30 -0500
Received: from [192.168.1.17] (brln-4db9ca9c.pool.mediaWays.net [77.185.202.156])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id BEE7E461C3;
	Sat, 21 Jan 2012 22:33:27 +0100 (CET)
In-Reply-To: <4F1B13BB.8070603@gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188932>


--=-c48RplZH9VRDf9eKRMpT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-01-21 at 20:36 +0100, Stefano Lattarini wrote:
> I'd expect the last "git diff" to report the same diffs as the previous o=
ne;
> instead, it errors out with this bogus message:
>=20
>   fatal: Path 'README' exists on disk, but not in 'master'.
>=20
> Behaviour verified with git version 1.7.7.3 (installed from official Debi=
an
> packages) and the latest git development version (1.7.9.rc0.69.gbddcef, f=
rom
> master).
>=20

See http://thread.gmane.org/gmane.comp.version-control.git/188355 for
earlier discussion. I haven't gotten around to see if I can fix it
without upsetting too much code.

   cmn

--=-c48RplZH9VRDf9eKRMpT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPGy8oAAoJEHKRP1jG7ZzT/igH/27sPM4Q2iKaJispX5LaYYh5
WiSrk4xIQLKfOfTszKEFY7GsNEpPazv9KuKnLkBp/oaENoSTCCwXAmJyjB63etzY
orUoAq1/6hnHoVj9og0seQNPJ34mBGRJcDTIQIUh8w6cqrTxo4RrkE+OqDJggKfL
3yC9WJX52+9TKKH1z6iagwL/T4uCydJ6RGmE9VmGLl1bBDYLZ5059XZwkKwE99Bh
mPhUra4KKJDUpxOwGZAq9f2r8pTcgTOGT9RC+tQRqsEzB7xXFMqiK1FTQUpaA/hi
v1B8X15jAy7oVfd7a73xJWp/liyrm5zKWQ/0+wzzO9QrBc6A6e5h2dovyVXRU88=
=i/hD
-----END PGP SIGNATURE-----

--=-c48RplZH9VRDf9eKRMpT--
