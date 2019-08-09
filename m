Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302F91F731
	for <e@80x24.org>; Fri,  9 Aug 2019 11:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405928AbfHILVb (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 07:21:31 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:43942 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfHILVb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 07:21:31 -0400
Received: by mail-qt1-f170.google.com with SMTP id w17so14765609qto.10
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 04:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KwQN7J0G//+rTA70ZdjOWaC02qhn6AxHS8TkX7N+6qk=;
        b=fZZxiazLIMXbvGhMgxS6dW/wTlI146ZMgGxTx2gFeUNjmB0JuiyTV2OZxvXl7Nt8D+
         8MeP8EAJ4MJ2Z72XBSsrlsbp/hVQwoPJ9tCT093rwci8lFIGJzedTJU9RwUIf06otTW9
         wRcL/4xXGhlGM+zoDmtg4lEFrDBtrL+Jhfwseu1I2qORsxzjx7LiC/fvnvVAAbDGzyts
         M17crcmH6DwRMfzYGI0rDC7i/pZZ0nBnF/fm+U5gqdF21eTduoqRqqtYpCm65jniAuMV
         EJcXVI0ClFXwKx0XyKGFaVICincA5cY/DDj4r4z++XOotTMydPPkOByzqgTjFwUGx5OT
         vSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KwQN7J0G//+rTA70ZdjOWaC02qhn6AxHS8TkX7N+6qk=;
        b=IYsHNH1z+x8WMLH/Vjn2u8BHiFQyBWDsF/Bkha5JhzsBCcn2ljSDOLf8eJVouYvxcL
         EizedLXiARxU+NdrSpZs5KLIkkGamqobLcZxBl8KT/9ns/H3Kt4bkzXoQ58YBquCi73+
         mTuDmpeVZImB16GRjN3F6DzWUCGgJIkUnAIxmSJ5mRly7LLoR0UkfBpnZEF3Xs78T8wF
         FfZqtUas7sWD8z8YyfjemD9ryB9hsT9SCCzMgaafC9MmaOB3QCZZidV9spJL/8zyG8x7
         bGRdJe5QOG84FeCTggko2ZB9s34ckp/FIYdz+YldzS4C22cMoJuRYOkvWrde+MWi4c4r
         bwvg==
X-Gm-Message-State: APjAAAWYS1K7S+WDoOEnP6/PNomzLdHrOHYfgby4LJSTChzUGNE83DxI
        hg9frNMMEUYvLRSbuBfAExhZaQ==
X-Google-Smtp-Source: APXvYqzwCZ9G6uasb3taj0YbjETt9thE+X6CWwDz/FDGifAUaSB07y+b8ZL84Ph4It3hrHZptMuSVQ==
X-Received: by 2002:ad4:5401:: with SMTP id f1mr17075777qvt.66.1565349689971;
        Fri, 09 Aug 2019 04:21:29 -0700 (PDT)
Received: from localhost ([50.49.245.163])
        by smtp.gmail.com with ESMTPSA id l206sm6595148qke.33.2019.08.09.04.21.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 04:21:29 -0700 (PDT)
Date:   Fri, 9 Aug 2019 07:21:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     Phil Hord <phil.hord@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
Message-ID: <20190809112128.GC93559@syl.local>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
 <20190809001315.GA87896@syl.lan>
 <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
 <20190809020732.GA89008@syl.lan>
 <CABURp0oFNWfWEwnkjV1+Tag91HTRBCaJjyvc8CXtPGu78DhtSw@mail.gmail.com>
 <CAAOiGNzuLu26H56RvNCT=1iPQWOtGQJACO-pS8azerUio--=tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAOiGNzuLu26H56RvNCT=1iPQWOtGQJACO-pS8azerUio--=tw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ariadne,

On Thu, Aug 08, 2019 at 10:21:02PM -0500, Ariadne Conill wrote:
> Hello,
>
> On Thu, Aug 8, 2019 at 10:07 PM Phil Hord <phil.hord@gmail.com> wrote:
> >
> > The issue of deadnaming aside, turning on log.mailmap by default is
> > the sensible thing to do given that other Git features already honor
> > it that way.  Having it ignored-by-default (but only sometimes) just
> > adds confusion when a mailmap is available.
>
> This is my point exactly!  My motive for improving this behaviour is
> entirely irrelevant, honestly.  I regret ever bringing it up elsewhere
> in the discussions, as it's completely irrelevant.

Yeah, I think that this makes much more sense (at least to me) as an
issue separate from the deadname rewriting topic. If nothing else, this
makes 'git log' act like 'git shortlog', which only makes sense.

> > > > >  - The '.mailmap' provides a list of transgender individuals, along
> > > > >    with their deadname, which can be used to harass them.
> > > >
> > > > This is potentially a problem but it's not as bad as you depict.  A
> > > > mailmap rule can match against e-mail only, which is precisely what I
> > > > have done in my projects.
> > >
> > > Ah, I may be severely mistaken -- my memory was that '.mailmap'
> > > rewriting could be used to rewrite both name and email, not merely
> > > email. I thought that records could take:
> > >
> > >   A U Thor <author@xample.com> -> B C Xyzz <newname@example.com>
> > >
> > > instead of canonicalizing by email alone. If this is the case, then I
> > > completely agree and share the opinion that this is not as bad as I
> > > originally depicted.
> >
> > The long form you give there is to be used in case the old email
> > address is not a unique key. See 'git help shortlog'.
> >
> > The problem we have at work is that one woman's old email address
> > includes her deadname, like <firstname.lastname@company.com>.  I will
> > leave it up to her whether she chooses to be listed explicitly in the
> > mailmap.  I have wondered if we should permit hashed email addresses
> > to be used for this specific case, but this also has its drawbacks.
>
> I'd be open to looking into adding support for hashing the e-mail for
> cases like this if people are interested.  The
> firstname.lastname@company.com case is certainly a tough one to crack
> otherwise, but I think that a solution that works for most cases still
> is useful.  In the meantime, I think it makes sense to let people
> decide whether they wish to use mailmap for this purpose, based on
> their own understanding of the risks involved.

Yep. Totally agreed, and thank you for these patches.

> Ariadne

Thanks,
Taylor
