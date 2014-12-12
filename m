From: Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] skip RFC1991 tests with gnupg 2.1.x
Date: Fri, 12 Dec 2014 10:54:44 +0100
Message-ID: <20141212105444.50adca35@leda.localdomain>
References: <1418290234-21516-1-git-send-email-mail@eworm.de>
	<5489B90B.6070706@web.de>
	<5489CC60.7080704@drmicha.warpmail.net>
	<20141211234405.3513d5d7@leda.localdomain>
	<xmqqegs5dbqu.fsf@gitster.dls.corp.google.com>
	<20141212093543.5175e7a5@leda.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GQE/w0a2N3kBRrL9Fyelz53"; protocol="application/pgp-signature"
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten =?UTF-8?B?QsO2?= =?UTF-8?B?Z2Vyc2hhdXNlbg==?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 10:55:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzMwG-0007IS-FK
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 10:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934746AbaLLJy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 04:54:59 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:41447 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934514AbaLLJy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 04:54:57 -0500
Received: from leda.localdomain (unknown [10.10.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 43E6823EBA;
	Fri, 12 Dec 2014 10:54:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de 43E6823EBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418378096; bh=k9qlxrAnCdBtPx+N6K9+FQ7/cpYsTlptoez0pxbN9bQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l9knk88+8Zizko4saRAeR9OJvTChYrO3hg/fwQPX45bDflvsxatN+pkdh/tPzy5B2
	 XjZ0Vwhn6Mcg69IQmNwYAPk5/OLSQSd3QI0qMwYgequEgZaIhW1/Ie5SGXbquXOr8H
	 TJpPOOptWsmNh39vEG126LLuvFKKV2T5pgvAf8wU=
In-Reply-To: <20141212093543.5175e7a5@leda.localdomain>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-unknown-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex
 /RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261347>

--Sig_/GQE/w0a2N3kBRrL9Fyelz53
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Christian Hesse <mail@eworm.de> on Fri, 2014/12/12 09:35:
> Junio C Hamano <gitster@pobox.com> on Thu, 2014/12/11 15:10:
> > Christian Hesse <mail@eworm.de> writes:
> >  =20
> > > However... Even if GnuPG 2.2.x (or whatever future release) will beco=
me
> > > next stable: It will not reintroduce support for rfc1991. =20
> >=20
> > How certain are we about the deprecation? =20
>=20
> The sixth beta of GnuPG [0] had this change:
>=20
>  * gpg: Removed the option --pgp2 and --rfc1991 and the ability to
>    create PGP-2 compatible messages.

This is the corresponding commit:

http://git.gnupg.org/cgi-bin/gitweb.cgi?p=3Dgnupg.git;a=3Dcommit;h=3D2b8d83=
69d59249b89526c18c5ac276e6445dc35e
--=20
Best regards,
Chris

--Sig_/GQE/w0a2N3kBRrL9Fyelz53
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUirtlAAoJEFTtyRYJvJGDp9AP/139zmCs/Gz+0V/7vT4eheaE
FmUdRdBuMz+C6gYHL4HdqiQW8+A8IgUPBBZk6SIlRKL/efRCMQfQq7//oTCfZOFu
j3ddjfnZFfZUIaTJ4Hk35nByAw6E4J9Wcct/lSb6EV1AzXtJrHfWd7mTWVAUEsse
Iq9ROfQtcb77DbFx9jWKsDi4TzR08K3/FFcqYWvKRPKTPq52Xf0N/UPE7UJUd0f6
v3YmdtZFZTFx6h+B/560wZ2sjwrI4YAJaUdcSNGscTKHdNqxf9VYRB6W0zrqhw/R
LfDAI3EJfoP3FY/wwwI1yeMPcISV0DXnJnXuWbthK5yaYWx3waseDA7CrSkuADoQ
jMHWZBre71fj6h/ZcnuFWRccN658ZVl+uO1b7WfKT9mXXY9hekasUf5rXflgZRb7
I9cBnH20EVQF9F0PYoN4sjeB/IqZAhGXlGLp51drnkTxCON6St3UReuujJ3PI1H9
xHueV1KH252GWEgKQF73eIm+X9C1cMndjPdsp05RCR8GY66Qolf2K8nwA4SBrRJx
mvjk1e/DqTy9/9L1DEDreMNwL1IeBQt7h+7uYHKEWmVlnyaj+bcE6/iCN2NadMem
+kdsZjjuDPmfcZebywqIZTXYG2tv3MyNDi1zYDkjOOdCRSGWAaf/cbcI1yJ1Wixv
LvY1YZZSn8eMOMvCsUQS
=E3+n
-----END PGP SIGNATURE-----

--Sig_/GQE/w0a2N3kBRrL9Fyelz53--
