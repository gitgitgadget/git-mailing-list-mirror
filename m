Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58021F461
	for <e@80x24.org>; Wed, 10 Jul 2019 11:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfGJLOk (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 07:14:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:52019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJLOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 07:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562757275;
        bh=fgoHI0JjUU5HXGP9hHrTWVFrmZkHYsGCUA10pMaPrPo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SGzWZTJQ/c66tcaEMN3NJlma0Lo2+jvH/+TN4ZYT2g+x5cuYb+K7CZtFVCGhCxQ8+
         yHkTStlxNmdHx7LbS5OkVIPEKvTdMz6nLL+IND4bCOb5E6x1brhrN70LDVKx0W7NLG
         osI0U4Bwa0bv/oO/7cxpVrO/ui4prIoIh8UkhE3Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MD9uq-1hhuty3DwK-00GZPY; Wed, 10
 Jul 2019 13:14:34 +0200
Date:   Wed, 10 Jul 2019 13:14:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     Brandon Williams <bwilliams.eng@gmail.com>,
        Daniel Zaoui <jackdanielz@eyomi.org>, git <git@vger.kernel.org>
Subject: Re: Weird behavior with git grep --recurse-submodules
In-Reply-To: <CAHd-oW5Q1PWDzWKpsmdv4ecUMrQTj4Vyh_SoVu6vaFeSFmxE5g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907101313450.46@tvgsbejvaqbjf.bet>
References: <20190708111459.135abe50@zen> <CAHd-oW5Q1PWDzWKpsmdv4ecUMrQTj4Vyh_SoVu6vaFeSFmxE5g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:86+xQYC4dx6TDkh+tIKRpEAJqcUFaaYW+9PZk4Qx7OWXq8EBIk3
 xr8dBAf21W4b5O1BWG7z+RutTquvx4HKCi5e41ka435BrVmgOgwXStbz4t+l9mO0MfmpUe1
 AZy6hUXWWMqROY8oalafV4js2tjthHDkqnT/buX+9fE/wD+hKQoYBgTTe0Je0oPUmphf6wY
 f/HwbNiL5NpqjkH0bXbFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cNisLPi61BM=:JellxIBnCqjx6vK4BuCt6I
 /b2JJSyaWt4eley0z3CwdfgY8fHjEB0A9jKj4xpIDykdZKvPxnjEi9DI/gzx0HRKg0SPZQsVe
 9BBX4E+ITxNsXy/3YsAmxwuPkItn3uLtyrjaQqiW/pkXbK6bmSJq2aULi/hvagAuPIGnk9ogy
 1hPhVFFaMEfAr0q+pKz8VaBm7MTeBWiuddqaPP5fRRIz/WHg+qpsUxGfEGu3BRhkJw6BlS+aP
 /5sf7U/JLOv7UOEIRH5zq6Qe75u+4+aik0WAssiiy9NcvB9ig4bHAxteihwe19xaQaq8aqsOd
 qoZnE8M80d4gZYTYgZI1orUvV0NTuoAXwpt4suCYgrUCc2ymMilmHrVK3fZaTURMGLA/MtytD
 FoL4ovYlDVCpm5a6TwyU/Or4Lfe6VuD4NdhgHXlt1Nd0FizuR0lcl8Rh9OehBBLjcJCHM6wH9
 pNfP7eczuI/dxSL8YTQr3uU1Rg20/tYw7/LVR5O6Woh7rgpbi0ihwnU7m103Qs0oGTWJtVzd9
 q56kmLHh3EyKdsroeljl5iWri9v9yJL+VK+qXNgd/v4INp0yCusDA03wwQWaF8Arg1TbUbPen
 3C3FBJgremOFmnkwmprxXlgD7LnJ2ECwk5V7qsf6DYoLHRi2+E0AZLFn/pUXdpRr8ti6EbHnz
 Zl/vsJ3l9FFTbpVH4rMpGyRMfIy6Q8ljNmvG2dLjcder4oL6sujT0b71TJoLIkRe62zQtPh5c
 oJNhh1Ihn7ftooYSmm73lQfauxtTFpJ3uMaGnTDWuhNZv/YDxPcUsRZDuSJqE5i3dJzP668bC
 Rzi1eiXeiyAe78HiS7G+A+b9idDyuNwBFQXL36MKPTZ7wBSmEj2NRCSrQ4uti+kytt4QpuuuG
 LlPGcRajONdFgJ2F4ItZkA3bGpNSoiEZSK3mSmBgpu96KM3b9NL6IIxXbK9CIceOEvukjgTtw
 d957WpGK4BZ/7Y8dlFhkkED4XwuurZQd2915tz++NE0Bf69943MzGLHR709lfW/Ox8iBmGOM1
 E1r8HhniDEeeAbBQ2xK2xOalWYTEpS87PeIVNvjLhLgSIfeKu5H/qlCPby9ho+sJgW3g65me1
 6+K3J4wsUuEXnim/7DKHvbZ/cpLnkTVJHK1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cC:ing Brandon via his current email address, as per .mailmap]


On Wed, 10 Jul 2019, Matheus Tavares Bernardino wrote:

> On Mon, Jul 8, 2019 at 5:22 AM Daniel Zaoui <jackdanielz@eyomi.org> wrot=
e:
> >
> > Hi guys,
>
> Hi, Daniel
>
> > I work with submodules and use git grep a lot.
> >
> > I noted that when it is invoked used with --recurse-submodules, the re=
sult is not as expected for the submodules. I get submodules results as if=
 no files were modified (like --cached option) although I would expect res=
ults taking into account the modifications.
> >
> > Expected behavior:
> > git grep --recurse-submodules string:
> > - git grep string // search into main repo
> > - for each submodule, git grep string // search into submodule
> >
> > Actual behavior:
> > git grep --recurse-submodules string:
> > - git grep string // search into main repo
> > - for each submodule, git grep --cached string // search into submodul=
e
> >
> > Do you get the same behavior? Am I doing something wrong? Was I unders=
tandable :-)? Is it a bug?
>
> It seems git-grep was taking into account the worktree modifications
> in submodules before f9ee2fc ("grep: recurse in-process using 'struct
> repository'", 02-08-2017). I'm not sure, thought, if this behavior
> change was a bug during the conversion or a project decision.
>
> CC-ing Brandon, in case he has other inputs
>
> > git --version: git version 2.22.0
> > uname -a: Linux daniel 5.1.15-arch1-1-ARCH #1 SMP PREEMPT Tue Jun 25 0=
4:49:39 UTC 2019 x86_64 GNU/Linux
> >
> > Thanks
> > Daniel
>
> Best,
> Matheus
>
