Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C161F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbeDTWjy (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:39:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:38999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752144AbeDTWjw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:39:52 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBrCt-1fJFCD3Q7b-00AkQ8; Sat, 21
 Apr 2018 00:39:43 +0200
Date:   Sat, 21 Apr 2018 00:39:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v7 06/17] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <fa4d22ec-0c40-b7ec-6715-67507b15181d@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1804210036400.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de> <77c08b61387057af1be57c2b50769651cc8ec898.1524139900.git.johannes.schindelin@gmx.de> <fa4d22ec-0c40-b7ec-6715-67507b15181d@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AfWPH/iOuVYw3r7uLrTvvUAOm/p0WfgJDFZLHXta+amx502v1yp
 n6QL9zXkeeYn7KsDyngRjRG+wHWLtIikoWCA3qTKQr355G5Uz04QisT0GBDsDer2qZFkLBi
 Hv+AIpIxVRYlYQ6nwqYrNQi9HZWFFf51Ff5M0e60SbtWuRFZqNu2DL5eTpmHXMEscsBCuuc
 gxDu7BdduKgI5DmiDo09g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CBoziHpIzzU=:7Wol/r8ULuWC8klmsux4J2
 O7wFQ4n20HPCOEGxiZTFSXhD8apiobBeuh0L4oiuKA7gNVS0qOjo9CseMRE/iEQhq7HuARhk3
 xMb5C6J/PCaoOy8AXHorjOekjv0nd61KZT8vf2nEJYoOmQkSOBFC21InrST8IQBp7lfj6k9Ju
 1R8YmWlzt4iMp4X0w92/5CTS2m6DJVtEdYQ6w3uKct2KH5SxjCkJg1JKyVm4Dru8brLT+sURR
 TmPA6zCZtz8x68FOf15zxfSQ/Q+VQrKah5vUhfZxfpZKsG4xE/ZPmQTte+iEF+ysDKJ09tiQ4
 rHQlH0nfY2/p+bQi5OnYm/9MoWiwrdCHBry0PxLZ5f1bkbctqh8aqTXenXEEEX75x82wkxKoO
 wLbZHEFTTSYSlY1OAAk8Sbd5udLxcg4zLY/YljeMd6VKnKVcWiK6h3l85O95sF62QKUl8mb68
 FWknnhv+72hAa9tNywzHJ9aVWaH1unYgKJ9odsXiLlfj/XwGsJ4kSk89+vOxIe0sC+mkmtlzS
 hhE26mZAKpjfSFaqfsXyeHuAh+nKvGS6YcZMwP8mGHI2JbNSENV9hj3P6rN4b1m/8jRVcFGn8
 QGtKXfvcRWeyyOFPcJisizVqhN0rQryRy9EMoqNQR2sdfN7Ajvcf4gbgeS36DKr3N5eUZhHGq
 tuXPyXCIOALFbnxihlAnPPzrQx54wT2VfyKKiHWbz2HxPvMDLnK9Lq04TGkaDRCwT7G2Q8P0q
 YhDTPEogO1xNDj9HBAMtyqcRAk8KoQIi4k1UrsHVBcHP8FWq5kePf+2e+qOHrIFCbLwuS7V7q
 vh0W9AvLGX4tKhXQv2NcMTTlfZyggkjNYA0en05nNcsmWg/Izo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 20 Apr 2018, Phillip Wood wrote:

> On 19/04/18 13:20, Johannes Schindelin wrote:
>
> [... please cull long stretches of quoted mail that is not responded to ...]
>
> > @@ -2665,6 +2846,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> >  				/* `current` will be incremented below */
> >  				todo_list->current = -1;
> >  			}
> > +		} else if (item->command == TODO_LABEL) {
> > +			if ((res = do_label(item->arg, item->arg_len)))
> > +				goto reschedule;
> 
> I can see why you've implemented like this but I'm uneasy with jumping
> into a block guarded with "if (item->command <= TODO_SQUASH)" when
> item->command > TODO_SQUASH. I think it works OK at the moment but it's
> possible that in the future someone will edit that block of code and add
> something like
> 
> if (item->command == TODO_PICK)
> 	do_something()
> else
> 	do_something_else()
> 
> assuming that item->command <= TODO_SQUASH because they haven't noticed
> the goto jumping back into that block.

I changed it by duplicating the rescheduling, as I agree that it is
somewhat dangerous what with all the code going on after the rescheduling
of a pick/fixup/squash/reword.

My plan is to go over the documentation changes once more tomorrow, with a
fresh set of eyes, and then submit the hopefully final iteration of this
patch series.

Ciao,
Dscho
