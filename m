From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Wed, 15 Oct 2014 23:52:38 +0000
Message-ID: <20141015235237.GB146788@vauxhall.crustytoothpaste.net>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
 <20141014095119.GC16686@peff.net>
 <543E5966.80400@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Thu Oct 16 01:52:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeYN7-0003IC-Th
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 01:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbaJOXwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 19:52:46 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49305 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751262AbaJOXwp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 19:52:45 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8F78C2808F;
	Wed, 15 Oct 2014 23:52:41 +0000 (UTC)
Mail-Followup-To: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <543E5966.80400@virtuell-zuhause.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2014 at 01:24:22PM +0200, Thomas Braun wrote:
> Am 14.10.2014 um 11:51 schrieb Jeff King:
> > What's the status on AsciiDoc versus AsciiDoctor? The latter seems more
> > actively developed these days, but perhaps that is just my perception.
> > The incompatibilities seem fairly minimal (if those first two patches
> > are the extent of it, I have no problem at all trying to remain
> > compatible with both). Would it ever make sense to switch to AsciiDoctor
> > as our official command-line build program? I know it is supposed to be
> > much faster (though a lot of the slowness in our build chain is due to
> > docbook, not asciidoc itself).

I don't think there's a lot of benefit for us to switch, and I say that
being a contributor to Asciidoctor.  It's useful to be able to build Git
with both simply to find incompatibilities that we're going to need to
fix anyway, due to the fact that Asciidoctor is used for the website.

And yes, those first two patches are it, as far as I'm aware.

> Just recently we added the AsciiDoc toolchain to our git-for-windows/sdk
> (formerly known as msysgit). So I'm not really fond of switching now to
> something different again.
>=20
> Remaining compatible with both would therefore be my choice.

That's my goal.  I simply wanted the ability to support both AsciiDoc
and Asciidoctor without making major changes to the codebase.  Hence,
moving the calls into variables.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUPwjFAAoJEL9TXYEfUvaLRIoP+waqavQK6iOW6In6I9tF6zGa
YPufz2RVMsgq9cFxgTULOBP0c90WHiUuw2wBb24lAWXSBioKoJW2QV0zLhuLIzQp
+Is0VrJ++/2zIl8Q8RRFxjhoMTJZSHezgnKNAsOJpvgTeFYivOskMLeGjcg3QD7J
VpbXso1oH6ttFStqtpwcbkh33FWs61UdBM9PSV3A4WWPzyQGuQ5S0H9JCSOyy1Ga
k3R+uvr3l34exRE4pZGm83biYH6JEVsHqkn++TqVBVLH4liw3S4QHmnYU61YbdCm
uFWgUtxwLtPYK3febZLxcvS0gZdrWS2XoYgrVvqGEoX2jPdhlTiFsvXdffEBm2Dz
iTcclytCY0H3JqfMyOHN0fceaCREBtI89Gra0eUHO7y2q5jT1M56GQxHEKcEQrxT
nw3jNdsNnIlJurRIkbc75klxBZXsn5Sxq+rorGrAbvxRx7mnfP9ckT2kLQ5zu+4C
n7XmJyeqN/WKbAKbCo7YuovmUmzjiXafBsrVh8J+jIbLwxbC2Djp/2FYPUMCXSt9
drsN73I+wD8qsOiaewF46EZqOnZp7Uh7NjTw75yWzelhkVmpVcim+IJbIkuOfxG4
j8em/KZg1ekp8x08aMfABEejlVhIjEjBdoMe0llkZK4cHhEEgJKdcB8+dt6d7TEH
oFSEJV2CzwGY5Usu1WUF
=umS/
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
