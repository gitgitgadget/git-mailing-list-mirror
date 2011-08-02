From: martin f krafft <madduck@madduck.net>
Subject: per-ref data storage (was: Storing additional information in commit
 headers)
Date: Tue, 2 Aug 2011 21:27:28 +0200
Message-ID: <20110802192727.GB20239@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
 <20110802082810.GC29887@fishbowl.rw.madduck.net>
 <20110802185154.GA2499@sigill.intra.peff.net>
 <20110802190645.GB17322@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
To: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Aug 02 21:27:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoKd1-0008QV-IG
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 21:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab1HBT1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 15:27:43 -0400
Received: from seamus.madduck.net ([213.203.238.82]:55704 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286Ab1HBT1m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 15:27:42 -0400
Received: from fishbowl.rw.madduck.net (28-193.78-83.cust.bluewin.ch [83.78.193.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 18F05407D3B;
	Tue,  2 Aug 2011 21:27:29 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 16D021FE57; Tue,  2 Aug 2011 21:27:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110802190645.GB17322@fishbowl.rw.madduck.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178505>


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[sorry, my previous message was a total reply FAIL]

also sprach martin f krafft <madduck@madduck.net> [2011.08.02.2106 +0200]:
> It just seems to me that per-ref storage is a lot further away than
> per-commit storage, and I'd really like to move forward with TopGit=E2=80=
=A6

refs/heads/master is a file, containing its payload in the first
line by format definition, right?

I mean: the storage is right there, isn't it?

Of course this opens a whole new can of worms: merging per-ref data.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"nothing can cure the soul but the senses,
 just as nothing can cure the senses but the soul."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOOE+fwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xP5a
EACb+jLzOMQvRzl3EFzbLAyN/SCyNB0EXGs5sVOPl/j1RXhTXcEV7QckUmGB6KTU
ftiLARyyrOc0pPtHAB5xRYBNAwZSuLP/FV0QQuzWlGiStUGM55dfhiqW+DEafORv
LQHfk8JhVtsDUG1ds/74MMs8AgpWot5dZIHHCJW/suufKyQeaq2IrtZ6aX1L6dlD
P65teFPhducvDQc/BpJIn+qvmFhh1jTxr8xKeEdKhVgaUKvDvPI8AOKX3tpA3wgO
Fep53RlqHKSuABTPfFzpnxIDTb87t/FTjSc6JXfkueX7VBHbH3yqgMmnNZWDEy6f
/eDQVtfVSIRCVHh3L5YWxjbuD/81SNqAn5nba59uoh83ZHnbA1idzgcin/pFMCFU
+qul4ByN/Fcp3KGt/Hzy8orVXU6aPGaimrJiVHsFlsVgl9huDapEfla45ec+JOG6
hDRfMkUOU/tojyQf2EKoyuX/+MJUF5IboN2Ay0ocqSDJM9VATcnquTzQYLbJ6EjR
972qjgDHVWMdjL0qQKM6GZkTxfy/+Hv9Ce+imNQW4JkgreSwaH7WJCz7kX7EKk4y
5xEQVd/UEXM6dLyvScDsWUa7L9/C6A4YggiZf1vOhDtXsIqc0UeNyCuP0Qn6vSP0
nniJ8niKb3oeWuE31OnriSPnUOfIWL9oUoopIXEv1IP72w==
=Xhsv
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
