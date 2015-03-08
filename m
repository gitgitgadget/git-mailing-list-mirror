From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t7510: do not fail when gpg warns about insecure memory
Date: Sun, 8 Mar 2015 22:04:25 +0000
Message-ID: <20150308220424.GD4245@vauxhall.crustytoothpaste.net>
References: <2652cb72a82d4ca4be3ea90bafd263e@74d39fa044aa309eaea14b9f57fe79c>
 <CAPig+cQXJgZJAoyQVYg3CNNzd70eA=ttdL7=g6wabtBkWBijeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 23:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUjJN-0001c1-VI
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 23:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbbCHWEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 18:04:34 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49937 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752932AbbCHWEc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2015 18:04:32 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e0df:a888:a4a7:fd4e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D4E7F2808F;
	Sun,  8 Mar 2015 22:04:30 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPig+cQXJgZJAoyQVYg3CNNzd70eA=ttdL7=g6wabtBkWBijeQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265113>


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 08, 2015 at 05:43:41PM -0400, Eric Sunshine wrote:
>On Sun, Mar 8, 2015 at 11:40 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
>> Depending on how gpg was built, it may issue the following
>> message to stderr when run:
>>
>>   Warning: using insecure memory!
>>
>> Unfortunately when running the test, that message gets
>> collected in the stdout result of git show -s --show-signature
>> but is collected in the stderr result of git verify-commit -v
>
>I'm having trouble parsing this. Is there a word missing?
>
>> causing both the stdout and stderr result comparisions to fail.

Perhaps this is better?

  Unfortunately when running the test, that message is found in the=20
  standard output of git show -s --show-signature, but in the standard=20
  error of git verify-commit -v causing the comparisons of both standard=20
  output and standard error to fail.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/MdoAAoJEL9TXYEfUvaLtP0P/1MlTjp3e4fbo92U56xdj79X
dsM54XQupVKkVsBHrW4JToNXgJJefKGkyIGPr2nQjhtkQQw9J+Hfckwx1YoVW6tK
5h7mZmIMvXKUfPuMjuuH1hrG3dIu85BggLG9vuomw9QSWjT2Ls8K3K9J8x3yyTN9
zmZCHFmQ5st2SHvWLCcE05Pz7dAj79wVdCSIShy7FWBp23ARaXSp/ffyT9iNKutc
gOBiD8ogWsU8wRN8pYtrzfXCWqq16Nj8Rzz/C40YSjWHdMkhTHsf2DT5d4pEaC7n
50dRCr3Of6b1tGw5IT5dBF0zEhyqFM2aUMHVO4bYwozfNWdwvEgpSgdGMXF4wTkm
oGR7IkudctMSFOKzKD2rqwr2tD9Up58+FeEhtLtA184D5fXPnqJMqP7+oraPwl1e
cnkEGxIjZWsTF21DGooFtcXCiN9mwU6v/rUYoZQLmO+MEZRxGIQr6OiCnM3bMJ2I
IWYo+opPhH1JH3dLjWLvpYGiORrO8FZgNZrGvz9OmDcrkJ/q2PN3yuDaX+/t9pc+
TI0RYcurf5EtGxEMeOrFznOTCw638botZNH3dkIUTNOOnywSMNzqxPYU7wM3u1kR
8zGy3CE+xB7OX5BnaaiuQs8+0jAWkF7vyGSO3ZFoAd5f3J/MEb2Tb5HIRDI2EUx1
l7IpY9vgLHYNq/YSmBdy
=2YbH
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
