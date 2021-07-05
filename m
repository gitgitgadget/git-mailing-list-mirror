Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659D9C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 21:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CCF61988
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 21:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhGEVie (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 17:38:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:44603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233060AbhGEVie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 17:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625520942;
        bh=crPdysO+ngBCzCp/dQWxn3ElGD+zR2UfC8bl1h9lLYI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FQp+29qNZpDKSX0gNsDkjo4zMkdiSKOXDMea27ffpK90qYXCMLX5BEHtfXArFERob
         mx1rvDQOkUqt98Dv0iD9hO0k+RFpP+eub0fUVEJ1OX6h5hKiL+tWxSwIjU30Ylwh/z
         7/Z4YmGGvcSh48R8kAM63g67CtJxJxkSzECJTIzQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.249.152] ([89.1.213.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1lD5UY0Ado-00uLTf; Mon, 05
 Jul 2021 23:35:42 +0200
Date:   Mon, 5 Jul 2021 23:35:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        David Turner <David.Turner@twosigma.com>
Subject: Re: [PATCH v3 00/34] Builtin FSMonitor Feature
In-Reply-To: <87czs1d6uy.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107052259340.8230@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>        <87fswyc4dz.fsf@evledraar.gmail.com>        <e1442a04-7c68-0a7a-6e95-304854adff39@jeffhostetler.com>
 <87czs1d6uy.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-799668434-1625520942=:8230"
X-Provags-ID: V03:K1:HnGoKXrUDPFYecso+Ajnp9U1D1Ms+Hr0qvhizkL/TN3PWBE+HQX
 /HT6LeXsj0/EnldsTJF1N0Mi65JgGn1opUJ8xLopJBZyTM30j4m6L+KEgQCb9KLShlvd3qw
 DPSrG6wBWoxKGuMY1mLs4+JgP2WS6oBjnTUBSQl0M+2/XiYWaHq7cRxBLa1hs5zpuGA6Rzf
 e+n89SAdNdZpEYqKGotSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R62LSLjxPfU=:RBMZCcMARB3ZurajwCGO2L
 PboIqLFqGl1Wb59VrybnPOUl3APq4ekCd24gI3WoihDcxxVdyoobKHO6U+T/c5jXtH096tDLO
 RQMPoDTLzHR3r0YYVLI4Su7PxR8Gew8RqztCitn98GE4Oq1yIorWvjGyAGzGHRZADQOnAG0mh
 9snUac4oSx1ONHqqyAgoq8cAcvcS1WZsvuALHQGu+9u02+DbPeyCLROTEqv5iDCA9MIAsbn+P
 MVFWR/lldwIaVj9gHiWS0b8ZmldOmPJB8C6Ji32+HQK4KyG6YiXOQSfwf/RTUeOh7qbRAXIZr
 j1Ga3qXnA5K6hhDFZFkkkc2UbtZD3GsZH3cfECfauehq6ilh1Evf/xwTF7ptdvQgmHIqvb2Ki
 wBPIpuHz8Ng9RaKTyiIyAWKr8cvg3Yc3xU5xqKL2NpLb22n6QWzKagHkHe/r7fO9x4qMnfgSa
 a68Miy9wOFlnJdSr2UN9NSfl7FAmmE224n/pvXowKhZe3qBNtLCK+0pWrSmy0tuzN+fllutcl
 VnRgr/xfdK3dQ7OidSuqb2YD3HYijWHFU+vY3aPCDqZNBao/9zDuikNkD8/0so0NgQW/JsUNS
 g+8hwLtj+dSJLBUfD0V7HNbdNBa1T2YrGoomXLoEjw9ZwvuBT9kmx/ZxI02CskisSweiE+K7P
 ssj2DYOzHr+3MhUfRD4XZpF9VDsktDZlqYFWkZsGM4udLPcgxxhwWRulk/r10cZeRUYwd8Lnh
 V9L8gF/dqfxCkHVjYpiRAxiKrDzcCZbORFgjkNsKkWGPl12nMxsutdfgr4RYmN+2bFvccbO+2
 8ztofYRA/QT4V3LBrfwYxF0t2BWc5C2oX4VI4gnscPgJJZU1gBGaWG9ttsJVQ9erf/JzzqPV4
 bN1CBJ0bu0CiQqgc65gflJcL4sI7sb8fX9bskmcS6aJ2wiAtNlqOwHeOhtdAKbxjNqDDa9OZE
 YKIVUxrZ5mx2bqUl76jz5zgbWL+dZ2/QNc0rw/A32eManMs20bUQWiOSS5H/eqZPzG/XR9Cdy
 zLQhrRKPxM5zM3R9nq4NAq0iR1klKqKqADPoCECYpnz74lUep7zWRTL+pEhspwTmkb2CctLlJ
 5YpkfeLlx/5b2H5B0q9L2TNaayXCjE3rBRxHWvTjWvcSQNWQQD1UJXENA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-799668434-1625520942=:8230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 1 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Jul 01 2021, Jeff Hostetler wrote:
>
> > On 7/1/21 1:40 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> Any other testing of it is stalled by there being no linux backend
> >> for it as part of this series. I see from spelunking repos that
> >> Johannes had a WIP compat/fsmonitor/linux.c which looks like it
> >> could/should mostly work, but the API names all changed since then,
> >> and after a short try I gave up on trying to rebase it.

I am a bit surprised that you gave up so easily, it cannot be that hard if
you use `git rebase -i` smartly.

But I think there is an even bigger obstacle lurking than just the
challenge of rebasing that experimental backend.

> > The early Linux version was dropped because inotify does not give
> > recursive coverage -- only the requested directory.  Using inotify
> > requires adding a watch to each subdirectory (recursively) in the
> > worktree.  There's a system limit on the maximum number of watched
> > directories (defaults to 8K IIRC) and that limit is system-wide.
> >
> > Since the whole point was to support large very large repos, using
> > inotify was a non-starter, so I removed the Linux version from our
> > patch series.  For example, the first repo I tried it on (outside of
> > the test suite) had 25K subdirectories.
> >
> > I'm told there is a new fanotify API in recent Linux kernels that is a
> > better fit for what we need, but we haven't had time to investigate it
> > yet.
>
> That default limit is a bit annoying, but I don't see how it's a blocker
> in any way.

Let me help you to see it.

So let's assume that you start FSMonitor-enabled Git, with the default
values. What is going to happen if you have any decently-sized worktree?
You run out of handles. What then? Throw your hands in the air? Stop
working? Report incorrect results?

Those are real design challenges, and together with the race problems Jeff
mentioned, they pose a much bigger obstacle than the rebasing you
mentioned above.

> You simply adjust the limit. E.g. I deployed and tested the hook version
> of inotify (using watchman) in a sizable development environment, and
> written my own code using the API. This was all before fanotify(7)
> existed. IIRC I set most of the limits to 2^24 or 2^20. I've used it
> with really large Git repos, including with David Turner's
> 2015-04-03-1M-git for testing (`git ls-files | wc -l` on that is around
> a quarter-million).
>
> If you have a humongous repository and don't have root on your own
> machine you're out of luck. But I think most people who'd use this are
> either using their own laptop, or e.g. in a corporate setting where
> administrators would tweak the sysctl limits given the performance
> advantages (as I did).

This conjecture that most people who'd use this are using their own laptop
or have a corporate setting where administrators would tweak the sysctl
limits according to engineers' wishes strikes me as totally made up from
thin air, nothing else.

In other words, I find it an incredibly unconvincing argument.

I prefer not to address the rest of your mail, as I found it not only a
lengthy tangent (basically trying to talk Jeff into adding Linux support
in what could have been a much shorter mail), but actively distracting
from the already long patch series Jeff presented. It is so long, in fact,
that we had to put in an exemption in GitGitGadget because it is already
longer than a usually-unreasonable 30 patches. Also, at this point,
insisting on Linux support (in so many words) is unhelpful.

Let me summarize why I think this is unhelpful: In Git, it is our
tradition to develop incrementally, for better or worse. Jeff's effort
brought us to a point where we already have Windows and macOS support,
i.e. support for the most prevalent development platforms (see e.g.
https://insights.stackoverflow.com/survey/2020#technology-developers-prima=
ry-operating-systems).
We already established multiple obstacles for Linux support, therefore
demanding Linux support to be included Right Now would increase the patch
series even further, making it even less reviewable, being even less
incremental, hold up the current known-to-work-well state, force Jeff to
work on something he probably cannot work on right now, and therefore
delaying the entire effort even further.

Ciao,
Johannes

--8323328-799668434-1625520942=:8230--
