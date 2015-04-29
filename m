From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/3] Improve robustness of putty detection
Date: Wed, 29 Apr 2015 01:38:31 +0000
Message-ID: <20150429013831.GB5015@vauxhall.crustytoothpaste.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq4mo2zgtz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 03:38:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnGxY-00028Q-JG
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 03:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031507AbbD2Bik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 21:38:40 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51199 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031401AbbD2Bij (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2015 21:38:39 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d8d7:1ec4:dcc9:52a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F19B12808D;
	Wed, 29 Apr 2015 01:38:36 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Content-Disposition: inline
In-Reply-To: <xmqq4mo2zgtz.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267951>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2015 at 03:04:56PM -0700, Junio C Hamano wrote:
> Good eyes.  While fixing the test is necessary, we should also be
> able to improve the test framework to prevent such mistakes at the
> same time.
>=20
> ok 38 # skip
>         git clone "[myhost:123]:src" ssh-bracket-clone &&
>         expect_ssh myhost -p (missing bracketed hostnames are still
>         ssh)
>=20
> The test scripts are expected to take either 3 or 4 parameters, and
> the extra parameter when it takes 4 is the comma separated list of
> prerequisites.  "bracketed hostnames are still ssh" does not look
> like prerequisites at all to us humans, and the framework should
> also be able to notice that and barf, I would think.
>=20
> Perhaps something like this?

I think this is a good change.  I haven't tested to see if we have any
other issues in the testsuite that this would expose, but if so, they
should be easy enough to fix up.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVQDYXAAoJEL9TXYEfUvaLwoEQAM/fEuh53BnMJYHiAIh3SKTl
S3Q+NgQdWB+S4kbLBHlnjKHosCtwXqlietc2PujP34TZEh7baF9TbVdKnGLr+w1K
pAgA1vKrxe5+eKopQ4R2+QPSB5oNDn9Davx0OtHdvyqivJlBbbYMuvZDJMHp5hjh
IAuXNZlN2pti1zgsSbMzwY3FXXnvuAfBb+YjsWr3JNtPeq9Gddqh9NU7PK8gvBIi
cS0eWzaU/txWGYD8MvovEgTQyAN/z9ubPaYwh1LI6JH8FUUN4wqBqZvxv6HNjYG2
2g9E259ga5uTF92EPzJL2rwjsZQZT9JAYe1MNUIgYZP+DrCKtT1Yx2Q6LcZEhXDq
YhqooJMGW2PWa/Up51dhXeTIZlnCB8DeCuh2dAdCxg+nybvHg4//jYv2Nx/sNUgt
M4AuJuEEDKYDH8aqSVqm2JoT5F0HYgtJHYfDwseVmr/ieKfaqFBSfZEBa2aNnnqQ
3LZW6/8idWTOW9mTJw0zATlELriiL3djv/3x/Zumcu4h/4gStOIRmo+5rWjn8Gey
r8JCE5o4U17c2ze5x2mO8UC7FS9js5J8rFIMViXZBK7QEKEEKi5NaHysI3Pf68SS
BkLviL/qQf9Vt/r8a1JGotn/cFUbLm5E3TLZAxzfYkC+DfJchrsI7iNkAhDzsY3p
dRtRLApdVuEnnLiACJOm
=OR+V
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
