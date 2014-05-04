From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 4 May 2014 16:07:28 +0000
Message-ID: <20140504160728.GN75770@vauxhall.crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
 <1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
 <5365D91E.70207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WU3I8Do+sziGY3UL"
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 04 18:07:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgyxD-0005CY-2q
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 18:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbaEDQHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 12:07:43 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47543 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755503AbaEDQHk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2014 12:07:40 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:406f:e13c:7c96:bfde])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 87B0828087;
	Sun,  4 May 2014 16:07:33 +0000 (UTC)
Mail-Followup-To: Michael Haggerty <mhagger@alum.mit.edu>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5365D91E.70207@alum.mit.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248096>


--WU3I8Do+sziGY3UL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 04, 2014 at 08:07:26AM +0200, Michael Haggerty wrote:
> Please clarify whether you plan to rely on all platforms having "the
> same size and alignment constraints" for correctness, or whether that
> observation of the status quo is only meant to reassure us that this
> change won't cause memory to be wasted on padding.

I plan to write the code portably.  My statement was basically that I
don't expect this to result in more memory being used.  I don't even
plan to write the code assuming that offsetof(struct object_id, oid) is
0.

I have owned SPARC systems, and I have experienced plenty of aggravation
with code that makes unportable alignment assumptions.  I don't want to
make that mistake myself.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--WU3I8Do+sziGY3UL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTZmW/AAoJEL9TXYEfUvaLMwcQAKL3aY1mHN18SDMu0+NieUxi
jgZVBIoUKmiZEqx0oBoQ7ir6NL6A+l5fxe4CVetDPptXfzdO5LYRXVXhXZ5gY2nr
TIGmojPomAoP6oEV8xjwZStjUlpvhDJRpGvCvZXXcjGidrPnMrTybdagTGWSnWkL
GKbUExwWItPBpgqmoHBk2SMSiyOQPT5so2WW5DlTduax6EqEP0RWBTefekPKXrPl
KR5cl3XrufCl8SvypBUIOaUVNmLfwDDa41BL2uuqdeApNSCt8gPsbFr38qYyIVS+
r8QVE52UqS8veTN84kQy83FSxusCjWTni4wYxFD/y6/5JbjohMU7JtrUWVZAod4Q
lMPflXHfqt09sRIzZj8n1hwcto2ZWXY8H3zuxLuHJpdUGrC0iUt4EkWL2EKBPWqY
7L7RwQ/VNzxFLzCE1PlxyyyNaM19J4T393idWJ7Ux4Qm9vKBJlbZeO3Nf2pkYiZO
UYy4k0P7qkKdajyllf145n4p2rDYpzdSuWSkBLz9mhhALkc+cpJwVnjEOZqGxSVq
TFM+zIZiLCyEye7osvW20gSodRW/e/cCrmfTLo3r054i7wuE4OMDZ6nDDE2NyweU
3C4aZK5MLG7FjMuhh5NtXSwj09Yb6J1thNKqw+Aw5OApo7ThOH0IVwCQ4InJ7m70
FPYVxipKDvL98hG0u0C9
=2kwk
-----END PGP SIGNATURE-----

--WU3I8Do+sziGY3UL--
