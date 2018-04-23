Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8331F424
	for <e@80x24.org>; Mon, 23 Apr 2018 12:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754961AbeDWMD7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 08:03:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:60669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754955AbeDWMD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 08:03:56 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcnRD-1ejFzD3cTX-00k56R; Mon, 23
 Apr 2018 14:03:45 +0200
Date:   Mon, 23 Apr 2018 14:03:27 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Philip Oakley <philipoakley@iee.org>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
In-Reply-To: <9270DF86352B4E3493AADA159E7FFE33@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1804231401130.15174@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <7360a072f6fdd276d30839613434329b645e2cce.1524306546.git.johannes.schindelin@gmx.de> <9270DF86352B4E3493AADA159E7FFE33@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vmKHQOf5NNCgi1F4HNciswHns8JQxrac47OZcke47maAmOPVtl7
 KLwhEn+BGfsnQAm/k+P/cMxo8pjLuWjdZubJY04yGeVaMZmeE38s4d0cEalkt2O1x/RfxW/
 0oFjUuzgb4jzLyKarGlkmRM8gTQCjmos9ECCmrN7DvHTwYlP5j29omzjrpD6PDms4tcvO7W
 FFWv6NB0OK1T4UVuidmIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wPvrcn3ZGUQ=:FlA9wR3kqb/doOs+1oNtfw
 Z/MyWb+DZt9pngGPPtOZg+r15nEyMjBUbuOd41HxhA3BfuXh7ZZfs4KcAd7bsTf9aO9KRlHB5
 PDFpEfwkjnrJ2pVc8DPdF7GYMLnyFxwzzU01kSQzcW8ET41sJX+BfeZPiaZfAas2kpOmNJ5hi
 j0nuQBy1LFFhXs6WL0oN1WmpXfgnCkDjQB4gIdkJMOGaOzEHdzcDDxmfHIUsxZPsiVBz2fglG
 p0xEL88lelacC91vYfT1NvQjU3282ydUl+9uQSmby2mP46rf2eLQ2UU5u3fjQBwc09UIz6Cr2
 RyVxOw37l4+lvf2jakcFip20syV34Xc9EB/BDENJB3JM6roi3+8sjrpgrHwHH+GMb53VrA4bM
 vz9mtWSyWzJir2LDuqsR3MFfGEmDePPso7cFKW+iCIVGoR/ebhZBRWh2wu6gVWSyzahgDMl80
 hA5UQTz/qifr8TRUEzfLxSwDmKLVbrQinQHV5p6uoQrK9FvLBh9QjnsY6gcJh3Fwy2Wx/DPwv
 pZ4Tgo2+yzlmkJDVnQiPAm/aRfUldZneWWlAUY/IDxaMAuQSG9xyZ/NAOB21Eqx8McUgEmt5G
 1asUcU2I8OMyQ7P6T70EhZbIe1m/Pv+4yPNpymKjHV6ziAaG8AjlUKeIMkA784d1xx7LmWBgZ
 ih69kFw87XgJX68VaUdTx+lJC2v9KjVLJz8KIfx2uMDH0PDnr99yTXJdwh9pona2dHdfuLL0r
 Msj3+F8STpKw27mG/Ys+YdgjSu3wKuMr8SgDlJ7ynfBVpJaB2OwnvUx0PckvA5/f2xWGRvAPN
 JKLO4+SDPlAGcwAdgvPRRrLS/77kSxbhWsITExMKCfkWusCiFk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sun, 22 Apr 2018, Philip Oakley wrote:

> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> > This patch is part of the effort to reimplement `--preserve-merges` with
> > a substantially improved design, a design that has been developed in the
> > Git for Windows project to maintain the dozens of Windows-specific patch
> > series on top of upstream Git.
> >
> > The previous patch implemented the `label` and `reset` commands to label
> 
> The previous patch was [Patch 05/16] git-rebase--interactive: clarify
> arguments, so this statement doesn't appear to be true. Has a patch been
> missed or re-ordered? Or should it be simply "This patch implements" ?
> Likewise the patch subject would be updated.

As Phillip guessed correctly, it was a mistaken `git commit --amend`.

> > commits and to reset to labeled commits. This patch adds the `merge`
> 
> s/adds/also adds/ ?

No, as I really want to keep those two commits separate. I disentangled
them.

> > command, with the following syntax:
> >
> > merge [-C <commit>] <rev> # <oneline>
> >
> > The <commit> parameter in this instance is the *original* merge commit,
> > whose author and message will be used for the merge commit that is about
> > to be created.
> >
> > The <rev> parameter refers to the (possibly rewritten) revision to
> > merge. Let's see an example of a todo list:
> >
> The example ought to also note that `label onto` is to
> `# label current HEAD with a name`, seeing as this is the first occurance.
> It may be obvious in retrospect, but not at first reading.

I added some sentence to describe what `label onto` does and why.

> > label onto
> >
> > # Branch abc
> > reset onto
> 
> Is this reset strictly necessary. We are already there @head.

No, this is not strictly necessary, but

- it makes it easier to auto-generate (otherwise you would have to keep
  track of the "current HEAD" while generating that todo list, and

- if I keep the `reset onto` there, then it is *a lot* easier to reorder
  topic branches.

Ciao,
Dscho
