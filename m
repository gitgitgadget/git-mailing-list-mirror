From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri, 5 Jul 2013 13:01:02 +0000
Message-ID: <20130705130101.GV862789@vauxhall.crustytoothpaste.net>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-3-git-send-email-artagnon@gmail.com>
 <20130705124536.GU862789@vauxhall.crustytoothpaste.net>
 <CALkWK0nbib0G4w6X4sy56X4KixFqpqQ2GEJ-uSOqxVoH8M7C5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v6gilOcl2gU05R9Q"
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 15:01:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv5dT-0000b7-OD
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 15:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757367Ab3GENBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 09:01:09 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:49107 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757340Ab3GENBI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jul 2013 09:01:08 -0400
Received: from omta04.emeryville.ca.mail.comcast.net ([76.96.30.35])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id wcrM1l0010lTkoCA1d179H; Fri, 05 Jul 2013 13:01:07 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta04.emeryville.ca.mail.comcast.net with comcast
	id wd151l00h25wmie8Qd16ox; Fri, 05 Jul 2013 13:01:07 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6B76A28057;
	Fri,  5 Jul 2013 13:01:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALkWK0nbib0G4w6X4sy56X4KixFqpqQ2GEJ-uSOqxVoH8M7C5g@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373029267;
	bh=/pcXKRGXPnc4xIwy1UcxPDPknGI6XJTOY0LmLHOog2c=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=gUwzj2Vbp2U9zo5YO9S73tyUjhdzcNV1HA3nx8I2plACd4psYS2dyrN/Xqlvvr/iq
	 EGXtYtCheHJYRFdmYppwIxa/4m3ojD0FUot6gMLiMzNHJ2pOyM/URpO2EbB+qUtd+z
	 0BBQWRfOG52M5S1+Xe1QnmMt1t8hQF+ajlWkClyrWDlHq6a1Xopq3i0NaRmwyCMc1x
	 iIwtWaNcZoBMem0g01ASkWsiWClGV3rg1do/G23OX7cu0Qn1pbnnw3jX2DjsJKLAO5
	 GnrpBu3wrsO6ZdJbAS8Gum70PfOILjEC6EVLkEr9VuW20g1ev+lh8F+Ots655SzeBX
	 hw5b5E7SuKsNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229665>


--v6gilOcl2gU05R9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2013 at 06:23:58PM +0530, Ramkumar Ramachandra wrote:
> Thanks.  On a related note, how do I find out about all these things?  I =
tried
>=20
>   $ perldoc Net::SMTP::SSL
>=20
> but it was completely useless.  The only reason I got this far is
> because you literally told me what to do.  Do I have to resort to
> reading the sources?  If so, how do I bring up the relevant functions
> quickly? (I'm looking for something like the elisp M-x find-function).

Since Net::SMTP::SSL inherits from IO::Socket::SSL, you can do "perldoc
IO::Socket::SSL", which is significantly more helpful.  If you're
looking for the source of a module, use "perldoc -lm Net::SMTP::SSL";
that will print the .pm file for the module.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--v6gilOcl2gU05R9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJR1sONAAoJEL9TXYEfUvaL/9EQAM+4swAtEJScnIfhne2ua+vU
P8DR5+ZOkbSIVz0fTBh+vLQ8/9TDql+4ckGtB7qxhKBkoQWybLiUX+e0TiUStdLw
PtCH3LidTj2GpbSQmN0cSglp1xMB/QXwiTtTewn1RSqCLgvz9QPadAMn+5VH+7QA
gEI4ulhFo8H6iFtLIT2iKNokc9vOlXC6mm7+66ija2KJIfLfh5gv80UAdvRo2TpY
hIoV0gSD98dCO+tAiCdQE/JwBb05e3HjyQWgyzzWdRBqlsniHPEx/05XlOTrzpSD
ni3enCzzp1LIrjkyuRHbuLNoHhRH20CK0y4SdPrzQ9bFCpDImA8cgyhv3B5DHMYP
viVM1pwjhwE2HJJV90c+O33uKtYlJ2M4U59b5ZZ5a3F/rbhtBhA94R+JyMryAXUv
KEb1R87IlhNa4ZrQ8Ppj4qsTZqBNrzsJIn4RWSbNPv0Z/or6rhgcVxzOo2yiicdb
zqFjNIpV0POhKT5VgF3xU1/QYKOuc6RbHriFBKSTDiZTtsxwWBHRPZg7aNm8eDNj
z7/POIr0RU5dqZYtg81XBNZFfpNPzkBvuHEizOEceHTz8Q58TljZE8KDRt6VKyG8
DvMyQOCASFU+qwg9GSFBijJ85x8CjP4nnghomVrr9C6q/i5AcsTTilxHMONlzvwP
fjm5cGAfC6F7Cfikhh+e
=GnTB
-----END PGP SIGNATURE-----

--v6gilOcl2gU05R9Q--
