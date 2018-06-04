Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2482D1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 08:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeFDIUz (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 04:20:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38713 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeFDIUx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 04:20:53 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180604082051euoutp01a5ca3367223f2464f3783f340160ad50~050Oi1iHT1277612776euoutp01H
        for <git@vger.kernel.org>; Mon,  4 Jun 2018 08:20:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180604082051euoutp01a5ca3367223f2464f3783f340160ad50~050Oi1iHT1277612776euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528100451;
        bh=FlgeCx6GVg4ZGcHmtql3gBpKkKEuY0asGxS0Zg4+tOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeabgpzqPLbxDSzS9wFSXwGxGc4plrt1LRZYwytCVmacdA+ni9TsCKeGvo3DsMKKZ
         tlPmCrGx1YkL9yFpRopyOySRd+ARldVDoxeP/nD9q2M4958kc+rCt/JrDDH2bgxWAQ
         VMqrn1HqPGOhHh5vrckTeyrD94dlFXE5b6StrYmM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180604082050eucas1p2d4723a5f16712c0db2516568f2df4525~050Nu0Sgp2531025310eucas1p21;
        Mon,  4 Jun 2018 08:20:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8D.97.10409.266F41B5; Mon,  4
        Jun 2018 09:20:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180604082049eucas1p1a81cdb5ae39a76d4421ccdbce4dcdbba~050M1aPTC1920019200eucas1p1R;
        Mon,  4 Jun 2018 08:20:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180604082049eusmtrp1d1051c9ed6936ac8dccb910290c20462~050Mm_Kdm1169611696eusmtrp1s;
        Mon,  4 Jun 2018 08:20:49 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-6f-5b14f6625399
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B2.EF.04178.166F41B5; Mon,  4
        Jun 2018 09:20:49 +0100 (BST)
Received: from localhost (unknown [106.116.147.110]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20180604082048eusmtip22ac8eea1f3883c5dec798e9490955274~050MZnm8Q3055130551eusmtip2L;
        Mon,  4 Jun 2018 08:20:48 +0000 (GMT)
From:   =?utf-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: complete remote names too
Date:   Mon, 04 Jun 2018 10:20:22 +0200
In-Reply-To: <20180530153701.GA23809@duynguyen.home> (Duy Nguyen's message
        of "Wed, 30 May 2018 17:37:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7pJ30SiDRatYLHoutLNZNHQe4XZ
        onvKW0aL3sY/rA4sHjtn3WX3uHhJ2ePzJrkA5igum5TUnMyy1CJ9uwSujNnnu5gKtitW3DvY
        xtbAuFyhi5GTQ0LARKLvcANLFyMXh5DACkaJy1vuMEE4Xxgldiw6BpX5zChx6cgjNpiWkx3v
        WSESyxklfs64BdXyklFiws1f7CBVbAL2Ev1H9rGA2CICShJvOrYxg9jMAqUST37vApskLGAl
        0dt0HqyGRUBVYsf5tWBxToEiiekvP4HFRQUsJe713QWL8woISpyc+YQFYk6uxMzzbxhBFksI
        zGOXODN/BlRRmcTGma2sEKe6SBx88J0RwhaWeHV8CzuELSNxenIPC4SdL/Hl9z0mCLtC4s+m
        JcwQtrXEn1UToV52lFjUfQPI5gCy+SRuvBWEuIFPYtK26cwQYV6JjjYhiGoViXX9e6CmS0n0
        vloBdYGHRN+jHdCAa2eUaJj5nX0Co8IsJK/NQvIahK0tsWzha+ZZQCuYBTQl1u/ShwjbSqxb
        955lASPrKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMBUc/rf8a87GPf9STrEKMDBqMTD
        u8JYJFqINbGsuDL3EKMK0KRHG1ZfYJRiycvPS1US4WU/CZTmTUmsrEotyo8vKs1JLT7EKM3B
        oiTOG6dRFyUkkJ5YkpqdmlqQWgSTZeLglGpgnOXi+UQkY/HVjObD1+IsjcN3OF+KK37fzNly
        jfGdm9rh/ws40zSY2Xv1cm6eOHAw6cXD1L/SHLMViiq16jLruCbHH5yftOpzuMhNh11mgd8X
        KX5/eniXbV2x2AvTB405B68eWXZ6Zu6kR7cWsyiGHi+sidF/sqvUW8/lStVHA4NHApO6/qhM
        UmIpzkg01GIuKk4EAJ8fW889AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7qJ30SiDTpesVh0XelmsmjovcJs
        0T3lLaNFb+MfVgcWj52z7rJ7XLyk7PF5k1wAc5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRvulaUwFGyUr2g8tZWlgPCvaxcjJISFgInGy4z1r
        FyMXh5DAUkaJjpkfmLsYOYASUhIr56ZD1AhL/LnWxQZiCwk8Z5Q4+9oDxGYTsJfoP7KPBcQW
        EVCSeNOxjRnEZhYoldi2+DxYXFjASqK3CcIWEjCWeLe6iRHEZhFQldhxfi0byCpOgSKJG1ey
        QMK8QCWH/kwBKxEVsJS413eXDSIuKHFy5hMWiPHZEl9XP2eewCgwC0lqFpLULKCpzAKaEut3
        6UOEtSWWLXzNDGHbSqxb955lASPrKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAI2Xbs5+Yd
        jJc2Bh9iFOBgVOLhXWEsEi3EmlhWXJl7iFEFaMyjDasvMEqx5OXnpSqJ8LKfBErzpiRWVqUW
        5ccXleakFh9iNAV6cyKzlGhyPjCq80riDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YW
        pBbB9DFxcEo1ME59mrV81c8wCW+/Ja/u9s5kO/3V+tFGM4Wap7z+Mlw5fiErngV2xbPtvbJZ
        u6NP1GlxW27IbW6RtCnzhfct1aj4uphdec8Fy9pVZ5f75Ov9ve7Ezz/lROsXQQWDSzEueofk
        JG7sUZ7i/a/grezVvIu6+ktNM+qvybF9uLVdqoXL9EyyfdjKRUosxRmJhlrMRcWJAFMNAp+y
        AgAA
Message-Id: <20180604082049eucas1p1a81cdb5ae39a76d4421ccdbce4dcdbba~050M1aPTC1920019200eucas1p1R@eucas1p1.samsung.com>
X-CMS-MailID: 20180604082049eucas1p1a81cdb5ae39a76d4421ccdbce4dcdbba
X-Msg-Generator: CA
X-RootMTR: 20180604082049eucas1p1a81cdb5ae39a76d4421ccdbce4dcdbba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604082049eucas1p1a81cdb5ae39a76d4421ccdbce4dcdbba
References: <20180530153701.GA23809@duynguyen.home>
        <CGME20180604082049eucas1p1a81cdb5ae39a76d4421ccdbce4dcdbba@eucas1p1.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

It was <2018-05-30 =C5=9Bro=2017:37>,=20when=20Duy=20Nguyen=20wrote:=0D=0A>=
=20On=20Fri,=20May=2025,=202018=20at=2012:48:42PM=20+0200,=20=C5=81ukasz=20=
Stelmach=20wrote:=0D=0A>>=20=22git=20remote=20update=22=20accepts=20both=20=
groups=20and=20single=20remotes.=0D=0A>>=20=0D=0A>>=20Signed-off-by:=20=C5=
=81ukasz=20Stelmach=20<l.stelmach=40samsung.com>=0D=0A>>=20---=0D=0A>>=20=
=20contrib/completion/git-completion.bash=20=7C=202=20+-=0D=0A>>=20=201=20f=
ile=20changed,=201=20insertion(+),=201=20deletion(-)=0D=0A>>=20=0D=0A>>=20d=
iff=20--git=20a/contrib/completion/git-completion.bash=20b/contrib/completi=
on/git-completion.bash=0D=0A>>=20index=20961a0ed76..fb05bb2f9=20100644=0D=
=0A>>=20---=20a/contrib/completion/git-completion.bash=0D=0A>>=20+++=20b/co=
ntrib/completion/git-completion.bash=0D=0A>>=20=40=40=20-2632,7=20+2632,7=
=20=40=40=20_git_remote=20()=0D=0A>>=20=20=09=09__gitcomp_builtin=20remote_=
update=0D=0A>>=20=20=09=09;;=0D=0A>>=20=20=09update,*)=0D=0A>>=20-=09=09__g=
itcomp=20=22=24(__git_get_config_variables=20=22remotes=22)=22=0D=0A>>=20+=
=09=09__gitcomp=20=22=24(__git_remotes)=20=24(__git_get_config_variables=20=
=22remotes=22)=22=0D=0A>=0D=0A>=20Reviewed-by:=20me.=0D=0A>=0D=0A>=20The=20=
short=20commit=20description=20actually=20made=20me=20curious,=20which=20le=
d=20to=0D=0A>=20more=20digging=20and=20finally=20this=20follow=20up=20patch=
.=0D=0A>=0D=0A>=20--=208<=20--=0D=0A>=20Subject:=20=5BPATCH=5D=20remote.txt=
:=20update=20documentation=20for=20'update'=20command=0D=0A>=0D=0A>=20Commi=
t=20b344e1614b=20(git=20remote=20update:=20Fallback=20to=20remote=20if=20gr=
oup=20does=0D=0A>=20not=20exist=20-=202009-04-06)=20lets=20=22git=20remote=
=20update=22=20accept=20individual=0D=0A>=20remotes=20as=20well.=20Previous=
ly=20this=20command=20only=20accepted=20remote=0D=0A>=20groups.=20The=20com=
mit=20updates=20the=20command=20syntax=20but=20not=20the=20actual=0D=0A>=20=
document=20of=20this=20subcommand.=20Update=20it.=0D=0A>=0D=0A>=20Signed-of=
f-by:=20Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy=20<pclouds=40gmail.=
com>=0D=0A>=20---=0D=0A>=20=20Documentation/git-remote.txt=20=7C=204=20++--=
=0D=0A>=20=201=20file=20changed,=202=20insertions(+),=202=20deletions(-)=0D=
=0A>=0D=0A>=20diff=20--git=20a/Documentation/git-remote.txt=20b/Documentati=
on/git-remote.txt=0D=0A>=20index=20595948da53..dd38587168=20100644=0D=0A>=
=20---=20a/Documentation/git-remote.txt=0D=0A>=20+++=20b/Documentation/git-=
remote.txt=0D=0A>=20=40=40=20-186,8=20+186,8=20=40=40=20actually=20prune=20=
them.=0D=0A>=20=20=0D=0A>=20=20'update'::=0D=0A>=20=20=0D=0A>=20-Fetch=20up=
dates=20for=20a=20named=20set=20of=20remotes=20in=20the=20repository=20as=
=20defined=20by=0D=0A>=20-remotes.<group>.=20=20If=20a=20named=20group=20is=
=20not=20specified=20on=20the=20command=20line,=0D=0A>=20+Fetch=20updates=
=20for=20remotes=20or=20remote=20groups=20in=20the=20repository=20as=20defi=
ned=20by=0D=0A>=20+remotes.<group>.=20=20If=20no=20group=20or=20remote=20is=
=20not=20specified=20on=20the=20command=20line,=0D=0A=0D=0AIf=20neither=20g=
roup=20nor=20remote=20is=20specified=20on=20the=20command=20line,=0D=0A=0D=
=0A>=20=20the=20configuration=20parameter=20remotes.default=20will=20be=20u=
sed;=20if=0D=0A>=20=20remotes.default=20is=20not=20defined,=20all=20remotes=
=20which=20do=20not=20have=20the=0D=0A>=20=20configuration=20parameter=20re=
mote.<name>.skipDefaultUpdate=20set=20to=20true=20will=0D=0A=0D=0A--=20=0D=
=0A=C5=81ukasz=20Stelmach=0D=0ASamsung=20R&D=20Institute=20Poland=0D=0ASams=
ung=20Electronics=0D=0A
--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAlsU9kYACgkQsK4enJil
gBC5mQgAi3cTmcoAtEFoeg5WwyTBxKfeQAyo/ReS+SI+6/YiIwfGYpNuIXvlxVY1
Y4s5ldXUvWbzjVJSq8aUJvWv2wjdruQNLUL/j6PNkV0iYhjNSCAcIMYBSUUIMizP
2BwodCDcEJ98u8lN9TosYLv/vohWk30BApWiOftJ/v12kVGnQZX/UgmZbSoZGafF
G0KC99ot/G04EP7qmUIxf3wjWf3n5DT28viC6PO2Jw4fgtq0fbUdnJl3Od4AKQeT
9UNn4dGmXzh9K+5rMBBigjPivM6T3l+4JTaDXl2ioAqw3v+qinj7z6JsIWTqXh7x
PSaGtYjd5tBZ7fogxV/bWe9NisRD6Q==
=s3FH
-----END PGP SIGNATURE-----
--=-=-=--
