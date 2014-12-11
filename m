From: Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] skip RFC1991 tests with gnupg 2.1.x
Date: Thu, 11 Dec 2014 23:44:05 +0100
Message-ID: <20141211234405.3513d5d7@leda.localdomain>
References: <1418290234-21516-1-git-send-email-mail@eworm.de>
	<5489B90B.6070706@web.de>
	<5489CC60.7080704@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hHJZnx5WJI5L_F+jMGkRSdH"; protocol="application/pgp-signature"
Cc: Torsten =?UTF-8?B?QsO2Z2Vyc2hhdXNlbg==?= <tboegi@web.de>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:01:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzCjH-0008Cr-UZ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 00:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966968AbaLKWwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 17:52:16 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:35877 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966958AbaLKWwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 17:52:14 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Dec 2014 17:52:13 EST
Received: from leda.localdomain (unknown [IPv6:2001:470:1f0b:a5b:f274:910:ef56:5686])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id ED7B3242AB;
	Thu, 11 Dec 2014 23:44:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de ED7B3242AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418337851; bh=dUX7QgpH2tdNmG0oYIzM9f7sbJpYa5cUj4uTWT2VouI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=4aPtQMJSOvSOdl2x7DBacJKSuAveFjQJU+s+X52Jkb2cUiyVTgc3+TG0indQ06fCj
	 C9DaJMxTLQC0itJqIa0F7DzibEkeFivm066TcFxvHpBthi00OYiV76UINRCeTrvRUD
	 pSdbxO3Uw2afFliqzbiacUKkW8SVSpVQziUTBfNA=
In-Reply-To: <5489CC60.7080704@drmicha.warpmail.net>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-unknown-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex
 /RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261301>

--Sig_/hHJZnx5WJI5L_F+jMGkRSdH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michael J Gruber <git@drmicha.warpmail.net> on Thu, 2014/12/11 17:54:
> Torsten B=C3=B6gershausen schrieb am 11.12.2014 um 16:32:
> > On 11.12.14 10:30, Christian Hesse wrote:
> >> ---
> >>  t/lib-gpg.sh   |  6 ++++++
> >>  t/t7004-tag.sh | 14 +++++++-------
> >>  2 files changed, 13 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> >> index cd2baef..05b07c6 100755
> >> --- a/t/lib-gpg.sh
> >> +++ b/t/lib-gpg.sh
> >> @@ -22,6 +22,12 @@ else
> >>  		GNUPGHOME=3D"$(pwd)/gpghome"
> >>  		export GNUPGHOME
> >>  		test_set_prereq GPG
> >> +		case "$gpg_version" in
> >> +		'gpg (GnuPG) 2.1.'*)
> >> +			say "Your version of gpg (2.1.x) is missing
> >> some legacy features"
> >> +			test_set_prereq GNUPG21
> >> +			;;
> >> +		esac
> >>  		;;
> >>  	esac
> >>  fi
> > We do not really need the GNUPG21 (and we don't need to touch the TC at
> > all) case "$gpg_version" in
> > 		'gpg (GnuPG) 2.1.'*)
> > 			say "Your version of gpg (2.1.x) is missing some
> > legacy features" ;;
> > 		*)
> > 			test_set_prereq GPG
> > 			;;
> >=20
> > 		esac
> >   		;;
> >=20
>=20
> That would disable all GPG tests, which is pretty harsh.

Agreed. ;)

It's just six tests we have to disable. Everything else works just perfectl=
y.

> If gpg 2.1 is the future of gpg (which I don't know), which should
> rather prepare for that and make our tests independent of the version.
> Is gpg 2.1 stable enough to cater for its special needs?

GnuPG 2.0.x is still the official stable, 2.1.x is the "modern" branch. Loo=
ks
like the decision about whether or not 2.1.x will be stable has not been ma=
de
yet.

Though "official stable" is to be read as "absolutely rock solid stable"
IMHO. That is what enterprise distributions should use.
The modern branch is stable for daily use but has some experimental feature=
s.
Arch Linux for example already uses it [0], so stability can not be that
bad. ;)

However... Even if GnuPG 2.2.x (or whatever future release) will become next
stable: It will not reintroduce support for rfc1991. So applying my patch is
the way to go. (And version 2 of the patch even simplifies things and makes=
 it
more generic.)

[0] https://www.archlinux.org/packages/?name=3Dgnupg
--=20
Best Regards,
Chris

--Sig_/hHJZnx5WJI5L_F+jMGkRSdH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUih41AAoJEFTtyRYJvJGD2tUP/2hSFcAsGjibAWkFxU+vAjGw
nim1RbezSs7DvLhgdqhnvdyUQBl5aC9K7jEl8veU6OTQwWwO1mSpGnB0L/ZibREU
ZVT9UVqxQkov8xbblGF94S4c9rhFG8O0LTi1VV2P15x2C8l7eZQfx5lDcTvXoy/x
lu4GljsyBcS6t6mkqqiilp4BBfhHHOFJgs5Af8VjJh/A29OMdwnD8SbnQbKnhqxN
bJtJ2eyo1MTx99LMB8cSUuTZZiZ4Q/nFpO3pDgPeTcKQx2CdJOmPlhtsI8g0HWf1
keMaFOAO0mTwyWQGbkdssj8HzMGav7UqB0WMwJNsoqqr7dx0U7TGvYJZgQcOwFNm
NisjLy1t3r+PkMpTKb7+IxDCduwODvUlBwT1zqAH8J+Kcsl37vqX9oQ4FwyzHy6N
JCqAvjc4pdA/CjSgrAtuiFKf8DK2JytdLfOm6t8DNcISRH+t36Cxqz3crWhjNLdG
Ux0cdiJmSiJAc7vAbkYvR4h1C4ZySmmcncnQRRldroBdQKi1dMA8jaKXFTnj3Wj+
+7ldIBnoXy2UOSPdlCfLQ++l0irjnpfL38gHm5UTa9rotfciRgT77OECEPUmSdlR
11FcBmgGmL2dMck7dE25FqcwEK0JiCVmLTe+SCJ4eytvUeN/fhBEma0rSwIMejNE
HtqeVwwOufUKbDDfGc0g
=VLIZ
-----END PGP SIGNATURE-----

--Sig_/hHJZnx5WJI5L_F+jMGkRSdH--
