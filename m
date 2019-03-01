Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA8620248
	for <e@80x24.org>; Fri,  1 Mar 2019 09:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfCAJbP (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 04:31:15 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:37336 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfCAJbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 04:31:14 -0500
Received: by mail-it1-f169.google.com with SMTP id z124so20382801itc.2
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 01:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkedx81GsBhaGV9jkJ3cjjPn9FRbaWAQbum25ZB8K78=;
        b=cU37yFBMRE4hM/oygtySy30XAk/Onh8u+ZeVFAPZ+G0TERc5ioTSF41HNfzlnY4HB1
         qtqW4AUNEGRtwMmNRuaOCKht7CCsNveGG+oEuiQRwr0fupdUDXIZEoaGw5jWrO207ZQI
         2BvejhRC2CalfueR2ChkR929QJNns2l2n+sHli9rXqGAbwlKAV8Nq/+zOedJLziliGN0
         QEppgbIJGu/GGYIXd2GuKeF+MQdmUi6jjEvy65FXmLRNv5kF8NMVjAGgX1jEL6KHpXW2
         ORmc7Gv4mQRCUa1R5PK2T5sSGDr5oPZpbtz9uizEPIgH8kEWP1R5/124PU9GE7kgfzvw
         X3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkedx81GsBhaGV9jkJ3cjjPn9FRbaWAQbum25ZB8K78=;
        b=XSsG4id7hLCvo1W2PPVTTG6w6WRX5N6p+LZu227DlgX9cXN3Eyp02VpaXN/3G1WkmI
         8sMOcgZCQlKORwY3c0onYYEItrt5zC4ryv0o7OkQsFq7+d8FqGkRJGqyHbPyKYw3iG2R
         xTuIX/pJn9Btn3QkPVpsQ4/Px2ugEnw5t/ULbYvYMvh1nYYf1haJDdsv30puUni9AWAS
         HUBpZ+yDwOFZfxfb/rkWqbo3RD93x+IkU4aEVZ7ZbFtIPQ5uzDhW8tkAP+cQ/xlpDUtA
         rAUe19b/zljEwcnoHcwPBOeoZpyTtuqQq5a+RoFCdSi/Cdc0pk3iGgR3tBmFRici+mXM
         3eGw==
X-Gm-Message-State: AHQUAuaerRe2/rqlnl9tpUdtxK4uo+rx2sm0cKXgRwhBWYOtykAYTBy1
        p3GpeT9S7hTHd6u4VH/cLa9UQv/RgPqaccf3sww=
X-Google-Smtp-Source: APXvYqxlzX0nRTN+Y/ykpzLnaCiS2e5memSaQJobaV5OIzgKE5TGPHIO9JXTiZvMZt/s/1uUrP8ZGSZMO1AjGBiEqns=
X-Received: by 2002:a24:7542:: with SMTP id y63mr2596744itc.70.1551432673500;
 Fri, 01 Mar 2019 01:31:13 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
In-Reply-To: <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 1 Mar 2019 16:30:47 +0700
Message-ID: <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 1, 2019 at 5:20 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Matheus,
>
> On Thu, Feb 28, 2019 at 10:46 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > I've been in the mailing list for a couple weeks now, mainly working
> > on my gsoc micro-project[1] and in other patches that derived from it.
> > I also have been contributing to the Linux Kernel for half an year,
> > but am now mainly just supporting other students here at USP.
> >
> > I have read the ideas page for the GSoC 2019 and many of them interest
> > me. Also, looking around git-dev materials on the web, I got to the
> > GSoC 2012 ideas page. And this one got my attention:
> > https://github.com/peff/git/wiki/SoC-2012-Ideas#improving-parallelism-in-various-commands
> >
> > I'm interested in parallel computing and that has been my research
> > topic for about an year now. So I would like to ask what's the status
> > of this GSoC idea. I've read git-grep and saw that it is already
> > parallel, but I was wondering if there is any other section in git in
> > which it was already considered to bring parallelism, seeking to
> > achieve greater performance. And also, if this could, perhaps, be a
> > GSoC project.
>
> I vaguely remember that we thought at one point that all the low
> hanging fruits had already been taken in this area but I might be
> wrong.

We still have to remove some global variables, which is quite easy to
do, before one could actually add mutexes and stuff to allow multiple
pack access. I don't know though if the removing global variables is
that exciting for GSoC, or if both tasks could fit in one GSoC. The
adding parallel access is not that hard, I think, once you know
packfile.c and sha1-file.c relatively well. It's mostly dealing with
caches and all the sliding access windows safely.
-- 
Duy
