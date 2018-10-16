Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB321F453
	for <e@80x24.org>; Tue, 16 Oct 2018 13:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJPU5B (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:57:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:37013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPU5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:57:01 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx4dh-1faW7U0vw9-016cPG; Tue, 16
 Oct 2018 15:06:33 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx4dh-1faW7U0vw9-016cPG; Tue, 16
 Oct 2018 15:06:33 +0200
Date:   Tue, 16 Oct 2018 15:06:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] getpwuid(mingw): provide a better default for the
 user name
In-Reply-To: <CAPig+cTvKicLKZO38AcVzXJJhZ1CajOhiADotRJ0V7EJXBicUA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810161506230.4546@tvgsbejvaqbjf.bet>
References: <pull.45.git.gitgitgadget@gmail.com> <11025b1639785577924b2020fb20d076308e9c69.1539596822.git.gitgitgadget@gmail.com> <CAPig+cRbOOrC5_jCnR2ohMZWoYXfNqvWtj3m_JTpudJhV1mQng@mail.gmail.com> <nycvar.QRO.7.76.6.1810161436480.4546@tvgsbejvaqbjf.bet>
 <CAPig+cTvKicLKZO38AcVzXJJhZ1CajOhiADotRJ0V7EJXBicUA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zUkeX4BN6i8Lb/8zopDeeZvm6HvNmkb7f5k87fN0bg0+T5ScVpr
 S8NAY63yYLhEiMJycglDVfeemnysz81FIZ4UDr+8191leh8LhaJBMAARfyLcoYQHKeYW554
 qzvrWkBUZKOiMNjCpJ5v0kle02/W9yr0rqK/s7DwtXtX00efR2UHF+wXnqf7/Rn9Bv6Evk9
 IJ9ki2KKNWvbZtuvxgORw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IHBXIaBmcpU=:wwnc03qTOj8fPb/5tdk1Fm
 5DQDPek3u/8QCGnV6DVhX+2fYWK9wQmsYB9jr/tSTyPH7+IlS+maziHkt+YRlEJv6+slmpidy
 bRop8C49ayZgJiiCkzVOCr5F8faEEDhlqQ3iF+b4yG1xGGE7YIKVJiK6OR9faYhN3zHHI7Wgi
 O5OcuSnchrTFS5NMs0s1fp8ZGTf08+0r6meLexbHUl02haO+do5srepjJ8irytf/IR+VZ860w
 nphkjUOiJTVCt71y5HnHn8YTDCjnE8hJc27Q4GtFGi1Ic6VbVMesZixNe63hdUrNt3RJ62HDO
 GJeHnFIt0/f5n949CyJmWDhfVdDkLmePurHvp6hqhyiqi6HPWMSAFWkx8zVOB8eOiv9z/1V/c
 fLC6HjtkBt0nqQ+phBZTFZcRCvh/C2EVTSprf/42U2QrhxPbvePqygOPaPRExsuYhiNB3Udqx
 RCxdSKNrNUQyFLU05bhqQsO0WLOzEuIRrjP3/P2ko3SrK4n3eqjnYnTA0EaJmqArRWTbuM4Pd
 vQFHOEL49zaG9k05zX4jkyQ0MNJ/ZYVahOyUPDak3dSoBzF2j1HTDdo0XtDzQnHQlXGWFYPaB
 0NroS6Vm4yHyeReGKt0gUAbS+sPhm/U/uqimByBJv3iy1ItEyM09L3WbKz5z+gJMmKXUXzPdh
 XyMwLxUbzpTBSCksSYvYhx6dNfZK1LEYkGYdF8Mqha07cOFEQBE+wHpYrz8Zu82VIsnd3diZC
 VdiQEnBPGKEmAitJqBOCM+nOPTRY+EN0E7VHnSOyyFtRs69AGaNoDjb/cK9RzsY05NRYTLcT1
 9dMnFyDAWnxjWaOP1inqeT4GWGh812oUnLDelmvY/f4dKex+8g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 16 Oct 2018, Eric Sunshine wrote:

> On Tue, Oct 16, 2018 at 8:38 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 15 Oct 2018, Eric Sunshine wrote:
> > > On Mon, Oct 15, 2018 at 5:47 AM Johannes Schindelin via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > > > +       len = ARRAY_SIZE(wbuffer);
> > > > +       if (GetUserNameExW(type, wbuffer, &len)) {
> > > > +               char *converted = xmalloc((len *= 3));
> >
> > Oh wow. I *just* realized this. It is an off-by-one: the `xmalloc()` call
> > needs to receive `len + 1` to accommodate for the trailing NUL. Will fix,
> > too.
> 
> Or, xmallocz() (note the "z") which gives you overflow-checking of the
> +1 for free.

Very good point! Thanks for the suggestion,
Dscho
