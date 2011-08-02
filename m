From: martin f krafft <madduck@madduck.net>
Subject: Re: per-ref data storage
Date: Tue, 2 Aug 2011 23:12:41 +0200
Message-ID: <20110802211241.GA29029@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
 <20110802082810.GC29887@fishbowl.rw.madduck.net>
 <20110802185154.GA2499@sigill.intra.peff.net>
 <20110802190645.GB17322@fishbowl.rw.madduck.net>
 <20110802192727.GB20239@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
To: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Aug 02 23:13:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoMGs-000871-Me
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 23:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328Ab1HBVM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 17:12:59 -0400
Received: from seamus.madduck.net ([213.203.238.82]:53700 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab1HBVM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 17:12:57 -0400
Received: from fishbowl.rw.madduck.net (198-226.79-83.cust.bluewin.ch [83.79.226.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 7C1C4415258;
	Tue,  2 Aug 2011 23:12:43 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id F2D441FE57; Tue,  2 Aug 2011 23:12:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110802192727.GB20239@fishbowl.rw.madduck.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178508>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2011.08.02.2127 +0200]:
> refs/heads/master is a file, containing its payload in the first
> line by format definition, right?
>=20
> I mean: the storage is right there, isn't it?
>=20
> Of course this opens a whole new can of worms: merging per-ref data.

origin/master can contain a different set of per-ref data than
master, and the consolidation would need to happen during the normal
merge.

But unless there's always a new commit associated with a change of
those data, git-push will happily overwrite those data on the
remote.

=E2=80=A6 unless the remote refuses to accept a ref update if the data have
changed. Conceivably that's could lead into a control path similar
to what happens on a non-fast-forward push =E2=80=94 unless
receive.nonFastForwards is on.

What then?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
seminars, n.:
  from "semi" and "arse", hence, any half-assed discussion.
=20
spamtraps: madduck.bogus@madduck.net

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOOGhJwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xDI0
D/9AD9S/fJVP+mLk9JEJ+JWXpv7ZdQ3agNQZTYGUvbsBM4+OTfyt8grf45ASL/bO
ky63QQX+cA3j0E+TS917ka+w2uq8czwyrChYZJPBlB/yXgOtTkk0J1JXAW6hGFbq
wuixgTHlR7d+KGmyjCJTuniNXJorVrUIexUK5kZl+2T6Y906iW52stBLUKHzFH7P
qbYvExRcg4QLv2B+5OZidKvvt1/3kSP3aLqEBJVVEtejPvvQ5OIPgGxbMvL/BByk
0w2eNZXtf3+sReoIvapsAqPdR7lSW++a7rN5bunSQHCKT7ZgHYeDBhaW06WUIiEQ
lpvXvcb0QMFJIHDHZcDHn+N7HvkB2NGaBNawuMSAecMezzdxTwGd5Fdpgz0ofBwG
4ZedyIRX0UfCV0mOCi/1VP4rikCkDafbUQJevyp5qlpsJzp5Ay5s7GFCtd+kX/RB
D0NLNvU9qRJTW8X8mcLlW7eyPCOmeZVMzJyckWhmWlZdHu46+/5hfKnIVzVE/UqW
VKTCoG6odbGJ3QGFIRqrSTJdWWRnSywkis8Ghc2oxMFVpAs51DwRYDSul+H/9ODz
pRPyrImRi8AzPruH1Tm6OHwUoo5EyqP2IrFOiyekY3fcheV8VTx0/nORA6jvJkHm
320o/xD6TqT2rzn6Zw23Yir+pj8NOVIEHPu5u5xcw3cyfw==
=13FG
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
