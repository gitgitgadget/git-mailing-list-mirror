Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FBFC1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbeGQRTw (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 13:19:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:58499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbeGQRTw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 13:19:52 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8ZtH-1g1NmC2a5T-00wAVa; Tue, 17
 Jul 2018 18:46:11 +0200
Date:   Tue, 17 Jul 2018 18:46:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Daniel Harding <dharding@living180.net>
cc:     Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sequencer: use configured comment character
In-Reply-To: <66ce6f94-49ae-618e-bf6c-43a0f15bb752@living180.net>
Message-ID: <nycvar.QRO.7.76.6.1807171844040.71@tvgsbejvaqbjf.bet>
References: <xmqq4lh4z870.fsf@gitster-ct.c.googlers.com> <20180716045902.16629-1-aaron@schrab.com> <nycvar.QRO.7.76.6.1807161758560.71@tvgsbejvaqbjf.bet> <66ce6f94-49ae-618e-bf6c-43a0f15bb752@living180.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sXobYAYh9Mt7sfel+Jqylhr70R4pXXTYkdoexjXz594hH5fesui
 IkmEVF/HSvX4ZJFMU4sd6orBV2n9AM1r1mm3ufgq8eIKVANQx6QcfleO4q/Lz6ony1v/sGE
 02cgAb/Z7MsaFvdbvJbXKYvXmg5CvrwEsJPWIU5WXAHSUzFIRrAooWwJIjOWu1cHY1tBIvR
 +POQ/31qpS2YbHIwS1QnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CDLQYDnKiBA=:9Y+BGcOr65B7os2Vzwbiap
 WdG3lSzF/aXbtVqkvTwpFrWYnylBFxcb6ARzHgdj7OQPnsLkGrkJ9SlFXbMB3Lo1JkrLCtytJ
 2ScBlltc3vjBa/5kdI8uFXSFM3vsZciT7ersHTh7zQ4rVTJ6qEIazkGJSWhgFOq/GvlMqtrS6
 PwjTFWLi0opQxIxw3ri0+K8FR9Acitq8J7kipyFeXhl3UhrK1WSim7+DOdF0vcc0rCBHVNzeh
 LhXS8H8WVPfKa0sNOGnjCKpucZQmEZhGD1mQ1zN+KTAj8R5Pok5pqwgAUGOiXLV8InACNa4lF
 THeg1nqUCOX2GibFdnLl45bxVjFI953UY4BFqYMEGn2m3TaJVCouALgtqZI985EBdV0NOFll0
 H2s41vNSquEpxspFrTh/FVKKjQ512wPiG8j9ipS91WOkX1nTlBrtDmmVSIq5cMckKwIbS05JE
 Yqvl8D3T7J1ij6GI13/9a6Ju0/PsQwEBVniNvgRalq6hensvC9eISHAKKvS+52UejGy7pf+r+
 cLUjywmg6kSWGvKN/2EkD1JFiOLflil6qyohETSXoT/wBT1rFhOhUvj/CNSogKzEHbKnWl2O7
 LkLEz3g8emZ5e4IipwW6/q9y8LEKnA1P5/yr7y+cegggjWVmheX9cDTXzHCtYcprhiXn57dBm
 sQOiReyT2Y+f8mhNedsXFEzgoCqZoML/lhvB6rR00uZkDlsFpZbozK6+GGLykFvjalu+rbtMV
 npbtIlJB91IrKvAchJ2VoEFia3rwU4f1tFV0QoOnbkMrMbv2DgIPhzZnVzC0gMA6SM7EYzyp0
 hqTYGS7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Mon, 16 Jul 2018, Daniel Harding wrote:

> On Mon, 16 Jul 2018 at 18:59:03 +0300, Johannes Schindelin wrote:
> > 
> > On Mon, 16 Jul 2018, Aaron Schrab wrote:
> > >
> > > Looking into that a bit further, it does seem like my explanation above
> > > was incorrect.  Here's another attempt to explain why setting
> > > core.commentChar=auto isn't a problem for this change.
> > >
> > > 8< -----
> > >
> > > Use the configured comment character when generating comments about
> > > branches in a todo list.  Failure to honor this configuration causes a
> > > failure to parse the resulting todo list.
> > >
> > > Setting core.commentChar to "auto" will not be honored here, and the
> > > previously configured or default value will be used instead. But, since
> > > the todo list will consist of only generated content, there should not
> > > be any non-comment lines beginning with that character.
> > 
> > How about this instead?
> > 
> >  If core.commentChar is set to "auto", the intention is to
> >  determine the comment line character from whatever content is there
> >  already.
> > 
> >  As the code path in question is the one *generating* the todo list
> >  from scratch, it will automatically use whatever core.commentChar
> >  has been configured before the "auto" (and fall back to "#" if none
> >  has been configured explicitly), which is consistent with users'
> >  expectations.
> 
> Honestly, the above still doesn't read clearly to me.  I've take a stab at it
> myself - let me know what you think:
> 
>     If core.commentChar is set to "auto", the comment_line_char global
>     variable will be initialized to '#'.  The only time
>     comment_line_char gets changed to an automatic value is when the
>     prepare_to_commit() function (in commit.c) calls
>     adjust_comment_line_char().  This does not happen when generating
>     the todo list, so '#' will be used as the comment character in the
>     todo list if core.commentChar is set to "auto".

There is a concocted way to have core.commentChar = auto *and* to override
the comment char: if you use `git config --add core.commentChar auto`, or
if you have it set in $HOME/.gitconfig and in .git/config.

I tried to cover that in my suggestion, but that was probably trying to be
too precise, rather than being useful...

Ciao,
Johannes
