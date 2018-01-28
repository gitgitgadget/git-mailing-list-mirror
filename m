Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61921F404
	for <e@80x24.org>; Sun, 28 Jan 2018 20:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeA1Uoz (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 15:44:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:50816 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751798AbeA1Uoy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 15:44:54 -0500
Received: from minint-kr8j64v.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LkOaJ-1fClfG3fjP-00cNWN; Sun, 28 Jan 2018 21:44:49 +0100
Date:   Sun, 28 Jan 2018 21:44:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        David Turner <dturner@twopensource.com>
Subject: Re: Some rough edges of core.fsmonitor
In-Reply-To: <87efmcw3fa.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801282140330.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87efmcw3fa.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1538789730-1517172289=:35"
X-Provags-ID: V03:K0:SqhDYm9lxb5HiuWQYxx8FF1hZ85NJWFB8jH1eM8Ewqzj1JGw8jQ
 koLsic7C9ncfsQqUr//nvZkYM8OXU93ns5LjzSrp4Qdreejn2XsRbVVCcCdpEPOF3XJzwQh
 XP57he7quMq/H8CRri5b/P1txj5zSzUSKN2uPy0/rxHkD7YzmpOImUxFFYn5key+/JrvoOl
 Wh7B/y4VW0qWDdoQ0Ooog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I1KtG+CEpL8=:W0vdD/TbqYoVxM9Edr43hF
 ZJXh0EzXoMW2+HuMjZejGnLWPS4n7Bn6zEZh4vmkDVsHQoCFNjNbyDhWQsLI2JjQVhapJXUA9
 V6Xy9JsGWdxnbdSYNZ3Ep8EbHAvD+0yNfd5kMq/75MgsyBEJa50v3KyZJL+EES/vx0Ifkgz6R
 Fj//N8qbv6Qk5LZX3IIBCpp+uEnty8bPgzcjEGh33uXLWexfBcbfC8gjfQ3C+85UxaN8USTMu
 zMZfPmFkFjP8J226NWipLYZhIf+eUwGB3gktVklQUogKBggr+i71cNEsCTvVP9Sbw7/Adv69K
 HAbg4OHwE847/YiMABYwPil8x0Uh/WXc47T2bFRTbNTO4nptClQoV2M9YLf0dl+HvCQ0GTi8t
 ZsSB52xWkmSAVgIJqif/N9mQ2F2Jzp7rPjS7TTMByAhxRbFwmeOGdAzsXUt+KwGVSFbrS4c5z
 yyg4eROCThSbxjzfPeE3yg9vUzyWuhUZ56xiK0Fyl0RA9xjiir4y5lgq+GKHvjupYS0UManer
 PcI2AHzwDnXCLjbVR0/qXo2ydkBAd0oJhYQpKmDAeNH7N/2in8DVaKh3op7BaDDyOyoJWGVyQ
 fS/WSWSakyzysItfOjR5l2XHDjEW8uL5n48CtSL3NAE+xPNZ665Yue7z2dUpnfDyumQfj9Wwk
 YYN8MPCCzgh1SsUVvlGKQwGE92+SiMuF6+2G3cNne3D/TQBKVLZLXzGi9SyNuugpaQ5D1H2sd
 +qGqRUJtY0unhmuwCkHO/sh59sjn853ClGmjrmgi0nB3Nga4rBG2FOLc7FCNQIAmMttJrO3mY
 JZ7IPnybgtKnY8+Y7q4aZ+QbPezST4CgFRyNpMfr8VVjZBWTKllRTLrCsSpGeq67M+N1HsJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1538789730-1517172289=:35
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Sat, 27 Jan 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I just got around to testing this since it landed, for context some
> previous poking of mine in [1].
>=20
> Issues / stuff I've noticed:
>=20
> 1) We end up invalidating the untracked cache because stuff in .git/
> changed. For example:
>=20
>     01:09:24.975524 fsmonitor.c:173         fsmonitor process '.git/hooks=
/fsmonitor-watchman' returned success
>     01:09:24.975548 fsmonitor.c:138         fsmonitor_refresh_callback '.=
git'
>     01:09:24.975556 fsmonitor.c:138         fsmonitor_refresh_callback '.=
git/config'
>     01:09:24.975568 fsmonitor.c:138         fsmonitor_refresh_callback '.=
git/index'
>     01:09:25.122726 fsmonitor.c:91          write fsmonitor extension suc=
cessful
>=20
> Am I missing something or should we do something like:
>=20
>     diff --git a/fsmonitor.c b/fsmonitor.c
>     index 0af7c4edba..5067b89bda 100644
>     --- a/fsmonitor.c
>     +++ b/fsmonitor.c
>     @@ -118,7 +118,12 @@ static int query_fsmonitor(int version, uint64_t=
 last_update, struct strbuf *que
>=20
>      static void fsmonitor_refresh_callback(struct index_state *istate, c=
onst char *name)
>      {
>     -       int pos =3D index_name_pos(istate, name, strlen(name));
>     +       int pos;
>     +
>     +       if (!strcmp(name, ".git") || starts_with(name, ".git/"))
>     +               return;
>     +
>     +       pos =3D index_name_pos(istate, name, strlen(name));

I would much rather have the fsmonitor hook already exclude those.

If you *must* add these comparisons, you have to use fspathcmp() and
fspathncmp() instead (because case-insensitivity).

Ciao,
Dscho
--8323329-1538789730-1517172289=:35--
