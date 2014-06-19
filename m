From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Error 128 Clone succeeded, but checkout failed
Date: Thu, 19 Jun 2014 00:24:44 +0000
Message-ID: <20140619002444.GM368384@vauxhall.crustytoothpaste.net>
References: <05c29ee7-8629-424e-b2db-de49db976e55@US-BV-EXH02-P.global.tektronix.net>
 <20140618235539.GL368384@vauxhall.crustytoothpaste.net>
 <C8DDA0C887F79C468978FDEF2DA46F9F0145B453@US-BV-EXM01-P.global.tektronix.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="prC3/KjdfqNV7evK"
Cc: git@vger.kernel.org
To: "Dodge, Warren L" <warren.l.dodge@tektronix.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 02:25:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxQAQ-0000Gx-OZ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 02:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472AbaFSAYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 20:24:50 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48418 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756218AbaFSAYt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 20:24:49 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:4482:19b0:51d5:328f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AFD892808E;
	Thu, 19 Jun 2014 00:24:47 +0000 (UTC)
Mail-Followup-To: "Dodge, Warren L" <warren.l.dodge@tektronix.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <C8DDA0C887F79C468978FDEF2DA46F9F0145B453@US-BV-EXM01-P.global.tektronix.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252083>


--prC3/KjdfqNV7evK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2014 at 12:11:43AM +0000, Dodge, Warren L wrote:
> Hi Brian

Hi.  Please do keep the list in CC.  Someone else may be able to help
you better than I.

> c:\Program Files (x86)\Git\bin\git.exe" --version
> git version 1.9.4.msysgit.0
>=20
> I also had 1.8.?? and it did the same thing so I updated to try that.
>=20
> This is exact.
> "c:\Program Files (x86)\Git\bin\git.exe"  clone --progress -v VHDR_GIT_RE=
POSITORY fail
> Cloning into 'fail'...
> done.
> fatal: unable to read tree a7b8f40dcafba3ec534db6d11e4b928775f26bcd

This means that git is unable to read this object.  It could be missing
or corrupt.

What do you get if you try to run git fsck --full on this newly cloned
repository?  I realize it won't have a working directory, but git fsck
should still run.

> warning: Clone succeeded, but checkout failed.
> You can inspect what was checked out with 'git status'
> and retry the checkout with 'git checkout -f HEAD'
>=20
> I didn't get the status code but is was 128 when I did this in bash
>=20
> Our file servers are many terabytes and use DFS to break them up into
> the file systems that are used.

=46rom what I can tell of DFS from Wikipedia, it's using SMB under the
hood, and I'm not sure how well git works over SMB.  Maybe some of the
msysgit folks can chime in here?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--prC3/KjdfqNV7evK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJToi3LAAoJEL9TXYEfUvaLHzIP/2ivzQdvaBEau12++sOogP4t
ON0kbtEbbkVFA60WgkFapm6yUS+v/tUEGqkCqx09UkEZ1JNxxoG7pYkMM6q4/WKa
RoyzDjtKNShw6VGBKQpIxIIL71RnQywK2sWUbdA14BgzQ+P0US2Jq7z6EgadFpmU
SH7m7w+pOwGNSiLxreUeo3s0RZji7ZrSNUV1kwUrUku+mnvp7cXJE6V7W4Gd2Zpr
6zKwerW1LcN+FG5QKxvd7gDbVGwstFrDflwUnubcwJ9RH7TZThXXsbwsC+L9wNkv
3k2PG4DlKhVx+DCcFpUPM1AV6g7AHRGDJSkqRee5nIkXbgjQjxmrxcyRF1zhW/BC
O1RObEM88k4ad6gjd2VeqVRO9fAma0MmNw389JnqQW9o1gkDN/Q9nmZufcHB8zXR
+9X0RzgkBdK6SAQc0pmVlYesRnuoEOqP2MLqz5HAIpmMrSK8uxzA1F3gYaAG+GG5
bpsI3ERJUYTS4lpQFD1jpR+COuPwXnJp1kjDHQlE+E9w5E5IF4Qt++Hkiz0yRCrc
ZQeWR8SbeT3FzeLWfL0nxdmtR30CMW0MNhcOmbl8j9o59dYK5wjFGZ2OUrkrmujG
gP97hRLOuAhFp99QgQIrphBk+4L9MJRr8dUuy+aqSDVn/YwWrBf7iLsZ8i+tpiwV
BAlLvUnxm4ShgtinO+xT
=BqrG
-----END PGP SIGNATURE-----

--prC3/KjdfqNV7evK--
