From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/16] Convert parts of refs.c to struct object_id
Date: Sun, 3 May 2015 21:45:00 +0000
Message-ID: <20150503214500.GA214319@vauxhall.crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
 <553D49EE.4000801@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 03 23:45:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp1hJ-0005nN-0R
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 23:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbbECVpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 17:45:09 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56302 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505AbbECVpH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2015 17:45:07 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:9420:74e2:364c:62c7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B87FE2808D;
	Sun,  3 May 2015 21:45:05 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <553D49EE.4000801@alum.mit.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268297>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2015 at 10:26:22PM +0200, Michael Haggerty wrote:
> After that, there is one patch for each callsite, rewriting it to use
> for_each_ref natively (which usually entails modifying my_function to
> take an object_id parameter then undoing the wrapper). These patches
> involve a little bit of thought, but not too much. And the results are
> very bisectable because each patch makes a single small change. I also
> suspect it might be easier to rebase and/or merge my patch series, for
> the same reason.
>=20
> The end result was very similar to yours, so I am confident that the net
> result of your patch series is correct. But the remaining differences in
> the end results are also interesting. I made a few more changes in the
> neighborhood of the patches, not to mention a few formatting
> improvements in code that I touched. If you compare the tip of my
> branch, above, to the tip of yours (I uploaded that to my repo too, as
> branch "bc-oid-refs"), it may give you some ideas for other code that
> can be changed to object_id.

This is a very interesting approach.  I've only just had time to look at
it, but I like it.

I agree that it's much more bisectable, although your series has a much
larger quantity of patches.  I feel like sending an 83-patch series to
the list may frighten reviewers away.  That's really the only thing
preventing me from replacing my series with yours.

Junio, what would you think about such a series?  Would you prefer
slightly larger patches, one per file, if it meant that we had many
fewer patches, or would you prefer a large number of patches touching a
single function each?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVRpbcAAoJEL9TXYEfUvaLDvYP/RrEb/hVVxCiK5vaN9N99Gvx
m/CxrdoDAdhZmZTz2Rd2POcPR8EjA+FkeAf7z4fMKlvmM9ryMC/QCvQXhOU5vdfP
d8xTewBaCV0fOuBdevJIIK1QUbQkjJ98akZgr8sJYwqpgo/+iGKlIrgGJkMzQwJU
lSXdfPLUcnuBVpv3QkshPX4jOHEtFHJEcnv2DCNFTo8trKwYivKvfkSCaK7OYYQD
yZwbQBvwVrGZ0CB9ko9Nrn5DCH/nVkJDnncw2weDovqoRxWAp5YpYL7eAEP0CB1X
U1rXfETuKptsJjnTP/nYkEjKm/95QpW7N6P5/H+RRjgZx2DxeyxLh3Gh6VIyevG7
JhoBZxG+J4RBRQdxnTHpoB2vfoB+d/0aAD9BR1eCUpTgGN8fsnwmwap9mkIRa5xh
47+w76v5PiA06Rk5g7OqbF+q1Xi/HbCQRJTILqAn6a3qD4xR8LyQePo6Qr1U/9zi
zpPuRU+oWEnjTcpRQytL0CuOkWLGSbMBXMgAJCUJ6IFENBBcE4IxV8XrhWDvHW00
ClZzpkG9cAMB913BiEJDvho4HiqN59/ZFEUHrhhRO2xB/zj8Mhwx8ZoUe8ZZ/TCn
KuQQUmrxEjT3KfgiAYPa5sKtf+Gz6aPikQ5XMcNc7fnt6djFGMyhKG86WqM3zR2a
VmMqQnt+tOl0xcndmfow
=Rd2M
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
