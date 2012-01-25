From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git version not changed after installing new version
Date: Wed, 25 Jan 2012 19:57:21 +0100
Message-ID: <1327517841.31804.75.camel@centaur.lab.cmartin.tk>
References: <loom.20120125T173801-500@post.gmane.org>
	 <loom.20120125T181639-351@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-+sC1pWdOjCx10Rrmm0aU"
Cc: git@vger.kernel.org
To: freefly <free.fly@live.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 19:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq82A-0007TG-7v
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 19:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab2AYS5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 13:57:22 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:38830 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084Ab2AYS5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 13:57:21 -0500
Received: from [192.168.1.17] (brln-4dbc4241.pool.mediaWays.net [77.188.66.65])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 8D60246092;
	Wed, 25 Jan 2012 19:57:17 +0100 (CET)
In-Reply-To: <loom.20120125T181639-351@post.gmane.org>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189118>


--=-+sC1pWdOjCx10Rrmm0aU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-01-25 at 17:19 +0000, freefly wrote:
> Thanks both of you for your replies, I have checked but,=20
> it still points to the old "/usr/bin/git" not the=20
> "/usr/local/git/bin" :(

What do `which git` and `type git` say? Bash remembers where it ran a
command so if you install a binary to a new location, it might not find
it straight away.

>=20
> when I run the update path script I get this output.
>=20
>=20
> No change to PATH in ~/.MacOSX/environment.plist
> ~ /Volumes/Git 1.7.8.3 Snow Leopard Intel Universal
> /Volumes/Git 1.7.8.3 Snow Leopard Intel Universal

So the script detected that no change was needed presumably. What's your
$PATH and is /usr/local/bin/ before /usr/bin/?

   cmn

--=-+sC1pWdOjCx10Rrmm0aU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPIFCRAAoJEHKRP1jG7ZzTZZoH/2DxbdjihC4824woz0CKlco+
vC6HUP0v63jYIwTsqXiNvL+ZHslbKDW6ZIoHoMQsS8Hz/6ARfMxsv7xqz2/BLRkf
2y3Fzz6vBLfiH5rlWYj55QF0RFdAZRCqG536cTzJ2svBYlJZnI93GumNTg71q3IF
UIlvSA39+s1n0S8VX74Xhm7BPE87GRfgKzFqyD48ph+Z/trx673MZL+gq/mJSHOa
JFWAkBbDNNLxzqFXqxmATP73hQbzc8GEZELHuqyxUElQEO+lhnXW1NAgUwYg1MW+
qBPLE9CF0zKdJWknm96WECCejisGS1I8xOZdwVhSo57Tb2t89V+Vd8hY2cC4J6U=
=gWHe
-----END PGP SIGNATURE-----

--=-+sC1pWdOjCx10Rrmm0aU--
