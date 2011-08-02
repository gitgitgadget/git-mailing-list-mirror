From: martin f krafft <madduck@madduck.net>
Subject: Re: working prototype of orphan parent commits as datastores (was:
 Storing additional information in commit headers)
Date: Tue, 2 Aug 2011 21:09:23 +0200
Message-ID: <20110802190923.GB16674@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
 <20110802082810.GC29887@fishbowl.rw.madduck.net>
 <20110802150321.GA1390@fishbowl.rw.madduck.net>
 <20110802185708.GB2499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
To: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Aug 02 21:09:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoKLX-0007yK-8u
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 21:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068Ab1HBTJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 15:09:39 -0400
Received: from seamus.madduck.net ([213.203.238.82]:43646 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab1HBTJi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 15:09:38 -0400
Received: from fishbowl.rw.madduck.net (28-193.78-83.cust.bluewin.ch [83.78.193.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 14A87407D3B;
	Tue,  2 Aug 2011 21:09:25 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id EF3B11FE57; Tue,  2 Aug 2011 21:09:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110802185708.GB2499@sigill.intra.peff.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178502>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jeff King <peff@peff.net> [2011.08.02.2057 +0200]:
> Look at "git show origin/master" here. It ends up as a combined diff.
> Which is kind of ugly.

Yes, absolutely. However, this would no longer be the case if
x-*-ref could be used. Right now, I am just using orphan parent
commits to avoid garbage collection.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"he gave me his card
 he said, 'call me if they die'
 i shook his hand and said goodbye
 ran out to the street
 when a bowling ball came down the road
 and knocked me off my feet"
                                                        -- bob dylan
=20
spamtraps: madduck.bogus@madduck.net

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOOEtjwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xADU
D/9eRiCreEPGD+MhWPrCd93AF+/v4rywz1UzPZ5i/n8asEPkIIgaVNIa5q9ZGiQw
ra+Mv3N/tgQo3riGBiRthQ13KBMD18309i1KRwQ49mVCKIMDeUbIbvvOFtN3iLYV
HL3YUwS61BnlrHUHCdQ9SBuUWOKc7QFA/HOK4PYSvTmORKWz0WhgIT+TRU57Bkhb
e7RJEIGj5nfz9HuuIUkMPJ7hwJHpUhouXuZ8rvgjtai6yyZ6wtI2mygZo5iZ2q+w
v5NcutgkDehgMtV5QUGkyF+g02DZH6vUNfhJks69GAv5aWf6/tOmYPkzOmN++2P0
f3nUFAErMo4NDieMxriusFy5DuyEmQHpTrNa6gj6qYN2SJXZDzgBZ2xm5H1NlIUB
URXV7T2HnEcKG5DE8mYN81U0uxygaERe5D5pQT4t8pavo05gxCBKZ6xKRM5sWuhj
gNprMkTSnpXJCp0x2VQn7CZxF/r0EFdyN2Km76nAjrXQ88+ajGsd6Pu2fePj36iI
t1nF4kBdVYcdSKZaeXWJFtUXyWsLyjESgN0Nuq/53iSNZ+0+pvCpjoSTBC7542dg
D1cB9/4EiyHVL2gsDXoWryf2xjaUxXDdKgmeAMBuSKZ1j0w+gKrVWvy5tOjioRzz
U/sWjkgqDN56sWcSyrwV+VOAG22W6cH1dxY47lBPd0dOxw==
=yVd4
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
