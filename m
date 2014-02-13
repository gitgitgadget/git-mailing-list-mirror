From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] contrib/diff-highlight: multibyte characters diff
Date: Thu, 13 Feb 2014 01:17:54 +0000
Message-ID: <20140213011753.GD4582@vauxhall.crustytoothpaste.net>
References: <1392109750-47852-1-git-send-email-sugi1982@gmail.com>
 <20140212205948.GA4453@sigill.intra.peff.net>
 <CA+39Oz5TSPNzYVvFytJwwUhRYjbEp5f_BdBWKT2tcYzpbF1WyQ@mail.gmail.com>
 <20140212232740.GA11098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Cc: Thomas Adam <thomas@xteddy.org>,
	Yoshihiro Sugi <sugi1982@gmail.com>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 13 02:18:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDkwj-0000Yq-Mu
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 02:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbaBMBSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 20:18:00 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51828 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751076AbaBMBSA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Feb 2014 20:18:00 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:485c:27a1:8772:5ef8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8DC072807A;
	Thu, 13 Feb 2014 01:17:57 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>,
	Thomas Adam <thomas@xteddy.org>,
	Yoshihiro Sugi <sugi1982@gmail.com>, git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140212232740.GA11098@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242037>


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2014 at 06:27:40PM -0500, Jeff King wrote:
> On Wed, Feb 12, 2014 at 11:10:49PM +0000, Thomas Adam wrote:
>=20
> > On 12 February 2014 20:59, Jeff King <peff@peff.net> wrote:
> > > +sub decode {
> > > +       my $orig =3D shift;
> > > +       my $decoded =3D eval { decode_utf8($orig, Encode::FB_CROAK) };
> > > +       return defined $decoded ?
> >=20
> > I'd still advocate checking $@ here, rather than the defined $decoded c=
heck.
>=20
> I don't mind changing it, but for my edification, what is the advantage?

The documentation for decode_utf8 isn't clear, but I don't know if it
can ever return undef.  What, for example, does it return if $orig is
not defined?  That's the benefit: it's immediately clear to the user
that you're interested in whether it threw an exception, rather than
whether it produced a given value.

That said, $DAYJOB is a Perl shop, and I would certainly not reject this
code in review, and depending on the situation, I might even write
something like this.  I personally think it's fine.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS/B1BAAoJEL9TXYEfUvaLXswQALvYnOGXQcTl7QU9CbEvW0wC
XnE9PUVLlxx3iFHTAo560m5+TNAta0UyERXeP72lek9yOiEJkkPJj8Iq3Am3YLa+
/pYkiUPr/xDJDE2I78fDKkJhtcGBypuGb8cgWgS+1eZHdHEzYRsh8fkTJ9lI05tN
wwTM9rGbAeluooqqRL+MCLNTX0VrqS3WFXpcxxV/qcSVu6POcRl9YmiNo+ZUKJs+
a6qBlDg9HC36t4/OWODa4E4WoOEjKgTaRVvh/6UqAFAXIB5WHjMxFBLWhpnyMGYa
JSIDUzI3ZubiNmnS3svx5OMfnUWVE84GlndU4NvP9OV2MMBvjdcqtXcBILrUSE9w
vBpR9Qxgjll1LCYPW96UUCitJf5qOAFLIz09C7+XAob6I3gd86AsqjwpFylo2d22
Lkk4l/utk/J234xmVwbV/EFTUOS1cbzKXsGg/zopLlj2CGjaiEx+UM/7W2YHohLA
yfeJKNltCOf7T9Sl151NHYHtJP2/F6WMn1pg6JkFOASOLkVSAOzTinuMd2qKW2HY
E03nr8dHWpw1RtZLY56zzHaAwGCYoHjepb/DROz2VfVysj9+lSgB7bzU/0a4LagY
AIbLlGq1hR/a/V/DCrUIgU0qZX2X8UWiJkzdyO/gFYm37Hns9na6+CEUhkYIqlPf
zU7RZ+LiZz4xxE51VgyI
=GA5K
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
