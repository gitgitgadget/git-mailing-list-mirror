From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Fri, 18 Oct 2013 22:15:35 +0000
Message-ID: <20131018221535.GM865149@vauxhall.crustytoothpaste.net>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
 <20131011235052.GV9464@google.com>
 <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/NwG7NuG0/W8LcLh"
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 00:15:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXIKf-0006qf-JU
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 00:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab3JRWPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 18:15:42 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33155 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756553Ab3JRWPl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Oct 2013 18:15:41 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:bd11:cacc:8cde:90e9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6E6F1E;
	Fri, 18 Oct 2013 22:15:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236373>


--/NwG7NuG0/W8LcLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2013 at 12:26:39AM +0000, brian m. carlson wrote:
> On Fri, Oct 11, 2013 at 04:50:52PM -0700, Jonathan Nieder wrote:
> > Perhaps this should be conditional on the authentication method used,
> > so affected people could still contact broken servers without having
> > different configuration per server and without having to wait a second
> > for the timeout.
>=20
> curl determines what method, but I guess it's safe to assume that the
> authentication method used for the probe will be the same as the one
> used for the final connection.  Unfortunately, all curl will tell us is
> what was offered, not what it would have chosen, so if GSSAPI and
> something non-Basic are both offered, we'd have to make a guess.  (curl
> will always prefer non-Basic to Basic for the obvious reasons.)
>=20
> If you can argue for some sane semantics in what we should do in that
> case, I'll reroll with that fix and a clearer wording for the docs.

Reading Jonathan Nieder's responses to the first patch, it looks like he
was going to apply it, but I haven't seen it make its way into next or
pu.  Junio, do you want a reroll, and if so, do you want certain
semantics for autodetecting this case, or are you just looking for
documentation fixes?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--/NwG7NuG0/W8LcLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSYbMHAAoJEL9TXYEfUvaLqmAQAIOL5cOu0x0GLil107XFNwoK
/Q1WBp75z9aWH0w9JqRDf3hERpxJ+XEQt8/iGDot4Mkz0V80bas7D/kyZ5M5WETg
Y4nDFCr73vKxmVwA7k4jwSkOnaf3OBooE5svgM6lnF9/geipRSNY8CI+P6VNuL1Y
hh6YbEkMXdutoDcNKueaqr1b+zFG3ZahCH9BZ9OUK05obrs7KpiR5k/3p2YRDvxJ
UER92JemR6A5YDmPtfzyesDJAlX0KnXCsxu0lSuLvJk9SyKVq8Fg6+UdCWdHbNUa
O9/xzp/VjIWdtjV0y5vX/3XaJnm0H94WEnpHchOHp1H3jLIEDcsikJl7mVTi1+W5
+yL7nBLBK0Mm0oGvR45fvk0fpMocFW86DA6TVTlrrrFHFkrDAUi5bStMLgddlX44
NeaehQ4NxL85l1tG8EqupqZKTIY2/RO/9+njxXHM3m5CsrslmCPGjHINYS08dtUm
+mg+Fby5m1Ccr6kQ+LOujj83kpnHVeLDXwNwzA0bZzp0NYJj5P54h4VDfERnRCez
KYaWJwA9IRpp4ORww+mbuhBCmRPtfKE3NEly5ayRORpJS5dS6H7dskw94XTpvcrQ
cCk0aXGq1aZAbfEdcBmSdzHq/sKswd7ivYTgxbznmv3MQgVjGeLcafVFFy7udv57
Vm+rf38WMn0d7RP1qQhg
=MDaF
-----END PGP SIGNATURE-----

--/NwG7NuG0/W8LcLh--
