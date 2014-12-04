From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: FW: [cygwin] Cygwin's git says "error: failed to read delta-pack
 base object"
Date: Thu, 4 Dec 2014 00:54:44 +0000
Message-ID: <20141204005443.GB200195@vauxhall.crustytoothpaste.net>
References: <64C98FC352BD45EC9632202946A081E1@black>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 01:54:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwKh2-0005M5-I7
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 01:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbaLDAys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 19:54:48 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54967 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905AbaLDAys (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2014 19:54:48 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4AE8D2808F
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 00:54:47 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <64C98FC352BD45EC9632202946A081E1@black>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260718>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 06:31:18PM -0500, Jason Pyeron wrote:
> I remember hitting this a while ago, but just gave up.
>=20
> It seems to be a problem for others too.
>=20
> Any ideas on how to debug this so it can be patched?
>=20
> -----Original Message-----
> From: Dave Lindbergh
> Sent: Wednesday, December 03, 2014 18:07
> To: cygwin
>=20
> Aha - you're right.
>=20
> It works fine on a local NTFS volume.
>=20
> I get the error when I do it on Z:, which is mapped to a network drive
> (on another Windows box).
>=20
> Is there a workaround? Why does this happen?

I don't think anyone is sure.  My wild guess is that there's something
about the way that Cygwin wraps Windows calls that makes it fail in this
case.  It might be interesting to run the Windows and Cygwin versions
under an strace equivalent and see where things differ.

It's an interesting problem, but I don't have any Windows systems, so I
can't look into it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUf7DTAAoJEL9TXYEfUvaLZR8P/A9DlIb0ALc7CzCYBN9ZMt4m
U09qzCJwWmUBB5bCTwDDZwLIbzBh1Er6kBS8d01Hxa29Om5J9K0ga7Scpa4P8iCA
01eqMeemTnq6/p3X5yycz2q0zljNZdDYOR3QD5+U0YsARgvHjLAIB2/wCHE4kAwc
VGt44wD+Ix87Vw+CKFQETK0oU8gArWt1YyOLyv9XKG2e6rDJZtgl4P+r+FiTb012
jzN3fOT99Ux1V5SmhQ3k4yv6AcV1OLdi1x4ujx+Xe6yKVV2VvYPgK5KDQP17hZXV
bHnAsy1Pzb1rADF/xyGXt1tE4IrRcnFYQ6i/ZG7uJ0F1DYTinjwKs36TRKXIPzP/
OXMSTramGk0XDc+KArjkV2X4iNXRvawJLDlwpHIy4nzvXzJERtYHstFT9DRov+Gw
ztrRXixymj70GNhU5ZiF7ZwdD6nfrXe4j0hP9dsjLvd9CObQBACdHqdQh3RKK+9W
vdgRrvRet5TKLwOc3qvlR8scWf91UmegkXC/er2pfvqvXwldfjcddqdbyLC5PqW9
c8nCxyCN3k3qG+yqI29W+g8nec427DpGYbQYFg7hfZCrGDnsfcu0D1XKkS70pjzR
WwmMBJIC5iVj2U75LPUNNuBu1w+ERg8fvhkeDQfiV3g6Ke3Tl/jyCykS8N256GV9
th+rmqyFU4bUnuMX3Ses
=9lyf
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
