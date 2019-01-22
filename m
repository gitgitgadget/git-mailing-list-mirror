Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21BD1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 09:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfAVJSM (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 04:18:12 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:40862 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfAVJSM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 04:18:12 -0500
Received: by mail-ed1-f47.google.com with SMTP id g22so18679508edr.7
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 01:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmXaccD8x5CTqvW3Vn360b7bMseLgHH6nBw9t5deAG4=;
        b=cETfOmbRl2cFchLKjVdeD/VinjV3KteRRPY/U0IGYsqIX0H7NJQgrImjJnn/F6g4d3
         5xqqDFxNi3O1BrYvOCSVaEnSOqjkMmaT9EaQWe6m7SqAM2dMGhTZbJsaYaLZIDmgpTZ5
         xyUmCk8Jgm6ZxRQu3UUMzGjF8kaf0DklMMgESbjj1uJegwKH+i0XeEPYpJ2XergD9wEe
         zgCiCx8h4K3JnLAfMm5Py1Vhz/eDxy1XkaoKMDq8Q3P7lfrDb3Ns8ZqLkv9Cgc0sj0rT
         18fmwQVcBptjoPF6b+3M/0q1hzmDvNGn3u1Ya/Arv9htdMr9hkb21L93b00LdLQCkSSx
         jlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmXaccD8x5CTqvW3Vn360b7bMseLgHH6nBw9t5deAG4=;
        b=FLBDNMXckAbLWFaXQeUezOf2sP2bV3FkukMpQhX8A9RbiPcW4IcVsxEZOclUl+a0I9
         8a5I2dnEn7WieCNRBP+aFRB3prIm9Y+6qbh/nsjSesPFIcW66WuAz8tjVBljHvvwJ7yu
         byt8qjs0tKNYdAVzxmQCvddznCuWIrbJA4kUaoUQheO5A9+GBdaPVrbhRB9EYsn2/CQe
         JW7BGYYNMNRUE2UMYU0cwx1FbaGJRj3bXVPllDJfbFGpZFODC53Oj+h3UzyLDxe/3FMT
         yJ2krQxxC9e0TCQ2trgj6NS8aksnFSnt/nwZL4fJbXXHQVwgSpGImYvi5rqdt4dhXK6p
         aXUQ==
X-Gm-Message-State: AJcUukcZ1s1Nz1o1S+AArboIe0hITKgnZlCSGWzyuh+UqorI05Wr2jX0
        vn4L4C25+sgJwf0uk6OHvEgzdYfD85usIpFYQhU=
X-Google-Smtp-Source: ALg8bN4R6S2i8S0tuHNvS07QHxSrBwzjwWYz5bJFR54PvVXwz+rPfdkKy5nj5PVsVQsqGAv8kxncueeJTX9vQoYSBYQ=
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr28536573edd.188.1548148690315;
 Tue, 22 Jan 2019 01:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20190122075027.GA29441@sigill.intra.peff.net> <20190122082647.GA31608@sigill.intra.peff.net>
In-Reply-To: <20190122082647.GA31608@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 22 Jan 2019 10:17:59 +0100
Message-ID: <CAP8UFD3Kt3dreMnfAdLiP2yc47kBLoVYCk-2yDw67OkujVY=Ew@mail.gmail.com>
Subject: GSoC 2019 (was: Contributor Summit Topics and Logistics)
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 9:26 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Jan 22, 2019 at 02:50:27AM -0500, Jeff King wrote:
>
> > There's no set agenda; we'll decide what to discuss that day. But if
> > anybody would like to mention topics they are interested in (whether you
> > want to present on them, or just have an open discussion), please do so
> > here. A little advance notice can help people prepare more for the
> > discussions.
>
> One topic worth discussing (here or there): the GSoC org deadline is Feb
> 6th. Last year's org admins were Christian and Stefan (cc'd). Are you
> both interested and able to continue?

Yeah, I am interested and able to both be org admin and mentor. Thanks
for talking about this.

I think that as usual we will have to prepare a few pages about:

- our application (like https://git.github.io/SoC-2018-Org-Application/)
- microprojects idea for interested students (like
https://git.github.io/SoC-2018-Microprojects/)
- project ideas (like https://git.github.io/SoC-2018-Ideas/)

Suggestions for microprojects or project ideas are welcome! Volunteers
for mentoring or org admin are welcome too!
