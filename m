Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD5EE49AA
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 13:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjHVNB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 09:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbjHVNB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 09:01:58 -0400
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [IPv6:2a01:4f8:10b:ddb::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED410CC7
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 06:01:55 -0700 (PDT)
Received: from leda.eworm.net (unknown [194.36.25.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 39B2722F53F;
        Tue, 22 Aug 2023 15:01:54 +0200 (CEST)
Date:   Tue, 22 Aug 2023 15:01:49 +0200
From:   Christian Hesse <list@eworm.de>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] t6300: fix match with insecure memory
Message-ID: <20230822150149.541ccb35@leda.eworm.net>
In-Reply-To: <20230822110404.1c002dcf@leda.eworm.net>
References: <20230821202606.49067-1-list@eworm.de>
        <ZORpucPcjzm-dhjP@five231003>
        <20230822110404.1c002dcf@leda.eworm.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KkrnCxiQTmMiXHspsT5YQwZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/KkrnCxiQTmMiXHspsT5YQwZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Christian Hesse <list@eworm.de> on Tue, 2023/08/22 11:04:
> So we need a set of commands to bring the output of both command in line,
> with or without warning on insecure memory.

I think I found a clean solution... Running a trustdb update earlier
makes the extra lines go away, and we do not need to filter them. See
the follow up...
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/KkrnCxiQTmMiXHspsT5YQwZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmTksb4ACgkQiUUh18yA
9HZ/MAgAu966s6btzF1vey8ztAWip2OB9oYMOVW574gH3bZs54ACne1pfCGyN3Sm
uERGXPL1X7jaY/Ytolg/FucUnOhugknyKuW6QXAp5Y7AtqzTKNNNGDFj6lZPF/uW
3xiy+djqHOk3tkg7Hhf7dxUo/wJBn5XV7phICRKaAKNXBD+84GGpcQXg5LaeGiFW
5fvHjrMEh6R2hdr8JlDK6v29BZJNLWWbivaM83hjmI8fGbt99XefRkNjJjRZu3J9
szSp7+4jQ4lcujB6VgncZ2rdSt1Mos1EiQA2jPY4dp6ZMXzF/LDggNfUDzkFsheO
l+vr9a58cszaqfd0fITMRvdZozHRIA==
=K328
-----END PGP SIGNATURE-----

--Sig_/KkrnCxiQTmMiXHspsT5YQwZ--
