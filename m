From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] send-email: improve SSL certificate verification
Date: Tue, 16 Jul 2013 02:35:49 +0000
Message-ID: <20130716023549.GH11097@vauxhall.crustytoothpaste.net>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-2-git-send-email-artagnon@gmail.com>
 <51D82970.5070108@web.de>
 <20130706143256.GX862789@vauxhall.crustytoothpaste.net>
 <51D83C7E.8000902@web.de>
 <CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com>
 <20130714170316.GE11097@vauxhall.crustytoothpaste.net>
 <51E3677D.6040903@web.de>
 <20130716001506.GG11097@vauxhall.crustytoothpaste.net>
 <51E4B113.8000009@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 16 04:36:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyv7T-00017P-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 04:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab3GPCf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 22:35:59 -0400
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:51784 "EHLO
	qmta07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753710Ab3GPCf6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 22:35:58 -0400
Received: from omta08.emeryville.ca.mail.comcast.net ([76.96.30.12])
	by qmta07.emeryville.ca.mail.comcast.net with comcast
	id 0qRG1m0020FhH24A7qby66; Tue, 16 Jul 2013 02:35:58 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta08.emeryville.ca.mail.comcast.net with comcast
	id 0qbv1m00825wmie8UqbwEK; Tue, 16 Jul 2013 02:35:57 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E3D7D28074;
	Tue, 16 Jul 2013 02:35:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <51E4B113.8000009@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373942158;
	bh=BXz7w/7q4OeBLpRvIGzAB+XiHiyKuYXd2v8bxNh6AmY=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=pPpaAMueczR/PO6BpkaYeLAe6INvD9vZwcKCvnzyMfwmnX4VkRkTqE2kFgPKtur1G
	 aO4TqELZKbDWz506ZS2zoFuQvJcDIQfIVOBi2aYu9ZmfDxFd9svTjAcfSET9xmdHF8
	 IV2z+PeGdrea5EDI1Y4LV4c4/6+yVfUb0p0jA6DJOssAjokslV1b7C5OPUevbQeoQV
	 ntyXG/c0CO/z8V0YNThGisnSgoz3LrWai5Z7WStkMzBdxszs/BaDfMMQeMIc/dfOa2
	 T85dcwiyE+lEX8+qDuukJlFRrHlXIZ9e5StJAmL6FVyj9XGD19SBLejP+VCkkazKr8
	 Q1gKvO3f7/yFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230537>


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2013 at 04:33:55AM +0200, Torsten B=C3=B6gershausen wrote:
> [snip]
> I wasn't sure where to apply the patch, so I manually copy/paste it
> on top of pu:
> commit 6b1ca0f4d443ee8716857b871b0513ae85c9f112
> Merge: bce90ab f351fcf
>=20
> Thanks, t9001 passes on Mac OS X 10.6.
> To be sure I didn't messed it up, please see the diff below.
> When it shows up on pu, I can re-test of course.

Yeah, that looks fine.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJR5LGFAAoJEL9TXYEfUvaLDmYP/0pTPtJAqMMv8wo3uFVFfMs0
D5MOVJIg5oZGGGa78UlqcITKanlcIpJ1Z51yqJekKUQFugbPLnZo91Yq/4IsvWEs
DwA+JHo1lu353woTAH69gJ0/r5+VWPYQKHELzbcaAlKGN3O6yyxZF+T5BLvGM6h5
nZeR9BmCZqbT4zr+yz61nVIbnwXGYesq7l6sEo8js2iUyIZymsMF3j3YofYnz2n8
HfJGOEGRcf+yVOCsZ8Y8buV9wG//+8MzL7Hd8F747NOt4fajxXqdf06jVoDz0uY2
CRZuvlkMQ9X8QIpwvdTZUF7P6ABLtrIuiVT+OrAVtLCtr3qoLXCy1YBbm4NZbYQ9
AvzfTJcFCm/QVQ3XHV5P+bblh9EHZPX/BqppbUntL6wbh0pUnUi/NDoa2PbjL+eM
4xB5w3jumgYceEqwB8aK7dCRLcSEYbG+f3dktxZHjpWCdH6HOyavhbj+2yqSQ6td
UgP0dWal16fqjsKij954qX/dBYnxux1DUKtHCjjXiKAIUJmXVawF4F2e99lgP6Zn
EPXCtM7N+AbSomBaqP2pKGaoh/XV2AXUt339FFO9l0r0Gb+smkxNmvsTICtIKLAT
9ipeYG5sHKhgSRr6Ue5uSpZ82VDKjhYHCQRuOKB3luK0MH827BNQ4fDdCoLzbO5Y
gVE58wPjftceuUsh2vvK
=veKM
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
