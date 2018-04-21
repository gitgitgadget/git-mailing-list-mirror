Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73581F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeDUJmr (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:42:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:33859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeDUJmq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:42:46 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwF9u-1eM2FK1Ais-01849t; Sat, 21
 Apr 2018 11:42:40 +0200
Date:   Sat, 21 Apr 2018 11:42:23 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 06/11] Add a test for `git replace
 --convert-graft-file`
In-Reply-To: <20180421062054.4290-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804211140170.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de> <de1d455d6e526cf264ce1291c1923b97271969c3.1524262793.git.johannes.schindelin@gmx.de> <20180421062054.4290-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1802354994-1524303760=:4241"
X-Provags-ID: V03:K1:ZD230mJLqL4UHJ/Gz9u9lhspUNVNVIqertaIEAuNMv9Zc0X9mnp
 kdrwN24LiJa8rMWdiSuF/xvfY767d++H5Na1u2hrq8wdFcU9E2sHBN0OiiO09TB2sXEMNL2
 N/nMtRULtJehSJWBDCrxbopoJSazuIDF7mqFjOb3DwVt7RMOV2taNIoiNFvLd7l0uAw/iMk
 VaNjHlZOd193/AxosUEHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h6ZKAq0b4pE=:jpqFIUT2YqmPaBh/whiesx
 uupWQpmJE8OQgCPcnlfbF+MUKqye9PRbwjxltmRmDGHtse0VsikUxxBdQH70YCIXFFroFiyfZ
 lDkya18SGAYsdzLZYlTQtw6ZImLSRyjA+vy94tN7m/cXkZxum22T1ydIF0++Ehmoip7d9VoeV
 Yv47UE1QxB1nZk3VXONd62IRRGAF8UK2Hd6+VhDGsJRSIrXPjxrvVyj2B/+pDUV6KecoOLI1N
 E3gh0jnUcPPw0VLuXOlTE+CIWEfnK/4AhI5/7FUkp7jOgSz6dsJiBOEbscs7hkM1Ew70swzM+
 ocdfAzglKP7zoB9M/e7UYmGMFbr3mM7eBYDSs8xKYu71lqTi0LVJdg5wihwM/UG+rpgC/foRb
 eiDpVZpUhX7KHjf3zo+6eJHNe0OQToK8VBY4jML3KLY0OH4oOFVZUKnSV+HDBrmkqWGjsOkL9
 ltXdE9dtPcMrl9GNiXQowS0wBtB1/vpBFDl4aRywoEvQoTpusYyMN7ZAnouJAAh0LQ9rMp/2F
 Wun2nYdI4Iptwn+W/bT8oEB5qGo2iLXW+NhcCI4Sy+wh1ExJdy15AbeKhSMZQuxqg5aI+MbfU
 bugvv7RBdeHz2DGC0Xvqi8pQv41jXiqynDeHoleIH4KtbMAyFh9ub+9o10ICuKpgxhJdksMr6
 Y5UREt98L5l34zHlLoAh/WihP/nD6UAowsWWjMpl1yBvQ0lZIX7toFE4Sse0eK3CZ/xsJA+nH
 nzlMpV4JQ4ataCKDgfU4x7sTQrvozGhnIXmdF0XzPvuctCC7P1PL1dK7pfoJRoxSARTdykXWo
 k/Jxw7mWI+cXl1AZaO5XB5vH7VJ9bhpSpOOIqp1lzYAfCseetg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1802354994-1524303760=:4241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Sat, 21 Apr 2018, SZEDER G=C3=A1bor wrote:

> > The proof, as the saying goes, lies in the pudding. So here is a
> > regression test that not only demonstrates what the option is supposed =
to
> > accomplish, but also demonstrates that it does accomplish it.
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t6050-replace.sh | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> > index c630aba657e..8a3ee7c3db9 100755
> > --- a/t/t6050-replace.sh
> > +++ b/t/t6050-replace.sh
> > @@ -444,4 +444,24 @@ test_expect_success GPG '--graft on a commit with =
a mergetag' '
> >  =09git replace -d $HASH10
> >  '
> > =20
> > +test_expect_success '--convert-graft-file' '
> > +=09: add and convert graft file &&
> > +=09printf "%s\n%s %s\n\n# comment\n%s\n" \
> > +=09=09$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
> > +=09=09>.git/info/grafts &&
> > +=09git replace --convert-graft-file &&
> > +=09test_path_is_missing .git/info/grafts &&
> > +
> > +=09: verify that the history is now "grafted" &&
> > +=09git rev-list HEAD >out &&
> > +=09test_line_count =3D 4 out &&
> > +
> > +=09: create invalid graft file and verify that it is not deleted &&
> > +=09test_when_finished "rm -f .git/info/grafts" &&
> > +=09echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
> > +=09test_must_fail git replace --convert-graft-file 2>err &&
> > +=09grep "$EMPTY_BLOB $EMPTY_TREE" err &&
>=20
> This should be 'test_i18ngrep'.  Apparently this error message is
> translated, and, consequently, the check fails in a GETTEXT_POISON
> build.

Sure enough, you're right! I thought it would not be translated, what with
being an parameter to a formatted string...

Will fix,
Dscho
--8323329-1802354994-1524303760=:4241--
