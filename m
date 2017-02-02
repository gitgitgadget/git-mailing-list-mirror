Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622F31F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 06:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdBBGzg (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 01:55:36 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:33211 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdBBGzf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 01:55:35 -0500
Received: by mail-ua0-f175.google.com with SMTP id i68so5042902uad.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 22:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j6tJDxNd0b0OvtlAGwK3V0L6lqDymXSknGRly7rJZbE=;
        b=T8EWZH53FSkLdhPST+qw6ObKEk+2/UQTPADDJH8qMQSO/5ZPLFnuiDoivg3csqZVkq
         GIb2wH+SRXUN39iK1FxxrxwBVh7KweGsqGs1On6luDBx7yvpeINydHvKLNmCI0wB3jTl
         2aATayTGyegfx8kdNordhr5ii9dOTDRUZKiqkQotLHY+Y5TbGRvJLECHQtXKPoPRs8Ew
         m+k1E90UgTP9opz5CqIBJV5XfB3pb1DZv0Eb+K+QHU359DFS6Tu5RCCVQ2MP28r4Lnab
         G+4rAd2IOaDBITSgrpcCZT3Go3hr/UV2O53KQmayiT20My6qWPCb6sYMpPGtOLvhyAxj
         9j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j6tJDxNd0b0OvtlAGwK3V0L6lqDymXSknGRly7rJZbE=;
        b=oyNp5eQPriYhsmTJqIiKXOpR4TNeZpo/0u8y9VLNK/SG0sPeAN+bxVYTVzUD0XmD/R
         OtJBSVGGDpCiKwOm7mf/IX2ni8JqwN1tNGrHEnihVlhjsbjynkzH+yMcj2JLI8gpHJ4n
         fpvrpilft+blxzMwWHBRL+JLcwMulX5dQiztZoq3jk10Km9fuCQwb+985SAnTYn679AW
         3keR/E1jmBG1U1+UWQuzDK7uBrew7ElkJB1Uy5ukyZJytMyXd1NosfOzvpEQyVFOcw2N
         2JEQTJYMLrJ8fYkQiDMIrA3HvC+2mwOvV1/+HPrrCyf4wubFIQZ5dWdhtk69Cl8nCtIl
         bN+Q==
X-Gm-Message-State: AIkVDXIRk249Jl9CySd13vylAv+ZkUlFnsQUP32kYDbBTGCdPjmHDfbSc7aIfde0RLPb7veQPAqM+aUmAXpO1w==
X-Received: by 10.176.6.106 with SMTP id f97mr3349028uaf.118.1486018534305;
 Wed, 01 Feb 2017 22:55:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Wed, 1 Feb 2017 22:54:53 -0800 (PST)
In-Reply-To: <20170202043610.GA12738@starla>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net> <20170202043610.GA12738@starla>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 2 Feb 2017 00:54:53 -0600
Message-ID: <CAJZjrdUGsp5-HsA0Hxk4Qo+2s6crLbu-LuX=ECuC2QpM6HCWgg@mail.gmail.com>
Subject: Re: git-scm.com status report
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In theory, you could also dump the build artifacts to a GH Pages repo
and host it from there, although I don't know if you would run up
against any of the usage limits[0]. The immediate problem I see with
that approach, though, is that I have no idea how any of the dynamic
stuff (e.g. search) would be replaced.

A question: there's a DB schema in there. Does the site still use a DB?

[0] https://help.github.com/articles/what-is-github-pages/#usage-limits

On Wed, Feb 1, 2017 at 10:36 PM, Eric Wong <e@80x24.org> wrote:
> Jeff King <peff@peff.net> wrote:
>> With the caveat that I know very little about web hosting, $230/mo
>> sounds like an awful lot for what is essentially a static web site.
>
> Yes, that's a lot.
>
> Fwiw, that covers a year of low-end VPS hosting for the main
> public-inbox.org/git machine + mail host
> (~1GB git objects + ~3GB Xapian index).
>
>> The site does see a lot of hits, but most of the content is a few basic
>> web pages, and copies of other static content that is updated
>> only occasionally (manpage content, lists of downloads, etc).  The biggest
>> dynamic component is the site search, I think.
>
> Maybe optimize search if that's slowest, first.  public-inbox
> uses per-host Xapian indexes so there's no extra network latency
> and it seems to work well.  But maybe you don't get FS write
> access without full VPS access on Heroku...
>
> nginx handles static content easily, and since it looks like you
> guys use unicorn[*] for running the Ruby part.  I really hope
> nginx is in front of unicorn, since (AFAIK) Heroku doesn't put
> nginx in front of it by default.
>
>
> [*] I wrote and maintain unicorn; and have not yet recommended
>     any reverse proxy besides nginx to buffer for it.
>     However, having varnish or any other caching layer in
>     between nginx and unicorn is great, too.  I dunno how Heroku
>     (or any proprietary deployment systems) handle it, though.
>
>> I do wonder if there's room for improvement either:
>>
>>   - by measuring and optimizing the Heroku deploy. I have no idea about
>>     scaling Rails or Heroku apps. Do we really need three expensive
>>     dynos, or a $50/mo database plan? I'm not even sure what to measure,
>>     or how. There are some analytics on the site, but I don't have
>>     access to them (I could probably dig around for access if there was
>>     somebody who actually knew how to do something productive with
>>     them).
>
> I track down the most expensive requests in per-request timing
> logs and work on profiling + optimizations from there...
> Nothing fancy and no relying on proprietary tools like NewRelic.
>
> I also watch for queueing in listen socket backlog (with
> raindrops <https://raindrops-demo.bogomips.org/> or ss(8) to
> notice overloading.  Again, I don't know how much visibility
> you have with Heroku.
>
>>   - by moving to a simpler model. I wonder if we could build the site
>>     once and then deploy a more static variant of it to a cheaper
>>     hosting platform. I'm not really sure what our options would be, how
>>     much work it would take to do the conversion, and if we'd lose any
>>     functionality.
>
> *shrug*  That'd be more work, at least.  I'd figure out what's
> slow, first.
>
> Fwiw, Varnish definitely helps public-inbox when slammed by
> HN/Reddit traffic.  It's great as long as you don't have
> per-user data to invalidate, which seems to be the case for
> git-scm.
>
>> If anybody is interested in tackling a project like this, let me know,
>> and I can try to provide access to whatever parts are needed.
>
> While I'm not up-to-date with modern Rails or deployment stuff,
> I'm available via email if you have any lower-level
> Ruby/unicorn/nginx-related questions.  I'm sure GitHub/GitLab
> also has folks familiar with nginx+unicorn deployment on
> bare metal or VPS who could also help.
