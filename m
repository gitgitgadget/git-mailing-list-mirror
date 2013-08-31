From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar
 to disable display of #
Date: Sat, 31 Aug 2013 00:00:20 +0000
Message-ID: <20130831000019.GA899703@vauxhall.crustytoothpaste.net>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
 <1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
 <1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
 <xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
 <20130828201803.GB8088@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	j.sixt@viscovery.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 31 02:00:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFYcJ-0001cZ-Us
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 02:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab3HaAAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 20:00:35 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:59983 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754538Ab3HaAAe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 20:00:34 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1CA1928072;
	Sat, 31 Aug 2013 00:00:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130828201803.GB8088@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233485>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2013 at 04:18:03PM -0400, Jeff King wrote:
> On Wed, Aug 28, 2013 at 01:05:38PM -0700, Junio C Hamano wrote:
>=20
> > What are our plans to help existing scripts people have written over
> > time, especially before "status -s" was invented, that will be
> > broken by use of this?
>=20
> I thought that our response to parsing the long output of "git status"
> was always "you are doing it wrong". The right way has always been to
> run the plumbing tools yourself, followed eventually by the --porcelain
> mode to "git status" being blessed as a convenient plumbing.
>=20
> I will not say that people might not do it anyway, but at what point do
> we say "you were warned"?

It already has changed.  At cPanel, we had code that broke with a new
version of git because the output of git status changed between 1.7.11
and 1.8.3.  We fixed it to use --porcelain and had no problems.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSITITAAoJEL9TXYEfUvaLglgQALwKXtIHzXuFkt+aLnyMLALe
1dV4e5jBvSe4b++cpw3vR5dlMLw8unCHhwMbXmSwnJkBF7Maw/ejEXw2OS3N55vt
GErc0k7u3MKCLMXsK+skjX2m6GcK8cGqwyGPmsIoMFKb2UuAkzjSBBCjtVgWkPc3
ZvrfF5uv+xuEJhV8csNOR5oqz+O19cjz0sg0UFMCL4gX+PdXtsKb7kKYJUDFv4H3
Fejiq1wQg9659Jyao/vc7kSKb9qI710s0kBktICI4j+zSIEwSBFp+IvHFb1mfMm0
d0qTuD1MvdNwqpsefWlFNzDjVjWOcbIuzfCGDnjAc2G1LnKIXLhhZbgC35K77dVg
o4nDWhk6tc/qzFEHFaQRgE8lWZdNhixj5OlDJJA4vth4xi4w46+5/8cX45aZSMJB
iHNX4nY+rTkac3POh/lqCq6G4NBjbU12dtLOWgFmr6v3nHp73q/pLl0BXqG7RZeB
TxWoelxhHGcR9LrCWz9RnkO0UYnzqyugkiyW3kbQqNinhYjmuvZtM0dvfOjb/ej9
YzNrkd7KdKUlBdMIDTBdzihPDI9CbJQszykjLtWB1bU2ZQk/Smc2JBnxe0gJ4pJq
kwOwlxEZ0BhDZJe5LT10giTLVZqnrVOATqj/fTHDSywahgbXIlSZi7WjpADs/5O/
XV1h3pmJF4grM8Hnn3Do
=LbNw
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
