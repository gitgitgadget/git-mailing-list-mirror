Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34F01F461
	for <e@80x24.org>; Fri, 23 Aug 2019 13:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbfHWNBz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 09:01:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:39781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732009AbfHWNBz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 09:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566565308;
        bh=rn2q38LXHVzcy0cVShNDceZJaxZAV6ujBx58bmrB5mI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=csoMx9bh1kRUn4KfOrvHdSnBPFoFRxOB5F9zsuwfswqVV2ENyJFrVoBPMnPRaHhcB
         cwtS+a2xfoBq/auTU7bcbidqAFOycl3BD/evxUErTM9jbwiWnDuPOkWwmpMVgXvbDt
         fnPnOiqmvwFQeScY7aqqTGLFsxE1rcos7kB4sdzg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9s8K-1i7ilP3F4C-00B5m4; Fri, 23
 Aug 2019 15:01:47 +0200
Date:   Fri, 23 Aug 2019 15:01:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-gui: Add the ability to revert selected lines
In-Reply-To: <20190821214829.2dzat2quo3h2s3z2@localhost.localdomain>
Message-ID: <nycvar.QRO.7.76.6.1908231500030.46@tvgsbejvaqbjf.bet>
References: <20190819214110.26461-1-me@yadavpratyush.com> <20190819214110.26461-3-me@yadavpratyush.com> <73e63382-4f79-cfd0-47f4-812f9cd4f88b@kdbg.org> <20190820192944.gzfwnm52fvb5refq@localhost.localdomain> <93095b5a-6e15-ce4a-eb9b-22f9528312e1@kdbg.org>
 <20190821214829.2dzat2quo3h2s3z2@localhost.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RQBypXphz0OHKioy4LA8WlUKbhNJKvVj/q2ezaaYqtcZkfbQoMD
 w5XfnIG/Ks3g/vHYU+qGMCQQGbfCJsgD977T8eL2W0LMZUAPV0bJlJWV3b23bqa2XstYkjl
 x1VL/3Gq2c2dQg58X0f5VSYCCMkSB6q9Hf391d7EDELFwz5PH4rgodDfKK0xOQfV1JB8AOM
 2af05V5DTTySvjfLlxq9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dQPm8AYUSfE=:aCtmllOSmeiGbBX6KwIEpZ
 VX2tsxIlf/w0pkMrawCPkxpiClRm3raoNTr2db/ENMvsi4EPHb0cBpJG+pTyMErM/LT29wIRA
 I9/79gS4D/7222jk8CLGBL9RPWKZDTH1/StPjTcMIEnzYppQX9s8GIqe7lvusLoDUJhPG5DR+
 1emA1ntHhWEBa7bEk8Q7815kiVJMtRKv0kpTL3gkRRXiWuNY9H2yzQ+PZMcnZM3oTn/kzMtXh
 /SWUAen1q0jz6L7pHwPPuwDf9psYiuM3eMJaDjxbhWGrzBvH4jiyJj6Mvdo9Zuva9RdpohCiF
 HhT2WgfEVDfQYK/y/QsJulSUqA5hnphGsucsXSR3N0CfHAcNIc0G6KbThf4rBHWYLbZH3Rri3
 8RkI/bznI0tYkuBX5pucAlmv9cbAAtlHzya/qA/3wa377Y8ey+pQ5vK19fYE42RM18Tjzi1+b
 rphAdYSjNrfhnih8gKeQq4hh9tBoy183JTAD63DtCGNmstngayizdsiuNHY4fuJqGOnke23zY
 aGiEmdPI3M/MYm069XbZihu1RtR1jZ392WKeD2tyM8+Dkk02e6s99Qw2YF9KM9zj6k/gUDXPL
 P60gYWoEIFQWJKIz2uYPh+7eiKTytXk8H9gWb3+bgtrWK60QCazS5KseahnLsZr1pcZgMYYJG
 CkdyY339SpAeFMvHRyljCCGXKIkAgSU6jJDOvTmwSRnV2vzACgVXAs6y/b+D9IVVFAihg8QD4
 pXgYOtKycnGd21WmGico7Q7eb7VW4/Ktvost+65bzzc0e4xrcgzpdrayNNPkNgkWARGKwb/C9
 f5xfu2X2A7Co8zb6xLAOgzp7DMLt2nJP+kc4vgiNx0plcv6tP2hQYNzKQP3kCZOdWFVMSNiB2
 xrca3ShePwuUHf4dhj60cwkIyB9HIi1n7gLJJ2wzm8G8HDb0elt2iSFnsS0KHFDzP+gVJ/3E4
 LKPPZI0WAaObdGK15Ei8SnCJGBdG5zAdM45RcPPGUGFfKN2QJ1cxfnu6HWv+9toGIx4BL7nKK
 okfOLUezfmSCuZszEQGozf3pRHWXLDuPDD19YZ9PB8fctqTUN5BnnbCTYqv1w4M/T/iF4Siod
 PtKMLoCmeAwntZnJmKT3AGSvBoYhvuC0zLGVZ8XNZ3oENLPgdx23s0y/VyONCm8N1PLqsdtx3
 FhVd858i20iFCnU5e5L9mLHfoKAxgYmXSrDovVnVVa/d+7/1WMVuL2VqMTun0OC7EKts8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 22 Aug 2019, Pratyush Yadav wrote:

> On 20/08/19 11:19PM, Johannes Sixt wrote:
> > Am 20.08.19 um 21:29 schrieb Pratyush Yadav:
> > > On 20/08/19 09:21PM, Johannes Sixt wrote:
> > >> Please don't do this. This confirmation dialog is unacceptable in m=
y
> > >> workflow. I use reversals of hunks and lines frequently, almost lik=
e a
> > >> secondary code editor. My safety net is the undo function of the ID=
E,
> > >> which works across reloads that are triggered by these external edi=
ts.
> > >> These confirmations get in the way.
> > >
> > > But not everyone uses an IDE. I use vim and it does not have any suc=
h
> > > undo feature that works across reloads. Not one I'm aware of anyway.=
 It
> > > is absolutely necessary IMO to ask the user for confirmation before
> > > deleting their work, unless we have a built in safety net.
> >
> > But you have a safety net built-in: Commit the work, then do the
> > reversals in amend-mode. Now you can recover old state to your heart's
> > content. That's recommended anyway if stuff is potentially precious.
>
> I suppose we disagree on this. I feel very uncomfortable removing the
> prompt by default, because it is pretty easy to mis-click revert instead
> of stage, and all of a sudden lots of your work is gone. It is a pretty
> common workflow to make some changes, stage some hunks in one commit and
> then some others in the next. Not everyone (including me) will first
> commit changes, then amend them, especially if they are not that big or
> complicated. Accidentally deleting your work, no matter how small,
> because of a misclick sucks.
>
> So, I feel strongly in favor of keeping the prompt on by default. I will
> add a config option to disable it for people who are willing to accept
> misclicks. That keeps both sides of the argument happy. You just have to
> disable it once in your global config and you're good to go.

Maybe the direction taken by this discussion merely suggests that the
design is a bit unfortunate. Why "revert"? Why not "stash" instead? Then
you don't need to have that annoying confirmation dialog.

Ciao,
Johannes

>
> > > So how about adding a config option that allows you to disable the
> > > confirmation dialog? Sounds like a reasonable compromise to me.
> >
> > That's always an option. Needless to say that I'd prefer it off by
> > default; I don't need three safety nets.
> >
> > -- Hannes
>
> --
> Regards,
> Pratyush Yadav
>
