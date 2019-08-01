Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1DD81F731
	for <e@80x24.org>; Thu,  1 Aug 2019 01:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfHABi0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 21:38:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34306 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHABi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 21:38:26 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so140762547iot.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 18:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJitGIui0LoxyodciSeY3QL4iIbV7Ht1Z4T+MDbQzjo=;
        b=Yeu/7HLCJHorIE3ooDLHHrVdCbph5DUSrrYgefW6oh5tZSL7Ffuv8XzyjcxjcrZanP
         dWe8UfjQH/Ao/ncQr7fFg84wm4PBqS34b1nJS3Fqfq8t3ubr4aE78BbANTf2kXJB9Jov
         ipyxzMA9UCr605KkeqUESttnTHsdQLObHspGacOsHeUgeUzekt+jtCn7fnuIlf49tSeZ
         x9mmia4ZKqqZ4lnNkZlF8TcxsBUjQG6d5RLUxBRvxl+nrvw2o7lYKrksw0r0H2pe5No9
         +YrfAIlDz+4Y5ykjCwnQUM9+LMaOjMe0jpD/D2NXjxBd5cpcrSVO+Zl8fPGWIGryrk/c
         jZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJitGIui0LoxyodciSeY3QL4iIbV7Ht1Z4T+MDbQzjo=;
        b=As3wck736ubR1lqO8grHmpISlZKW76GNJ4SkDpN+ZTmb91l6pXwJQzu9GwK3JUB1b/
         Co12AZrKbqzy/inV5HNFqml59f1RLr6YrqL7I/EYZVn1wa37q+LI1pUl7anlwJF6J1eN
         sAzFsL28jSVodK4gkOUmpNrVMeHRR0KuUwi62xyvNpK2yLeuOO8e0ICJahTHY5w8/yi8
         Laeeh/y8UF8OTXzGdYAAwXpL95D4no1mUwsbi/1iVamm495+s4yOLpvKB0/p6YXJ5Lrf
         UVGcBrtJh0Iu0S9czatbixsC/xkRhD12sUOsqQiy0PasjUzLgQAXcX6E1nLAKD9uMEBe
         bpTw==
X-Gm-Message-State: APjAAAVw1nQIOsOlP2CZVzGOueKIoe6BjnE/9c2uHl6R89BUzdrSmzmd
        wL0q74+8l/0HKTCGqud6E7rQ+XiPFvPV/+ALeRI=
X-Google-Smtp-Source: APXvYqxOpQTD2sKetbg93qepyHaHqB2zFEn0RaabnYw7AqN8zokjZqU3aCjUI+Op/VVgUbJskAjBygZ+SUj0peF+OXU=
X-Received: by 2002:a5e:c247:: with SMTP id w7mr47277292iop.72.1564623505333;
 Wed, 31 Jul 2019 18:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net> <20190801002125.GA176307@google.com>
 <20190801010022.GA6553@sigill.intra.peff.net>
In-Reply-To: <20190801010022.GA6553@sigill.intra.peff.net>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Wed, 31 Jul 2019 20:38:14 -0500
Message-ID: <CAAOiGNwDV3LNGRVPQN6DgES6raG76u-rW0nBuw=i2oHTibVSPg@mail.gmail.com>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Wed, Jul 31, 2019 at 8:00 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 31, 2019 at 05:21:25PM -0700, Jonathan Nieder wrote:
>
> > Although as Dscho mentions, it's particularly irritating because it is
> > not part of the paginated output.
> >
> > I wonder if the ideal might not be to trigger it more selectively, when
> > the output actually changed due to a reflog entry.  I mean something
> > like
> >
> >       commit 393a9dd0f9762c69f753a8fa0bc89c203c6b4e9e (HEAD, origin/foo, other/pu)
> >       Merge: 18598e40e6 1eba6eb1c2
> >       Author: A U Thor <author@example.com> (see "git help mailmap")
> >       Date:   Tue Jul 30 15:05:41 2019 -0700
> >
> >           Merge branch 'jt/fetch-cdn-offload' into foo
>
> I actually kind of like that, because it tells you exactly when it is
> impacting things (not just that the mailmap was used, but that this
> _particular_ name was mapped, which is going to be the most actionable
> thing). But I do think the syntax above might end up breaking somebody
> who's trying to parse it (people aren't supposed to be parsing log
> output, but...).
>
> Something like:
>
>   Author: A U Thor <author@example.com>
>   Original-Author: I M Mailmapped <orig@example.com>
>
> gives even more information while leaving the "Author:" line untouched.
> But in introducing a new line, it may also be breaking somebody.

It also makes this entire exercise completely moot because not only
does it deadname the contributor, it discloses that it is deadnaming
the contributor while also telling you who they are now, which is even
worse than the current behaviour.  The purpose of this exercise is to
ensure that users have the *current* contact information of the
contributor by default, including their current name and e-mail.  My
entire goal behind transitioning this config default is to ensure that
git respects *present* identity information by default, while giving
access to the raw identity data in cases where it makes sense to do so
(such as historical research or whatever).  I don't really wish for
git to remind me of my previous identity while browsing through
historical git logs.  I also don't think most people care about the
previous identity data of contributors -- in most cases, if you're
looking up a commit's author, you're doing so because you intend to
ask them a question about the commit, and so, having the most current
identity data available is what actually makes sense.

> I think all of these are riskier than just quietly engaging the mailmap.
> That's syntactically identical, so no risk of parsing regressions That's
> almost always going to be what people _actually_ want if there's a
> mailmap in the repo. The only exception is if they're somehow trying to
> do analysis on original versus mapped names. At which point they really
> ought to be using a parseable format like --pretty=raw, or "%an <%ae>".

Precisely, which is why I think we should just flip the default.
However, as previously mentioned, it was requested to do a formal
transition for the config setting, just to be absolutely sure that
people are aware the default was going to flip.

> > is *particularly* unactionable in the current state where we're not
> > rewriting authors.  I think we should bite the bullet and just flip
> > the default to "true", with the config as an escape hatch to allow
> > going back to the old behavior.
> >
> > Is it too late in the release cycle to do that?  If not, we can do
>
> IMHO no, it is not too late. This is a new feature in this release, and
> we're at -rc0. The point of the rc period is to find problems in the new
> code. So certainly I think it is not too late to change our minds about
> this feature. I could see an argument that instead of changing it now,
> we should revert for v2.23 and work on it with less urgency during the
> next cycle. But personally I'd see what a day or two of discussion turns
> up; if everybody agrees on the path forward and the implementation isn't
> complicated, it may be easiest to just proceed now.

Honestly, the current default is arguably an unintentional bug.  As
you note, it's a default that makes no sense and flipping it will give
people what they *actually* want.  Accordingly, I have thought, and
still think, that we're best off just flipping the default and saying
we fixed a bug, because the current behaviour is certainly perceived
by many people as being a bug -- in fact, when I first looked into
this, I thought it *was* a bug, only to find out that the default was
the way it was.  I'm certainly not alone in perceiving the current
behaviour as a bug, especially since `git shortlog` respects mailmap
by default and `git log` doesn't.

>
> > -- >8 --
> > Subject: log: use mailmap by default in interactive use
>
> This seems OK to me, though I kind of wonder if anybody really wants
> "auto". Unlike log.decorate, which changes the syntax, there is no real
> reason to avoid mailmap when somebody else is parsing the output. And I
> could imagine it is especially confusing if:
>
>   git log --author=whoever
>
> and
>
>   git log | grep whoever | wc -l
>
> do not agree.
>
> -Peff
