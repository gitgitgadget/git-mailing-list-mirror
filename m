Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB181F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeCZSdN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:33:13 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:36459 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCZSdM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:33:12 -0400
Received: by mail-yw0-f181.google.com with SMTP id y64so6436548ywa.3
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRrRgxDsanfUWsgrCJmPG8im2tTbaRIUqyDe68jXM+E=;
        b=h4rwucSCsB6RuiaCtQjHqA4TFqeeWwadP+bYWB8ORKasxf0TdwV0W4JDpmNsX56k+0
         +OFVlgnYz8gaTMqMU8Cd9BqPMgmCyNEsK+/TRPWzZWBnClI3XL48Pr94WSwfseP8M+L1
         im+Ve6vB0PP1P9JenZZA2zfbwBvcHpLGjs0MG4ces57W0Q7J/7dkYE0mub2tane5j/qy
         AzV/k7y22PEyKgvmfH61XrURgScluLYrjk6IepJqbF45dpn7Zj4UvCIwTOmgXR/i9zJ5
         nyl7Ix0dHRUkNYcH+T8LUNJlVXY7BtyPrpv77reBDMyS8ssFI7DUGrYkvp2dcgVAWMA5
         DG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRrRgxDsanfUWsgrCJmPG8im2tTbaRIUqyDe68jXM+E=;
        b=gB37mPSYOSRgox61a90rgso01qkLXwxvgd7PSe4wsol6X/D2h8mRBLj48vfzSZMW+z
         ifpNdScP23LT30GFPoh0vY36Vgs0U7cr5fGaePTex+rMZ7QiYhK2LXA55oiUKtvksALj
         PfqWBUJI1/kAyJDatHrp45hE0cLzIU7Jvc3i2rM3XqeAy2gaEAdZMjlDPf6N6c7cczBC
         6dndKvLA/2QEk+Ajn6fN3fwfJp4zP9+/9uMMdtWGqDhhKcPXlSww3zq9fJeRBlw1OKXx
         CFdrQdi2aIhhzMqJJUXYJnG3fYg9Fz6zG2oozZEVrX9wSNWHLXsuZseGCo02UYxHTAde
         TBJQ==
X-Gm-Message-State: AElRT7FHM5r1DkU6TtTTHGVokGHGLcOgGj0LGMGPNdX1O0ag3p6U6Qv0
        ZhjSQG91YSFFwboF2IA0nxi9EL9njAjYESG8KwpH4JAmMQ4=
X-Google-Smtp-Source: AG47ELt/hEBFbzEYnhOFFgDFjHcTBnU16f/Pql5wOZ1ev0ZiMNcPvNlGikvok0V306Uw/My97q+LcDLk6NpWtUVFWTY=
X-Received: by 10.129.108.67 with SMTP id h64mr23968640ywc.500.1522089191028;
 Mon, 26 Mar 2018 11:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD2D-XU=YeJD7A+9wauu0WKHwkXgVxbEBkOGPyZE7GiOZA@mail.gmail.com>
 <20180324084103.3367-1-predatoramigo@gmail.com> <CAP8UFD3Q26oiusO-+0SyFd=J+DTnrL5Xemrk+LLOk3hAUEVe9Q@mail.gmail.com>
In-Reply-To: <CAP8UFD3Q26oiusO-+0SyFd=J+DTnrL5Xemrk+LLOk3hAUEVe9Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 18:33:00 +0000
Message-ID: <CAGZ79kapp-k5NY+Zop78r+2VtxC+Qs-SBK75r3S6T78EAg4q+g@mail.gmail.com>
Subject: Re: [GSoC] Re: Info: git log --oneline improvements
To:     Christian Couder <christian.couder@gmail.com>
Cc:     predatoramigo@gmail.com, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 4:15 AM Christian Couder
<christian.couder@gmail.com>
wrote:

> Hi,

> On Sat, Mar 24, 2018 at 9:41 AM, Pratik Karki <predatoramigo@gmail.com>
wrote:
> >
> > Hi Christian and Johannes,
> >
> > Though I sent a mail earlier, saying I would like to submit another
> > proposal, I am now skeptical on re-writing another proposal as you
> > guys are only available mentor for GSoC

Is there a place/email where I can read up on the git log --oneline
improvements? I use the --oneline flag a lot and would be interested
in hearing what you plan there.

> Well Stefan Beller wrote in


https://public-inbox.org/git/CAGZ79kax5Hip1wP3U60im__Dm0GvH8nNd+ByxG5OxMXrRkRvdQ@mail.gmail.com/

> that he would be ok to co-mentor, but I am not sure which projects he
> would be ok to co-mentor. I just Cc'ed him so he can tell us more.

I would be happy to co mentor any project by prioritizing some
review time on it.

Regarding rewriting shell scripts in C,
there have been GSoC students in the previous years, which may help you
understand the scope of the project better.

     git clone --mirror https://public-inbox.org/git
     git clone https://git.kernel.org/pub/scm/git/git.git/

and search via "git log --author=" for
Paul Tan, who converted git-am and git-pull into C
or Prathamesh Chavan, who rewrote git-submodule
to be in C, but the result is not upstream (yet).

I think there are more shell to C conversions, but I was involved
with these 2, hence giving these examples.

> > and I believe Git doesn't
> > select more than 2 proposals.

> Yeah, because mentoring is a lot of work, and doesn't always work out
> as well as we would expect, (mostly because it is difficult to explain
> to new contributors that review cycles for significant patch series
> take a lot more time than they could imagine), so not many people
> volunteer to mentor or co-mentor.

I agree on this. Mentoring takes some time as well.
The coding part is the easy part, the communication part with
the community is the harder part.

For example the Git community is spread across all time zones.
So if you want to give everyone the opportunity to give input to
your patches you want to wait 2 hours.

The community consists of people with diverse backgrounds, e.g.
some work on Git in their spare time on the weekends [only]. Others
work on it as their job [so it is rather a Mon-Fri activity]; others glance
at the mailing list in the lunch break or in the evenings.

These timing issues are not the hardest part,
but the easiest to explain shortly. ;)

> I still hope though that over time some former GSoC student will
> become (co-)mentors as this happens quite often in other projects that
> participates in the GSoC.
