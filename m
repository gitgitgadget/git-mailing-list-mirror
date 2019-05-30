Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 216691F462
	for <e@80x24.org>; Thu, 30 May 2019 15:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfE3PCi (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 11:02:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:40577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfE3PCi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 11:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559228529;
        bh=YUe8UGaHXjFpiPgB3tBp3LLjay1TSGUxJEbhxfi3UQo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bSNy/SDJpzrSsS7c1yq/6Uj6G0Rr3h3/PtYzagetvFMdIK5d8iEiiw/5j++qkKy6u
         0Z7YBTjAIeQ5IIoSztkv8PwJJPaFyR/55ylzeZkiRXkLp3+L7QS/Fqf+8+2ZXtyS6+
         G6qVpTpFRkAKSlia4SixV+8r1dKR2YHmAKstcjpw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.166.183] ([95.208.59.239]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lurin-1gWFii3A7V-0102BO; Thu, 30
 May 2019 17:02:09 +0200
Date:   Thu, 30 May 2019 17:01:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2019, #04; Tue, 28)
In-Reply-To: <20190530115122.GA31607@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905301659070.44@tvgsbejvaqbjf.bet>
References: <xmqqtvdez0yo.fsf@gitster-ct.c.googlers.com> <20190528222604.GA14921@sigill.intra.peff.net> <xmqqlfypyzfr.fsf@gitster-ct.c.googlers.com> <20190530115122.GA31607@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:K+fmQoacf1E31JgLE0HQYIif7P8FgCNmzs36t1ZnbNi5SOYZuRb
 Z3bZLRMynwa+UyR33cxuq21wkTkbNrGew7cJ4x8zOwyz4ivPf9VlVVlCGp9mvi+aJY20+ky
 J/xbrfgnts4e1QgzcB5+3E2iRD7F8m6pRe3ntZget7OxrAv4tMFhWnDVUhE+udemL0Omykb
 kLg56Msedux+MF7Qq3DmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OA6h68eYSiA=:fDH6FQUEDSmu/SSinXmDP+
 wt7mB7sNZhbYsEfsCqI7fpY4ntSS5qOQGxnZTWjy4NHq5awU5TDA0XRwaW+A1Vbi4GQJV0Vgk
 9aHEMpwwDf4aCrYsG/w+n7TNyUO93JxhgW1sJHwmLKh4q7VyQRMT/K7g7Lq7s2lBOw/49qTWi
 Vx0Sb62UTz6jSmfXlvsHMs15l2NV9ujsLibV/DDP+v+F9ejHLKC5VfoCK/J+noBBLjDWOyE9R
 QN5ZcM9AcPCNq+iIMEH79pTdv8PygXTa8pgQ6nlh4OoIvUEMf5teuTQQVc9h5I4aVGeYjxpHp
 dDKKxeXjFDziwtfjApMZvgaMGC4UwX9duzFkEY5xrF9RBhQ89xXrZNg08wzmgHVb8VIS0EYT7
 jvIEhCGq4Bz/U3Ivw1VXQ8XAjwj0mcKXNduZrJe2LHHExKIUkWhQVxqKf/2bfUikD9867ZJEw
 78KY9oR3ApBgpQJlCSrWSzWgbd0fSgFtezrSaHiEQDKpOIRkKciZSNED6N6Ws0eWfa+H4tAnF
 yf4xBBnKcXVBen9boze+v65fTwP+/J35WVAbM6urI9EPPYJ0pRO5K6yAApBlpeUOBeQBvg00B
 UbEyhgLiNJpEwfvriPWrct4YrnMaBNoGX01N2CIBqJLmbcIY2Dr14UqvGaAb1u7d5eNh3wcQQ
 3Yd0IJLEa2GTOQmFBSDYVsQHgtCrdf4CCkJE/LpQVt+AFzpc4nhlatKXVOO72/j9EJR2pqEw9
 pkg44Fz81+WxxmIt0lDpoqvXaemrkgDtNCqwV6Bpmvo65SrwDoa7Bk/fUqFuwRWe4w4cwDt3X
 SNCYCRksjzRYrgygBJXVhoAktc7WPhmiRXfEYgP1p0AiC6FGndxfNq3v5VQVaUbMMQng3u5Qo
 iEE+TbxhvKyGgAYucI3ml5sk7bwYkC1Rg0QIy2KwgqNMjl/2p5fPjHCCcpI/Ky+LivY58jZ3I
 O2FQNtKhxwQO2du6Xm+j72PpeRv/e3D2rytiQfE79Ha38ZGg9lt09
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 30 May 2019, Jeff King wrote:

> On Wed, May 29, 2019 at 09:53:44AM -0700, Junio C Hamano wrote:
>
> > >> * ds/object-info-for-prefetch-fix (2019-05-28) 1 commit
> > >>  - sha1-file: split OBJECT_INFO_FOR_PREFETCH
> > >>
> > >>  Code cleanup.
> > >>
> > >>  Will merge to 'next'.
> > >
> > > I think this one is actually a bug-fix (we are refusing to prefetch =
for
> > > "QUICK" calls even though was not the intent), and it is new in this
> > > release.
> > >
> > > I'm not sure of the user-visible impacts, though. There are a lot of
> > > QUICK calls, and I'm not sure for which ones it is important to fetc=
h.
> >
> > Hmph.  I took it as primarily futureproofing, as I didn't find a way
> > to trigger bad behaviour from within the current codebase.
>
> Hmm. Looking over the uses of OBJECT_INFO_QUICK, they all seem to be in
> either index-pack or as part of a fetch operation. And in both of those
> cases, we'd disable the whole feature anyway with fetch_if_missing.
>
> So I _think_ you are right, and there isn't a way to trigger it.

FWIW that was also my impression, but then, I did not look very closely.

In an attempt to find regressions (and to fix them) during the -rc phase,
we rebased VFSforGit's patches on top of current `master`, and saw this
issue. But yeah, the issue fixed by Stolee's patch seems to be caused by
the interaction between current `master` and the VFSforGit patches.

Thanks,
Dscho
