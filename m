Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3C61F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfBLAXi (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:23:38 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:54716 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfBLAXh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:23:37 -0500
Received: by mail-it1-f171.google.com with SMTP id i145so2952826ita.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 16:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69pqB8BigCGnkq4JItY3nyQlqBBvf1Us5NuNQ2IyJds=;
        b=nTNHjENF86JtV3lqALAG0/7VW74HjuUjfRezPKl/iopRIvrQS/7VHFH4VE5uylcBeJ
         l/JTbcIvq+5gvMjB3RKdKSlIjd1tA3/uzuazFjFWqAW14/RdvCW+ajNfjI0O2rF9q75K
         hHxFVLM9Q9eAtMQJtnXrgm/AZq2rLzdGR/ApdZIFmF3G1z5sRUJukYk5UzdQLNmGHUzj
         WtHETmJLzPKPbPLWRuuWWyrcQ7ULguUC/YXi0UZ06+/B5YO3PRJNUgdwgTynPvZ90HnA
         VDLEzrSX6AJR77r/imuR5Qjp2yBjedAXaSFuHjBsCyw8nW+8FmPFnelx5T98Z/QuKEMc
         bVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69pqB8BigCGnkq4JItY3nyQlqBBvf1Us5NuNQ2IyJds=;
        b=mrmGv25V9OMf/ebE9N6LXm9ufj4DVUSO380Wwa5uC/mcP7/9Na0wT/nCnD6E1izq2p
         DTd0S3ibc9bEm9B/Db2YN/dZCueBm6gLQUmMYi/03QqLApqxT8P3yswrs+EfgPGPQ0j8
         T8NsWGkmmNrM4y2dfvshMN/j/HSiwzrI0zqBk9FWai0w+wlKfuXAuqtgE0+9GOiJ3h72
         A9Z2Wu2YtaUPmiGT3wjA+zU+6Ojot9rRctIRyc8eomYIkXALrfkUmNqPOdivWbjD8x+m
         5hu/f0aZwwLlcuQ31GT83qTOVlcIjQf4hY0+IoGSyS5vda4DNz11gPCCJFkbwNqjQB1B
         cP6A==
X-Gm-Message-State: AHQUAuZOmvAGCMnJBXnqT7LvuvnQdDxT8F8qgmTKJVrnkWaNwqXo+WxP
        xWoL9JvQfw0VE8nr9y22vL6NYwaboaoHxNVHX9mJuSFO
X-Google-Smtp-Source: AHgI3IbPKKeVTAhKLTryuG5dcCUU5mhKHbLXnrqy/sjNallYdWhaEVd2zE96mT3vVXELwFslBjLl9FIiiCRBPC0bnWs=
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr472567ite.72.1549931016181;
 Mon, 11 Feb 2019 16:23:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW4p6XUjF_j+XXwYWGt__L_5bTJGwxmgWhxJfpuAFac=dQ@mail.gmail.com>
 <20190212000033.GB13301@sigill.intra.peff.net>
In-Reply-To: <20190212000033.GB13301@sigill.intra.peff.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 11 Feb 2019 22:23:25 -0200
Message-ID: <CAHd-oW5me9KXEgngb3GD9uhQR5FQn9GS5pBoQAfV8awkuo4iVA@mail.gmail.com>
Subject: Re: [GSoC] Microproject on git-credential-cache
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 10:00 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Feb 11, 2019 at 09:45:21PM -0200, Matheus Tavares Bernardino wrote:
>
> > I've been contributing to the Linux Kernel for the past semester and
> > I'm now looking to take my first steps in the git community. I'm also
> > interested in GSoC 2019.
>
> Hi, and welcome!
>

Thanks, Jeff!

> > I started looking at https://git.github.io/SoC-2019-Microprojects/ and
> > one that got my attention was "Move ~/.git-credential-cache to
> > ~/.cache/git". But looking around at the code and the mailing list,
> > this microproject seems to have been already solved at 60759ba
> > ("credential-cache: use XDG_CACHE_HOME for socket", 2017-03-17),
> > right?
>
> Yes, I think so. We should remove it from the list (you're welcome to
> submit a PR at https://github.com/git/git.github.io.
>

Thanks! PR submitted :)

> > For the microproject "Add configuration options for some commonly used
> > command-line options", are there some options already known to be good
> > for adding to configuration file?
>
> Hmm. I don't offhand have any suggestions. That one has been floating
> around since at least 2015. I wonder if it may also be time to retire it
> (or give some more concrete examples).
>

So it may be better if I choose another microproject, right?

> > Finally, a non GSoC-related question. Just to confirm my understanding
> > of Documentation/SubmittingPatches: I must send patches to the mailing
> > list first and after some feedback from community, send to the
> > maintainer with CC to the list, is that correct?
>
> Yes. Often the maintainer will even pick them up without being cc'd (in
> which case he'll usually reply to say so). The main goal is to avoid
> overwhelming him with first-draft patches that are not yet ready to be
> applied. :)
>

Got it, thanks! I just asked because that's different from Kernel's
workflow. But totally makes sense.

Matheus

> -Peff
