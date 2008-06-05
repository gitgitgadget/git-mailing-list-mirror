From: David =?utf-8?q?=E2=80=98Bombe=E2=80=99_Roden?= 
	<bombe@pterodactylus.net>
Subject: Re: [PATCH] handle http urls with query string ("?foo") correctly
Date: Thu, 5 Jun 2008 14:14:59 +0200
Message-ID: <200806051415.02809.bombe@pterodactylus.net>
References: <200806050128.33467.bombe@pterodactylus.net> <alpine.DEB.1.00.0806050758210.21190@racer> <7vtzg82u18.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2070997.l7Q6IXN3XL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 14:16:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4EO4-0002as-6z
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 14:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbYFEMPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 08:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756267AbYFEMPS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 08:15:18 -0400
Received: from wing.pterodactylus.net ([89.207.253.13]:45633 "HELO
	pterodactylus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755797AbYFEMPR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 08:15:17 -0400
Received: (qmail 17943 invoked from network); 5 Jun 2008 12:15:10 -0000
Received: from unknown (HELO ?192.168.178.19?) (10.98.86.10)
  by 10.98.86.1 with SMTP; 5 Jun 2008 12:15:10 -0000
User-Agent: KMail/1.9.9
In-Reply-To: <7vtzg82u18.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83913>

--nextPart2070997.l7Q6IXN3XL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 05 June 2008 09:57:39 Junio C Hamano wrote:

> If the protocol being used is still the "dumb commit walker" protocol,
> then, given the base URL of the repository $URL, "info/refs" must exist at
> "$URL/info/refs", and a loose object deadbeef... must exist at
> "$URL/objects/de/adbeef...".  That's how the protocol is defined.

Through a small patch in Freenet it is now possible to use the existing htt=
p=20
transport, without any modifications in git.


Thanks for all your help, anyway,

	David

--nextPart2070997.l7Q6IXN3XL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhH2MYACgkQsh8Hgp5TwkN0FACdHCm1NW5ifaliSRq0LTME6Whj
OHwAn3OAtURlYRuyHLI4h1IPWXyJAjgi
=KdCz
-----END PGP SIGNATURE-----

--nextPart2070997.l7Q6IXN3XL--
