From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] Add the commit.gpgsign option to sign all commits
Date: Tue, 5 Nov 2013 00:03:46 +0000
Message-ID: <20131105000346.GC183446@vauxhall.crustytoothpaste.net>
References: <1383606881-2979-1-git-send-email-boklm@mars-attacks.org>
 <xmqqppqfag2e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Cc: Nicolas Vigier <boklm@mars-attacks.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 05 01:05:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdU7g-0000Ju-Bz
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 01:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab3KEADw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 19:03:52 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33557 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451Ab3KEADw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Nov 2013 19:03:52 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:b0ef:4a47:7a46:7dd2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E4C9E2807A;
	Tue,  5 Nov 2013 00:03:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqppqfag2e.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237316>


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2013 at 03:43:37PM -0800, Junio C Hamano wrote:
> Nicolas Vigier <boklm@mars-attacks.org> writes:
>=20
> > If you want to GPG sign all your commits, you have to add the -S option
> > all the time. The commit.gpgsign config option allows to sign all
> > commits automatically.
>=20
> I'm somewhat horrified to imagine the end-user experience this
> "feature" adds to the system; if one sets htis configuration and
> then runs "git rebase" or anything that internally creates or
> recreates commits, does one have to sign each and every commit, even
> if such a rebase was done merely as a trial run to see if a topic
> can be rebased to an older codebase, or something?

Probably so, but you can use an agent so this happens automatically.
It's not very useful for people who don't use an agent.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSeDXhAAoJEL9TXYEfUvaL0NEP/3LTmKMe8d4nPIxjsRRFut5V
4JkObsLGaLQkgpq9mdXGUZIIFRiEG8LMEjGqz/ssKUxO+D52X2nlgRRKKDxd8cQU
J3FRiKQVRplFnBpMFTNJUyTLoGkcSZ8drbW7biBWRrm8ebG2ZHLDQihiJDkV+fgo
sU9/ojuVSXOTBz9mm4AMsA0z3JGcfl/bP1q7gCUz93TfGC9mmc97SkRG/6ji06z/
z2Xu4fhVIc4Nvh/z6mMwemV/+6z/pW6HupIeXfiI6CCCzjvZm40mzl+avwUHF3bt
ySrMXFmvIFzDhaRuTQxPiCJleS4Aly5HPEIRyiEJBOoOOATlIz+Ii5AVMx4qCUgC
Og/59kE1VCHTycWI7VWrkeSuNwDXd/nt9scGxdPlZmhvwOhxLrivI5pjQYd7GK4X
n3df3vUHy8Whb1gyMtW8IK20gwHx4QMI3/Z0jphlNGdqcT/RF/eSWnpA3fHTsMf6
OygY7SCS+O3NmQzM2uTWIL7CRejnyUSKJvbFbs+7/M9xsfVGaluFdkItx6v7ewhe
O7dXzPY8p3SPvut6Gkdrbhl4D9l4oxwqktJ8HOh0AmOQU8oQDpiXL6Zm/V6rilYm
hT7Gwdja19t7bzs5CuLAFb5XwAFSENGXmD6NTPEj34r3Qkgu96iHWbSN9S4iYK1J
mkUPPdwzNK7+PqnB8NTc
=tdrw
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
