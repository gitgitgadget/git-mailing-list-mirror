Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D062200B9
	for <e@80x24.org>; Mon,  7 May 2018 18:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeEGSPt (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 14:15:49 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:46930 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeEGSPs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 14:15:48 -0400
Received: by mail-yb0-f181.google.com with SMTP id f3-v6so1844307ybg.13
        for <git@vger.kernel.org>; Mon, 07 May 2018 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LRr+vz/bQGeg4iQtZ6fZMMRyxlheb/NIlBryRbLkqZw=;
        b=XcKELbEy40qugxUD5Dz49vsLn1GxXSu96y7rRi1CXZScIHN2RuULj6Y+BldM1aBFJR
         AWIZd6I6dHSRoi3GC4H7D3gKIY6y2O+V21IxGtSIxjB1StDLU9wpcL27/3yEB2Dto49v
         BVuAma9VT0yxH6YsBuzBTL7xf4f4Q4uxUuFg8teSE6F1CWgkR61r1XrSmbYuNDlMU4cj
         ooyYZlNMkmxyEfWRxUbc9mRbHYkK0JhJSi7Syf+V84k4zJRAsCvHW5wJnUUX7mdga0HA
         jO3ntQgS3DuGL0WYcbJ0ZUhe6743+MF+fS55SBTtHpGP6wH7qfWpXqlPPbDEyv4zWq5P
         HJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LRr+vz/bQGeg4iQtZ6fZMMRyxlheb/NIlBryRbLkqZw=;
        b=TqB0aqseg8SkbS3vVD5iWScf7Dc/TcKYvNJGrQbUmWrb5D9NB4PvrHWoCpYz49j7NX
         jIe2WQcdpykk1H5ajiQ1Z/eHZwXIX+abvoLHZ6LY4e4SAtHeXcLEwu+ykhJZJaxxTqv3
         H1/NpZbumeVlaCDpRlYKO3RYqbvk1HxMcDzLyrcmp9p/Ii0NBFHevOHN6UFemMz7l44s
         n3nERpVa+202Hmhr64Zz0iCRs16I7zas1oLqGlTxn/jmBMM8YOLCsOGL/QMj2Jv1HP6P
         m/YnznBqFeMZHoOt9A5PVU5OTaGC/N6nfs+YMh4YuCgqqmdZTEKRgtxnMYBhYL9TnXiZ
         p/Ow==
X-Gm-Message-State: ALQs6tAUAYhTvTJ6vuAu60Fcp3ViD682ARekT8n6GlY0TL5wO9aKHZRD
        J1IcMVh1BzsQQG0naJsjXwy43cv1lX63JYZN28cioQ==
X-Google-Smtp-Source: AB8JxZoMtUJGeTQOPSI9siF6bVMbERj6l9BBLEv2ZGTZvdIou7o8gaMA7s2Pgg/WIVpaFHrLWT/yWSyjeGxV3x+vrns=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr23341511ybb.334.1525716947298;
 Mon, 07 May 2018 11:15:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 7 May 2018 11:15:46 -0700 (PDT)
In-Reply-To: <20180507063713.GA28961@sigill.intra.peff.net>
References: <20180507063713.GA28961@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 May 2018 11:15:46 -0700
Message-ID: <CAGZ79kZVdiEOO+b_Ygrfw1D9uV1T5TYBS580zPaZeYoMRfNuUQ@mail.gmail.com>
Subject: Re: main url for linking to git source?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Sun, May 6, 2018 at 11:37 PM, Jeff King <peff@peff.net> wrote:
> The git-scm.com site currently links to https://github.com/git/git for
> the (non-tarball) source code. Somebody raised the question[1] of
> whether it should point to kernel.org instead. Do people find one
> interface more or less pleasing than the other? Do we want to prefer
> kernel.org as more "official" or less commercial?
>
> I could see arguments both ways, so I thought I'd take a straw poll of
> what people on the list think.

That PR is changing quite a few places, so in classic Git community
fashion, I advise to break it up into more patches. ;)

Junios reply below focuses on the URL passed to git-clone, which
is only found at https://git-scm.com/downloads (?)

There I would try to mirror Junios list of "public repositories"
https://git-blame.blogspot.com/p/git-public-repositories.html
without officially endorsing one over another.

For those links that link to web pages, I am ok with any of the
hosting providers, maybe even taking the one with the prettiest
web page. Maybe we want to reword those sections to rely
more on indirection, e.g. "get the source[link to the source page],
checkout the next branch", without the quick web link to a web page
showing the 'next' tree. Any of the pages with the 'next' tree
do not really help for the purpose of spotting which development
is currently happening. Maybe a "log --merges" would be better.
Something like https://kernel.googlesource.com/pub/scm/git/git/+log/next
(Not that I am endorsing this link over others. I just happen to know
that this comes close to what I propose having there)

Kernel.org might feel a bit more official than the others because
Linus started it there? And given that it is a non profit, I feel
better to link to them over any other commercial entity.

Hope that helps,
Stefan
