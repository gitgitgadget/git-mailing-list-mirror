Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F691F461
	for <e@80x24.org>; Fri, 21 Jun 2019 19:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFUTAS (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 15:00:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfFUTAS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 15:00:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so6354332wrs.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 12:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8kgP25lEB9LRZXMFEeDFQ/+HGujz8LlGifwhkqpMd8=;
        b=tQ5zLHRYg/QwBuzLA7X5Ua3SUbYxXwVt3X3ag9K9wmbXiJpSFcUnoVwE1s+bj2heN1
         5puVxGEH55YmS+7cpfFFu/7sFF28ozt4EB0RMjwdO9ALYgREmqt1APQM3hjWrDU1Gf27
         YjzVE90DckO2pfKFjIc2xhdFrYsQValXBaSyViBsIlfGGDw1IK/Txt1hCVUkcYd7o6cp
         rhuPXgnmg3m0IhmxoWIB8dR2nfEm4bsSZWbsQdr3vcMfLd90d/Pj6cWesCm9q7GRLaJ0
         WgPoY3z7dHwg4SFBWWLksF51tmnuJZdaCBBSD1fMCLqPzvRXemSvVVfdlDgnNpX7iYy8
         Q1rw==
X-Gm-Message-State: APjAAAXAxm6RGGsdGKb3mKIQekUNUvsTedKGviDkZhZi1AwnL8S4/MNC
        WxW0wWRIobVX6qF8eO+lPniZeJXG0i22pVGQaWo=
X-Google-Smtp-Source: APXvYqx5K19Ke5NDmvMdwOK7uKcq3x+f6vmgOjYa80P8Yiwg0dJQEjoGFICYJFf8q1oFdJrL1Fnucb2bOZxkj6MyBvU=
X-Received: by 2002:adf:f101:: with SMTP id r1mr6511232wro.170.1561143616062;
 Fri, 21 Jun 2019 12:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190619221315.7343-1-chriscool@tuxfamily.org>
 <20190620212922.GB87385@google.com> <CAP8UFD1KRq9gUJQbDP9d3xewS9F_9wHnt463Qt7UXoi7VdmOJg@mail.gmail.com>
 <CAPig+cQh0MC9JQPMkxhDKFzzCwRTC-_rVBR7RnzcP3SM_kn_vA@mail.gmail.com> <xmqqmuiakgaq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuiakgaq.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Jun 2019 15:00:05 -0400
Message-ID: <CAPig+cQJRwfEnsPwY=Cwwy2zPU+=rd+5XJckh7=iEjsb2h1A7g@mail.gmail.com>
Subject: Re: [PATCH] doc: improve usage string in MyFirstContribution
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 1:19 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Fri, Jun 21, 2019 at 6:43 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> >> On Thu, Jun 20, 2019 at 11:29 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> >> > It doesn't require 1 or more args - you can run it with no args. So it
> >> > might be better suited to state the args as optional:
> >> >
> >> >   'git psuh [arg]...'
> >>
> >> Yeah sure, I will will resend soon with such changes.
> >
> > More correct would be "git psuh [<arg>]".
>
> I think this takes 0 or more, not 0 or 1, so "git psuh [<arg>...]",
> no?

I hadn't read the tutorial, but looking at it now, I see that it
indeed takes zero or more, so "git psuh [<arg>...]" would be best.
