From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git-svn and mergeinfo
Date: Tue, 06 Sep 2011 16:28:22 +0200
Message-ID: <1315319309.9839.13.camel@bee.lab.cmartin.tk>
References: <20110829132052.0ad7a088@robyn.woti.com>
	 <4E5F4987.5040205@alum.mit.edu> <20110901104327.14d4dba6@robyn.woti.com>
	 <1315313800.9839.10.camel@bee.lab.cmartin.tk>
	 <20110906095256.205dd5d0@robyn.woti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-E6rolw19YMrqHpgjo0zX"
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 16:28:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0wde-0007Jq-Lf
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 16:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab1IFO2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 10:28:31 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:43610 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627Ab1IFO2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 10:28:30 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 584FB46170;
	Tue,  6 Sep 2011 16:28:13 +0200 (CEST)
In-Reply-To: <20110906095256.205dd5d0@robyn.woti.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180804>


--=-E6rolw19YMrqHpgjo0zX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-09-06 at 09:52 -0400, Bryan Jacobs wrote:
> On Tue, 06 Sep 2011 14:56:38 +0200
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> wrote:
>=20
> > You can also save the mergeinfo to a file, add the line, and use
> > --mergeinfo=3D$(cat /tmp/some-file) to set it. It is indeed awkward, bu=
t
> > blindly replacing every space with a newline is not always the right
> > option. If a merged directory contains a space, this change will break
> > the mergeinfo, even if you're properly quoting your variable or using
> > the $(cat /some/file) method.
> >=20
> > Cheers,
> >    cmn
>=20
> Ah, a situation I neglected to consider! Perhaps we should revert this
> patch, since I worked up the initiative to write an
> auto-populating-mergeinfo patch for git-svn anyhow.

As it can cause regressions, I think reverting is the right option. And
since git-svn is going to learn to do it by itself, the functionality
isn't a big loss.

Cheers,
   cmn


--=-E6rolw19YMrqHpgjo0zX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOZi4GAAoJEHKRP1jG7ZzTC/gH/1ag1FlVXvE4kogL1WJkLiF7
e7D4cmhY1pxq2tJ/zkCIr2ssLiIiVgwNLpcDuRubOtvxWYbHs5K3iQPq0NzwdTIk
RGA75wPC3Km189rQlMao/8jbBMPjKqTuB6bhMkmEswEYEwkRyAcMcvNwsrdY37Zz
rheOkjEojubDwShDJ07xpaajulxDqRs+qjGodsHpnsdcXTEWAwx7AtF9UsfjJgDo
jJYrRcvbkqDaa23Tz93e37eCNQM1ug3P1PT6baGiV2pgSU5QPjurgbmZOsk0YrPp
0y+vKtKkF+53yWq7K7CHUgw4EQrBQN5h6uFQuU9jL33DzyyM1P3O3/fAWpQ+a7E=
=h/Lz
-----END PGP SIGNATURE-----

--=-E6rolw19YMrqHpgjo0zX--
