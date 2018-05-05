Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD8D200B9
	for <e@80x24.org>; Sat,  5 May 2018 19:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbeEETaW (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 15:30:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:48931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbeEETaW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 15:30:22 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M93Jp-1f3GEM3fuH-00CO1I; Sat, 05
 May 2018 21:30:08 +0200
Date:   Sat, 5 May 2018 21:30:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] test-tool: help verifying BUG() code paths
In-Reply-To: <CACsJy8D+h+7BXSs1cggRP_UQc5qvtu6ZtrtLiBcu-qLeTpz3Yg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805052126410.77@tvgsbejvaqbjf.bet>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net> <cover.1525253892.git.johannes.schindelin@gmx.de> <6e2bfd3a6eb5270c809262f046e6a8b80090b352.1525253892.git.johannes.schindelin@gmx.de>
 <CACsJy8D+h+7BXSs1cggRP_UQc5qvtu6ZtrtLiBcu-qLeTpz3Yg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-270727833-1525548611=:77"
X-Provags-ID: V03:K1:y+2jnOM3WXmcmBOwYIZbCrH4mp1hse6xEkn8ZBN/xThByFV2CTz
 Dzl7gpe6eLLuM0SYFXDHLdu4DFKeIBpqEbhL5d5y2zT0gibIFe8Mz5H7/OqS00BWoIAeFbg
 za8PqHZM2Okh5BIdL5gFpy6/61cjiKXlDbr6vHRJ+wDTgVVg/KaNU/40BuwL/PI5XlQcBgR
 iywWX9+hf+lkLeb6sxilQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kZSWiqLj4uY=:/6C0leavOMuIzrNAnZqJAR
 vdizQuUFHNYlu6+7iLj0zxyFiQESD/26F0fXyz91hKp6h5h2eMKyXpQ1INNgwx0vJqVhwRvvz
 mqsGOI5f+zdT3rsRFxRMUmbvRLd1XZgd9zLr1k1LDTiMcnwXEGU8DZf6ebXT+lZd4yaj8KuFV
 watqXZkdHA5UikJLrys2SoMagQoMxZ/6LK2mBeKWV5ayk+L+rycyzke4010eMEAoIkSSHeq+J
 uTAIgBQZKUJYkacgjJ7qE4MP6m16aW4+toQrpiBu6DnwxjtB11izzTb/U+fyp6zZSTj4TJ3lD
 87zAbI8106+QrZh1FzyPPlAUoYwrYjmXa0I94XT36NIfdsk6dHX7KVMYkzl4SmL33ofeOcEov
 fH/lO0NXr0sIOGC0ERzhvNmJrG2/H/uy0CrXWj8yQJNjkXqx0s7xt3JuirYn3Xb7JIKIQf17d
 vB+AxUAIo3qCQ4FjUUlXh81NqNBDWOaAwEzKscuNFaszqZx6stAPa1x9/ERZHSca4xSi57PsO
 8tuBElJ4UjAgJxHt12xNxrv7AQzAB192nkujhdJnq4D2CPWW4t3NFmRnjzKWU4yqkgJBVDCSG
 JGfg92KV/koeEpTKyRHSRQ20ktcCdvFmMwV8cBJx4w4PO9lg6LgVoWMnq6m1iy3u57AT4aoKd
 mM9jbJky07sOkyWMbh7cmdS6whdVvpv8dZ7QjACi/ixOYkivBhE2N96cngijIQle6QcSQotxM
 t1jocVPTBvkeRwpHRhr7hmu4MA4fsNii8LP4ztWXXMvrJlEMHH3F5E4bnPDCrYp5fgQgnOhvX
 ERRlmke
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-270727833-1525548611=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 2 May 2018, Duy Nguyen wrote:

> On Wed, May 2, 2018 at 11:38 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > When we call BUG(), we signal via SIGABRT that something bad happened,
> > dumping cores if so configured. In some setups these coredumps are
> > redirected to some central place such as /proc/sys/kernel/core_pattern,
> > which is a good thing.
> >
> > However, when we try to verify in our test suite that bugs are caught i=
n
> > certain code paths, we do *not* want to clutter such a central place
> > with unnecessary coredumps.
> >
> > So let's special-case the test helpers (which we use to verify such cod=
e
> > paths) so that the BUG() calls will *not* call abort() but exit with a
> > special-purpose exit code instead.
> >
> > Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/helper/test-tool.c | 2 ++
> >  usage.c              | 5 +++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> > index 87066ced62a..5176f9f20ae 100644
> > --- a/t/helper/test-tool.c
> > +++ b/t/helper/test-tool.c
> > @@ -47,7 +47,9 @@ static struct test_cmd cmds[] =3D {
> >  int cmd_main(int argc, const char **argv)
> >  {
> >         int i;
> > +       extern int BUG_exit_code;
> >
> > +       BUG_exit_code =3D 99;
>=20
> It may be even better to let individual tests in t1406 control this,
> pretty much like your original patch, except that we tell usage.c to
> not send SIGABRT and just return a special fault code. That way we
> don't accidentally suppress BUG()'s sigabrt behavior  in tests that do
> not anticipate it (even in t1406).

I thought long and hard about this, even slept over it. And I came to the
conclusion that I do not really know whether we want such a special
treatment (you may even want to go crazier and limit *which* BUG() call
you intend to catch, so that others are still reported).

And I came to an important realization: whether or not to handle the bugs
in the way you described is actually *outside* the purpose of this patch
series. This patch series is really only about converting die(BUG:...)
calls to BUG() calls. And it simply leaves the concern you raised for
another patch series.

> But this patch is ok for me too if you don't want another reroll.

I don't ;-) (for the reasons mentioned above: I don't disagree with you, I
just think it should be addressed in another patch series than this here
patch series).

Ciao,
Dscho
--8323328-270727833-1525548611=:77--
