Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641C220357
	for <e@80x24.org>; Mon, 10 Jul 2017 14:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbdGJOkq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 10:40:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34752 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753673AbdGJOkp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 10:40:45 -0400
Received: by mail-wr0-f193.google.com with SMTP id k67so25340310wrc.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DBxmt9OQJoLEYpRnFY8jvrooPwwn0/jlNffe5TgvVQE=;
        b=RXMheI6lyRT1jBJYwl25D3rOjItZdmFwymiYg5JXB3q2zSUy8GVh9xsjrYyRBKAOJv
         ot5jkiI/APgsXyoG4YcRlMCTTpUsH9wsdWIFFibJshmdQhudscNcwR3+1YdvbJ/8YpvH
         xgSz4cWLfH47Cmvv3DNr7tQ4EKYbYaTxCDiYlW1+VxbgsTsVzHNPDR6mBPVXGMPpeA1k
         0QSMywU3PiHUD4FBWotE7dktK7+Q9m1fZoRU14GK2sac0ci+IZ5D/q0v+Y19WWqwVzuY
         Nu0vVwpm6lSS1JtOE1qRHRMq7BBnaVFKve/K/H82kckGmWE8/645A3XrtpRsfRFbgImn
         i4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DBxmt9OQJoLEYpRnFY8jvrooPwwn0/jlNffe5TgvVQE=;
        b=ZQjAl4kT+qVovWjlQFIXtHYJrCIrCIfGMTPAJ5szLgOQ3yRBVSCahzG7ysc0tFo/tY
         gnLI5RkvA17W1A/vnTqhPqlZJnbEbbAZtBKkHyohrdS5vJX03e1xcyNIJvlGqI1Ri58s
         wK7cKFrTjPzS0IsegdXQB7RorG9BB34euOLNO8lz23+3oTFXvR/pQazUqOTxQshSeAhY
         3SWOKMGX8HuAZ9AJNwcBR0bMAHEcb8Ffdl1kvyzbGZY5AtdtpWqi7kO82pPzXn1V+4OZ
         chxinkanqIOBbTPAJoLEGTYs2oGjoAMuJEEiZOeX3NC5Y5uDYyajQ1fxWao498e/umj1
         XpBg==
X-Gm-Message-State: AIVw110xEJBtU099f1nuCwaQdXNWA8usWahsmPmrpGfGEBTC6G4tt1/r
        wMAObrP5HqX4iUVM/hg=
X-Received: by 10.223.135.237 with SMTP id c42mr8049239wrc.10.1499697644453;
        Mon, 10 Jul 2017 07:40:44 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 143sm9128576wmo.11.2017.07.10.07.40.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 07:40:43 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/5] building git with clang/gcc address sanitizer
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
Date:   Mon, 10 Jul 2017 16:40:42 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <40D62A0D-5636-4EC2-ABCB-14175FC541F9@gmail.com>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Jul 2017, at 15:24, Jeff King <peff@peff.net> wrote:
> 
> I mentioned recently that I sometimes run the test suite with ASan, so
> here are a few tweaks to make this easier (most of which I've been
> carrying in my personal config.mak for a few years).
> 
> In my experience ASan does at least as well as valgrind at finding
> memory bugs, and runs way faster. With this series, running:
> 
>  make SANITIZE=address test
> 
> takes about 4.5 minutes on my machine. A normal build+test is about 1.5
> minutes on the same machine. I haven't timed a full run with --valgrind
> recently, but I know that it is much much slower. :)
> 
> If you want to see it in action, you can do:
> 
>  make SANITIZE=address
>  ./git log -g HEAD HEAD >/dev/null
> 
> which finds a bug I recently fixed (but the fix isn't in master yet).

Do you think it would make sense to run these sanitizers on TravisCI
to ensure they keep clean? If yes, should we run only "address" or all
of them (if they run clean)?

- Lars


> 
> There are other sanitizers, too. I _thought_ I had
> 
>  make SANITIZE=undefined test
> 
> running cleanly at one point, but it's definitely not clean now. Patch 5
> helps a little by disabling unaligned loads in our get_be32() macros.
> Once upon a time I had to set INTERNAL_QSORT, but it isn't necessary
> anymore since everything goes through sane_qsort(). Most of the
> remaining bugs are of a similar form, doing something like:
> 
>  memcpy(NULL, NULL, 0);
> 
> I don't know if it's worth having a sane_memcpy() there, or simply
> tweaking the code to avoid the call (almost all of them are a single
> call from apply.c:2870).
> 
> It looks like we also have a case of shifting off the left side of a
> signed int, which is undefined.
> 
> You can also try:
> 
>  make SANITIZE=thread test
> 
> but it's not clean. I poked at some of the errors, and I don't think
> there a problem in practice (though they may be worth cleaning up in the
> name of code hygiene).
> 
> There's also:
> 
>  make SANITIZE=memory test
> 
> This is clang-only. It's supposed to find uses of uninitialized memory.
> But it complains about writing out anything that zlib has touched. I
> seem to recall that valgrind had a similar problem. I'm not sure what
> zlib does to confuse these analyzers. For valgrind we were able to add a
> suppression. We could probably do the same here, but I haven't looked
> into it.
> 
>  [1/5]: test-lib: set ASAN_OPTIONS variable before we run git
>  [2/5]: test-lib: turn on ASan abort_on_error by default
>  [3/5]: Makefile: add helper for compiling with -fsanitize
>  [4/5]: Makefile: turn off -fomit-frame-pointer with sanitizers
>  [5/5]: Makefile: disable unaligned loads with UBSan
> 
> Makefile      |  8 ++++++++
> t/test-lib.sh | 11 ++++++++---
> 2 files changed, 16 insertions(+), 3 deletions(-)
> 
> -Peff

