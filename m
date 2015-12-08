From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: rebase has no --verify-signatures
Date: Tue, 8 Dec 2015 01:21:25 +0000
Message-ID: <20151208012125.GD990758@vauxhall.crustytoothpaste.net>
References: <20151207140015.GA14956@netblarch.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Cc: git@vger.kernel.org
To: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 02:25:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a671q-0002wL-03
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 02:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbbLHBVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 20:21:30 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34622 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932193AbbLHBV3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 20:21:29 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1EB652808C;
	Tue,  8 Dec 2015 01:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1449537688;
	bh=uS4ytXuX0E5fMY8Vf1P7qfGFcRHGOJvTTW16I1pZU58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZ5pig8QVZcOQhYlBR7DY88ci58+uSk35YP+YuXYgjFHpKl8GV3taEpNGwrHidW8x
	 99pxriTGkHAxTnB6U5UfwvcbYDECDfdKynnNC+OkgOqugz+Q5dvHb7ymzhbF7k+NKh
	 OxqfoLkAWv4cEy8A8Q2tJyZ66vMSylMGIFXJP7uDG7bBs1Tf3IRi2+mG9CtzMy5AsE
	 TIOHOcEJq3kJUDQETj7Eed1AAFIkhEbGQ1MsXHzuoan9MeyFHyBF9cmy8aXKq7rN90
	 uN3yK2DQCyHq+VG1AXushtyjyo7gv72g+IfHbR3AiU9XlGticHMVVe58OeknzJyhSP
	 74PQN+nXZ6oZupYSqGTGnMm/9YVb/dXxtrwVqt0I9UoHQpULQDU+XdnSxS5kOyhxjq
	 P2qQrJq5dxzUfY2Bf1vjXKmKFbOR+GZwb0hro3PDnM4w9H8+unV0z0FOWdKOtFqJwi
	 S3RndrEG7El00KlvclybSVuVWq3zvM+mahYbcJ5URNWiZJOoHKo
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alexander 'z33ky' Hirsch <1zeeky@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20151207140015.GA14956@netblarch.tu-darmstadt.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282145>


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2015 at 03:00:15PM +0100, Alexander 'z33ky' Hirsch wrote:
> Is there any technical reason why rebase should not have a
> --verify-signatures flag? I have written a patch to git-rebase--am
> which enables it to do such a check. If there is no reason not to
> include it I'd add documentation and a test and submit it.

As far as I know, there is no technical reason that it shouldn't.  It's
probably that nobody has implemented it yet.  I'd certainly be
interested in such a patch.

For a thorough change, you'd probably want to make it work with
git-rebase--merge and git-rebase--interactive as well.  I'm sure I'm not
the only person who frequently uses rebase -m.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWZjCUAAoJEL9TXYEfUvaLTCkQAIuJ1p/T7KmQ25G0mcgsQrri
PznidvZ+rOIbCw9s1STQINDv5tOVheK5+v5uz3XdKEhBwGK1rdnVhZUAukoKUrt9
XssaRXOo8G1asqTWvrzUKauPXakLraNmIwz8pRT8u2iqcV6CsR3vCQKYdnrjY1I7
/WpFBvuXiGYc1o07+QvdxAkRAX0dTBjDc2RBIKaZxiaTr3a5j9txeljC/AqA3QeZ
4Vkqdvj7AazAHVKHFJDYSLiaOUDpAYcztSQOGmC4AFF7UfHiF+pt80It+7HjVcYf
q1WWKrMFE98HDfXngIdZBNoticnjxQiKWAz6hQkoo/0Ajqqy3zybm6RSx8A1dr2H
UOUJu8xDWXvil4ViWbf1UfZF61/5HwHxCQNmqzWVASZ9f5Shabf2R0jw7UCt0dgW
tsySWZZIvJq7BHHd4r0tq6MN2MdYgeLAQQXzd6BrxrFSe2X0TPT76w47O38DL8nd
Va5g2In73NAMFPfQMznA997LmGk5DddDEv5vl0wq6kDHlGuvQbB8Rrkn9bXW+qH0
pSmDCzI9FKDplEnJ7U2Z2AZiVjEXeIV4p6c9KR9vAg1vx5PeHBZe2RKVHp7fEswA
UZ2LZz7mEwNNiN4Dl81U3kFlMjLdOJChBLRezwkSaeHF9/bLZ5h+UcqYeOsFCYqi
OPy3xN3togrn0gKLQb6x
=hwNm
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
