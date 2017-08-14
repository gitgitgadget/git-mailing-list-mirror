Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200D220899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbdHNVuS (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:50:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:56050 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbdHNVuR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:50:17 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh5h7-1dutmt0yYb-00MIKx; Mon, 14
 Aug 2017 23:50:10 +0200
Date:   Mon, 14 Aug 2017 23:50:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] dropping support for older curl
In-Reply-To: <CAHVLzcnnrABmkYNg31Aq99NgBbyuCKEM60pHGygyjXbjmaUEYQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1708142302180.19382@virtualbox>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net> <alpine.DEB.2.21.1.1708092337350.11175@virtualbox> <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net> <alpine.DEB.2.21.1.1708101111080.11175@virtualbox>
 <CAHVLzcnnrABmkYNg31Aq99NgBbyuCKEM60pHGygyjXbjmaUEYQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:S05jasgXoT4RhRUnHziySs+xEsCw4Lk7p1C1h0MTFyqIMEhCSr8
 HmusFGMcuqKxXAFi+ymtyng5fyz+v1jEU5WiduM6rar4dXT/YHBbEMLmAMTbdX1RjAOf8PR
 a6dTpHbfS4Qj82SOQoJCwYQ0NBzHBvlaQTSpwBiVKGNfAwKvOhTfiihTo/sVLC3hyqSokuA
 eiz5fSHmi5auML030XP6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ef6HuA3g9Kw=:L6VvvAbaDIou2rDvK7wS9g
 RMnuq9X8OlbFn02wap6X0ON6oR7uGOi28m4AY/pQQFTEjZBtzgwfO8hwSOjXHyhHQ5xieG+2E
 5L+I1ApA1XHH3SkVnAmFPGbBTK09iCuGNUxdCWam7ih/jNtPndiMM5lnavgHb8IlaAZczqR6q
 bx6amlwJ17rZ8H+hZOeklFhHNpdrVMfGOlIPNnXrnuyUWHchF2vdly+XattgjwQzbjcCkru+C
 loyJDtG4SI7APkqpglVxjwLQw8zgdA6jp4dP/Rk/sGJ4BxkrwFXFHRQBSIcUdkfwuxiG3IcVL
 hWXmHPgQpMwN6+tOnJTKAiu64DVrXu32Vae31zcJSPdV8pFjHDvOOxh5lr7yYt01QL55RH8ef
 yk6qxajqK8SVOsIcPaWeudWU3BurLYPjKyLyDgbwkEkNMeUhcUx7Y0rK63EY9D6anBoH/1BcR
 A1mGTzBzdN8atjmY4UXk5maZKSKme37MkU3nw62uOOh4W8T6TTZs2umFZNPGYNrSWn1dVfjtq
 Hp0I8yjzQNBQtg/0vX55BX4Ndo3Fr8x5WBlXFFEOXMY0hyttZe3xCQQ6QPtcc3NKJYf93YCJP
 VBIeXXyz0uM2bNxB45FknE1QSHNRK2RfnE8/TICgWKhy8/W47Tc7nqgReeWOdVLP0neN6Pvot
 DyeX40zCO2ts5era06yT9+Y1mR9CT1BLRSRJeLoJJU/epZNHPbZS3rXzkgIz2Oq4Y1L1dZQDa
 hqkcLkEWJWHdo7ot6nCz6TC1qnYi1ADU7CQ0tWXjmCzMYLfLKR7cOnOIfJiCygB5gVCRK5P0R
 7PaVyByvXD1UQSs3x+OziuWCPWp1p0NyaDr/ZTXKScbllkRlVA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paolo,

On Thu, 10 Aug 2017, Paolo Ciarrocchi wrote:

> Il 10 ago 2017 11:39 AM, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> ha scritto:
> 
> 
> 
> Footnote *1*: It is no secret that I find our patch submission less than
> inviting. Granted, *I* use it. *I* did not have problems entering the
> mailing list. But then, my mails were not swallowed silently, because my
> mail program does not send HTML by default. And prepared by the German
> school system (I learned the term "sugar coating" only when exposed to
> some US culture), I had little emotional problems with being criticized
> and not thanked for my contribution, I persisted nevertheless. The opinion
> that the Git contribution process is a lot less inviting than it could be
> is not only my view, by the way. I hear this a lot. I give you that we are
> not quite as textbook "keep out from here unless you look like us, smell
> like us, talk like us, have the same genital setup like us" as the Linux
> kernel mailing list, but we are in a different universe compared to, say,
> the Drupal community. And their universe is a lot nicer to live in.
> 
> 
> Isn't SumbitGit a possible answer to your doubts (I strongly agree with
> you) about the current development process?

No. I hate to say that SubmitGit neither integrates well with GitHub Pull
Requests (code comments on GitHub are approximately 1,523x easier to
write, read, associate with the actual code, and see the current state of,
compared to the mailing list, and SubmitGit does not even hint at
integrating with that user experience).

Also, the barrier to start using SubmitGit is rather high. If you open a
Pull Request on github.com/git/git, you get *no* indication that SubmitGit
is an option to *actually* get the code into Git. There are also concerns
about required permissions that Junio Hamano himself would not accept.

Now, let's assume that you submitted the code via SubmitGit. The
challenges of the patch submission process do not end there, yet SubmitGit
goes home and has a beer. But the hard part, the discussions on the
mailing list, the status updates in the completely separate What's cooking
mails, the missing links back to the original source code (let alone the
information in which worktree on your computer under which branch name
that topic was developed again?), the diverging mail threads, the
"rerolls" that should not forget to Cc: all reviewers of previous rounds,
all that jazz is still all very, very manual.

And even if there was an easier path from having a local branch that works
to finally getting it onto the list in the required form, your mail is an
eloquent example of one of the most preposterous hurdles along the way: we
pride ourselves with the openness we demonstrate by communicating via a
mailing list, everybody has a mail address, amirite? But of course, HTML
mails, like, about 130% of all mails on the internet (or so it feels),
including yours, are dropped. Silently. Not so open anymore, are we.

It is all so frustrating, really. I work in a team (Visual Studio Team
Services, you can think of it as kind of a Microsoft take on Git hosting
plus a lot of other tooling) where we get really, really positive feedback
regarding our user experience, in particular the frequent enhancements to
PRs. It is really powerful to open, review and merge PRs, interact with
other developers, see the state of PRs and their respective discussions,
open and resolve issues, automate workflows and build tasks [*1*]. And
then I try to convince people here on this mailing list that it really
makes a difference if you start using tools to lighten the load of
everybody, and... little changes.

At least thanks to Lars Schneider's incredible efforts we have Continuous
Testing (I know how much time he spent on this, it is another thing
deserving the label "preposterous", and I know how much time I spent on
top to add the Windows part which mostly works). If only we could push it
further to true Continuous Integration. Or at least to accepting PRs from
professionals who simply have no time to fight with our patch contribution
process and whose expertise we lose as a consequence.

Ciao,
Johannes

Footnote *1*: The funniest part about this is that I do get mails about
all of this all the time. When I am pulled in as a reviewer. When a build
failed. When a previously failing task was fixed by a new build. When
somebody responded to my comments. The difference to the mailing
list-centric approach is of course that those mails are only
notifications, and link back to the tool appropriately supporting what
I, the user, want to get done.
