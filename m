Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA3E1F859
	for <e@80x24.org>; Mon, 22 Aug 2016 13:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755398AbcHVNG2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 09:06:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:65124 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755389AbcHVNG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 09:06:26 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LaGJa-1arzzq04Za-00m5Ya; Mon, 22 Aug 2016 15:06:16
 +0200
Date:   Mon, 22 Aug 2016 15:06:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1608221450250.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:n9LQ0q2XNvy4huBIzgyQfAl0nsiF+bQ7IIfnY5a0JbfAOavr4p/
 ODxRFmUvkmjKVAPTKS4EVp4VToQNcDhsN0vl7bHlOQWjN9LJucoXEYItitX4ElNeVj97Qoc
 V28W3jAkS9HZfW50LJ/Amg0AmrAttPUNi1JqWv8Fpg5heNO42Mp5QkozgzEdDZApr1MMlC/
 cMv7yWBUGawurwGYCZgVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EELoBnZ4TmQ=:8CUiZufeU6ZT7XxJMXiL/L
 Xe8DPOf6rrvHnQiVS3BPRiRi0hrSPD30S6rF9gYelgWnhORQYZdRhLeJ1/9Aaa1WatgRk6WHR
 uiTca4A+JYHyknmcMqWZIx/Ynlp0waJae1b0JrpA5y3o0yLXgWqeweqXIYcfNlziZsMLS1oDO
 /8qQxU2QKKJ0Bs0WlLQZ38hN+ec3/Rxh48Q4KcED9UMMNspB3M1rMOh8OiGtmABCfFP/u1cH2
 O+acbw4alKsz76wvJuTAXKw81BoB4FNh48q6/bSnpsZFt0K0ff60Uw4YaiLCOV9V60joOBcLq
 Eeag6mCN4pHlsS/XjXwRvBHgP0J6bPAkd+8xCaKGM4Y3SSW0gC/BViGri8USGoJjbLLKtdGGF
 y/5xzICf0Ajg0ZnQQlhMzFrGsTCBgtlDyZvNm1MigzW/dUlDwAVJqWljlkmHsCOYArNhMsOKl
 Uz5tssTiiVfsLCG0lTZd3SJVOxjKH3uhUsW8EbQmqWCl73p6MD7TGeDZe0QgpGC1ArrguopBs
 IaB+u2LzxIiWlcHuqOlrOnfq0PcUG+knue6hkft0knU2W20xLDl8aUY5uMCw5fNByYFWCjEkB
 qyBqVZt1GuL3uhlTYd9hjwjzoKRAXqqeN7c+4pfKrsTUE3Bey2b7g8D7ZETE0hoYDxXrwzbqS
 iYHhxr148XzZMiSByX8hhrWGTrBRj/K3cdilk0h65Kz4i9ebEZauLQBJ1qTPXjU07qzouUY1J
 lcPCfB2Z68VE3lUSkcswxxXMpkE5luZZvZ8VYM54SOqEPtJrmhR9391ISm9wwTfIKcu2dfeZ4
 LHU/Lt8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 19 Aug 2016, Jeff King wrote:

> On Thu, Aug 18, 2016 at 02:42:34PM +0200, Johannes Schindelin wrote:
> 
> > BTW I take this thread as yet another proof that people are unhappy
> > with mail list-based review: if you have to build *that much* tooling
> > around it (and Peff & Junio certainly have a megaton of advanced and
> > sophisticated tooling around it, holy cow!) it is really incorrect to
> > state that the mail list-driven approach works for you. It is much
> > closer to the truth to say that the
> > mail-list-plus-loads-of-custom-tools-driven approach works for you.
> > 
> > I am really not a fan of this.
> > 
> > The theory "it's inclusive because everyone has access to mail" falls
> > on its face, badly, when even old timers have to build entire
> > infrastructures around it just to begin to be able to use it
> > efficiently.
> > 
> > It reminds me of an old software developer I met long ago, who claimed
> > CVS works for him. He had written tens of thousands of lines of shell
> > scripts, is what allowed "CVS" to work for him.
> > 
> > Same here. Old dogs claim the mail list-approach works for them. Nope.
> > Doesn't. Else you would not have written all those custom scripts.
> 
> I read this over, didn't agree, waited a whole day for perspective, and
> still just can't agree. So now I'm responding. :)

Thank you for your constructive feedback.

Obviously I just can't agree with what you wrote, at least not completely.
So after waiting an entire weekend for perspective, here are my thoughts
on your comments:

> There is nothing wrong with building tooling around your workflow. If we
> had a GitHub-based workflow, I'd build tooling around that, too.

Sure. You, Junio and myself seem to be kings of scripting. Automating
common tasks through scripting is something that allows me to not go
completely bunkers with the workload I have. I imagine it is similar on
your side.

> One of the things I _like_ about a mail-based workflow is how easy it is
> to build that tooling, and to get it to integrate with other existing
> tools.

Here I disagree violently. What I would have agreed to would be a
statement similar to "It is easy to integrate scripting with mutt".

To be quite frank: we are talking about very different things when we talk
about mail-based workflows. Heck, we even talk about gazillions of
different things when we talk about an email! Just think about this here
email: you might read it written in a font that makes it easy to discern
"1" from "l" from "I". For a vast number of people, this is not even true!

So what we are talking about here are apples and oranges and apple cider
vinegar. Email clients are *so vastly different* from one another, it
would be ludicrious to assume that they have anything in common when it
comes to "mail-based workflows".

As a matter of fact, the thing that you pointed out as the most important
("how easy it is [...] to integrate with other existing tools") does *not*
apply for the *vast* majority of email clients, most prominently Outlook,
GMail, Apple Mail and Thunderbird.

And that mere fact is very, very important to keep in mind. We build Git,
which is very, very successful because it fills a need of developers using
means that are accessible to many, directly or indirectly (the
command-line).

Yet, when it comes to contributing to Git's source code, we deviate from
the common path and require a means that is *not* accessible to many. We
require them to use something different than their regular email client.

> It's the major reason I'm resistant to moving development to GitHub. Not
> only would I have to throw away all of my tools, but I'm not sure I
> could easily build equivalent ones.

I am sympathetic to your reasoning (even if I vividly disagree with your
assessment that it would be difficult to build tools around the GitHub
API, I made quite a couple of such tools myself, and it is quite easy, you
can even script it on the command-line using cURL).

However, I have to point out that the Git project is really uninviting to
contributors, and that this resistance is part of what makes it so.

> Now, I am perfectly open to the idea that more of the tooling should be
> standardized, so people do not have to build their own. But the major
> problem there is that so much of what I've built is about gluing things
> together for the rest of _my_ tools. I've shared my techniques and
> scripts for using mutt several times, but they don't do somebody a lick
> of good if they are using gmail or thunderbird.

It is nice of you to share those tools, of course, and you are correct
that the specificity of your tools limits their being useful. I, for one,
cannot use your mutt-based tools.

(I gladly use git-jump now, though, but it is still very limited by its
being specific to vim. In other words, both your mutt-based scripts and
your git-jump script are limited in their audience just by being so
opinionated. This is distinctly different from Git's being unopinionated.)

> So I don't really think I have a megaton of tooling. I just have a
> little bit of glue to existing tools I was using anyway.

Those existing tools are part of that megaton. For the purpose of my
argument, they contribute as much to the barrier of entry to contribute
easily to Git's source code as anything else in the mail-based workflow.

> And I think that is where the disconnect is. If you are not using mutt
> already, then it sure seems like a big jump to change your MUA. And I'm
> sympathetic to that. But I don't think that means that the mailing-list
> approach is not working for me, as you claim in the last paragraph.

Okay, let's call it the mailing-list-plus-mutt-plus-glue approach, then.

My point stands. We are way more uninviting to contributors than
necessary. And a huge part of the problem is that we require contributors
to send their patches inlined into whitespace-preserving mails.

Personally, I think we can do much better than that.

Ciao,
Dscho
