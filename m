Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E1D1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbeGLPWQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:22:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:46967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732456AbeGLPWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:22:16 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lzsf1-1g7eYM3mol-0151GK; Thu, 12
 Jul 2018 17:12:10 +0200
Date:   Thu, 12 Jul 2018 17:11:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost
 assignment problems
In-Reply-To: <20180711100717.3747-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807121711170.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com> <20180711100717.3747-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-712297192-1531408329=:75"
X-Provags-ID: V03:K1:k+Mi+AMp1HPcB39cheBqP6z0mIk6Q+6XEEgXWAcht7J+S2BeAra
 eCVvL08vNHCZGlmqrnM16GxUbIXuQUKTDTkQ5A77HP9ImWTugXGDhtesc4pIfDYcc/6YK88
 amojr2sH8scVKALDob8gGmnXiSQ1hmgK3Ui9YlO4iNZq5jHK59SSpUKc7ZDXG6dXsYCoaqx
 EUPkpVFPxE0ytlxB1EvDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RgzFrdPlJRE=:JxIaLpFfRO4RNMveARyMJV
 Y/KlXVHGu0PV0bcjYU+GHBQWc3SDXSZI5MCvbN0HoDLRW4BctZxkTcvKIQKPOyy2vwuSwismc
 uubqJ4SqHZKuWc33Fx9O0J6w89iwT/Xn/u4bQ65eX1E9T8VkBWyL1SY4wgDxlPXrE+o82ZofY
 vsFNmv1qkoQbu+QsD26yOM4mboBJgAE9VSZtwKtFYZvyVYJYJBBoatyWXOrfru054ZfWi2NQV
 LCG7w893Hw4IX4XeMAtY3hYGIFKwrXe1mcGROYP7lJDPM0ilVAiyFokcOx0XHfCWGEECRxoO0
 MTpKiCSo7DSiaXV8BZpnTzADVvcYXNP/0TaMYX4wYP049FzvHDRDZ8ppw7G7vmLz++hYFU5l5
 Iw1uQ3NNXOY9UBFImFvVwjOhQOII7BSExWFtkP50kqO5wyfc3RxwOAMUt53VK7dqPKwp6Hg+/
 Vn2OAmCskk/fBpEvcu0sAPEgsNCBg5DmLzFVNZNPuIIK83fqTOhM3+NaGZQu2md78b/614Vn3
 6E9dymPxWKcSeLcJps+fXI+OVTlpMD4WZEbF7M5Mdpqv0qkgld7zb2eMeKkWN8Wunw+mXWiDP
 BY4Hw1WW8TOngDe3iiMG4uESRIqzlEJ6Kbt+hPi/TI09ERtT7pHzM4moiLvPBMHjuL97BTkqy
 bWOpWsUkXu3554IWKsdvBYILq/OCNySR0FBY+NZrPs+QNZGArLz4HmA2C+gGeLObVH7RSNG95
 nY5pc6c+ivqoWp7ajtalSlQF6LG5kCynIj5JNpYP4ga1cAqOYsSxFrirSRw4rPMN6EyecTFZG
 Bi7WxAr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-712297192-1531408329=:75
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Wed, 11 Jul 2018, SZEDER G=C3=A1bor wrote:

> > diff --git a/linear-assignment.c b/linear-assignment.c
> > new file mode 100644
> > index 000000000..0b0344b5f
> > --- /dev/null
> > +++ b/linear-assignment.c
> > @@ -0,0 +1,203 @@
> > +/*
> > + * Based on: Jonker, R., & Volgenant, A. (1987). <i>A shortest augment=
ing path
> > + * algorithm for dense and sparse linear assignment problems</i>. Comp=
uting,
> > + * 38(4), 325-340.
> > + */
> > +#include "cache.h"
> > +#include "linear-assignment.h"
> > +
> > +#define COST(column, row) cost[(column) + column_count * (row)]
> > +
> > +/*
> > + * The parameter `cost` is the cost matrix: the cost to assign column =
j to row
> > + * i is `cost[j + column_count * i].
> > + */
> > +void compute_assignment(int column_count, int row_count, int *cost,
> > +=09=09=09int *column2row, int *row2column)
> > +{
>=20
> [...]
>=20
> > +update:
> > +=09=09/* updating of the column pieces */
> > +=09=09for (k =3D 0; k < last; k++) {
> > +=09=09=09int j1 =3D col[k];
> > +=09=09=09v[j1] +=3D d[j1] - min;
> > +=09=09}
> > +
> > +=09=09/* augmentation */
> > +=09=09do {
> > +=09=09=09if (j < 0)
> > +=09=09=09=09BUG("negative j: %d", j);
> > +=09=09=09i =3D pred[j];
> > +=09=09=09column2row[j] =3D i;
> > +=09=09=09k =3D j;
> > +=09=09=09j =3D row2column[i];
> > +=09=09=09row2column[i] =3D k;
>=20
> Coccinelle suggests using SWAP(j, row2column[i]) instead of the last
> three lines above.
> It's more idiomatic, and it avoids (ab)using the 'k' variable
> (elsewhere used as loop variable) as a temporary variable.

Good point.

I audited the rest of the code in this file, and there are no more swap
operations.

Thanks,
Dscho
--8323328-712297192-1531408329=:75--
