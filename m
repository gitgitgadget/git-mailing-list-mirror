Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E37420248
	for <e@80x24.org>; Wed,  6 Mar 2019 09:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfCFJgk (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 04:36:40 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39070 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfCFJgj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 04:36:39 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so9165703iti.4
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 01:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AodImjW1WZok9wohrTRP78XT+AZeS0KnhWDY79qxcfs=;
        b=O/uhQPI2tBklJ8oBAgw0cOjg42YlJi+lhpY72wll/n8/LzDpipN4I6TJJnxb8cTZTW
         s/Q6V4rv9Z9/a96ft5pLXtjitUwfvGBTF/uflJpzri53NTQ35lvxxU65u2COc8r4wUol
         NrKddOnC/rVzMYNUzuaKB9DgcvdHzi8DqkDJcElL0yNCWcWyopcRwaCKRjsytT1P+ib+
         pqQzlBO7n5RB6+BSphOA0WpJzM2lLSgWKnAu+FHtae59K2ZrT7zqWjQJ0TklFmYB7s0q
         yep6DJDeCa0tUToTXJS9I1zoL+ADyMvieajKkrtssaGw/2PD1f/LKrNFTgIfWoxHvPHg
         YzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AodImjW1WZok9wohrTRP78XT+AZeS0KnhWDY79qxcfs=;
        b=gEJxXPapHCALmsH7QGGZt2nkkfyCtszLM6nfU1VnE5ljSke/28ecYN19159UA089Nj
         xEJOollE8cPU3T4swmD1zzRIqF+CEECJhby+DCd3pFVLPLEi5SDYsw8M/Py4hYGdCD8c
         7NXzSrijUDl4KBsovgrM5wj6wzDLSFixnn8Drp8lKHRa7wB9FLD1gupfW9oBKYlOG2uw
         rkbdSsXGM6s4/ghOgMeLH6liuHtmSBMiBSAku3NfNdqjob7OdlR5oOqd3OFH4QvZKBwP
         eZAki7eQcGt2zE0rpWnyXAAx90EiDj5k79ecmvxmqxl2YOH5DXZtrQSEdRIOF/P78+X9
         yQ7Q==
X-Gm-Message-State: APjAAAUp4NP7NLbGDW7a0scK1wcuy+W4v+FnfYi5D1Kf0JudyBRVw2On
        yjHDrJblaDkc6dptiaY97mAOybeiKPwOfk0Hc2E=
X-Google-Smtp-Source: APXvYqwUqQchdQGOSoyD+0IGN4YQcY9+eb0Bwifc/vDE3Pwoi6zkfAG1g5DN2+h2T3j1//iCP8k7UBK9ZFtP/MW2RtM=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr1474445itf.123.1551864998694;
 Wed, 06 Mar 2019 01:36:38 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <CACsJy8DhDe+28z2=3v1dBqco7q2Zj12hdKKT==yWFPui8SBkiw@mail.gmail.com> <20190306044955.GC6664@sigill.intra.peff.net>
In-Reply-To: <20190306044955.GC6664@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Mar 2019 16:36:12 +0700
Message-ID: <CACsJy8BaCMsXhXSAwu+wmZCTwL5TO8wVDtGd87vRwH=AcOsThA@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 6, 2019 at 11:49 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Mar 05, 2019 at 07:04:59PM +0700, Duy Nguyen wrote:
>
> > On Mon, Feb 4, 2019 at 4:17 PM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > >
> > > Hi everyone,
> > >
> > > There are now ideas, micro-projects and organization application pages
> > > for GSoC 2019 on https://git.github.io/
> > >
> > > It would be nice to have a few more project ideas.
> >
> > Not sure if it's too late now. Anyway this could be something fun to
> > do: support C-based tests in our test suite.
> >
> > A while back I noticed some test running very long because it was
> > trying a lot of input combination. The actual logic is not much, but
> > because of the increasing number of test cases, overhead goes off the
> > roof. The last part is probably not true, but Windows port I think is
> > hit much harder than what I experience, and I think Dscho did complain
> > about it.
> >
> > So what this project does is somehow allow people to write test cases
> > in C instead of shell. Imagine replacing t3070-wildmatch.sh with a
> > binary program t3070-wildmatch that behaves the same way. This test
> > framework needs to support the same basic feature set as test-lib.sh:
> > TAP output, test results summary, maybe -i and --valgrind... To
> > demonstrate that the test framework works, one of these long test
> > files should be rewritten in C. I'm sure there's one that is simple to
> > rewrite.
> >
> > I'm pretty sure I had some fun with this idea and made some prototype
> > but I couldn't find it. If I do, I'll post the link here.
>
> In my experience, it's nicer to have a tool written in C that can be
> driven by arbitrary input. That makes it easy to write new test cases,
> because you just have to write in some easy domain-specific format
> instead of embedding the test data in C code.
>
> And many of our tests do work like that (in fact, many of the Git
> plumbing tools function as that). E.g., test-date gives you direct
> access to the low-level routines, and we feed it a variety of dates.
>
> That doesn't help with the cost of invoking that tool over and over,
> though, once per test case. I wonder if we could have some kind of
> hybrid. I.e., where t3070 is still a shell script, but it primarily
> consists of running one big binary, like:
>
>   test-wildmatch <<-\EOF
>   case 1
>   case 2
>   ...etc
>   EOF
>
> but with one added twist: test-wildmatch would actually generate TAP
> output for each test, rather than just returning 0/1 for each success or
> failure, and being embedded in a test_expect_success.

Yeah. I mean, converting a full file is just one of the ways to go.
The exact design is up to whoever implements it.

> It seems like that would even be pretty easy to do, with the exception
> of the numbering.

I'd like some niceties from test-lib.sh though. -i should be supported
to stop at the first failure. -v would be nice if possible. Skipping
tsets also.

> It would be nice if we could intermingle this kind of
> "chunk of C tests" with normal tests, but we'd have to figure out how
> many tests it ran and increment our shell-script's counter
> appropriately.

Even if you convert a full file, you need to do that anyway, to make
sure final test run summary is correct (at least when TAP is not used)

This kind of framework, I think also helps write new unit tests. There
are cases where creating the right condition to trigger just one
function is lots of work and easy to break. Sometimes it's easier to
do everything in C when full repository is not involved.
-- 
Duy
