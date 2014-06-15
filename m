From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] gitk: use mktemp -d to avoid predictable temporary
 directories
Date: Sun, 15 Jun 2014 22:16:32 +0000
Message-ID: <20140615221632.GH368384@vauxhall.crustytoothpaste.net>
References: <1402695828-91537-1-git-send-email-davvid@gmail.com>
 <87k38ir4p0.fsf@red.patthoyts.tk>
 <20140615163227.GE368384@vauxhall.crustytoothpaste.net>
 <20140615214928.GA619@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="svExV93C05KqedWb"
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 00:17:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwIjR-0001N6-Cw
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 00:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbaFOWQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 18:16:46 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48356 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409AbaFOWQh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jun 2014 18:16:37 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:410d:6806:9865:2e4b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4C0462808E;
	Sun, 15 Jun 2014 22:16:36 +0000 (UTC)
Mail-Followup-To: David Aguilar <davvid@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140615214928.GA619@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251699>


--svExV93C05KqedWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2014 at 02:49:29PM -0700, David Aguilar wrote:
> I don't think this requires a CVE since it's basically plugging a hole
> that my previous patch introduced by making gitk honor the TMPDIR
> variable; it hasn't strictly been in any release yet.

Yeah, that's not needed, then.  I didn't notice it was the immediately
previous patch.  My bad.

> Hmm.. I guess what I could do is keep the old behavior (having gitk
> ignore TMPDIR) on Windows and only use the new code path on
> non-Windows.
>=20
> That seems like it'd be the simplest implementation (no need to check
> versions) and the least harmful to existing users (avoids a tcl
> upgrade or mkdtemp installation for Windows users).

Yeah, that would be the safest bet.  Maybe a comment to that effect
would be appropriate, so that when Tcl gets upgraded, that change can be
removed.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--svExV93C05KqedWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTnhtAAAoJEL9TXYEfUvaLkWAP/j25+/9JLN9uK9OH69NcD2Ln
eht3c81iFHTXJJc4SfiOHCepaNqydKKiMYsP2BH4ZVTirM4MI3dJYu3HKPxd/tjo
kAid+zdm8OEbFZOXOFduEHLJUlwx1s9olcsOHSJuj5MGe/v3X7JMmX9MzYHFcaSD
IzXo6sFCW4B+rjVmMfZFtgjwf2btap4Xo3DF8ICcQo7oLkpRfzLTAiYERv07ZaQ3
yFnSpfeZq+MaiKGwh4t8383OAE5Eso9dK69lGOrwaPHgmcKwcgpfcXBm9lW+ROLV
QxBmp9iyUTvgu5/2PA1A+7bHmxv6oJ6UuPpL9T6wjfRj9Sh8ISoLQsrwXoaUGuzW
v+p/QYnroZIFhQr9yWKzC9MEqnJa+9g/bQdDU8gwULdtjIsCvOiHJ5soZhduJo3P
ljYDgvZ39ZM8XBtxh7kN8+4S0WBMv9Y5cDDj31Dzy0+6vQU8DkB4Ry0oYKBk/913
C/JPTsm1zjT2jVlk+BH53CTLfAphAMOJlOuqt9712riiRTEF026439yJoBA8ZR/g
w3PPkp2leDXV/ruA/Tyswg7isVRKBDgzbVOaoqJaa8691ZUFzZJ20lys2+4yn3Cq
tHA0JY4GG1RxCdvw5UnjQz4X9F+D0bU/iCZ9bDH0V73TWR5HC6ICupiMFazqDwIo
IBlj8NeJdHYcClRsXh3/
=F9S1
-----END PGP SIGNATURE-----

--svExV93C05KqedWb--
