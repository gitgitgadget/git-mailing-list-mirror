From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] remote-curl: fall back to Basic auth if Negotiate fails.
Date: Sun, 28 Dec 2014 00:05:03 +0000
Message-ID: <20141228000501.GB10649@vauxhall.crustytoothpaste.net>
References: <FBFEB910-4CB8-4049-901C-AADBFAB3AE9E@cisco.com>
 <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
 <20141227175604.GA23732@peff.net>
 <20141227210935.GA10649@vauxhall.crustytoothpaste.net>
 <20141227212948.GA30098@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Cc: git@vger.kernel.org,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 28 01:05:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y51MM-0001kT-GY
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 01:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbaL1AFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2014 19:05:10 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56372 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205AbaL1AFJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2014 19:05:09 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 546FB2808F;
	Sun, 28 Dec 2014 00:05:08 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Disposition: inline
In-Reply-To: <20141227212948.GA30098@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261847>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2014 at 04:29:49PM -0500, Jeff King wrote:
> >>> since if they failed the first time, they will never succeed
>=20
> Are there other GSSAPI methods where this is not the case? I don't know
> of any, and AFAICT git's support is used only for Kerberos, so this is
> probably safe for now. If somebody can produce a concrete case that
> behaves differently, we can untangle it then.

GSSAPI defines a token-based interface.  While it's possible that a user
could have multiple tokens, I don't think libcurl knows how to select
different ones, so TTBOMK it will always present the same token and
hence always get the same response.

libcurl could theoretically be linked against any shared library
implementing the GSSAPI version 2.  I only know if it being used in
Kerberos and NTLM in practice.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUn0ktAAoJEL9TXYEfUvaLx1kP/A7JBQrwUTzHue330370fstm
EnTYQaGfKA5p4p5PbWqCWdD+dFBupxmhbo3IubHG+za1YChlG8MIihdr0oNol+XH
WN6xKkwRaVa1J4PVa/88FRtDcMNyc2IxBA2OUp/iRVp7JrepEfDxdMhFkYg85Pxq
zuhvRN1I8z90YInX2ml4mH/4qKIFSJEJWmD6CwUJfkjlzVleiDt+xFgkhCMxkH4s
+H3khKaT48k34e1uO8/9GYxxA3k5rY2jeAHAPZi7ABondyGcfFEtZV9jnpySIUEK
GjPmvu+2FnwvYrJAx4m/aKf23ZPnrRwIyqWGhDYbLuwbY5tqVaxnGbDiCP8J/pSm
riogxV/xa3Cv472jw6zN6VugK3SU658xz+8POMiu3KqTrNTTtEnp18UFk3GgPd18
oJx0kztt0kUGlb8XC4LRHdJr+z+W216X4rqIJo+rlx4pvRkGW+4HBAc8qfdC0SWC
HpAlODwbINwHGnX4Zkmpdy1AycPXSk3D6KAceJe0DRBLd4sdC4RHl1Ioh3xhvs0a
Xx9wpJ+xWb36NQ3HrpFVLDW+Ot2Pxvtp9AJ2eLF8MS9Dey8a0wWAYBK8qQVaFP/r
+fYKvuhFlPNlywCsf5wezDUXuchoDmpvhvhojrncj+s0N6/k2QOzoi5Krjj9R7tI
9LdPZ2pIgEJ2Mza9ZSTN
=37ZD
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
