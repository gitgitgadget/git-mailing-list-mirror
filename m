Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B191F597
	for <e@80x24.org>; Wed,  1 Aug 2018 16:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389979AbeHARsU (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:48:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:54183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389698AbeHARsR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:48:17 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ldq55-1gBT0i2bsB-00j02E; Wed, 01
 Aug 2018 18:01:47 +0200
Date:   Wed, 1 Aug 2018 18:01:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: range-diff, was Re: What's cooking in git.git (Jul 2018, #03;
 Wed, 25)
In-Reply-To: <xmqqwotcivco.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808011800570.71@tvgsbejvaqbjf.bet>
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com> <87fu0469d1.fsf@evledraar.gmail.com> <xmqqd0v8oaf5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807301510370.10478@tvgsbejvaqbjf.bet> <xmqqwotcivco.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QlxXD2w1kabiC6UhWUyQEFEscX42lZ4kGxda+7v6z6/wL1PadGq
 T/KygSMi6UHX6Z10Houn3Q97ek+Gbu8Kc2sw9dHAdQqWv+O9vFWa8HNJnMY4dk07teJDINY
 DBgGt+raZ+/LbI6FeFDDsHUPIu4Wq3ueEaXV/ptfspCyHXPUq98C9Srix/bOD5SHWp9DhUF
 K2q7tmM5djBuLNTmZpw1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BBDSxxfQZVs=:nuab6vK/Umdm4/6vZ8AQ+1
 C5r4im0ktRnizrs3AsszmFusuWNSqwQi5sQYscu0SrTYiPWpYC6YhnWBRM+jBm2/pTrlf6Fc3
 9jyepobrWKb9rGQiUdLrTbfi3Ut5XjH3MQGgJhkPshIqJDjD6uHbW/5Qs56etZHtoCqJMS/nk
 LN9xh2PELjqFBwh54JBee5gbIwcc/x8ddvO0EAe+KTz92u7MJL8Z2B8nKi7szW8mtiYkKr0iY
 L8hMRaGTI5Y4CHjx0gFhDm63E0S6hpcSv2O91qo6K0uH3lMinSc3XZ7x4kLCpb19JPuHMywGO
 gO78uGA3D6BNiZgxFjjNXtE75WmIzMKJH7qoEZetXt1/mRlfBpO3rk5vcEWRdumDu0AclDi9T
 /quB1VV8yjug2TpE0E0IbrmSb6WDnlJCmT3xesIfXDiXR8L1l9B11izMmoRXE2HsmU3is0yJD
 fNhaH66a7zIh0vEwrmLsbR4YHReTvveoVzsE279egb69ae01UETecgpxwg4uyeD+L3kICgiJn
 6YXY8V3ZkyVmdDHd7KkZwGo7iJfdREIsu/WA1/k+AyjCB09t4C7hdADUKtZMOs2jpUDHFwAYE
 YoQPRz1+i+d8UC082ryXMHsFq6JlrgHH7Lq4Xc1WSfFUej614GU7HzwmacVw+s63Zx5y0agBX
 v1ZEgRL4MHAoAqxDAv3Rlr5HZeWeG+GnzUUU5tPEGXVqJxGLWRF9a0yZlirtx6na2tYPvNDrd
 IheQjLAAAKypXUKvgoJ9Po7pch6UZGajITmK8gtukNWwCayxZnuW3Ltj6ldvcrYle8R/t0Ob9
 jpD0O0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 30 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > FWIW I picked up your Asciidoc-underline fix, and I also fixed a typo in a
> > commit message (you may want to pick that up, too, unless you want me to
> > send a full new iteration, I don't care either way):
> 
> Meaning that if you send a full new iteration it would match what we
> have on 'pu' plus the one-liner below?  I think we can do without
> such a resend, because everybody has seen all there is to see if
> that is the case.
> 
> > -- snipsnap --
> > 11:  bf0a5879361 ! 11:  0c1f5db5d01 range-diff: add tests
> >     @@ -3,7 +3,7 @@
> >          range-diff: add tests
> >      
> >          These are essentially lifted from https://github.com/trast/tbdiff, with
> >     -    light touch-ups to account for the command now being names `git
> >     +    light touch-ups to account for the command now being named `git
> >          range-diff`.
> >      
> >          Apart from renaming `tbdiff` to `range-diff`, only one test case needed
> 
> I'll need to remember to rebuild es/format-patch-rangediff after
> amending bf0a587936 with this, but I think I should be able to push
> out the result in today's round.
> 
> If any other issue arises, I do not mind taking an update, either,
> but I think at this point the topic is reaching the point of
> diminishing returns and should switch to incremental.

Thomas had a couple of good suggestions, still, and I am considering to
try to find time to simply disable the whitespace warnings altogether in
range-diff.

Ciao,
Dscho
