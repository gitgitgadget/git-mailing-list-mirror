Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA741F462
	for <e@80x24.org>; Fri, 31 May 2019 18:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfEaS7W (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 14:59:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:36629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbfEaS7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 14:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559329159;
        bh=5fIM09kLEbHlhZtjJvMTjYDIYFJMfT0v0Im0i/qjuio=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JpgQm7eOBM2zygv4h95+2KM0zi+Ly31HXjKWdsxnJ/K2Jv+DMiIF+DkdsEfOY7Whq
         pBk/BBcZU3uQdAyDdP4PY7TEA7GhNQeu/i0l6iaeRTQoCTcthAmbX7T760fuYxI+bX
         r9AOWQB3NI4q/WFOIisPgFY2hGuQ/0JIesGuI9N8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEoGY-1hMHIy3khm-00G0Fd; Fri, 31
 May 2019 20:59:19 +0200
Date:   Fri, 31 May 2019 20:59:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     GIT Mailing-list <git@vger.kernel.org>,
        Barret Rhoden <brho@google.com>, michael@platin.gs,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Git Test Coverage Report (Thursday, May 30th)
In-Reply-To: <0d7dbfe6-53df-1df8-ac94-4dfab85bbc9f@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905312050330.1775@tvgsbejvaqbjf.bet>
References: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com> <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com> <0d7dbfe6-53df-1df8-ac94-4dfab85bbc9f@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:weY6qjin3qAUDfuJYyEkpU3pNpiTzoUSwmSFa4QKLmCyhHtkkAO
 yI37SQe/tnpcCn7mv/aT0fD6+SsUrrB7g/zfVf0a8LczcYDdIL9mYEBCmFg/z1+GRKDgs9i
 Fx7krtnMjt82CEZkMLMX81L1CgeoskhwK3j6gjc6qXfC+Q7QftEAwR4R+3NPDTQdYmobAxf
 8aI2FbX/aGWGcgt9tgkwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Bo1araBTVc=:wbNVpQ8jlFhouEuJjNQdKl
 P1D8oekj2pUCgULdZG5VOVIveeI0sXbi+4wVD7Xh2iOclgh1dyo1yP+CK6Wuk5YEyhY8y3hYr
 4ioZwjD4OHyXLSGH5Px1KJo/k50ijjFdHABIyHqjILlFdPMGqCzwqEUGTb6aEbD/MfaeYJ/UM
 ROR6YXj49XQUjVuLNOA6srbRJNN0gAk5WNVQgRu53tYv0YgTexQ8IFoJwcUdorxY259N4zkGa
 KfhzW7IEOXIjbuAcdFZ8Jm51D413iLL4mfQJQ8ugeO8wr3ZsN6xqeGY7Y/Dxej4GvhjvLXwa3
 e1lsFxSmNYzkiKLjHfjH+633Rmqt72jVY7qJvHhr0aX9zXW0U3E72Uw7FZupC1F/79DO15gRe
 FjwQVe5+VwkgiKME7im5z15h+ltKeJ8aT1JnnlVfMi31JXzwqd4/ykcSzSqJ8U1H2fNik+30l
 76LhYvh6qHfFmfl26ROc9ATCi3MT/0NZEpakM18rsvWo9cF7/evNqAx2TeiI1poGxQXgA+vc/
 BLB/Qcxqw1beHJzVpvo4gi+Qwbqas7kXNt/Rb2DcXHNii2Im/zJuM6IUyTQSyP1jr2226Lbyo
 NDdjo3cTfViO1Z5vqrd4fTl0YMg3tGvG7FtkiRTZpvMGkVMq3/ok3PbTCK9lpZzOloR5j1veb
 0eNG6I+ZJtmedDmb4k5Bi8PR682WeRmDp/QZ7G4/NtfLCBTEvEhj8E2jKJcgPGV+yx3qcfGGJ
 nnyTnuC0kJMa2GMaxt3eycGLzQW5d8qsysvXnlCV1VsWfkDYj0L2ThfGgy25o5wn0t4B/dszf
 1MNQmyDm2q8oDMRg6U73y5ZKT2sa3+0ZyCCBEzXapE2QeMqEJQBuA5DIjOJqLhdPW8m7/9B5w
 042GSHthLwPYNjwEr32Yrr4oqJiiwEf63NDHxoforGEbeApS/x/Zvf6lhSRtOEwOftJk52Bxn
 yZBsHI2cO9KB8fn18dLVfFF4n/pC3STxf70GxBBhi0iH+IBG5W+ur
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Fri, 31 May 2019, Derrick Stolee wrote:

> On 5/30/2019 2:24 PM, Derrick Stolee wrote:
> > Further, these tests failed
> >
> > t3400-rebase.sh                           (Wstat: 256 Tests: 28 Failed=
: 2)
> >   Failed tests:  20, 28
> >   Non-zero exit status: 1
> > t3420-rebase-autostash.sh                 (Wstat: 256 Tests: 38 Failed=
: 6)
> >   Failed tests:  6, 13, 16, 23, 26, 33
> >   Non-zero exit status: 1
> > t3404-rebase-interactive.sh               (Wstat: 256 Tests: 110 Faile=
d: 5)
> >   Failed tests:  3, 9-10, 100-101
> >   Non-zero exit status: 1
> > t5521-pull-options.sh                     (Wstat: 256 Tests: 19 Failed=
: 1)
> >   Failed test:  3
> >   Non-zero exit status: 1
> > t5551-http-fetch-smart.sh                 (Wstat: 256 Tests: 37 Failed=
: 1)
> >   Failed test:  26
> >   Non-zero exit status: 1
> >
> > They don't fail locally, so perhaps we shouldn't blindly trust the cov=
erage data
> > until I work out why these errors occurred. (Many of the cases I calle=
d out
> > above I couldn't hit locally with a die() statement.)
>
> These tests all failed during the second run that set optional GIT_TEST
> environment variables. Specifically, GIT_TEST_REBASE_USE_BUILTIN=3Dfalse
> caused these tests to break. We now output this message:
>
> 	warning: the rebase.useBuiltin support has been removed!
> 	See its entry in 'git help config' for details.
>
> I'm removing that variable from the build definition.

Would it make sense to have a file in t/ (or a script-let in ci/)
specifying all of the `GIT_TEST_*` variables that are currently supported
(and that actually make sense to be set)?

I saw a similar issue recently in a now-defunct Azure Pipeline that also
tried to replicate what half of the `linux-gcc` job [*1*] does: to run the
test suite with those variables overriding the defaults. That Pipeline
broke for the exact same reason you mentioned: we now handle
`GIT_TEST_REBASE_USE_BUILTIN` by showing that warning.

And issues like this could easily be avoided if we had, say,
`ci/non-standard-settings.sh` that simply set all those `GIT_TEST_*`
variables in the way that the `linux-gcc` job does (and of course, this
job should then source that file instead of duplicating those
assignments).

What do you think?
Dscho

Footnote *1*: It is a thorn in my side ever since I started work on our
Azure Pipeline support that the `linux-gcc` job actually runs *two* jobs:
it runs the vanilla test suite, and then it runs it again after setting
all supported `GIT_TEST_*` variables to the non-default settings. This
almost doubles the running time of that job, often making it the very last
job to finish, and it also makes it unclear whether a test failure stems
from said `GIT_TEST_*` settings or not.

I got so annoyed by this, in fact, that I finally broke down and opened
https://github.com/gitgitgadget/git/issues/242.
