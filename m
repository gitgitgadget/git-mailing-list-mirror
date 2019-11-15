Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652BA1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKOVzG (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 16:55:06 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41269 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKOVzG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 16:55:06 -0500
Received: by mail-ed1-f54.google.com with SMTP id a21so8639012edj.8
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 13:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ItJIiXxbbv7+aydJSby6JppI+HGxrOWt8VuRt1pqDoI=;
        b=Th18QBg6lH1fFYIFz8d6qfB+Nb/vki0/KkKl47xP4jBSHxryl3Wd4ZSTE1YZDB5maY
         O5Q6UpZ5pAa3joazFxMPQJUhFwV8+St+r5x5FO0o0vyeE8eKxj6OZOgcrKp89eROYG6q
         jMyyF3ueYxykU1kOZVpcpfMLglv/ZpKvg5Y7DvjVBmEDjFg7nsrZY/d9GPM3jrnlQ6OD
         2Ccgp2z53jpcIKp/WqGQgRi1Y4AFfhvfwL2XT47gZmA6M0vqTUvZNWlVk4707tUfSrxk
         9Xbk9/3gl1RA3aFOj1N/QhzxLNZLiKTtUCgKjfksv65IFWhPuBwTv6DbZFKtk0DJS94/
         lz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ItJIiXxbbv7+aydJSby6JppI+HGxrOWt8VuRt1pqDoI=;
        b=k/RzBtUbPVzvxl15Oj/UZFkUvy7q4+wlv2GMrUPfbssN0zYvvKmNs6wHo+ko6Vx3ML
         zKWQGA3dcBn2b96j1rsq4SUalK3wlFZwf33nSbKFfA+Luh/cUrABUzdL416SG9rdNGDS
         SuRgwGhP1JUXvTOB8magi8All1yLC15QlWEKfgs/9K37fJf1Ts8lKajSLubWn67B/YX4
         /lHlHTsAsRPDwqIc46dDGHnSuoybaG2u30hAHcnxf0y2+Poe/99wp/Kw2fvZwEffezJL
         GeHjBEG68Tb7gMxODif8EWNq8Z5Tt7s5yeMp8CIgR1uK3BRhLszSyrHtOcd5JFJjJ2aw
         zxDQ==
X-Gm-Message-State: APjAAAUAEMnC3uOpRYlu8pqdeRzTmLCrFKEdpYO6P8dRZUb1r69t9zK4
        4YRrRhf3VSsE7eKStQZ1ay2rzOHWydWBir/jPiz1xo4GDCo=
X-Google-Smtp-Source: APXvYqzrmc1p2uMfgktTER0JYjRV7XqFbinyiiCN5BmGHlnIfSF/IvlQeTOGKUxavpuGoz1Wmws3sIxMr26o6LH3pyY=
X-Received: by 2002:a17:906:1cd8:: with SMTP id i24mr4079252ejh.149.1573854904052;
 Fri, 15 Nov 2019 13:55:04 -0800 (PST)
MIME-Version: 1.0
References: <CABUeae82_qQrR5s_QYsDzkVX6CeVM-B7pT5DZt_BjpL=KJdtBg@mail.gmail.com>
 <20191113051530.GA3547@sigill.intra.peff.net> <xmqq8sokb673.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sokb673.fsf@gitster-ct.c.googlers.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Fri, 15 Nov 2019 22:54:37 +0100
Message-ID: <CABUeae9m+r-p-aaix_NFTFB1cAomFHgC8mckRHPiiRt1qRwv_w@mail.gmail.com>
Subject: Re: Merge commit says refs/heads/<branchname> instead of <branchname>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 Nov 2019 at 08:12, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
> > If I do:
> >
> >   git reset --hard tip && git merge --no-edit refs/heads/side
> >   git log -1 --oneline
> >
> > then I get:
> >
> >   Merge branch 'refs/heads/side'
> >
> > And the behavior seems the same going back to older versions of Git. Are
> > you sure your workflow hasn't changed somehow?
> >
> > Can you show an example that triggers the behavior for you?
>
> Yes, I am curious, too.

Jeff, Junio,

Thank you very much for your responses and confirmations
of expected behaviours.

I will try to confirm with my colleagues what's changed,
what are actual commands and Git versions in use.
I'll be back here if I discover anything suspicious.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
