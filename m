From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: bearer token authorization with HTTPS transport
Date: Tue, 6 Jan 2015 02:41:24 +0000
Message-ID: <20150106024123.GF1025060@vauxhall.crustytoothpaste.net>
References: <CACejzECGUnH6B2Leq+H6u0Joo1SQmMCZ5UoHja_fK99+6a_iEA@mail.gmail.com>
 <20141230235610.GC10649@vauxhall.crustytoothpaste.net>
 <20141231014209.GA8789@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Cc: David Renshaw <david@sandstorm.io>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 06 03:41:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8K5Q-0003DZ-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 03:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbbAFClc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 21:41:32 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56858 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138AbbAFClc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2015 21:41:32 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 608C22808F;
	Tue,  6 Jan 2015 02:41:30 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>,
	David Renshaw <david@sandstorm.io>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20141231014209.GA8789@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262042>


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2014 at 08:42:10PM -0500, Jeff King wrote:
>Another option would be to just teach the credential code to accept a
>"bearer" field from a credential helper. We would need to:
>
>  1. Teach the credential code that getting a "bearer" token is
>     sufficient (it does not need to prompt for username/password).
>
>  2. Teach the http code to pull the bearer field out and stick it in an
>     "Authorization" header.

For the benefit of someone trying to implement this, libcurl has the=20
CURLOPT_XOAUTH2_BEARER option.  It does requires libcurl 7.33, though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUq0tTAAoJEL9TXYEfUvaLzxIQAMW70CiKgMCP/4BQ7dVGmPyV
C53jxvf4th7B6I+wQOAuQFkyZndf1OoS6d90LINDtidLJ06U3eejHkVGJO9rGWNr
j6j6r/M97E/vGDkeFj0n1fn6T7hE71gYaqB0E92K7/hNQIbCiKnp6DHNLqt0Uro7
qVHAqPqzO0IMTcOeQ5VqcFg5M8kaQYC1Q0yfuCK2Vy9aYgAfBgXt4nGtB8GqWAKf
jd8ZtFuknNUJhaHHCRG6HR5tyLcrmGnzBL0V7aOCqNdW0Rat1GH9e5G3sMbxXr6H
QDbAPh6MWhkrx1muCAmsLqxutkbFNuhENAQ66bB1dCwHkJO4KgtwhUxlv1vmyFIn
ALomZPOkCFRjOuKeg3To0IjfxAO75aDV9FViB7V7mnSShiB0tg0JR/pDiTfbwtht
G6aueQwEbGx/pd2hEH3sm+pTSdhsiDw2BOlVhSbbAmMPHDtcGw5jwu30KPq2j0X6
PF0ijSlScIrwjDlUvCq/F544GlORtuHIjFe+zcg64aiopuZv4mQ5mKv/TTSAR0J0
mfgtKvTqUtsFlekc5Tiv7CWWU6mvtlzrFUue8so52EAJ1iP0aXZrQUlhAwyJ9R6g
wpMHlxMt37JcHtHH7O7hQA+wTmvqVir9JFJRPMSVcyRSucQJjJKOMxjnCTqAIcFn
2502cDnNbMJ0nG4eaEbZ
=8jqS
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--
