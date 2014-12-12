From: Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/3] create gpg homedir on the fly
Date: Fri, 12 Dec 2014 21:45:58 +0100
Message-ID: <20141212214558.6b4b778c@leda.localdomain>
References: <20141212094753.160a0fb5@leda.localdomain>
	<1418374214-8241-1-git-send-email-mail@eworm.de>
	<xmqqk31wbobc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fd9IJdabKB1fXwaG+heUE=0"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzX6P-0003Up-3E
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 21:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbaLLUqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 15:46:12 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:52236 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbaLLUqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 15:46:11 -0500
Received: from leda.localdomain (unknown [IPv6:2001:470:1f0b:a5b:c685:8ff:fe0e:b717])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 1265F21FBD;
	Fri, 12 Dec 2014 21:46:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de 1265F21FBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418417170; bh=+SZBh04Rf/elSUQcGY1s9zF49OBtv0mnFv65ppuypBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=s5jL1/Kd86+O6nx0sKFSSuVkZXIjguGpR58hwLG+zHKE84r0fRUFzACXGtCVszJqg
	 JIhFfFI2Kl7tkXZ0aw1MEQzkQ3deRu1c2u9pN6obV7VQey1OkYiG6pora8foJmeChJ
	 kqtru5fjtu9mmCPuOfDpDCgJj0lrLZ3NoUvRiwQo=
In-Reply-To: <xmqqk31wbobc.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-unknown-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex
 /RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261370>

--Sig_/fd9IJdabKB1fXwaG+heUE=0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Fri, 2014/12/12 12:33:
> After queuing these three, I _think_ it is better to have something
> like this patch on top, as it is distracting to let the GPG message
> while setting up the test gpghome leak into the test output,
> especially without running these tests with "-v" option.
>=20
> The splitting of RFC1991 prerequiste part is about future-proofing.
> When we want to define other kinds of specific prerequisites in the
> future, I'd prefer to see it done separately from the basic set-up
> code.

Sounds reasonable and looks good to me. So...

Signed-off-by: Christian Hesse <mail@eworm.de>

Thanks!

>  t/lib-gpg.sh | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index b611b78..33de402 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -16,23 +16,25 @@ else
>  		# Type DSA and Elgamal, size 2048 bits, no expiration date.
>  		# Name and email: C O Mitter <committer@example.com>
>  		# No password given, to enable non-interactive operation.
> -		mkdir ./gpghome
> -		chmod 0700 ./gpghome
> -		GNUPGHOME=3D"$(pwd)/gpghome"
> -		export GNUPGHOME
> -		gpg --homedir "${GNUPGHOME}" --import \
> -			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg
> -		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
> -			"$TEST_DIRECTORY"/lib-gpg/ownertrust
> +		mkdir ./gpghome &&
> +		chmod 0700 ./gpghome &&
> +		GNUPGHOME=3D"$(pwd)/gpghome" &&
> +		export GNUPGHOME &&
> +		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
> +			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
> +		gpg --homedir "${GNUPGHOME}" 2>/dev/null
> --import-ownertrust \
> +			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
>  		test_set_prereq GPG
> -		if echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991
> >/dev/null 2>&1
> -		then
> -			test_set_prereq RFC1991
> -		fi
>  		;;
>  	esac
>  fi
> =20
> +if test_have_prereq GPG &&
> +    echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
> +then
> +	test_set_prereq RFC1991
> +fi
> +
>  sanitize_pgp() {
>  	perl -ne '
>  		/^-----END PGP/ and $in_pgp =3D 0;
--=20
Best regards,
Chris

--Sig_/fd9IJdabKB1fXwaG+heUE=0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUi1QHAAoJEFTtyRYJvJGDJPAP/j2rjlGxqXmzPysqqWDW518A
P19R51XJhZrqz3WDOpkFA4UrHqcQbr8CFNcGWnKqNeEXV0k7BLNNZnihHg7Hv/ju
MTbAC4ESPw6UtqM1A4txXFB48Hn81wktiKCODFDmoQyAIGCI5i9CsvPm4t6L6ZLv
RFW+LKIDxAs8IeYr0ERroSFZOSzpqcty1N93WPxWiWkJmehl677TVqhgmKs+J0wd
YHH6x3V2p97HEJsvfqz6PsgXIIdjvw8YXz5ghwQhMvBn6Nzjl3oVrvz5alT4lyfe
QsX65r6VnmPzimXbitbsfasgwjD4JWOe1RyYxTIJY2usFcJ9h73g910SgJJhsVgB
APxc7cWy2WHGSr5bJQuoWXurNOEx+X8OCPrtIkOaBDcCB8XA4OsT/Qw1M2iMU9Wv
nkT0bEgirFpb/qso2OY+OH2791NgBrtVbEOKymXU00YanUzNbnkCVhRSfTePCCBT
1jMLt4ml6wOlw2WPTeZd963Tf+RraTWvNPj+Gzg0xokdr6Sj/3GhOZXchPuv8EdT
M0fZC67x+JUOBUcKrLVxrIrziSrCbxwft0OVeRbVID/z8m67nqxFUAyHBEekBjSc
AEaeRUAiqgtZPyotDR9tBTuOW6Q3XlC3QYelbLn6lX+ndM3T4cG6F37Lvb32Rq9T
QHmEhZNzxN/vBnS7jrYX
=lE37
-----END PGP SIGNATURE-----

--Sig_/fd9IJdabKB1fXwaG+heUE=0--
