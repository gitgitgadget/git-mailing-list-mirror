Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAF71F731
	for <e@80x24.org>; Thu,  1 Aug 2019 21:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfHAVki (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 17:40:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:58413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfHAVki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 17:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564695598;
        bh=T3rvIdx0T/xPm99T9Dv477SPsjIHz0U9bJXKtEJ+7T8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XxXW5j5pvosm2wpgX6LrpVMA0H7AODydRpKTrd2pPUBlyciPU/Rh8Ao2kUOnDszxJ
         HKt4HHFCktjG1FOlm7H64mQygsyMPEg0Z4f59xkKpI5o5F95MBNqwMzS/B2mNtXoSA
         crAmgoliZRdVdm5qnVvHq9PaLk6NgVDHrwh94QSI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQeA2-1hgZ6u1nVO-00Nfi3; Thu, 01
 Aug 2019 23:39:58 +0200
Date:   Thu, 1 Aug 2019 23:39:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ariadne Conill <ariadne@dereferenced.org>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git-for-windows@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git
 v2.23.0-rc0
In-Reply-To: <CAAOiGNzzGqSYxhw=KACYRTxArCY+5H8M4UyY5LFdsnO5VehpOA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908012338070.21907@tvgsbejvaqbjf.bet>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet> <20190731231848.GC1933@sigill.intra.peff.net> <20190801002125.GA176307@google.com> <20190801010022.GA6553@sigill.intra.peff.net>
 <xmqqsgqlo9j6.fsf@gitster-ct.c.googlers.com> <CAAOiGNzzGqSYxhw=KACYRTxArCY+5H8M4UyY5LFdsnO5VehpOA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b+I6yhK5966VlgB20G3fV4SvDkoB8UfLbdvqVuKAZKyxgZ1ZrX9
 rzny/Ve6rtdZj471YeB6jT0jSNgQDflmKSB5MAPMP2CdNCMFFj3gHg1tqy9Ld8Mjb9F+Rqx
 ZEHgWS5EQdvdR+vgBKXaM3YM8qa+HjyEAqc9d7tnLhRNMouXj+yCWmmrHEgLWW7DhKOWZqw
 f9nZ0gorD6b2JY8KzWXhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rhugbk8YPCU=:V1a4ht7O06D4ugS9wnBDJ9
 7aFxJMNNI5zwv1lSx3cG6/TQyx0ukbP1uhzyjpnzWGTrbJk0ViRDj8bNG2VzP44ccwBm28lqF
 uqXzPMXiByhhXq4beIhHcppt6pyDIiTF1r4RIoa2li3rNbozvbjH8C47A07umn1ApOcuG8Ygs
 mKP2eOtc8EXqVAUdFxsbg9Swd+FelrzibZvBKSt0J4MnYcYvizmvRLUg3efY4qZ1K2A8a5LnH
 96jBpRDrsazXfu0GY2XKew4qd5N9uh2O2ClfJf//Vw4RqWzb7eer/9eBS7fStW5g6IB4px42J
 9VfTroZWJ/KP40NOiPO0X4xqQCKfaFYdVvLkJYiicLGUWqWsbMMyvV7J929qLdk92TB3jf5MV
 7cXksUtTSARIUdtX+PRIx30qX5ugmhtwTWbwp5+5INOqKjKeGNZNZIFzxldUoIvSo1pFZ2fXk
 zRvqZhmRuYONT75njOvzDNwPwvUJQdLeoG2VCFPOswiU0HDhJnLl5KxizbaHp7RGi5bAaM+bx
 ENuiPfTPZTK19k5hWF/B8o03OiU3xF8MsPCfLPZCVpl7oiHRujhxFt83nfmhdiSi1TUd1lnxn
 JqeKOM6dBuvu1uPjbayCUKOQ34VnAnHa2AKrMSgmM8Gu++V1VnpwMhLYElEt/mf80jvpx3yeF
 r2J74hGXOjD2eVL4czxaWY6sk7a9jgiFkZL1ETD9iYjH/eA8JzXLN5IWiyQtpFz9E0DiRAFN/
 l1mkM8NKyVXVMhNhoJkysT3oV/H01IheJ4jvOfizXt1AblQ6TscmqIzlUkOCYahMPC2h+QVGu
 P/z1M+b4aVA6aVEl81o7B6PVunIoKfwVNPIkJOoKPjpEPwMhtiVShv+ORrEb6hv2BqDyucGbp
 8mY9gTDHyd0slX6Idf7CylqBwauiwCM/hAPetLFldck9zW9QTh5FMIw6j2dPlCQGVd4uj4imi
 ylYrePWf2ciwxdKZwzYdbDw/ZvKLNFh/Iv+8OsZPdtFvvdtdFzK7obG71LHM122AHYc+eFdPQ
 AwOBz5s9RbqRukeSFg/4uJp219rSrP7G6bvDf15/hL4NjMv33Pc0uAyVYSnosM6TvpBHUBCyP
 Pz5qnuv27sPVP8x1k2ty57HJ1ovFwm45kUBCMcTAaFfrV6I3fnID18yiP4C19YyGyMnaB5G0h
 mQa7I=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 31 Jul 2019, Ariadne Conill wrote:

> Hello,
>
> On Wed, Jul 31, 2019 at 10:21 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >
> > Jeff King <peff@peff.net> writes:
> >
> > > This seems OK to me, though I kind of wonder if anybody really wants
> > > "auto". Unlike log.decorate, which changes the syntax, there is no r=
eal
> > > reason to avoid mailmap when somebody else is parsing the output. An=
d I
> > > could imagine it is especially confusing if:
> > >
> > >   git log --author=3Dwhoever
> > >
> > > and
> > >
> > >   git log | grep whoever | wc -l
> > >
> > > do not agree.
> >
> > I personally do not think it is too late to change for the upcoming
> > release, either.
> >
> > But 'auto' that changes the displayed name depending on the output
> > being or not being a terminal makes little sense, I would think, for
> > the above reason.
> >
>
> I think if the warning is annoying people, then we should just change
> the default and document it in the release notes.  Ultimately, I think
> that this is behaviour that most see as a bug (especially when you
> consider that `git shortlog` and `git blame` default to using mailmap
> already), so simply describing it as a bugfix is arguably sufficient.

I also agree!

And it makes me happy not only because I am no longer annoyed by that
warning that flickers before the pager kicks in, but even happier
because I know people who used to be known by another name that they
really do not care about anymore.

Thanks,
Dscho
