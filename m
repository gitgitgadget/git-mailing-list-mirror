Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7132EEE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjHUUd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjHUUd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:33:59 -0400
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 13:33:56 PDT
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [88.99.235.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82691129
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:33:56 -0700 (PDT)
Received: from leda.eworm.net (p200300Cf2f1DFf001a67c4451EcfD67D.dip0.t-ipconnect.de [IPv6:2003:cf:2f1d:ff00:1a67:c445:1ecf:d67d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id B849022AD8D;
        Mon, 21 Aug 2023 22:24:53 +0200 (CEST)
Date:   Mon, 21 Aug 2023 22:24:48 +0200
From:   Christian Hesse <list@eworm.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] t6300: fix match with insecure memory
Message-ID: <20230821222448.1524a5fc@leda.eworm.net>
In-Reply-To: <20230821200645.36796-1-list@eworm.de>
References: <20230821200645.36796-1-list@eworm.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/owqdRz/xNEYI/S0WOQ/Jen5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/owqdRz/xNEYI/S0WOQ/Jen5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Christian Hesse <list@eworm.de> on Mon, 2023/08/21 22:06:
> From: Christian Hesse <mail@eworm.de>
>=20
> Running the tests in a build environment makes gnupg print a warning:
>=20
> gpg: Warning: using insecure memory!
>=20
> This warning breaks the match, as `head` misses one line. Let's strip
> the line, make `head` return what is expected and fix the match.

Ups, my fingers are typing too fast... Of course this one was incomplete. S=
ee
the follow up...
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/owqdRz/xNEYI/S0WOQ/Jen5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmTjyBAACgkQiUUh18yA
9HZPIAf+IHdm6/PwtK2ipI8P2HhWN8sARnYi8PmJIQ2WiG3ZT7gHeoQZwGzDaKNA
FoBXAl8YlORqYJ3ZJcKlI+xO7VTedziRgrW+OVDdhqZvphssAEj5a7SaQwDYK8JI
OO/oZZciI1nDVZIlFTHQVJy9wsjeir71iez3utw9Km+0jaWvXdiVpKndUnr7m4+I
6Sq0yAeoNGPN6il2yMSMX6ubo7WGRq/8cr9a724yqRjOF3uGaEOdYvMmiP3syLf7
x6XBOfeLHdthTho9uzinY0daKyW02bqkgBvOi/3jKdmFNIcmvYXRhZ4V3QCErjsX
lYQCPzMlygwNU8hKlIZn9g1FiBlo3w==
=in8i
-----END PGP SIGNATURE-----

--Sig_/owqdRz/xNEYI/S0WOQ/Jen5--
