Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2231FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 15:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbdBJP6F (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 10:58:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:51464 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbdBJP6D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 10:58:03 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MATlG-1cjL6d3Kaw-00Bexs; Fri, 10
 Feb 2017 16:57:33 +0100
Date:   Fri, 10 Feb 2017 16:57:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Bug with fixup and autosquash
In-Reply-To: <xmqqd1ernh7g.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702101654500.3496@virtualbox>
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com> <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092142020.3496@virtualbox> <xmqqwpcznjqi.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092301070.3496@virtualbox>
 <xmqqd1ernh7g.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Xwat1erqt9QkVPhS3GwGhaPpFh5NbWjHJcC0ts/L/rFjBc3dcbZ
 eZylQbsZw4f6gc0TlTflZaGZXDAZ65efzPeZFS4CAo2/Mucg+fdqX0nbkB62UE0al+iZp7r
 Ioq8Pw5efCAC3Kw/9EdChQBNz8WRNJUufPj/PIEV+wo0EtQ5ms/rJrMO8KWFpw8GTMceJ+0
 0aCEG5jUCTDILeg9p/2BQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IVnanlYh7TY=:cTz0612DZDYJLngge9pPDx
 oFN00B7R3W6WOz4oRStDbul92bnb/IpcXqTrSqqIasnZXP0o391x2TYUskil5pA3kUyGu+Mgd
 cxvwMy9WJa5nP2vTZhz7IY0WovKJ/4yjXgH9iHj9Z2bGccE0xl1Y2VnQnYFx1s2mHTu/z8dFM
 kl8Sgzak9c0ZS8ucdDqa6O95i6vXTF9jAQRrB2YNYOo69pZrnA2LGrXzqpZPqWayphzZiZLe6
 +jNs/z9WOYyfhgftCqkrqIVp3W4La/DuTQ9oaAgwd18Mxa5Cpvx/LTjJFqU6Z1zhY/0CHYsas
 4n+R7Xh9WM13wMR+bFH0JNoKDtVJDyJDKjTXPOfI+q4aHpOwVS+4DU7FaOhMi4iW1TCstYsK4
 12DhqMlZPvWg8QmrScgGwzyucnku3GlgMrnIt8VRw6TMg2SMDm+ykhunLoqdqO5pq5NH/SSXt
 3pCFfjLQaUOhmwGnVED0zW2Ub0q8AkHetsFl053C0RcKPaII0xg+LNNcA1SDCEhC1gIQkmX2Z
 p/2aReU97MU4xg6d+pmNtxeFQNc/a4aYbBGk+ZAMGuY3uyUaMPFIBS3jRc81delEzH597R62C
 3gBqnQdjQzqrQ7bhxZTjUMW+aMSNdKdbbXl0CCB3l7Kqt1qQwLoF1ZzzVo7gEjgi2xHpZNcx4
 Ce9naD8+ZLqvNhRI+liNX/Us5sp2tGc8Z+cd5cUyTa+NYd0LB8Ry+eh5c44ewIcYkYCG6jp/v
 h/6o/yLxC6s0dvY4oyC3Ynwd+gybnjJQlns56oz+GO/uhG1iPBy8Tyf8Sz7ie3tBJqHMGJSvR
 EjBI2H5sb9/mddehg+MZWDg4Dg22ySR9a0D51MmBnJwEVtUqtmg/e42C89lDWnWeVGZWnQPef
 hDeRynYKB6lkL07JdcW0GKTgSdocWZKzVbg5xlSnuGKBTDwZYJdY1bVy4BlxnkyyVnzDEvXPs
 KDmYZp81/drZmRt3uFn0Hxt64AmaqcSLEMH9tZDdrnBjMIkCzU8lEbPOFEnDIdXSbihZKJfTu
 rd9l0XaQ6RUl+jpmydDeQvc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 9 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Almost. While I fixed the performance issues as well as the design
> > allowed, I happened to "fix" the problem where an incomplete prefix
> > match could be favored over an exact match.
> 
> Hmph.  Would it require too much further work to do what you said the
> code does:

I was just being overly precise. I *did* fix the problem. But since it was
not my intention, I quoted the verb "fix".

> > The rebase--helper code (specifically, the patch moving autosquash
> > logic into it: https://github.com/dscho/git/commit/7d0831637f) tries
> > to match exact onelines first, and falls back to prefix matching only
> > after that.
> 
> If the code matches exact onlines and then falls back to prefix, I do
> not think incomplete prefix would be mistakenly chosen over an exact
> one, so perhaps your code already does the right thing?

The code does exactly that. It does even more: as `fixup! <SHA-1>` is
allowed (for SHA-1s that have been mentioned in previous `pick` lines), it
tries to match that before falling back to the incomplete prefix match.

Ciao,
Johannes
