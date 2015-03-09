From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t7510: do not fail when gpg warns about insecure memory
Date: Mon, 9 Mar 2015 01:22:14 +0000
Message-ID: <20150309012214.GE4245@vauxhall.crustytoothpaste.net>
References: <2652cb72a82d4ca4be3ea90bafd263e@74d39fa044aa309eaea14b9f57fe79c>
 <CAPig+cQXJgZJAoyQVYg3CNNzd70eA=ttdL7=g6wabtBkWBijeQ@mail.gmail.com>
 <20150308220424.GD4245@vauxhall.crustytoothpaste.net>
 <CAPig+cTj_z0xpDmnSvb-S_wEbwzdcFsGwUkFdGWgcJhwZpfMFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:23:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUmPT-0007Hk-Ic
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 02:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbbCIBWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 21:22:24 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49943 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752215AbbCIBWX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2015 21:22:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e0df:a888:a4a7:fd4e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 203102808F;
	Mon,  9 Mar 2015 01:22:22 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPig+cTj_z0xpDmnSvb-S_wEbwzdcFsGwUkFdGWgcJhwZpfMFQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265122>


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 08, 2015 at 06:15:55PM -0400, Eric Sunshine wrote:
>On Sun, Mar 8, 2015 at 6:04 PM, brian m. carlson
><sandals@crustytoothpaste.net> wrote:
>> Perhaps this is better?
>>
>>  Unfortunately when running the test, that message is found in the  stan=
dard
>> output of git show -s --show-signature, but in the standard  error of git
>> verify-commit -v causing the comparisons of both standard  output and
>> standard error to fail.
>
>That doesn't help me parse it any better.  It's the "but" without a
>corresponding "not" which seems to be throwing me off. Typically, one
>would write "this but not that" or "not this but that". I can't tell
>if there is a "not" missing or if the "but" is supposed to be an "and"
>or if something else was intended.

The intended meaning is "and" with the additional sense of contrast.=20
The sentence, if read with verbal emphasis, is, "=E2=80=A6is found in the=
=20
standard *output* of git show -s --signature, but in the standard=20
*error* of git verify-commit -v", thus demonstrating why the test fails:=20
the pairs of output files don't match up.

Maybe you can suggest a less confusing wording.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/PXGAAoJEL9TXYEfUvaLmdsQANG+sFFqIbTYa2ORl4oDUgmk
yfLUmMMXQdeS1CjIRFutnmDy3D82suLW6z/BAgrQmWZX1VQZcd3v1JRId4a4/Xg9
397sH8gDE9EIQFtZTLOv+0k3KryEXZl0jSOat/hA9Ls22HhelFgEOpTS3CDCUTff
S5n7dkpB+Cvtv6lwU7NIZXNd39hu+AWFsfiuU/jVPTAD1nLJVMhErmR+GWJ01cqG
0wmnteGzDcv37Z8TW4sYr9pHuMv4HGvPrY40D5rCppaaPuxhKDX1wr17pS5Uqlwi
/4pwPdU0q001rXM0iS8wS7fzSgfHZpFvff5jWRmEKKWPWam6VVZryjVd4nw9qtYw
TsS+TyNOEbI1DTKfHyYPrXbWbIQIJ55IOCfODASyUvivIhAAvZUhxudoUG0dmlXj
RQuo69boamDpdE0TqhBrqG681ZOuEZKUrKt/0FrCTKD1c5DVLluqPKWn7FkvXLU1
ssSkujJVp4GWKzDb3+JLGKwvOJ3ChU88nvaCrTfYe/5VBIgj3ER+emVmb2nJ1hnX
ykfxRDMOo4Yl35YB0jFKh64qhlWsETvgxm8LwE996EJr1k1gC1Rsk0TvEOqcKOrZ
M8FjNxh8rNu0X/oSfyJKNIyfluBs/f0acdcvHSVOIqca6ZS8G1GTkNQnv3caeEF4
d+8Z20bmN3DXOvaAZyTB
=uu2S
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
