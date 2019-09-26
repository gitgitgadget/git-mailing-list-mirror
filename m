Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93C071F463
	for <e@80x24.org>; Thu, 26 Sep 2019 13:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfIZN26 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 09:28:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44622 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfIZN26 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 09:28:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id i18so2464330wru.11
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 06:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iMRViA4J4Y7VUlrHVSDn0arSHqU3NrAf+TwslWWdXBY=;
        b=ERilNpH+WacRfvBCZWTI8CFMBP8mdTuKJtpZDCxZY3JiSULUKEaGYosnIM2c1w1K4Z
         ay0jo1sgcg7mR2tbQ86Rfoa+rlBUyfKpemfDL6BZGepGu4ufTQHAtwUyTgEyom74eNi1
         SBfj7PH9LMi5gLMdwuTdr+IaD3u2yMmSpp1Eu6YtcTCEZ0C7ikXEPof8zRi4qV1jWS0N
         xouYavKIltz2oIxdw1MT/qBy2iCIET57+M9LBew5Syt2+hlrWCkgrE22XGSNWLgPriUp
         HRL9PDCc1SfXEAYtmbZllh6pYUTQeIqE89KBC45H+7Gu38rdUSFoQXsjdfmSr8GKMv0Z
         v5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMRViA4J4Y7VUlrHVSDn0arSHqU3NrAf+TwslWWdXBY=;
        b=jonNr3ZafwThqeqCv9kZjx5ZNykAWVCw4L4rVk9aMpLWIBTPISVCVppbKhtFzFm9S5
         /EvZgzBgpswNMd9Pw1uTbvQKpyJhRYhi+wh5E6nJVzY1+ZoEymtdRaLISVxZaBhDMKny
         0wzobqaKukVbMFo4tK7jJ1cRt8uxwZcjtBf+I2t409j43zvV9V+1GMMbQinxYpkhHxVh
         PNOo5ltOzGtJXh0DyPsev7BrxzZ/jiXuch+HFx3Rr+SBopdLL+MnLFYEroCJRQNuPv1j
         osQtPf9MMKYfDbQBdsfBBBmgO8emIZJEFBzYbMSGL3m6gkl/s6toEYBprLapyUZ4chCa
         nkSg==
X-Gm-Message-State: APjAAAXpahuoDmCDk4mvp0eOYXlLNWHMUGm0c6KV/Q8bQSyV0YEHiTtu
        PzpXTrsZJQxL0h2O4d2XO3g=
X-Google-Smtp-Source: APXvYqyD9LmxDIsJ0RQv51fQiumaypAn794lKk1fUdAGtrKGoz75kx9QEni7KedeYSz1JwMuehlPzA==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr2965578wrr.152.1569504535985;
        Thu, 26 Sep 2019 06:28:55 -0700 (PDT)
Received: from szeder.dev (x4db9381f.dyn.telefonica.de. [77.185.56.31])
        by smtp.gmail.com with ESMTPSA id u4sm3809589wmg.41.2019.09.26.06.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:28:55 -0700 (PDT)
Date:   Thu, 26 Sep 2019 15:28:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190926132852.GF2637@szeder.dev>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev>
 <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet>
 <20190923165828.GA27068@szeder.dev>
 <nycvar.QRO.7.76.6.1909261257160.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909261257160.15067@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 01:04:48PM +0200, Johannes Schindelin wrote:
> > > > > Also, things like the code tracing via `-x` (which relies on Bash
> > > > > functionality in order to work properly,
> > > >
> > > > Not really.
> > >
> > > To work properly. What I meant was the trick we need to play with
> > > `BASH_XTRACEFD`.
> >
> > I'm still unsure what BASH_XTRACEFD trick you mean.  AFAICT we don't
> > play any tricks with it to make '-x' work properly, and indeed '-x'
> > tracing works properly even without BASH_XTRACEFD (and to achive that
> > we did have to play some tricks, but not any with BASH_XTRACEFD;
> > perhaps these tricks are what you meant?).
> 
> It works okay some of the time.

As far as I can tell it works all the time.

(Well, Ok, with the exception of t1510, but only because back then I
couldn't be bothered to figure out how that test script works.  But
even that script handles '-x' without BASH_XTRACEFD gracefully, and
it's safe to run the whole test suite with '-x'.)

>  But IIRC `-x -V` requires the `BASH_XTRACEFD` trick.

No, it doesn't; '-V' should have no effect on the '-x' trace
whatsoever.

As soon as I fixed running the test suite with '-x' and /bin/sh I
added GIT_TEST_OPTS="--verbose-log -x" to my 'config.mak' and to our
CI scripts.  The default shell running the test suite in our Linux CI
jobs is dash, and in our macOS jobs it's an ancient Bash version that
doesn't yet have BASH_XTRACEFD.  As far as I know they all work as
they should.

> However, I start to feel like I am distracted deliberately from my main
> argument

That was definitely not my intention.  However, if there are any open
issues with '-x', then I do want to know about it and fix it sooner
rather than later.  Alas, I still don't have the slightest clue about
what your issue actually is.

> I forgot a crucial tidbit: if you run with `-x` and a lazy prereq is
> evaluated, not only is the output disruptive, the trace is also turned
> off after the lazy prereq, _before_ the actual test case is run. So you
> don't see any trace of the actual test case.

Tracing is always turned on before running the test case,
independently from whether a lazy prereq was evaluated or not, so we
do always see the trace of the actual test case.  Notice the '+ true'
and '++ true' lines in my earlier reply including the test traces:
those lines are the trace of the actual test case.

  https://public-inbox.org/git/20190917120230.GA27531@szeder.dev/

