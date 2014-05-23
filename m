From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 8/8] http: default text charset to iso-8859-1
Date: Fri, 23 May 2014 02:02:24 +0000
Message-ID: <20140523020224.GB284865@vauxhall.crustytoothpaste.net>
References: <20140522092824.GA14530@sigill.intra.peff.net>
 <20140522093612.GH15032@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 23 04:02:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wneoh-0001ZV-CY
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 04:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbaEWCCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 22:02:35 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47915 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751805AbaEWCCe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 May 2014 22:02:34 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:9d23:25b3:8261:f09a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 412F028087;
	Fri, 23 May 2014 02:02:32 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
Content-Disposition: inline
In-Reply-To: <20140522093612.GH15032@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249969>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2014 at 05:36:12AM -0400, Jeff King wrote:
> If we do want to do magic like "latin1 is really iso-8859-1", that seems
> like the domain of iconv to me. If iconv doesn't handle it itself, I'd
> rather have a wrapper there. Putting it at that layer keeps the code
> cleaner, and it means the wrapper would benefit the regular commit-log
> reencoding code.

I think being a little stricter in our character encoding actually
benefits users.  If someone claims that all their commit messages are in
US-ASCII or ISO-8859-1, and then stuffs Windows-1252 in there, that's
going to break a lot of stuff, especially if someone assumes US-ASCII
means it's okay to use it where UTF-8 is required.

It's much better to let people not insert broken stuff in the first
place rather than deal with it afterwards.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTfqwwAAoJEL9TXYEfUvaLeS8QAJyofmf0tF9QVcfhYGPgsHWV
bHgYccNsAobfDVReZMwuaxgp96E9n1jL+BcIxWNTLVfBGA/H9CIPxrPQKzKpiD2U
7oUEn9/u10/pqJ6Ubzo2lV1k7jP6Z44aIELd2gMslghV4Zrt6H8Huf6A+g8VuaRE
PUIgy+eoHtSDvXI40jSe96A9JwsWieOqo2YuWwGiG1gYxJQ5INr1mIYJNXqvl7sa
VgeKxgsrpI0W3Oil0scye4oEnAkxoTgPvamA6ovtYGqRuJQYkr5KU8PgRA0zaA75
Ci3gcK3VN6mLv2br+zJpxhofcKbniWe8LDKL4ZiaumuIWrN05+KKDxrWrrYX3Wsz
qp9n90sJ0cxDrXOFASGo/32X+c604oI6azAy551DfCj6K4G9GY9DFrQKj+OwuJ8s
7/83NR0Mluw37rBQ1N8vMpOGS4x4KWVkK/V9iEToJa1RIKJkfTjxRx9J6zIR6hiv
AAR4RviLXdYr9Nqn1jzygkg2xIOCPkYjRM1ofQIeSBskGHjus5fkc1fuot4lf0OH
0axwUjhX+koPk5un/WLQwaQJQOPJpFc3DW5DJoM45yyTZ13igN6cWFHYZM4dBSvb
w51bFAUfaeHakkiXN7RLVnupGy3bUPC9Ph8tcMRCZJ3p3LU3dWdG+ZFhjHnw28MW
6fu+T4qDMpdx8JwYOF7s
=fjuu
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
