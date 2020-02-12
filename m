Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74546C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 11:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF8F20848
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 11:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="egV/CieB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgBLLoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:44:46 -0500
Received: from mout.gmx.net ([212.227.17.21]:39403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBLLoq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 06:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581507880;
        bh=nwdKs/xaPgaYQdsiUj3+L3iEPJFr3hCHkDIWu8gLXHI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=egV/CieB+ag2ZoaX/vpJOYKxUG4vrKhVegaHOdr0/VFMK1e0243zt7C4qxEOkbpkF
         dXRXTW9VcFrtKLkTpt6N0IJUzCf2yJ9CCGSN7SnBNi4jfF6GRj/b6uwM39Ilxy06Xw
         V8HJlVFHmcXyAMmYx911+IZMUA6bWZmQnO68d8Gg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1jKKlW2kL6-00s6O2; Wed, 12
 Feb 2020 12:44:38 +0100
Date:   Wed, 12 Feb 2020 12:44:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/ci-squelch-doc-warning, was Re: What's cooking in git.git
 (Feb 2020, #02; Mon, 10)
In-Reply-To: <xmqqk14sv96b.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2002121243450.3718@tvgsbejvaqbjf.bet>
References: <xmqqmu9qxej1.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2002120036570.3718@tvgsbejvaqbjf.bet> <xmqqk14sv96b.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HY3obADQF5KoWE4czp/WMyJxDgrx8UL/H3BtCmpOOGcIfNtYCKb
 vjbakntRtKtDnurQqQS7d5ksRaau1IiZc2dxStGywgFfBGdE3k8OfITx0GdUKskgCGQYWw6
 Fklu7cpoRmDhPz750a7B5mg6blR9vQ5FLeJbuUF6GjyBFLZK6sDgg5sUh0WlQfws+xN5omg
 fXGaVnTv6aM3S7DyxdWGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zJYTEU4dEQA=:8j17XT8WHIwpAbf7Bd0ZFU
 szhhTiRpWylcwkXBuueLH63A6UbPcCI0Am7MmkylJXqvcsGT1wJYVKEIK2mQYnsFX+FnMITDq
 j95iGaysTnh2MYJ7B/5/ptUkkK72Zv0jIaWjFuZpWVGt6VsEI1T2A5N72yKx97tIG87KXBPFX
 yb4pOGkXgZs83Nz2WizykhTQfpy3IlJM2tTVGR4IRgB/HMg8R9wVq/ZRGeK3J1ttuHa9UAtzq
 ShIkimlEPTrlOqjA1qJJOzfsaVZpQwJjdUsDKiU5LpB2J/9kaQKqj7rQ6HqNXTz7RTYly5r1Y
 GpYBi8FhZ5DOMOBh21OFMyb2kY7NgZySGmQbBq7HKPIprTCuiA26GQHOndT9fQgNlAHuscQFR
 3p9EKIQJG2M94NcTRFgtwRBQUUjJqMdhtO7whOvtl1X6PkvRAC25BJkHlTaNVYaF00axsm6Vd
 TlmF1+mQ1kuWXVgok5jnBJcLJYnGGMjNgQT/6PTKfaCOYfjIzTZUcP6k1f+Sv4cFyBZq3EiDY
 bZGG5mTqOk/1pIxc2WJb8u1bOo7DXA+Anajh6CyLORTpL7Gxz7RrBBxCU3fcWN6Xfsn7sc72B
 IL0vhpIYmkwSQUY2UaibBXWFYSn4Uy2dMcb6yxBXLJ+8PDxSanB6c+BQYDtQNWR8gWO6zE2zZ
 Vx/WARvC4avi67SyeDs8oZf2LT5jWA3O6O51lLjvE04HKpymVWxa/SAHwG2SdpIW+c+algESt
 JJwnrYFNuIol2SVZzR7HrMIfkiBbJhbWklc6uMLq+da0jculpXOV1yenpB00C5Kv8TAIKVF9N
 SDPYW7TQsVtBrFBlYfaFumkUqzEIS+HaZLd6EEmfH1ISK1ZfLDvzhhzxRKeM5JVid7xQnfpOJ
 e6SDrB0Fh6Lt2S3TXsscmD+gQ+YfjcHBZaHJdYD9MNZbk0R8KfXwmWTxQayct6rYC/WMrsM5b
 pNjM2GZ9A/5Nmf5xil1fO55+sKNEcrLvkMdoxv4wRChDeeuJe71WN/8n4bga3d47zNC57dnAP
 uJfwHI+G5T0K3m8ItKLI5v+98uIvtLXOYIDH3S/dqv2m9rKVstYJva/1/P2sZyOhkAuZ9Z0XH
 9QaEfIouw37Y0DqjBS2EAvCxkcXkBWw46AIRHfte0n2RzhRIR3gE3d6mJIxj0wsFJeacrokxC
 lKUinmP2MTNO3O/fpZvq/YzCVEbt0nedOxc8OOAFgtEFxWEINH0EC6CYZ+8zOr0siSuxBQJnJ
 513lYaNyK9KgEHPMw
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 11 Feb 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Mon, 10 Feb 2020, Junio C Hamano wrote:
> >
> >> * js/ci-squelch-doc-warning (2020-02-10) 1 commit
> >>  - ci: ignore rubygems warning in the "Documentation" job
> >>
> >>  Squelch unhelpful warning message during documentation build.
> >>
> >>  Will merge to 'next'.
> >
> > To be clear, this _is_ a warning message, but the CI builds are _faili=
ng_
> > because of it (the "Documentation" job expects `stderr` to be clean ex=
cept
> > for some known warnings).
> >
> > As a consequence, all the PR builds at https://github.com/git/git are
> > failing (except for PRs targeting `pu` or `next`, but I don't think th=
at
> > there are currently any).
> >
> > So maybe we could fast-track this change all the way into `maint`?
>
> Don't worry.  As it only affects the doc builds and nothing else,
> there is no need to rush, but unlike topics that update end-user
> experience (for which, the minimum gestation periods are 1 day
> outside 'next' and 7 days in 'next' before hitting 'master'),
> obvious and trivial docfixes and developer support topics are
> usually fast-tracked by often immediately hitting 'next' and
> spending as few as 2 days in 'next'.  I think this is one of these
> topics.

Excellent.

Also, I noticed that you merged the `smuge` typo fix to `next` within a
couple of hours of me contributing it; Thank you so much for that!

Ciao,
Dscho
