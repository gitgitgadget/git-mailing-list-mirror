From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Fri, 15 May 2015 02:52:24 +0000
Message-ID: <20150515025223.GB4665@vauxhall.crustytoothpaste.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <20150513045650.GA6070@peff.net>
 <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
 <20150514042544.GA9351@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Cc: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 15 04:52:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt5jq-0005JT-8O
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 04:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423529AbbEOCwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 22:52:31 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:39600 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423516AbbEOCw3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2015 22:52:29 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:ad86:55f5:98cb:7649])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B2C9F2808F;
	Fri, 15 May 2015 02:52:27 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150514042544.GA9351@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269122>


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2015 at 12:25:44AM -0400, Jeff King wrote:
> On Wed, May 13, 2015 at 10:41:31PM +0000, brian m. carlson wrote:
> > What you want here is [verse,subs=3Dnormal].  As of Asciidoctor 1.5.0,
> > this allows substitutions and markup within verse blocks.  I believe old
> > versions of AsciiDoc did not render substitutions and markup in verse
> > blocks, despite claiming to, and Asciidoctor picked up that behavior.
>=20
> That does work for AsciiDoctor, but sadly it seems to break rendering
> for AsciiDoc, where it puts:
>=20
>     <div class=3D"attribution">
>     &#8212; subs=3Dnormal
>     </div>
>=20
> in the middle of the SYNOPSIS. Yuck. Is there a way to make it work
> under both? Or a way to configure AsciiDoctor verses to always use
> "subs=3Dnormal"?

Using Asciidoctor 1.5.0, it seems to work properly for me without
subs=3Dnormal.  So perhaps we should just update the version used for the
site.  I realize the Debian version is out of date; I've already filed a
bug.

> I actually prefer backticks in many cases, but they do come with their
> own formatting. Surely there is a way in AsciiDoctor to say "do not
> interpret this magically, but also do not format it as monospace"?
>=20
> I guess the nuclear option is using attributes like {litdd} everywhere
> to avoid quoting. But it makes the source so ugly and hard to read.

I opened issue 1344[0] for this.  However, it looks like we can write
<refname>@+++{+++<date>+++}+++ instead of <refname>@\{<date>\} and it
will work correctly in both processors.  That looks to be a workaround,
as ugly and verbose as it is.

[0] https://github.com/asciidoctor/asciidoctor/issues/1344
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVVV9nAAoJEL9TXYEfUvaLFx8P/0B152rV5MW1ospH0P4GW9Q/
gTgDi45642507vVNP+rtbUiqqBTwEJFg91CqO14TM8bWvNe18G0wYVts5ebIOApI
KXHq3W/RIzG6pwOmdnn5WOX4YMxVa2JDTHKyj/+8ZjaW7lIFKeRFQsgrAugUwV8O
tvL9Z8ioC4oG7wNLpm/KZsCrMtB7tJLIsu0lkQ9el4wM8G8uYcVaBwaQWM0wNZ3G
HaIW6vmQW25WmdeCC5r8qsPz7kj2TAHudAE2tsDXwWn4/fNOP+2I24u+RrDxkY9b
JAmnpQte5FEOCJo/38W7nIlCu2il79UMVHM8rWJeHNQs9RG7BISVQrqDC5dizX9P
mnlwTYG5LaNNVJAcznnNPGeNtXsJ8GWA1yCu4BuTagOxnYvWNvA3oVtdkPQzZyEI
gca86K3f67UNPE/8QmUjoQx2S0jt/LZM0YmlUutvBWnlY2sgUXly+MfhQ/dBHeZ6
eB7d+va06L7q9LnaAin9e9FANq0r9jWDSIfIjO/N9IWLg8bC946Q7druNVjUsKMy
diSXc4F5+vBx9pdF8nt8WZIwglGWUyF7/8bfo2g9Kjhql8p4Zl8bEXKxm2j6i1CU
IyNNVG7r4S/hsemIAobJCf5JByF3irvXYHx5EmOOPp3XKi5o07k9gxHoYM1HiYi5
hgpTzazAsTd8ZPmJa50o
=lZ8c
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
