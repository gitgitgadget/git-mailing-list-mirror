Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E47207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 19:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642394AbdD1TWw (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 15:22:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:62680 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756430AbdD1TWv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 15:22:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtmK9-1e4ZFk3tCv-011D9E; Fri, 28
 Apr 2017 21:22:34 +0200
Date:   Fri, 28 Apr 2017 21:22:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     phillip.wood@dunelm.org.uk
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <8c1f3519-0768-69d9-4d15-782da0be8390@talktalk.net>
Message-ID: <alpine.DEB.2.20.1704282059100.3480@virtualbox>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de> <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de> <8c1f3519-0768-69d9-4d15-782da0be8390@talktalk.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VEU5bs06nmjd3YrkzInPkQtWA77Sir9zsd8KqvsrEHTi6XJEacG
 k+/qCJO3Fm+mgCuQtwnwSYYC09E8KITkXwuAfqUc6sAy2dLMeiHU1WIo3nn4o4pG5r11szk
 WDoR9N1/3npPExXk0VmpLLZrBI3WD5JA8+BpT/zpNyCIgmCzvOh8xFXXiVh7A+jtMhF10UW
 NHwdpY0Ip0lCqhZ+hjBhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PBlYOz3UUcs=:fvEvvgfdOkfoE5H38J9/xm
 kwjmf029bdf0eI8x+2pJYJS8PWApzSi0S0+dI2KaWABX58Fm0CKa0LvEAk38vXosyhPX2buwJ
 hnbxPab5LJEB1+8ZR2+GRE01nLOlzdau/E6cRnBkfmzMUAWLdiwzki71HvTyMNtfMuLxYYUeu
 ufOBTubwuznyRSOr3VXchBIw8TFwpZr1NAdMsB9XqSv4mVV8tKuMO9JwDc20F527cm4/ej6cL
 Z2lKsQuBVzG71Dc9iNmdPycDwWnTX4f/5OQMvJIcK6vMnHWypjWClFFv36vF4sgPmPmZRHf2Q
 DObaYnintdiu62eHm36JIi8zQEtYKrosOGVK1+b90qx09c3ZV/O+Lu1i3Dk5X9Z4ua2lQ3mra
 Vbe4i1228+MrbUdpwZs1BW4LCCmcMV9ZmXSflJfHlxr6tPayFHPEo5ixNhSfUL3PSg7SS1lDF
 DfOB7GbjmT0/jiXXTAVV9CF9r3lSHhyeLeXa7CZzJG3SFYzWOrRW+BFMgwfEP9XsyMy4x9ZJY
 J0aCfroWSZ+o1FLxhEwZy0oCRln9CaeaqOl/u9dX+jdgQSK/J5iEsj/tN+tuyV4Ffmv58jSAJ
 fUr5kIxlim1lRTJBjzqI6fvdKKnPMnIp1Hr4jpYuOSM8i30sWTd8hdGy/z9G4s/XxXJkXqgTM
 awN+Kns4+CLtL2o2lravmxrsRIIqjPH7m6g0eT/TLTE+BpIWLU4pq1fxQ2mKfKufQuCWoxb/w
 rq2Aq14RkbQwVx4JoqegWCQdsk4oFXZ2iNiheLIDmXf4FhioCLcoIeiK1topGiuIllbo/DLce
 oWfdl6J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Fri, 28 Apr 2017, Phillip Wood wrote:

> On 26/04/17 12:59, Johannes Schindelin wrote:
>
> > The first step of an interactive rebase is to generate the so-called
> > "todo script", to be stored in the state directory as
> > "git-rebase-todo" and to be edited by the user.
> > 
> > Originally, we adjusted the output of `git log <options>` using a
> > simple sed script. Over the course of the years, the code became more
> > complicated. We now use shell scripting to edit the output of `git
> > log` conditionally, depending whether to keep "empty" commits (i.e.
> > commits that do not change any files).
> > 
> > On platforms where shell scripting is not native, this can be a
> > serious drag. And it opens the door for incompatibilities between
> > platforms when it comes to shell scripting or to Unix-y commands.
> > 
> > Let's just re-implement the todo script generation in plain C, using
> > the revision machinery directly.
> > 
> > This is substantially faster, improving the speed relative to the
> > shell script version of the interactive rebase from 2x to 3x on
> > Windows.
> 
> This changes the behaviour of git -c rebase.instructionFormat= rebase -i
> The shell version treats the rebase.instructionFormat being unset or set
> to the empty string as equivalent. This version generates a todo list
> with lines like 'pick <abbrev sha1>' rather than 'pick <abbrev sha1>
> <subject>'
> 
> I only picked this up because I have a script that does 'git -c
> rebase.instructionFormat= rebase -i' with a custom sequence editor. I
> can easily add '%s' in the appropriate place but I thought I'd point it
> out in case other people are affected by the change.

While I would argue that the C version is more correct, it would be
backwards-incompatible.

So I changed it.

BTW in the future you could help me a *lot* by providing a patch that adds
a test case to our test suite that not only demonstrates what exactly goes
wrong, but also will help prevent future regressions.

Ciao,
Johannes
