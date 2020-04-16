Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA28CC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 12:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5720767
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 12:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YgGbdhlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634882AbgDPMF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:05:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:41413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634915AbgDPMFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 08:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587038706;
        bh=gC4Ed7krXljo/bfWcuHgiNN9T3C0Df5R1P2gje4p8+E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YgGbdhlpYil63rCKkYWPra+I1kF3NRxK5WIDfeY/EEOoS3NAOhYQpSzWX6XvX/Fsl
         xqLesKyoNM0Np9DTeMLP7ZCUmGYWtQ5mB4ocho7FunkZ1qX/h3gEqzizQB2hTrwhPJ
         rIJ2Qlk9D/Ib1OaDu/OebCigJ8ZsEJU1y+UECcog=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.99]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MdNY8-1ipzUo1yAi-00ZMxD; Thu, 16 Apr 2020 14:05:06 +0200
Date:   Thu, 16 Apr 2020 14:05:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Danh Doan <congdanhqx@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: fixing ci failure of 'pu' with the es/bugreport topic
In-Reply-To: <20200416112605.GC2285@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2004161348530.46@tvgsbejvaqbjf.bet>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com> <xmqqpncgmk5z.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet> <xmqq1rovl54d.fsf@gitster.c.googlers.com>
 <20200410174141.GB27699@danh.dev> <xmqqh7xk45l4.fsf@gitster.c.googlers.com> <xmqq1roo43sp.fsf_-_@gitster.c.googlers.com> <CAJoAoZk9Y9rc7ssfZ6S3pYepK6LpapoSzBAQjL+f7uHXv79HWg@mail.gmail.com> <CABPp-BFM-A43GpOkfNeSt6KKsdpXzObhwajvT5qBp-ws_jstRw@mail.gmail.com>
 <20200416112605.GC2285@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JNVOfHp3OP2N8QAW6/7dfa97wzoqRQX6Qaj37tvGEf72dfagEoD
 kbiM2V4IJlb+aPryCYI5p8SjIFX2UfRqQgUxYTKzTcDElXT0RYj985yZLCb39cMdomL7MHU
 sQ8ArU0Ngdaq3I1KqCypNDRtZVSYsm6YFMiN36+sBpWcO04DXkGt0UosPT1OuOQYjp5CW0n
 CXip/zyg/+5Vi1upJjjeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B8G/g6FHxTA=:MuvpyUBi9IJ+DNANGWZJ9D
 fZ7kyAyOH+WT3692yGXtRWAsguhm7kLCpBzAWguqG9QFD8S79xO2MvsrZolmFS2hqtu+N9Yfs
 3zE4SA0H8r6eL+4WDNwiqw3u6U62ml/FvFofzNTA+6WnstmoaYAoTt9aKbZESV4XiJBmhPAut
 EX2ObhAomEqPZaFR3e6BfhYZ6ozrhUwrrobHlLrsyJATJXHfurpHFnu3ni2b6hQ9/VA+A8vjC
 o1LdehCJ2gwan1ldnN0rWP4QnudBybMNi0lt0jRJfCgNi0o2+XLFNiLwTLxWb/3bhS7V6p+Eg
 fryV61HgutyR0Ys5+kH9x0xoEEQ4YbXCG/AyS/SzvHMMYG77vG4vawoid+FwBuJJ0xLjspqz7
 C5cnsKugfK/8s+4g5kz6pyWjfiguZwpknEgijSHLM9/e1FUUT1h7Ay93ZUrnLLBtG2c/bXVOb
 8X8ld1YXRuJmRMVoCc15wIId3TfDmr6ZgvjeVGDPkNp4g0FTJ6yIwfHjlCDWIpTToOv+eZDTQ
 2NsCLHbNlxx2zkhap7kKcFF5TSCN+pRCOmmQl/W+zedFneRWFP95H+1dS0zSOc6Kfpe/R79m4
 Wn/V5hBvxTqS8Y6FcYF9nQfw6RIJBmRfBn30tAAQioieqHQ9+obbAbcAEREKqdcKDms/p0PGS
 tk51M0VlzR1UnGcf6gfkHYXVmcm6ovMMir95n1RLPIesFrHwwYP6lPgV25m3+1Mnebu8upCoG
 /Mdu4jg8hWCYiz89YpIX41LKVQAstZ10yYpQSlXyDEc74IQ/3MN+PHx5fV46DOUD2xhCuLlpF
 10gQPkHDeEQmjhr0SyQY8Nkb17x1cGDAd1AAslAc/zrHaT+xthlGLaEOsbXoF1LJQNhG7sYWA
 rzcUkmHnyuElWWjTyc+k/+8MRWvwwxMBlVS0WkIdykp7z2fHpuoJ7eg9ZTCFaSHVfNS6l98HF
 LutoK/t0DCvCXEw3t19SHtQ4oOYCN+1tH7EkcOAUgzUaY9zoSxXxJbMjXde8fdcTrUDfLjLNd
 dW5rEm5HlNy8299GcNQ9gFtXYDp+L5VJQA0k/lI3nOY+rCqOFU0oaTi1mex9nlpmX/9gUeJES
 eWG0xRoJlcy9w/d8EovX10VDQLKySoRF8vsgZdElONXtCZm+GOkgyl4RYDGnQCjE3nC4edsY6
 x2+LNQ48N4cA8RplI2yqdNsXNO0HyCEoJzcEjsuP1anVIU5BfLENpT7KEvlI31+fTe5Qi3MBD
 leE4FA/VNEH1JLAA1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 16 Apr 2020, Danh Doan wrote:

> On 2020-04-15 20:45:05-0700, Elijah Newren <newren@gmail.com> wrote:
>
> > On Wed, Apr 15, 2020 at 7:01 PM Emily Shaffer
> > <emilyshaffer@google.com> wrote:
> >
> > > I'm curious to know how I can check this build method for myself for
> > > next time.
> >
> > Create a fork of github.com/git/git and open a pull request against
> > it.  (I believe you could also fork github.com/gitgitgadget/git and do
> > a pull request against it, but I switched over to /git/git a while
> > ago.) Immediately upon opening the pull request, a bunch of linux,
> > mac, windows, and freebsd builds will be triggered with various runs
> > of the testsuite.  Has been very useful for catching issues for me
> > before I sent them off to the list.
>
> For the time being, open a Github PR will trigger Azure Pipelines to

Please spell it with an upper-case `H`: there is no `th` sound in GitHub.

> check various things  with both Linux, macOS, and Windows.
> This Azure thing doesn't have that vs-build target, yet.

More concretely, you will want to open a PR at https://github.com/git/git,
not at https://github.com/gitgitgadget/git.

For reasons (having to do with Junio's practice to base branches on
older commits, where `azure-pipelines.yml` either does not exist, or needs
changes to pass), the latter runs an Azure Pipeline on Pull Requests which
is based _not_ on `azure-pipelines.yml`, but is essentially a manual
re-implementation of it that does _not_ use YAML (but is revisioned
separately), with manual patches for all kinds of issues on top that have
made it into core Git's `master`.

However, in your case I would strongly advise to simply use a throw-away
branch, merge in the GitHub workflow patches by Danh and myself (as
described in the quoted text below), and push it to your fork on GitHub.
That will execute a workflow run that will show up at
https://github.com/nasamuffin/git/actions/new.

Ciao,
Dscho

>
> We're moving to Github Actions. When that topic graduate to master,
> we can simply branch out from master and push to our fork in GitHub,
> it will run automatically. No need to create a PR on git.git anymore
>
> To check that vs-build target for the time being by merging
> dd/ci-swap-azure-pipelines-with-github-actions
> and push to your GitHub fork.
>
> --
> Danh
>
>
