Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC791F453
	for <e@80x24.org>; Mon, 24 Sep 2018 18:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeIYAzL (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 20:55:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38744 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbeIYAzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 20:55:11 -0400
Received: by mail-yw1-f66.google.com with SMTP id d126-v6so1629227ywa.5
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 11:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQwIdxcUijC5DKCgdziKOGcaGzP9sUzEflpiwKR1Wv8=;
        b=flKOHYf5ALIphpEwHpjTm3iVI9xl1+2MBXhj8CrtAL36fdCsJpPBHznpH09w056Pqo
         rXBprbkBE3fDAz18pXYsrGgI2RdpWowwyDMSWcYi+AZofD/hvfBdQUFPHwaQNfnO0inu
         fa6KCh3P26kR6ppqmZl6oFzx7KKU8wFZ+zMCQjBmDfCXXOn85RivhvvbqQpQIKpH14yi
         O9hvFHvxq+eYUNTGXSIyZlpliO+ojHR2TuQd5ekDsLyXf1uNVKrCWm/BKgRvUq4l+feL
         F1jtVZzV5lThWNDOwdOizmS28Mtsy2nY7kQBoNFNsrWwTvRtaBNyCqQG2TXfAO6QbHlm
         4Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQwIdxcUijC5DKCgdziKOGcaGzP9sUzEflpiwKR1Wv8=;
        b=JfoOnpNmsc20S03yRbhx/KF5TWq5Dg2hA0Obw52sxp9GfAeO1+I/UVPwcVQYTZXNAd
         +Oimy5I0aMTb+CCSRsZr3dqAO5FkYmza6og73TeR2/6dZ6UeQokhkx40RW3pnVbAxtHx
         w1wxns+oYPLOJRrqwi+8nIrVQkcJv74kdXgCoYLIQ4cmwEIPYcnXdXptvtU5L7pUyMlL
         LWYClEgZiJGCg19a5Cpjgdko9trl8k/nsWTlQF15v+9kBKLkjfDH5XNnFdHi2F3XRLnG
         VEAWvfTi3P/AASJ4xUOCbZfXWeZAGatgH6zAY8rLlJY/ZXky5h//MBjGBGsy+j3pTttp
         Ljag==
X-Gm-Message-State: ABuFfojNS+tprUAyMlepjWYf6cBBSXjbhMfRjIPJaYbKf15UgILXaP38
        6IkgMzoSvrHoKVNr6j9sV+Fzyry2J/6IHG2yPvMdYw==
X-Google-Smtp-Source: ACcGV62wXKplohdc8EvFOlIIOqP4DBrNY/d3++pkE1cpFly69pjb/SkWpUpsY5a/5tqrbttZ4u/mVn1EiAC0mqTY9b0=
X-Received: by 2002:a81:5bc6:: with SMTP id p189-v6mr80561ywb.370.1537815098396;
 Mon, 24 Sep 2018 11:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180921235833.99045-1-sbeller@google.com> <20180921235833.99045-2-sbeller@google.com>
 <7f77be2b-a084-5b8d-df65-1bb4b9c5da82@gmail.com>
In-Reply-To: <7f77be2b-a084-5b8d-df65-1bb4b9c5da82@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Sep 2018 11:51:27 -0700
Message-ID: <CAGZ79kaeWa5PRregdoJp82sSsY1-GF7kk33fxf1kbTPcZWu-bg@mail.gmail.com>
Subject: Re: [PATCH 1/3] t7001: reformat to newer style
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 6:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 9/21/2018 7:58 PM, Stefan Beller wrote:
> > The old formatting style is a real hindrance of getting people up to speed
> > contributing as they use existing code as an example and follow that style.
> > So let's get rid of the old style and reformat it in our current style.
> I was suspicious of your automated approach catching everything, so I
> looked carefully at this patch. There are still a lot of things
> happening that we would not recommend doing in new tests.

Heh, thanks for calling that out. So we're looking at a full formatter
instead of a partial formatter that helps moving in the right direction now. :-/

I would prefer to use automation as much as possible for these tasks
to keep it easy to apply it at scale once a file is not touched by
master..pu any more.

When applying styles manually, there is sometimes a judgement call,
which would like to the inevitable bikeshedding that I'd prefer to avoid.

> > +test_expect_success 'moving the file out of subdirectory' '
> > +     cd path0 && git mv COPYING ../path1/COPYING
> > +'
> Perhaps split this line on the &&?

In real modern testing, this could also be

    git -C path0 mv ...

which would also fix the cd.. below and not needing
a subshell there either (using -C again).

Looking at this from a higher level, nowadays I would write
tests that have more lines in them, instead of having
one git command per test.

> > +test_expect_success 'moving to existing tracked target with trailing slash' '
> > +     mkdir path2 &&
> > +     >path2/file && git add path2/file &&
> This line in particular looks a bit strange. What is this doing? At
> least we should split the &&.

Yes.

> > +test_expect_success 'do not move directory over existing directory' '
> > +     mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
> > +'
>
> Split this line.

Okay, I'll go manually over these tests to adapt to new style.

Thanks for looking over the patch!
Stefan
