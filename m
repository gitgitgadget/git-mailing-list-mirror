Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121641FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 20:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754252AbdDOUBB (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 16:01:01 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35840 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdDOUA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 16:00:59 -0400
Received: by mail-pf0-f170.google.com with SMTP id 194so12830201pfv.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 13:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smkent.net; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=y8czNt1ssbFGn5w6xH4ytLFM7gtZElmQKQxWghcQdk0=;
        b=C0PgX+6bvTxT3bby1/K5/0YkEXkb+q6SmOiCOgh0KX2mYj3+91T3DmmyGfEp5GQi0T
         BsMyRdFnVBry86FfxUKLO8LfaBJ+xUs4/5WlTGKLFTivyZ+3BI9LManMbPruGS9pW/S8
         VLwT5RzZE2jNBzAsmo9w8hF+OCK2BaIbPkkuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=y8czNt1ssbFGn5w6xH4ytLFM7gtZElmQKQxWghcQdk0=;
        b=FMKjACef3zvDcAK9lM2/mqF8VRdtd/nYbaVdgeFp84so6XCEM6/c/kevhDhqy8pKa9
         vACg0y7Xr2G5pRWUrXaf6YZcOw089DdO40GKMzF44y5xULQhGGL9inju+mwcdWMD/0kG
         NkRQbazWdj2N2irJaZyJB7pLSuwksOqCJhlLzL/TJIB2UQf0HX2MTc2gkMIIKThxCit2
         zi0kQpnufpGqUb1qafKEwFbzxV4O+lP7QD3OXGqV3J238TcXmtpirnDuc9+B330ZU0uQ
         VCA5OYWnTWuBd6l277sfam2MKs0rhT5uefU/r7Zz+E61wAVAGFFNjMztZU9RFKnlwrGs
         fFWA==
X-Gm-Message-State: AN3rC/520n/T6IuQocG5mk/hbd/CTfzlZ+XQajjzMp3kGQmKt2kSWuiK
        o7y+onlFtRkU1dTC3Ak=
X-Received: by 10.84.128.75 with SMTP id 69mr5365656pla.111.1492286458647;
        Sat, 15 Apr 2017 13:00:58 -0700 (PDT)
Received: from localhost (c-73-53-29-115.hsd1.wa.comcast.net. [73.53.29.115])
        by smtp.gmail.com with ESMTPSA id s10sm9878028pfe.28.2017.04.15.13.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Apr 2017 13:00:57 -0700 (PDT)
Date:   Sat, 15 Apr 2017 13:00:51 -0700
From:   Stephen Kent <smkent@smkent.net>
To:     git@vger.kernel.org
Subject: Feature request: Configurable branch colors in git status --short
 --branch
Message-ID: <201704555989224.827bd36f789cd969c3667696308d4@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: multipart/mixed; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It would be nice if the branch, remote tracking branch, and branch=20
commit comparison count colors in git status --short --branch were=20
configurable like the other git status colors.

Example command output:

$ git status --short --branch
## master...origin/master [ahead 1]
M  README.md
M  wrapper.c
 M ws.c
 M wt-status.c

In the above example, "master", "origin/master", and "1" (in "ahead 1")=20
use git's standard red and green colors. I have configured the staged=20
and unstaged modification markers (the M's) to use brighter green and=20
red, and I would like to configure the branch info to also use those=20
brighter colors. However, there is currently no option (color slot for=20
git status in git config) to change the branch colors in=20
git status --short --branch.

(See the attached screenshot or http://i.imgur.com/evqgaRd.png to see=20
the colors I am talking about.)

Stephen

--GRPZ8SYKNexpdSJ7
Content-Type: image/png
Content-Disposition: attachment; filename="git-status-short-branch.png"
Content-Transfer-Encoding: base64

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
glhkT0mWUYklyWwWPtyVZzeaVG/Sk2c+eI1vv9hPeMx09rn1Im/pMG558dei917M0+zxWPR3
VdRddNF2kuzqwJDWAfy43PP935PMHdqLN9Kups0do3njm3VE3BvFoK8L15/KgqPUvnMATcf9
h+00ZcCdtTlaULyK5ZWvUCguYLhkHRBstyCygURrIIm0IPlAZd7FDU7u3UFyUgJrF7zDi++l
YmvZmTBn0UVsZOxgy6ZNbDrzSUjlxNllib40H9AD3+Wv8Mpinc4DI4u/tyILOLEniS3xP/K/
Z/szaIZJn7GPEelevm/sXcBcqx/9G9uxN+5PP2suC/YWV9Gyyy+dgJ4LyDj8M0t/y8E4soT/
jPofidkGp9e8Qlv3W94XahqkUPz152QM2L5UEBEjqRsjEUsFx42qKFLgDGrPwL6hFCSuZG+B
l5easyl9e1dn81fL+fnrX7kqpj/NnaVEGfIUm2ZvID+sF+3rug+xYBfz5kG/ARFEDOgH8+ax
q6DyjspeTeOH+3rw/N4uPDvsBKM73st3DR9mWGs/0Osz6ONZPFP7a4a0bkGnsScY8FhT1HSM
4soSGeDEUoG8RdKptyRpqaBSfZBFDYbEncQwCshKX8o9Kf9H14EzSPcoJGBwHCc850T2vkkb
tym4LaQ3/eon882aDI6v/5rEOrfTp4mz9LgpI40T1CKs1plLOZ/d8+YjBz/DmLsk8+ftpuS7
nWWVXx4F6ctZtmkTy+MPkpn4E2u3riZunz+N6vmg1XabBo0ey/zEVBJmv8wz3+Wo3qe4suZk
AFxpsE2XdAfeTYNGlVmSzOanR2N4Yas/rR+eSmy/zgTbP2JdGXMiVu4hduQLwMY1MQNptPtz
fj5iIeUvzE4N4R+9GvDa9l3n9cWQZ+OmIvJT5zBXT+AVXuG61Hy6UfacTFH5XhyekUOBlMjc
fPKyC7Asg1wDHH4OnJfYNEih+NOIjDAEm14vNBzKMETligwGx3dtZ+uv2SRsv4em3dcxcdQE
fnx281l3szNzIlkld9Xr0fWuKJyRE0jKmeChit2pP3kXB85TmqNWQwI5zp6MojGfKNjJJ08O
4yg/sLPA5xyRKbV8b3WUwpcF3f9XaMrk1qhLaRqkUPxphksAmfGCDfGiuIVCZc/K5CXywcSN
BD00hq6BXmxf6ybujjrKzCFtiYqKIioqirZDZnI08i461zlPpCGq02pANM49i1hz1ComdAeX
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

--GRPZ8SYKNexpdSJ7--

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEELzwhe+BXPUKPZyKW62lgIps+KmsFAljye/EACgkQ62lgIps+
KmvCQxAAoOU2zVL5XGPCJVx2z46Bw8KAsYNpkBkFsegMT+Nxdvpu609u52bYq8F1
t1jKIH9UjOg86VYP+ccjdkXfAHS5Zsk8esAvFSnLo5u+VUedJn370rBupxIt5ZeS
HDSWnqR0IqXHWfHDpEFPSmWdEVqL+RNd83FOQCeQRspJy8YD1QT9lurRoM49vYn7
SkrgRLU/FLvgru6KRon7rntwXOgfR50JKDBREZgo+KVkpjR2optx14K0twGo/BYN
qoLZoPk2GMiyn2/2O0zWjCSij9LGpvZA2rIOXJNCk9QCYQrz5Hrt9nx5RADikWnd
Vjcv8m24jP/0OuXZCmb8z34p+JSVoCEI//y/laWgb0ASh6s5pFLIOFjL8hYgYzPv
B8xswQtvupX8lzVxXG0orC22oat3H7g3YIyLmIYnqypDTdXuczWBNwCSNPzNdseo
6B7q2QjuVTkBY7omqZLXKdhbFoqUuRZgpnS7NeJ/wS7zQ6635gkeByeAGjBFNTNw
bUrzWFjHlbCy0mSH2UrxKXHGBEwZvm/HaAwnUla5GW31fgm/qjBplFB8Ye0ldL70
31A1orTc6RyaVJIpjBLTHv5tDQeJqqxeFr6ukNECkP3VrePFcdv/sZQ5voo+Kpt5
ZvqpY7HwwaE9aiXbcKIjqmVZXtmofJ2PTL5SDXyxHycq8pxGfr8=
=nO/0
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
