From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 13:48:11 -0500
Message-ID: <50C8D16B.8060702@interlinx.bc.ca>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com> <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com> <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig39EBCDC3235FCF51F2846E43"
Cc: Kevin <ikke@ikke.info>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TirSJ-0005GR-FJ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 19:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab2LLSyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 13:54:38 -0500
Received: from mail.interlinx.bc.ca ([216.58.37.5]:43681 "EHLO
	linux.interlinx.bc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab2LLSyi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 13:54:38 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2012 13:54:37 EST
Received: from [IPv6:2001:470:1d:6f8:214:d1ff:fe13:45ac] (pc.interlinx.bc.ca [IPv6:2001:470:1d:6f8:214:d1ff:fe13:45ac])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.interlinx.bc.ca (Postfix) with ESMTPSA id D84B08D0C;
	Wed, 12 Dec 2012 13:48:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211381>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39EBCDC3235FCF51F2846E43
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12-12-12 01:29 PM, Junio C Hamano wrote:
>=20
> Here the end of the pre-context matches the end of the added lines,
> but it will produce worse result if you blindly apply the "shift the
> hunk up" trick:

Yeah.  I would not think a blind shift would be appropriate.  But I
wonder if diff can take whitespace hints about when to shift and when
not to.

It would still never be perfect but might be more accurate than it is
now.  Can't imagine it would be any worse.

b.



--------------enig39EBCDC3235FCF51F2846E43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDI0WsACgkQl3EQlGLyuXDt7gCg/iT5ckpIoKmbRUq82pSvB6YT
o0oAoPrglMVekpmXl47leZbLKQ3lkFVW
=/8n/
-----END PGP SIGNATURE-----

--------------enig39EBCDC3235FCF51F2846E43--
