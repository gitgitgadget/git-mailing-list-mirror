From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] Documentation: add a script to generate a (long/short)
 options overview
Date: Thu, 31 Oct 2013 23:45:14 +0000
Message-ID: <20131031234514.GC41460@vauxhall.crustytoothpaste.net>
References: <5272E1B9.6000705@googlemail.com>
 <1383260682-12364-1-git-send-email-stefanbeller@googlemail.com>
 <5272E316.5090108@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Cc: tr@thomasrast.ch, mhagger@alum.mit.edu, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 00:45:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc1vY-0007EE-Ll
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 00:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009Ab3JaXpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 19:45:20 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33457 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753350Ab3JaXpU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 19:45:20 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:21a5:310a:1a75:4292])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7A2F22807C;
	Thu, 31 Oct 2013 23:45:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5272E316.5090108@googlemail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237195>


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2013 at 12:09:10AM +0100, Stefan Beller wrote:
> On 11/01/2013 12:04 AM, Stefan Beller wrote:
> > Recently a discussion started on the mailing list, which short option
> > shall be best for a long option. (-f being always --force and therefore
> > should not be reassigned another meaning in one particular command)
> > See http://www.mail-archive.com/git@vger.kernel.org/msg38456.html
> >=20
> > For discussions as these we need a script to easily generate an
> > overview of all available one letter options, and their long option
> > equivalents.
> >=20
> > As the list of options was not retrieved fully automated,
> > there might be minor errors or missing items.
> >=20
> > Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> > ---
> >  Documentation/generateShortOptions.py | 460 ++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 460 insertions(+)
> >  create mode 100644 Documentation/generateShortOptions.py
> >=20
>=20
> When trying to send a follow-up patch with the table itself, I got:
> fatal: /tmp/wHpJlnf1r5/0002-Documentation-add-table-viewing-short-long-op=
tions-f.patch: 19: patch contains a line longer than 998 characters
> warning: no patches were sent
>=20
> Is this an artifical limitation or something that actually makes sense?

RFC 5321 forbids lines exceeding 1000 octets (including CRLF).  RFC 5322
forbids lines exceeding 998 characters (excluding CRLF).  If you want to
get around that, you need to base64-encode the content, which is
generally discouraged when sending patches, I believe.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJScuuJAAoJEL9TXYEfUvaLJyEP/2x2Jn0CrJWcU3f12ZuioVQY
b4xun7pAxBu6H7oT5C+IsS0vpr1XhF9ZVwyz0uhDvZwKQVNhli+VEfWAez7/Wudp
ITrmiWCIZZ4oncwrXg8KpiuMd2YbsKje/96ck/kc0S8MCCwxVo91F5Cvewd9sKWh
8mrdMCIrPfft4bm3ib+dYe2BSFpuQGQl7pivdUyMW+R+++xU5dTbRdXIPPv11vhV
j/SG4uPHJaObtrNVtUYbq4AR16APhDPxXX9HWXM9BE2E7oRxTqsVIxKNItKMe0aF
hFkU1ilkNPUJSbWWeo5vnl7TBdDa6Gf5sFDUQdMILK0poUOtEzdNi0oUHm4f6isp
MDYqsJH/H+7NF562YjiIdwDpKHWRUtIzFyRuD+iUhn+qOo8Y1uZO0+K7K7iSIxZx
ZnDuIUKETBCS57JV92liiJIYn51I61EuVLA/rE2x6GtLpBKwHiWIB8F7S+a2SZpI
25C8VYuw5OzHIlSQWeb6A52VqrJmW9c13J4BKeZcMiWOB64h2s2onfSPxWWGwOXw
tiFK0GKSK8rqjGshQ+K9CEvncCDExfxQ6t/ETG8F0rwPITRfOyGARUfhFuTLmdmL
e+ddFHMrztqOrTaIqZ/7dsIg13dMcLiJSoMDU/DloJrV64TUpROTanfIyWpFUDfw
HknLl1OJS98soIDesFTW
=QMyd
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
