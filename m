Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5D281FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 19:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933405AbeAHTgR (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 14:36:17 -0500
Received: from mout.gmx.net ([212.227.17.21]:58251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933402AbeAHTgN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 14:36:13 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfmZs-1eDgac2udI-00NEDJ; Mon, 08
 Jan 2018 20:36:10 +0100
Date:   Mon, 8 Jan 2018 20:36:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: rebase preserve-merges: incorrect merge commits
In-Reply-To: <CAJs94EYrBgNW-bzoEgy9=fStJW2esoULxfOHX45V63HavqOCpw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801082034470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAJs94Eas59UxZ+490AUSOuB37i+JBEvbCnGBMVpKi1G469OTbw@mail.gmail.com> <nycvar.QRO.7.76.6.1801081452290.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAJs94Ea52CcNvBxXVeZLvgsaS4YPiXaeDvRm2zUopoLVowgm+Q@mail.gmail.com>
 <CAJs94Ea_Kf5RFMuPreBOGYEjhECdQP2F7m=-wDkf9xRnQFPfhA@mail.gmail.com> <nycvar.QRO.7.76.6.1801081730170.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAJs94EYrBgNW-bzoEgy9=fStJW2esoULxfOHX45V63HavqOCpw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hYtVjdwZ2G1ajNEl3YS1pSSN3DO3/Dvvmn9gCRziEA+0Kk6O6s3
 Bb9WD6sffP1AVv44nm7JoLKgDtDYP2l/BDHREtezDgOBr/DeOJOpIWi+MxaXJP/K+ukxDb7
 OAX8lqskE9vdt0FG0JwwfVJG0siP6HgTRs/645YNgOWwmNojwcB+0tlXTzoZyaWkCWW1PgU
 wy1W7iX5c9RFlYtUfUKqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JDw0gfLI8VE=:Kz1rxY8WuI62JBDnks6e89
 IXQbIaHSYS9i4DnyN8nO9OvcdCO22+x3/8qgrbTnR4UW1ZeRKpTQT0rfoxIYMMeXVF6ktxWjZ
 fnWhv/O8v2E4js845quoE5jQI8xFOF30PMoMdb/FrkkA/4k/AzmMHQR9h6U10KU5D5C3vxwZv
 oO404ttSRYtOAMP7VLTv/Z7hhb6PYK4q6/t9yj+bXIqdGD1RCvF5y0HoXElyqRgdICbYy+TUC
 HNTx8dqPkUrbX+BhvqHMqNxU7orViuN9pZBpk3eiDFKZkErkkgTGPeYFbwltgk/3eM9VYuzMm
 cYSFDtQHNdGgMG/YID0OBxiXIqDHGqvkA3W3dW0S3wxDbN6+x+2P8AjKIpNPjSF8zyXizkFJl
 WsrMgnVG8J2LRFEC3XJoA7cmB6COcc886k4Aly21+SA9z99+C7nmbrK02meX7mKhMyfrVhguN
 zFILHF+VIRqQoFJ/VBZy2l/WZxQna75YEE0sWJtfYUvjf4ezAuT7Yh+66A7qzT7cx9w/RjKfr
 klFahozgO8wPMA/1YfZmqrD5lhvRFxN6HsOAAUAyHQgS1bw8wQKpznbboFz4qkX5ywtAhaXjE
 1pqTU6q/Gb7rl0Y59ESkEXlw+WedUJ0cx4KoXr8U4FeQ3r7ek11HNzriWVPO8ooZUEosZKMWE
 bx759C5IGXXt/+dDg/3j+mms3QkCqCLSB0Ig/Z87FjY1/HzDMwbbHRZq6jKffdHCCbU9uJIOV
 zYd5kthYFH31ziCmaCJOEYLYJJEAEZTpTIqnqbR2ku8jzaPxIV9duuQt0N2DB8JCqjbHeozLv
 Ead20LIEUGGQmXUrtr4B5UKm/a+aIKGKCK0aunyI3kO1xvlHlm7Bx0VLfOltmBUTF57WIkhdA
 t7v7RvH0HUeLr0gQCPvjsD4GJi+8I4CdYg42G3kTt3rW4F+b+3zOKUQI3HiHRyUdYmdhBElTH
 rRx2zWaY0PPpGFE8fA22GkHcGzcDrFzVitOJuJIBgBcLkTw0KfWqjJ9G/HLinMQkPGIjn2loU
 b06xWCgpQQbyFR/Lgi01LI8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matwey,

On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:

> 2018-01-08 19:32 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >
> > On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
> >
> >> 2018-01-08 17:42 GMT+03:00 Matwey V. Kornilov <matwey.kornilov@gmail.com>:
> >> > 2018-01-08 16:56 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >> >> Hi Matwey,
> >> >>
> >> >> On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
> >> >>
> >> >>> I think that rebase preserve-merges algorithm needs further
> >> >>> improvements. Probably, you already know it.
> >> >>
> >> >> Yes. preserve-merges is a fundamentally flawed design.
> >> >>
> >> >> Please have a look here:
> >> >>
> >> >>         https://github.com/git/git/pull/447
> >> >>
> >> >> Since we are in a feature freeze in preparation for v2.16.0, I will
> >> >> submit these patch series shortly after v2.16.0 is released.
> >> >>
> >> >>> As far as I understand the root cause of this that when new merge
> >> >>> commit is created by rebase it is done simply by git merge
> >> >>> $new_parents without taking into account any actual state of the
> >> >>> initial merge commit.
> >> >>
> >> >> Indeed. preserve-merges does not allow commits to be reordered. (Actually,
> >> >> it *does* allow it, but then fails to handle it correctly.) We even have
> >> >> test cases that mark this as "known breakage".
> >> >>
> >> >> But really, I do not think it is worth trying to fix the broken design.
> >> >> Better to go with the new recreate-merges. (I am biased, of course,
> >> >> because I invented recreate-merges. But then, I also invented
> >> >> preserve-merges, so ...)
> >> >
> >> > Well. I just checked --recreate-merges=no-rebase-cousins from the PR
> >> > and found that it produces the same wrong result in my test example.
> >> > The topology is reproduced correctly, but merge-commit content is
> >> > broken.
> >> > I did git rebase --recreate-merges=no-rebase-cousins --onto abc-0.1 v0.1 abc-0.2
> >>
> >> Indeed, exactly as you still say in the documentation: "Merge conflict
> >> resolutions or manual amendments to merge commits are not preserved."
> >> My initial point is that they have to be preserved. Probably in
> >> recreate-merges, if preserve-merges is discontinued.
> >
> > Ah, but that is consistent with how non-merge-preserving rebase works: the
> > `pick` commands *also* do not record merge conflict resolution...
> >
> 
> I am sorry, didn't get it. When I do non-merge-preserving rebase
> --interactive there is no way to `pick' merge-commit at all.

Right, but you can `pick` commits and you can get merge conflicts. And you
need to resolve those merge conflicts and those merge conflict resolutions
are not preserved for future interactive rebases, unless you use `rerere`
(in which case it also extends to `pick`ing merge commits in
merge-preserving mode).

Ciao,
Johannes
