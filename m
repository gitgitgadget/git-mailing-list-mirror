From: martin f krafft <madduck@madduck.net>
Subject: Re: working prototype of orphan parent commits as datastores (was:
 Storing additional information in commit headers)
Date: Tue, 2 Aug 2011 21:26:31 +0200
Message-ID: <20110802192631.GA20239@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
 <20110802082810.GC29887@fishbowl.rw.madduck.net>
 <20110802150321.GA1390@fishbowl.rw.madduck.net>
 <20110802185708.GB2499@sigill.intra.peff.net>
 <20110802190923.GB16674@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
To: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Aug 02 21:26:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoKc8-000810-MQ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 21:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab1HBT0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 15:26:48 -0400
Received: from seamus.madduck.net ([213.203.238.82]:55692 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286Ab1HBT0q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 15:26:46 -0400
Received: from fishbowl.rw.madduck.net (28-193.78-83.cust.bluewin.ch [83.78.193.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id C0325407D3B;
	Tue,  2 Aug 2011 21:26:32 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 994881FE57; Tue,  2 Aug 2011 21:26:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110802190923.GB16674@fishbowl.rw.madduck.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178504>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2011.08.02.2109 +0200]:
> Yes, absolutely. However, this would no longer be the case if
> x-*-ref could be used. Right now, I am just using orphan parent
> commits to avoid garbage collection.

refs/heads/master is a file, containing its payload in the first
line by format definition, right?

I mean: the storage is right there, isn't it?

Of course this opens a whole new can of worms: merging per-ref data.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"'oh, that was easy,' says Man, and for an encore goes on to prove
 that black is white and gets himself killed on the next zebra
 crossing."
            -- douglas adams, "the hitchhiker's guide to the galaxy"
=20
spamtraps: madduck.bogus@madduck.net

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOOE9nwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xMep
D/9AKJyW++bZ3ynnsNDS3Ikq4J76A2J/OCtI2j3hrP28x4q7pV9a7rOtyoVEaUI4
oYhULb+yslvxXATwSObOLGHN3krBtTwiMuJusJ2mPFhvjHgz9avL2HEaEmUmd6S8
M1gYzxKM1TIDutSwqmVHtXIJjmOOK1J1T9PeCZQWP3djqA2VW7qb46q+XN2oMTqU
XQXXlaGzbqc03sGr0/9UDHP3Xewb9S6T7l+1v+TB8yv49PL61CpftE//QBRhJKWE
+iMzBKlubelz1s/EZc5NmkjDNYraPr/Fl3sfXdqQGH4/Itp7HmHce8yYMbXIxAYQ
2Wr79NnA/QoJ9LIQLlC+92enVCYlD4cF/ilDVd61jQ5yBFoZDnr8kujiZkU8RXrA
l/4EzET3meWY5xt9spAsBBw4scqyLNrOHt3fJ1KNrsnwZ31eqkzl+I3XR/Og+r5z
+Ycy1UvENudmf9m1GLerHVdz4tZ0xgv1qIFH1UzUJGWOnWzY7hJmMO7hDPZeLo8Z
O4fmWKuw/9KXYKtdQ8YWy5uut05GtX6eFBrW3yWlCVqDAvDo4wfcoOBxqIn2VcfX
N9hHXpkoXnznGhN7RW0AsY5WmYFMXC3dMQPtsJr1hMKD6NoTCBc4WHm6NCzd/gSH
ITbX20sP1BN2hsO6TeR6O7BnuRBRYq5lvaJ9WGc0bkY94A==
=vWLB
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
