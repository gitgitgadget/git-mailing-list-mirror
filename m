Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2F31F461
	for <e@80x24.org>; Fri, 30 Aug 2019 00:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfH3AT5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 20:19:57 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44734 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfH3AT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 20:19:57 -0400
Received: by mail-ua1-f65.google.com with SMTP id m23so1755080uaq.11
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2o1EJ/OzABa1vhmwdp49cnBa+H9ueLZMwBii/GLQDTA=;
        b=bWe4PL7BeIYw9LZyDa8zPyEO9qT5bA6weCzuBRIIxw7PCqmf+riKY3v/heKm4TaPcr
         nr6pc9pKI2njrqQHhspyk0qM2r8LwSt8s4Oj1e+0KxJo/6YQzTaMepPvKTdpKzRRY7Cd
         Xa+FFcAKoh0VWuDIx2w+hOhEKVj5s/Es+XOYImoQvg9jic8bFEsPcZA3u8XuY9eBgEZf
         K9zr6HE5XTI7nwzGkZNonnDnNVRIxWO51vT2Kzd/0TrYyjDG+9RKftK6VMq2Q+UbRRtH
         bAtCGCBctXupOoiXFk8y3nt0gPLXBhxJ6MwCGwYr9Xc4qi2yUm0W9RgQ6TfiR4aAfnIJ
         VlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2o1EJ/OzABa1vhmwdp49cnBa+H9ueLZMwBii/GLQDTA=;
        b=I/leT3OS8lAIAyjPH8Oiw1dqd2UpHfp3x9iISdWuJk1+Jcwf7kjoT7VbUhPvXUDdWT
         MldY0V8DhOWxiREcaU7EExEx83KVW4FK/p7JvEOD7h6zHCVWqtfAhUZeyLAGU1Avd3nb
         c1QmdCwPNcy+cRMfprr/PsXRfFpOLtm8ePOQPXjTrFkHSX1rM++o6vRse5gYzHI7pVb8
         DLF+wfx3HlGsCr9DZTfCMSuer0/bGC8Jrz3hpOLpNSejzktMt+bm71pdrpu2sXuTYMeN
         0A7+0vXUQfJPZuXX1tT6pSx+ImvpVyxhoe5Iugw+9DurydhRwuQumVfgFdC/LzE0NS5G
         MUzw==
X-Gm-Message-State: APjAAAU5SHpKWXcmpM8qxr+lHvdmRoZ6i5TDBM9WvUSiVZWCRffABocZ
        GKDaaB9TGQHA7+GjFq8pa8gIW6TEynFYXNLazXU=
X-Google-Smtp-Source: APXvYqw8sT8HiEfn5X+zFYN2p7rma+gsvE/1x6g7qibMWZnXyGTTrJLQf/E2NaOhCyqmrdK5RIS9MmkQzACsjc5i4y8=
X-Received: by 2002:ab0:24d4:: with SMTP id k20mr6304669uan.1.1567124395972;
 Thu, 29 Aug 2019 17:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.325.git.gitgitgadget@gmail.com> <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
 <7e406b35-9ff6-348f-bdee-7540381f000e@gmail.com> <206819d0-8066-e8e8-8967-8a1db05eea26@gmail.com>
 <20190829203037.vzxuaxpsghbdc6vl@yadavpratyush.com> <20190829214014.vijdotp4g65a5mk3@yadavpratyush.com>
In-Reply-To: <20190829214014.vijdotp4g65a5mk3@yadavpratyush.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Aug 2019 17:19:44 -0700
Message-ID: <CABPp-BF_uBTKT_5YmoMNoToiujuMdQia-OfxOPAJPrhT6jPbdA@mail.gmail.com>
Subject: Re: [PATCH 1/1] checkout: add simple check for 'git checkout -b'
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 2:42 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 30/08/19 02:00AM, Pratyush Yadav wrote:
> > On 29/08/19 04:07PM, Derrick Stolee wrote:
> > > On 8/29/2019 2:54 PM, Phillip Wood wrote:
> > > > Hi Stolee
> > > >
> > > > On 29/08/2019 18:01, Derrick Stolee via GitGitGadget wrote:
> > > >> +
> > > >> +    if (argc == 3 && !strcmp(argv[1], "-b")) {
> > > >> +        /*
> > > >> +         * User ran 'git checkout -b <branch>' and expects
> > > >
> > > > What if the user ran 'git checkout -b<branch>'? Then argc == 2.
> > >
> > > Good catch. I'm tempted to say "don't do that" to keep this
> > > simple. They won't have incorrect results, just slower than
> > > the "with space" option.
> > >
> > > However, if there is enough interest in correcting the "-b<branch>"
> > > case, then I can make another attempt at this.
> >
> > You can probably do this with:
> >
> >   !strncmp(argv[1], "-b", 2)
> >
> > The difference is so little, might as well do it IMO.
>
> Actually, that is not correct. I took a quick look before writing this
> and missed the fact that argc == 3 is the bigger problem.
>
> Thinking a little more about this, you can mix other options with
> checkout -b, like --track. You can also specify <start_point>.
>
> Now I don't know enough about this optimization you are doing to know
> whether we need to optimize when these options are given, but at least
> for --track I don't see any reason not to.
>
> So maybe you are better off using something like getopt() (warning:
> getopt modifies the input string so you probably want to duplicate it)
> if you want to support all cases. Though for this simple case you can
> probably get away by just directly scanning the argv list for "-b"
> (using strncmp instead of strcmp to account for "-b<branch-name>)

NO.  This would be unsafe to use if <start_point> is specified.  I
think either -f or -m together with -b make no sense unless
<start_point> is specified, but if they do make sense separately, I'm
guessing this hack should not be used with those flags.  And
additional flags may appear in the future that should not be used
together with this hack.

Personally, although I understand the desire to support any possible
cases in general, *this is a performance hack*.  As such, it should be
as simple and localized as possible.  I don't think supporting
old-style stuck flags (-b$BRANCH) is worth complicating this.  I'm
even leery of adding support for --track (do any users of huge repos
use -b with --track?  Does anyone at all use --track anymore?  I'm not
sure I've ever seen any user use that flag in the last 10 years other
than myself.)  Besides, in the *worst* possible case, the command the
user specifies works just fine...it just takes a little longer.  My
opinion is that Stolee's patch is perfect as-is and should not be
generalized at all.

Just my $0.02,
Elijah
