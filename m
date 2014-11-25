From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Tue, 25 Nov 2014 11:07:11 +0000
Message-ID: <20141125110711.GF28310@vauxhall.crustytoothpaste.net>
References: <5468C33E.2080108@whonix.org>
 <20141117212657.GC15880@peff.net>
 <CAK3OfOgko5Fb5FMGCKw3+12fAzMVEHuUriaiBNGi8nb28bNTQA@mail.gmail.com>
 <CACsJy8BMNXUinfK=YcJPkx98tYv_e40N0_mqqnzMLxDN6hkruA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Cc: Nico Williams <nico@cryptonector.com>,
	git discussion list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 12:07:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtDy0-0004Aa-Ao
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 12:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbaKYLHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 06:07:24 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54760 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959AbaKYLHS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 06:07:18 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:7842:6890:c244:fad8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E7D272808F;
	Tue, 25 Nov 2014 11:07:14 +0000 (UTC)
Mail-Followup-To: Duy Nguyen <pclouds@gmail.com>,
	Nico Williams <nico@cryptonector.com>,
	git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8BMNXUinfK=YcJPkx98tYv_e40N0_mqqnzMLxDN6hkruA@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260209>


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2014 at 08:16:15AM +0700, Duy Nguyen wrote:
> On Tue, Nov 25, 2014 at 1:14 AM, Nico Williams <nico@cryptonector.com> wr=
ote:
> > Is there a plan for upgrading to a better hash function in the future?
> >  (E.g., should it become an urgent need.)
> >
> > What are the roadblocks to adoption of a replacement hash function?
> > Just documenting this would go a long way towards making it possible
> > to upgrade some day.
>=20
> The biggest obstacle is the assumption of SHA-1 everywhere in the
> source code (e.g. assume the object name always takes 20 bytes). Brian
> started on cleaning that up [1] but I think it's stalled. Then we need
> to deal with upgrade path for SHA-1 repos.

Yes, it is stalled.  It ended up being a Herculean task, so when I pick
up the patch series again, I'll probably submit changes in chunks to
avoid the huge amount of code churn required.  I feel the list and Junio
in particular will appreciate that more.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUdGLeAAoJEL9TXYEfUvaLFG4P/2AYpWyzQOkn7tDEedRTy/z1
vfgyRaviCJKoOh0fjLAusPzvCICgM7ILredmvLa25uy6IHBEK38q+NIgXzYdwxP6
YlnKdTBUdYigrMa9fGRJNZjyt21myYXElPsH98lR6l2TD7oAy1IcZF5cepOBaQYc
j27sZhxKSy1Df3C6NECWk7GdLybePa1U5BSNlwgcD8hV0Kl2U5NU+exFva0MqlD9
X1CUg+NoNwHHJ23972f8CN7G9tuz7xR5tyLACtfnnEChxTTagD87Y5Oz9lOnrs/P
SLdJLo4cchasQljcBEAnZNK2GGVxf5twUnAlwKQpC/J66LqO7JtBUpCXIUfdb9Eb
gKmSzNT9AQsRsUw3/9nmgUpdHoQIvsdDZbMwvffEOKWUjsTMwzIHdFwm9a2g/Ffk
5AhDEvPR0x4zkCWqU9XuQ4vPzfpSAsSRJLGY2vg9JRA001aZnLQhjoPQpiB1HRkH
FT5iN5jtK3EbnmQDeZukyeuoZg5FYj+FiYsrtMitYt/KAmtLrAV0ymJ2Zgyrp/4d
qgI7ClSoFNfdt8KWI3nep8eUaA9uy1qxsYe4i/Qc0Xb1IhYE3rk+Aw94+DXUUafW
vEGHkA1KEXHEF3k1hpwWcKpbPM1qSG9z1KXY9xrYZidI33wogRStx2l4W4aub8lG
8azwOmjByA2oNUWzhL4X
=dolz
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
