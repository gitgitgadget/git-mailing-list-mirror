From: Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] skip RFC1991 tests with gnupg 2.1.x
Date: Fri, 12 Dec 2014 09:35:43 +0100
Message-ID: <20141212093543.5175e7a5@leda.localdomain>
References: <1418290234-21516-1-git-send-email-mail@eworm.de>
	<5489B90B.6070706@web.de>
	<5489CC60.7080704@drmicha.warpmail.net>
	<20141211234405.3513d5d7@leda.localdomain>
	<xmqqegs5dbqu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DartVS_zHtduTNxVKeFwm4O"; protocol="application/pgp-signature"
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten =?UTF-8?B?QsO2?= =?UTF-8?B?Z2Vyc2hhdXNlbg==?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:36:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzLhi-0006mP-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933216AbaLLIf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:35:56 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:33135 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbaLLIfz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 03:35:55 -0500
Received: from leda.localdomain (unknown [10.10.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id B0BA8241AD;
	Fri, 12 Dec 2014 09:35:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de B0BA8241AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418373352; bh=XCJSHhAGlnxFOuEEh8WautwEjviPvTTRaX3eMMif7FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mSDdrGbCRq5G2aR8l6geQwpStOHKeXhGp74UGlUfcpnvtWDugU6S1hfr9fTHw7hja
	 XFZSBDBfK+AjTsYGhxXwlJDZmPr4/qrG+5n+aoOwk66Ro5So5j1LT/SII09D8t7PAq
	 my/Sr86Nkv2vGZ/hTshwRqaPQmyODQnrLsBMd5/c=
In-Reply-To: <xmqqegs5dbqu.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-unknown-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex
 /RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261312>

--Sig_/DartVS_zHtduTNxVKeFwm4O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Thu, 2014/12/11 15:10:
> Christian Hesse <mail@eworm.de> writes:
>=20
> > However... Even if GnuPG 2.2.x (or whatever future release) will become
> > next stable: It will not reintroduce support for rfc1991.
>=20
> How certain are we about the deprecation?

The sixth beta of GnuPG [0] had this change:

 * gpg: Removed the option --pgp2 and --rfc1991 and the ability to
   create PGP-2 compatible messages.

> It also would make us feel safer if we did not have to depend on the
> version or keyfile format (which would not have anything to do with
> the decision to support or not to support rfc1991 format) to check
> if the feature is supported, but that is a separate issue.

Changed in next version.

[0] http://lists.gnupg.org/pipermail/gnupg-announce/2014q3/000354.html
--=20
Best regards,
Chris

--Sig_/DartVS_zHtduTNxVKeFwm4O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUiqjfAAoJEFTtyRYJvJGD9d0QAIuztSbJEqP7OL9sDqSlzCYT
B5sH4MXueE1M3RWYSlNQ1/uw5Lk3Mz4F24D83x9sRF2SfyUkEnysjeEu/ISQd385
pVAFJmPVO44uSyndOjPGgZy6k65gigeYwEQqPIAs2O6FyVDvKeMBdb1h7XbVIU2m
lO6Vg1papiCx05kB9zympkI6BSVFY73clfelP++CAGBUQkbtsofCy7AA+2KJH9Sh
+sjAhhX3X4hKvGIqgb4b+dwuPQXydQtZxtG6hUPdvPGiwfSUTNpFKxQ7F1s+oatb
uVxmGXVkB3vFJMqCDyYvlR2rNw2QX3Rmla2xnPU9PZIH6WpoBm+SNXZQSNdC/cHU
JLVIEw0zKukRuW2nV12ToIksUOQW+Hu8uNWeC3eihGolaCAHHo64Fxmxsb6RpJGO
tAw45oae/lfHEstWNxWUp0y+AIQNKfIZ71r1is19a2fkopsODETsuurbCYwDZ7oj
5BZdoVc+n4Dm29SQM1pbOclFR/fstTrh2V74DQeWX+i1+FB28zjvemUcu5bbmHJL
vC3USim/NCFWigsboREvKtcAh6ixgNXV5fMnluNXp4alZUqSh34PgcSFaPXEiy/4
ZZQWdiw+RMj7x32DpYy9XWMA3JreQNnyDUaR2U1dewIFS/2v2tB6ogJTkV5iO/XY
NAhXcprpYstqIHd7DTqg
=xy/B
-----END PGP SIGNATURE-----

--Sig_/DartVS_zHtduTNxVKeFwm4O--
