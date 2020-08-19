Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FDEC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 18:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A10207FF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 18:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fIYZPo4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHSSsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:48:20 -0400
Received: from mout.web.de ([212.227.17.12]:35037 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgHSSsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 14:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597862886;
        bh=Qi6SDWjG+rlDm8tWYZcyGzTVGfeft1A8Ipb0lGCQZDc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=fIYZPo4xmBsyZHMdiwbT75Bo/nhFhwPz25Abe4E2d8m31lwRnPQwXoaWrggeu9X+F
         6F0W3ldkfnbFR8cWZmwHD5OGwPY/GaPnpWg9sOukPrp4HUDe3dKHZCZkjiSCHsCg3e
         6vdPBCaOwlOFzFNZPFTZ4MqI493UPtLJ/4On6vaU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.157]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MREzO-1kKUCo2DLQ-00NKa0; Wed, 19
 Aug 2020 20:48:06 +0200
Date:   Wed, 19 Aug 2020 20:47:50 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200819204750.6ce87f7c@luklap>
In-Reply-To: <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
References: <cover.1597853634.git.lukasstraub2@web.de>
        <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MJfX1LvuBpy5eIwkZW/08oA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:4vOKHG9+koGqZJToeEo3oAzTJfdOEEDXM5lYbXtoJMc9yZ1b1Nb
 TEB+tQ98BycF+0CceZeW1ltaV1uhRKvYYeqtJS8uNzG23zgV6wARKvWBkT9NOHrSjW0ALu3
 DcejNelqiNA4W/p6KEis1OxG2rDp2r+FP5QAGnLWOcTnF8jRCRf7Ad7j3C+9Khr3oWi3PZA
 BVRscpRljznbDivgyU/CQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mzT3dLpZT8Q=:ivQJu6eFCJmy6oUeZHwzZg
 kAIy5gu4QD9UjDXqRrXo/KG7bVT3+5gMh+ZU0qWYCJ8Y1AjMcjs5iwty/ebnTiycSk+0YZOul
 YPOTpwm6rKIw+l+dcnh+aU7tbK8wKYj5zQkeiUPVKgVlgDDK/lrONGtwJe9IDMqYkqsXwvqyH
 /wSkeAbN96F+WLgB15PATSH6G+DUDJep69shgt7w6vGRit0aA02PY3sFvpXPsZh4PGnY6whky
 4YhtRUc4BLF4rIrXOHMBj8cZ9ogCfYIpRUfabZGTLCHwJ7qyc7nQddrW9Yfw4LSKT+Xn57k8/
 rwaXkQTLMKtoHlVENOS1g54av4tbWM47no79c2s/VJGG5z8qJ5oOsHXSJazIFzcdumU0DBVRU
 7lPlV0wAtaEnpSKyL6bzdZ7QmPg0K2hVhCKbGLeBMQOhozhGmiGO+UpAds2OXYppWLkTChJXY
 guMTWP+Y8LlZGCIpCYRrlgFcktsaXeKh17KFeKCwGUuAwO/YJRw7UeOadPZeDGTuKAU/jr9OD
 oqR7HNyqFlaBUKRn/YCIrPPqWW5XhtLdCTwJZNzXzMpCPcUy/Rn9PfwcRzqbwawH4i73bPcE9
 z3FvYO2Ye3gdsM2vGUIHTpBuu565JMyet54knvASK9bgB5OEpCQelEaSy94cMWBdqPYpD6HPn
 lWlHioSwDUs3EV8skj5wS//u8TKvByzgxzDH5gIzSTGuvwgxmalPH3OdW8KTEVb+FyLdEXErz
 vYLTqy0ZiqPfbsHICGjoH0xO0w2xUhoVBadOP9T5F2YTN6aWpK+KghiRlCdTO5fnBIOT3JzSF
 mF2Pfsf6NNXMrBPyjxuHm9llUvfxvA4EA5zOvQXy0hDiHLfLM5sEQGcsqohMCkbiqJ9rhyVSY
 Kml+L0+XkOEmThFA/Ssu0gmHZYIqn0fcwA1z1Y5rUMkd/hpWDbloyb+wVZC/jbNW6UJe1wJTv
 wGFGJoSpJwLL3FucRob4UN+3SKT++PNuB7QhTwFR20FcuJSB73v7RKy0dKGxggJSIr6x6Wvqk
 pNkzFUirRu2TstClv6YJpShvL4LIPWxE+BfYCD6lmfblC1mKgwpXT9iY9QrJ6vFwKh59etlLC
 Qh6X3ew0tyS1e93taPCqDcNLzPnC/WHaXrk+NQ0XiG7rZoeO59YMRuvLv3FmmR5i+l0dE5/ny
 BWv9xxHKHGNqd3TG9qT8k8sBgcLtY8N9E5e+8XHdEaTB/EwC1KAeuRDtv6w/kxljlHsbCWIkM
 mp78TjVb6sUvdu0gddWi8hhpD2Mb18HL/hE5rWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/MJfX1LvuBpy5eIwkZW/08oA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Aug 2020 11:03:30 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Lukas Straub <lukasstraub2@web.de> writes:
>=20
> > These patches allow this and work well in a quick test. Of course some =
tests
> > fail because with this the handling of nested git repos changed. =20
>=20
> In other words, this breaks the workflow existing users rely on,
> right?  I do not know if such a behaviour ever needs to exist even
> as an opt-in feature, but it definitely feels wrong to make the
> behaviour these patches introduce the default.

Well, the current behavior is that nested repos (that are not submodules)
are completely ignored and none of the files within can be added. So the
old behavior can be restored with .gitignore. The same goes for files/dirs
named .git.

Of course I don't know what the current policy for behavioral changes in
git is, but I see that there have been such changes in the past.

Regards,
Lukas Straub

> Thanks.


--Sig_/MJfX1LvuBpy5eIwkZW/08oA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl89c9YACgkQNasLKJxd
sljSSw//Tc+++MYZkze4g2d9SSmwnn38JcHthxyJuDONorU9YEY19MjifXJz8hKs
QffhhOkBsRwL8Plg2kn2x5ms27Jkt3rjD5YAfmvfmcLKKP1SrttUhshXLH5Te8EY
kJI1fevHbNT9oxOlZBhD7YsrG6IAk8gfX7zifU1XZQ8dTjhtX2Tm3+lMj8adl1Rf
zIfmGyBaGCGjaT42DDV7rYD9JRCFs5pShrhXe5Y9xKZoHDpFgsxtDdCIwBRo4bEB
ACjQnigFBrJQ58C+gYAeieJFscEoxG2DWExA8dxZHWfPVy8do3/xy6vcSxq41YeE
CG4YVY3ZtLPbvzPTxXXYCbQRC1zA3dS+TtWXl3Qns13X2SxI4WVUWSZ8fsh1UCIf
hDxJj4EHHRNGzaaS/DzYymonWXJuOqelNzASt/3F+Bo/qe9//x2pxsS4Ad4Nc0mj
ky7d38Fyc607rkLHSi4CMBRUJ9ffE2M4cw/UrEyv1okdyItpaEETsuFmkAtXz5Fc
6U+wjIwrSmkyTRubv9N012Nqxiyxn46ujVnbkvm5xy9KQMYU+Sz/cTmvmc45Utuu
rbTRquf6eIAVZACtRICv94BOJ0Iq5qFyTxlJGNsMpBCcs6foSuCY7ubmlCVg2Vuz
ALOvBbTa6JyCl25TxiCIYxPKYXErhTjL8mJ+JDewb0KMSznHDrU=
=O7ue
-----END PGP SIGNATURE-----

--Sig_/MJfX1LvuBpy5eIwkZW/08oA--
