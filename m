From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Fri, 3 Apr 2015 01:30:21 +0000
Message-ID: <20150403013021.GA10125@vauxhall.crustytoothpaste.net>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com>
 <20150402180914.GA19081@peff.net>
 <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com>
 <20150402191452.GA20420@peff.net>
 <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com>
 <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com>
 <20150402193524.GA21555@peff.net>
 <551DD887.2010403@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Cc: Jeff King <peff@peff.net>,
	"Reid Woodbury Jr." <reidw@rawsound.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 03:30:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdqRM-0003cr-2X
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 03:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbbDCBa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 21:30:27 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54831 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751923AbbDCBa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2015 21:30:27 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:3964:791d:262f:be03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7B11A2808D;
	Fri,  3 Apr 2015 01:30:25 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, "Reid Woodbury Jr." <reidw@rawsound.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <551DD887.2010403@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266699>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2015 at 02:02:15AM +0200, Torsten B=C3=B6gershausen wrote:
> But not this one:
>  ./git fetch-pack  --diag-url  ssh://git.kernel.org:/pub/scm/linux/kernel=
/git/mchehab/v4l-dvb.git
> Diag: url=3Dssh://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dv=
b.git
> Diag: protocol=3Dssh
> Diag: userandhost=3Dgit.kernel.org:
> Diag: port=3DNONE
>=20
>=20
> Spontaneously I would say that a trailing ':' at the end of a hostname in=
 the ssh:// scheme
> can be safely ignored, what do you think ?

I think instead of ignoring it we can just produce an error.  The user
might have meant to specify a port, but forgotten.  I've done similar
things before.

I generally prefer being a bit stricter and giving helpful error
messages rather than trying to intuit what the user meant.  The user is
always going to come up with a new way to break the code.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVHe0tAAoJEL9TXYEfUvaL9s8QAIF72mTgL34Tv8KhPfhheMDN
ef/q7NAX/3B7O60fIVXjsKcm2pHhXrgj1LJ6R1g1+BHFeSgUKfC+w5nGJVoB8OUU
lwLm7wIST8IzGyBdiQdo4T13fsm95OmEAUXiJPPhZpMjGjPR9G0wprf4yLEX+cIP
KpuplRY7QIplt3phFl8R2BFqzE3lBh6eQeQAkcGVBAhqsXTC/2ok7/HoTXFuFQXu
oj7hw7kSZixdXLdnSc25wIBzpyN64ldQeAnbX9Xu66QB/gtyqXLKV9fW94MLr7vg
xUsxWdHmF02BRrxlubu9QH5HL3mCdipfwJeTAjbyb+2DyMkraLk+G81t3X7bBE5A
A4kqjBz49l+yU3anqNKUFgAgKmFOC0VSZX1iC1S+wFNfxOTm6vMnX+Eu1kH4XqsP
pv3XWeiyRmjhRbYtz7az1CE+18fgmDCBcUV8s7Yu/RzmV01y5v60Bx09H5nIm3or
NfHBrdknK9fu2b7E1gC9Jgk5PHbkp912cko3UhM4uhFaQdK6vQehWC95pilftoJ/
DJoxYfs7cJcERJPswQi9XufIGWsCkN2aUJIZRDR09V1FDptj80rvIEHJE98SRHIk
vQZr+IEE1JbqcL3OdyWvzYiD/LzFodGraVtXnrJyMBn6sTVzhH4zMJdpN8HYQGIL
+f4aXAMKWf+BJlqFcj3S
=TT2P
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
