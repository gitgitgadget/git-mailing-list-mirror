From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git blame breaking on repository with CRLF files
Date: Mon, 10 Aug 2015 23:54:03 +0000
Message-ID: <20150810235403.GC9420@vauxhall.crustytoothpaste.net>
References: <B0BFE3BB9B3E8C4A890D53FA460552D3737328B0@DEWDFEMB16B.global.corp.sap>
 <55C59A9B.9000808@web.de>
 <55C7B5EE.7060908@web.de>
 <B0BFE3BB9B3E8C4A890D53FA460552D373734199@DEWDFEMB16B.global.corp.sap>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Benkstein, Frank" <frank.benkstein@sap.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 01:54:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOwtR-0002NV-Fd
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 01:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933365AbbHJXyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 19:54:09 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44581 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754847AbbHJXyH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 19:54:07 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A740E2808D;
	Mon, 10 Aug 2015 23:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1439250846;
	bh=ini8kKUF0fO1fnZ11TDPtu1P/Wv3E57/BONpL7UrltI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5hGjm4Lu+syl+83ba86MvimZkqiAW9hls3q6wk0pfp8+zIwVyxtVdhrsnoHX8mfq
	 K2CZRhJgVeeSS/9gp7sbPQ2Q2aRIWBC1oaMZAB8V2gX5Zj/DIrSvRWxc0SP1C+WaQH
	 7Iml8KD60Iwf2BTaaFwr8TXWs5C7HY+ksm7EtlJTAGXTOOFCvpnHaEA+3OtOofe3Y4
	 eUEv4Bh51ITPetpHMB440nZ/BpvT88iDDpkPhJ0NRexQlQbg3ylNLaclD5YwpNyc5m
	 9d0ubOtyeuQUoQ3Ik5+E3HwNjMcSayRB7RXCa4tX+QSZlW9HsrJBTCrralH3FqcDi0
	 +HCb8fzv4TeiGAk9dJOOn2Bq352G9Sgbok/tcJwxVciRuW+DTHHYFRv1n7pprHPnmo
	 mwLH/923CVcD3s18q0EZt5+OGA0zeIm/QfSSw9KjuUplGboJpp/7xnBEwsRK++dTiL
	 /faVgZloREGbONlqzozlEHMExvUl+pOSI6A2SDCdOAYugdZ7GfO
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Benkstein, Frank" <frank.benkstein@sap.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B0BFE3BB9B3E8C4A890D53FA460552D373734199@DEWDFEMB16B.global.corp.sap>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.1.0-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275666>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2015 at 08:36:35AM +0000, Benkstein, Frank wrote:
> You are correct that it is also wrong in git v1.7.0.  However, it is corr=
ect in
> v2.4.0.
>=20
> Another bisect gave me this commit which was included in v2.0.1:
>=20
>  commit 4d4813a52f3722854a54bab046f4abfec13ef6ae
>  Author: brian m. carlson <sandals@crustytoothpaste.net>
>  Date:   Sat Apr 26 23:10:40 2014 +0000
>=20
>      blame: correctly handle files regardless of autocrlf
>=20
> So this still looks like a regression v2.5.0 to me.

This commit was reverted because it was decided that it wasn't the right
way to handle the problem and it broke other things.  The complexity of
the CRLF handling is a bit beyond me, to be honest.  I'm sure I'd
understand it better if I used it more, but I'm a Unix guy.

I stand by my earlier statement that we should improve the documentation
in this area, because it's a common source of confusion.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.6 (GNU/Linux)

iQIcBAEBCgAGBQJVyTmaAAoJEL9TXYEfUvaLbjcP/RPBSu7t5LaV4tgWl1K26w8W
9+Ygsf6Wt4iaZjo1oTvLgpt1+rZrhOJVkpuObKi0kl9TZPIbWtQRiw9zjkR4zmlA
8X2sLsa8iMedlKbJvuzg7yjuRlqVdg3nsDi53qPMwnV933fUTgwWnPDOLBbmVKAl
82ksSTnDiunua9WJj3P32W66Mj/yE+O7nSXobMmN79QZ63XK44HJN5YIW6CAR9g0
eEHCAb9FJBGwH8A+18EdSaNHv6jCT4BYqZoQNOL18Uw7C3t+bA47mXhXWiH9b7NO
UXY6UV/1BJrQdprdIOSnkY+3x2FSCvlV8TCiQe//xRhfTaGw5XEFxrOKbufydgNa
Jhgz8mIC5Sm3O7YpWuaU61/J3asIfLXOtv8Kn65DczcVVHhpeGaUEF/X6lSzDsen
JsSjH1on71MiWd9B4dumvu3UbyHeml2iABSWGUBqLt5LIE+Mff6/XoL2F7cb9t2n
uAEt73Apficx+t3ALva7KD9HFrM/qxZTJbJxsigPGvK+3Oft48fW+iuWi49XEdwy
NfaoJGL6hKz/L4hRkcnTuh4CLwJCjjsuQGBn0pLLgfYhj0maUzYgaKo5645dwims
Do+VboLc4u9sbsspLJ7wf4YGPZ/b929QfFvjJ3FZN155z8C2zK3NNgx6EjMLQoj7
CLXrKah/TIQi4FEuawWK
=H0E/
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
