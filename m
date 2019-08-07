Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A331F731
	for <e@80x24.org>; Wed,  7 Aug 2019 17:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbfHGRAz (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 13:00:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40209 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbfHGRAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 13:00:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so89023002qtn.7
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KdCaGe3SJ9EvL4yUSdticxIP3ZsmiPQLQV9gtiamLIc=;
        b=gTRkqDUYV5XeVf5vEX+EZrfBZty/myrS7mNSSUqEv0fJi+iF99plWpyys/39XMum3O
         8Xdf0wGiQa7HnEnKP3dYlMfp2HX2XuHzabLNc0QNKWirV/ahjtkAkvBIOIwf3TdGfVHL
         HOxOjh2TZENFSimtfUe9TySpzCZH0cT7Z8bQ1fkDD9y/Qfhe8TuASfp48YlNjdmsTtTn
         hT2WvjQGYYokM1a0jEwq2TPSQKLo8gqyO+NoIbpdmkpS9wZLGauNDpLson7WpHDhx4K5
         SeJ4iiKh1wo/L8Fu3iiBXwpZ8YvJ/LH001VrsM8WfrJ9VucBbp24Y35zo3/dHsJZIv6I
         lZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KdCaGe3SJ9EvL4yUSdticxIP3ZsmiPQLQV9gtiamLIc=;
        b=crOujRRNJfcrfLj5vHv7mWztQnVT1jVpvMdcslXLqKwNhE+zP5P06C2++N/ijdJFs+
         bzJAzABvU01DxCZK2rDbsmv8m60p4+2rNW1TCz3kXEsV1eYl+WsMwT/A88otpgVGxcnZ
         U6rzB5BgCK8hB/fsmv1hxkd9kEPC+e5iSeN1MPr5Ehfn2O49ZUdaTBTwtJCpVbhYwvO2
         MkM9hS7pxlgqmaSGejuCcA4vO9sfABrbuL11k3RlV1A8L16VlhNLtw8Wu7oyRMA30o1G
         M7iEA5Lme0ntlzeREOAMiYL8LiH3DE6Q7eHod8/p5PAU55xUE45W4D3i73+ALGOIQSvp
         FbXA==
X-Gm-Message-State: APjAAAV5xgbW+dZa5DTqjq25dqj0DwbwzBUDgmC9NOpNQ62NOuVP0+Ki
        L/XhAPnmRZIDESs6pL0fBrvi1w==
X-Google-Smtp-Source: APXvYqyFJ6FePSCn+UFoErtBWqbtEXPYdW0rVdXGGd6YXgcWhtQrPNEWIm0eIbfo6vTTB8g2vunrbg==
X-Received: by 2002:ac8:7319:: with SMTP id x25mr8826824qto.293.1565197253569;
        Wed, 07 Aug 2019 10:00:53 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id p3sm58971479qta.12.2019.08.07.10.00.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:00:52 -0700 (PDT)
Date:   Wed, 7 Aug 2019 13:00:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>
Subject: Re: RFC - Git Developer Blog
Message-ID: <20190807170052.GA61092@syl.local>
References: <20190806014935.GA26909@google.com>
 <xmqqlfw7klwk.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD1XNGWf8=_LvrEsFswZdw5pydk2VyVWxWvwALfhVbBOsg@mail.gmail.com>
 <20190806132730.GC18442@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806132730.GC18442@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 09:27:30AM -0400, Jeff King wrote:
> On Tue, Aug 06, 2019 at 06:59:21AM +0200, Christian Couder wrote:
>
> > When Git Rev News was started I thought that there could be such a
> > group effort to encourage each other to publish articles in it, but I
> > must say that outside the group of editors (currently Jakub, Markus,
> > Gabriel and me) it hasn't happened much.
> >
> > Each month though there are a small number of people helping on
> > smaller things like short news, typos, releases, etc. And people who
> > are interviewed are doing a great job when they accept to be
> > interviewed.
> >
> > Maybe it's also not clear that we could accept other kind of articles
> > than just articles focused on what happens on the mailing list. I
> > think we have generally tried to highlight articles by Git developers
> > that were published on their blogs or their company's blog though.
>
> I think the audience may be a bit different for Rev News versus a blog.
> I'd expect the blog to be written for people who use Git, and want to
> learn how to use new features, or maybe broaden their understanding of
> it. Rev News seems a lot more technical to me, and mostly of interest to
> people who are part of the development community.

Yeah, I agree and share the view that the audience between the two is
definitely different, at least if I'm understanding the purpose of this
new proposal correctly.

I quite enjoy reading Rev News, because it does a great job at
summarizing all of the on-list development. So, if I haven't had enough
time to stay up-to-date on it myself, I know that Rev News has.

But, I'm not sure that it holds the same interest for folks who don't
participate in development. Perhaps there are some willing spectators
who might be curious about what's going on, but I get the general sense
that the majority of Git users would be primarily interested in news
other than what's currently on Rev News.

> Which isn't to say those two things can't co-exist on a site[1] or a
> blog. But I think there needs to be some way for people to subscribe to
> one but not the other. Because I suspect that too many posts about the
> development process would drive away users who would be interested in
> the less-technical posts.

This is an interesting idea. I don't really have a strong preference
either way whether a new blog be grafted onto the existing Rev News
site, but I do think that the two should be separate.

> -Peff
>
> [1] By the way, Rev News lives over at git.github.io, but there's no
>     reason it couldn't be integrated (from the user's perspective) with
>     the git-scm.org site.
>
>     I wouldn't want it in the same repo for technical reasons, but it
>     could be revnews.git-scm.com or similar (and possibly styled in a
>     similar way).
>
>     If you're happy with it separate, I have no objections. I just
>     wanted to make it clear it's an option.

Thanks,
Taylor
