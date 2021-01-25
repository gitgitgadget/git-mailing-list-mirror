Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D080C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 16:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5980D22583
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 16:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbhAYQam (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 11:30:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:49385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729914AbhAYQa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 11:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611592129;
        bh=TNCBGvY5E9CybKhrktxK3qxfqekTkc6ClgkWrGrOAl0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AKfXH4FvrkHSKpLFu8QvGkpzKWaOygDY5pfErBeR+WSIjqikJnznC828c6+DVQDXi
         pOV8HGlD5b5PHJbkt44myAVmRxgmi4SCrhoQ6NeJU3rDmtkNvtZqwjx+wdl12Ajt16
         A5w/QOzkMStjK1ogOKIm0oFfYujSYciO8Wp6/axs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.88.23] ([89.1.213.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1lHUsT3fqD-00Dakd; Mon, 25
 Jan 2021 17:28:48 +0100
Date:   Mon, 25 Jan 2021 17:28:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Patricia B. C." <pati.camsky@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: RES: Can git change?
In-Reply-To: <CAK8LAYUsebOau+XJ66fEesLm4MfMuxJjse0YL408-2jih1d1eg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101251650150.57@tvgsbejvaqbjf.bet>
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com> <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com> <xmqqpn1w95dj.fsf@gitster.c.googlers.com> <CANiSa6gEJ8ezVLhHf+TkGpqvEwvb8HhqtU3ETKiopjLQj6E_QQ@mail.gmail.com>
 <xmqqh7n85qwd.fsf@gitster.c.googlers.com> <CAK8LAYUsebOau+XJ66fEesLm4MfMuxJjse0YL408-2jih1d1eg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wHnwQkPtQUY9lA8Nx/dIvbaEeWJHTSKqrLtLRVeGF0yUkQ/psR8
 3xaH7qN5WrlyyYakNiNMFcsIBbgiKKbsjxJoCqoiheoFtqRBY0cu5sWWdnoRqiD4tG3ErfD
 qU2nPejk0wLZ58TO0+U3xlcL5Pg5ce9t+U+OZOyFWerRcTQEcE8qKwYWnnIif/1XJ7ABVGp
 1bGeyUh3nSrBuvGki7rEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xIOkygjJdys=:7Sn98fc3jxZebwIQ/mLFST
 31+bWGzywYA82Uh6dzxp3hVfeNBDbagMNvs2RiCryInAUTSTVK4PuX98WfL50zl/LW6f3Li2R
 tVBgkLAiY+hNU8ZU35avVe9yFqY4Y2jv78SrefXMBjgTlgyAARIlRM3P5UP+8Pc1aWp/WLsqx
 q+yfqEmPCgxBXP5gEP02S8OJjC7Ekmo6kW2RAxkOmqOfgS0Vz+pUgQNJZx6yrzZ0PqVs6Up7k
 lh+gp+aIZTGwkGoCJV8LWcRBYEUYRHrdof4DfC5gKqRDOtcHS18ze7jK3af1SN63TUWae/Qc+
 avGYZKU6sgLzvhmzWXK5d1t4VyMZFXONNt6XBUH0C2/YHeUAC0ZcU+IMJX9ziMMBvKQfHqpPg
 iaQOOe4fLISAgfTpN+XkCIWYeXOyyxA6ISkWo0wMtijMe+KUyigubx7OhZiQ5eGl/XHmVb4qc
 FQLDLM7+3Lnzo34GSU8TpHouD/saqcOTjusFhtG83doG4rFwPBakKXYkw/Kkswd8fZzn+zG9h
 ExyuaONoA7iuiyWac3bPn/LtB3HFGpu3pz6bNL1P1qx9T/3EZdkw+fKq41+LY6HJzDotYUhiR
 xJp92l9wBM9CQlPYw/10loT2svY0yl1rBfA5r6iLhF/wOo7EEfryQFMA2twpKxjQ3tSsbxgAs
 YkjPRTkSC4Q9yawD0wNOnB1TvNWbj9uPYjZ0Ljx87e2oOzgBGdDu8zvHAw4iYNGQlK9Qk67Pt
 9HX0Gp9IWZzr+ZVRPtp8vF3Ess8gap9/tVOhIRcslVJNK3B3ac59EXDVbKJYmPfedPbenMWtG
 pUVroO8upTDppMFbvf4bcCuNSy3154mI434Kl9WrPxqFEC5q/wY8hBVsNwS889q6L+PvNkBwY
 AtV84+A4A+mL0PmdgHRbit5uoICwETNzWjPExEjn4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patricia,

On Sat, 23 Jan 2021, Patricia B. C. wrote:

> Yes, as Junio said, my intention was to understand a bit about what
> you were doing, so thank you for the explanation!
>
> The idea isn't really to imitate what you are doing, but just to use
> it as a benchmark to show that changing the name of the branch might
> not seem like an important thing, but it is a global movement that is
> being adopted by many renowned developers.

FWIW Git for Windows switched all of its repositories to use `main` as
default branch name: its git/git fork, the build-extra, MINGW-packages,
MSYS2-packages, git-sdk-32, git-sdk-64, git-for-windows.github.io,
msys2-runtime, busybox-w32 and WinToast repositories:

	https://github.com/git-for-windows/

> Quoting one of the comments on the discussion topic I raised:
>
> "It's only the default name for repositories created inside GitHub.
> Since our students only create their repositories locally on their
> computers with Git, I don't see how GitHub's decision will affect
> them. If Git decides to change over from master to main, and there is
> an industry-wide push to adopt this change (which doesn't seem very
> likely to me), then I might agree with you"

Any repository created on GitHub will have that branch name by default.
Likewise on Azure DevOps. I fully expect the other hosters to follow at
some stage, and also for `git init` to change the default in a future
version (I am working toward that goal).

And I have to admit that I am somewhat concerned about your students if
one of their instructors thinks that their education shouldn't prepare
them for more than working locally on their computers. Aren't they at all
interested in preparing the students for life after university? If so,
they will most certainly be affected by GitHub's decision.

> So, I just wanted to show that guy that this is an industry-wide push :)

Maybe Git itself is not a good example for that. Bigger projects face
dramatically bigger challenges replacing the default branch name because
of the short term disruption caused by it. Nevertheless, a growing number
of projects have already renamed their default branch, such as Snowpack
(https://github.com/snowpackjs/snowpack) and the react-refresh webpack
plugin (https://github.com/pmmmwh/react-refresh-webpack-plugin) but also
bigger ones such as LLVM (https://github.com/llvm/llvm-project).

Ciao,
Johannes
