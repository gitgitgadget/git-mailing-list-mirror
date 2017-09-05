Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0E3209B1
	for <e@80x24.org>; Tue,  5 Sep 2017 21:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbdIEVGg (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 17:06:36 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35244 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbdIEVGf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 17:06:35 -0400
Received: by mail-it0-f51.google.com with SMTP id k186so1899908ith.0
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S3Syg18jaKt17GoEsCqIfwFaS7mUM0FVig/c9fCWomU=;
        b=M/zlNawqbVBvoa9kM/EVhfyH13JUQT4sE1HVmFDUywMo0VLbYLsk3to11B1gL4duTS
         tZ50JtiB4st4jrx/tKyCw7rRiwpXyHvYpY45H4H1grh6gVOjNiJIBA7/Gids9Qh6ahgr
         rrH6M01pAzIF5qCx0Q3oR9YXaTXzV9npD0Ai9xgJbsGsKU9uMYopiCOCWcr3rlhRXWtt
         rqm6nH6s0Kwo3WiZkAAiQC6l8toHShTFfoRbXejopn267KvimgRUkY2tMXHqMFAoOdQl
         YPm5aZo37T//IWj2svRXzJZUtidk6HfRmaPnnHVwHbfdF+d4KXQQ2emPU+ZdVqLEJ1K2
         g4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S3Syg18jaKt17GoEsCqIfwFaS7mUM0FVig/c9fCWomU=;
        b=VkpsjSOWAJGuZ2m+rqwQAE3ioQgdereRlaJvEyJ6waRMVp1ktqK9D55A7+EallkhHp
         ee6fcf25FAnAA11/oNsUIrOCsJf7IWWKZW/Q2LNl08f2AXezQ4lgGesRvwH3jMdFD7g9
         eWBa5WG/ekTbSF+YBfObAX2TlYY6znhRSdKkIMIXihrNXT0D4LOUFDr5Evxp5eWOrHfq
         XMG0qzmi2M7EniMIleNPnmQYylgxoo5cW5CsiY1gjmR0lYnp20OiaVWOrniT0AX0xZnT
         BJVwUoad9CixaaTMPKvoSyWi/88xclSyhverz2YA13SO0YWt/vexagbPKCtJX9BNwQoV
         d2RQ==
X-Gm-Message-State: AHPjjUjcrFLjJE/QQfi/XOEVLxjxaVYxGQxuvB/I10hJuqn4p89lh88t
        l+dOWDjqVauh9f92AM7FS80YuOWsLA==
X-Google-Smtp-Source: ADKCNb48u92ut95NhZxLGsHqfWtC43nQ1M482Je79gGbjk34wM2Nn92bjA7TuJGyjwR+FsS65ibflwOtzDgviocml9M=
X-Received: by 10.36.6.71 with SMTP id 68mr557798itv.184.1504645595060; Tue,
 05 Sep 2017 14:06:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Tue, 5 Sep 2017 14:06:34 -0700 (PDT)
In-Reply-To: <20170901223059.xsbcpqff45mnblnj@sigill.intra.peff.net>
References: <20170901223059.xsbcpqff45mnblnj@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 5 Sep 2017 23:06:34 +0200
Message-ID: <CAP8UFD16Sg9q1TDku7gJZUCYB03GaBx0mNXjvE6A4W6zTxY6Lw@mail.gmail.com>
Subject: Re: Git in Outreachy round 15?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Sep 2, 2017 at 12:30 AM, Jeff King <peff@peff.net> wrote:
>
> The big questions on whether we can make this happen are:
>
>   1. Do we have mentor interest?
>
>      I'm willing to mentor, but I'd like to hear whether other people
>      are interested, as well. Either way I can take responsibility for
>      the administrative bits.

I am willing to co-mentor, but I prefer not to take care of administrative bits.

>      We could probably use some effort brushing up our project-ideas
>      page. I've also considered whether it would make sense to do a
>      "mixed bag" project where somebody works on multiple smaller
>      projects, and we try to get them more involved in day-to-day
>      project activities (after all, very few of us started working on
>      Git with a dedicated 3-month project; people typically ease into it
>      by fixing small problems, reviewing code, etc).

I agree that we should try "mixed bag" projects consisting in multiple
smaller projects.
It would be very interesting to see if it provides better results.

>   2. Do we have the money (and want to spend it on this)?
>
>      The Git project does have money to cover at least one intern.
>
>      I'm looking into securing outside funding, so that we don't have to
>      use project funds. If for whatever reason that doesn't happen, is
>      this something we want to spend project money on?
>
>      (My opinion is yes, but I'd like to hear what others in the
>      community think).

My opinion is yes too.

Is there something like the GSoC Mentor Summit? I think this is an
interesting part of the GSoC and it could help motivate mentors if
there was something like that.

Thanks for taking care of this,
Christian.
