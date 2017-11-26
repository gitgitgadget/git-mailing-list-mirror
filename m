Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9991920A40
	for <e@80x24.org>; Sun, 26 Nov 2017 21:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdKZVzT (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 16:55:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:63825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbdKZVzS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 16:55:18 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Me86g-1eUg1J1TrS-00Px1N; Sun, 26
 Nov 2017 22:55:03 +0100
Date:   Sun, 26 Nov 2017 22:55:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: git status always modifies index?
In-Reply-To: <20171126192508.GB1501@sigill>
Message-ID: <alpine.DEB.2.21.1.1711262231250.6482@virtualbox>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org> <20171122153028.olssotkcf3dd6ron@LykOS.localdomain> <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org> <20171122161014.djkdygmclk227xmq@LykOS.localdomain> <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com> <20171122211729.GA2854@sigill> <20171122215635.GE11671@aiede.mtv.corp.google.com> <20171122220627.GE2854@sigill> <alpine.DEB.2.21.1.1711252240300.6482@virtualbox> <20171126192508.GB1501@sigill>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ousL5rk0laX5Mh8+Moplbc7V9+0zdDedkQwCq9sq9zcrJiW5ifF
 drwG1Yb1gN+JgO6Mkby0B/oELNCNQBfEcNDIqv2FobwilYL5ApsLIzwIwYNdpb6QaykedE9
 9v5Y5ZA2YXQmeiYXf2veppsURiMlwQUtu17/YL0u1LeGFK7tEI30iyvPSEw6dfnpwM+7n0T
 I8bqi+KWXoLtldN6fcNrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7FEF54fWItM=:Qvs6ESIhonKw2Je2QzUPKG
 YzlgOaOYH8u4eJatiQyLKamQvAlyZIsHY2lYeewohIw1Qg4OxhabJYgYsBpJXkbvTGz573Fyk
 jdYmLzN+yXYqccDzsIq8mosauIiCOoWddxhSbd/Y5X7BM6b8R5PCKN/Sj2EgzJf6yuKGBJIu9
 7nLYsTu/osIwgv9edb0S3D6hVkrg3+989IcxOWd+zFjCHIMZEMcczzMlGIBgZnmcmJFFLoQXG
 UVw/ZebwjF51p9FVRSJ/0ImKjf6Z++no9JHurxWzxwkQjmL0WEAfQOAkVcZYRt5Wjdq5tTIvc
 Mb22DoIu+0zzmzf2pC/IV1fxQyC1gY2RLKQiMJ1ImYSRMsWP2IfeK0ZjkN0GNNWLDFCfiUWO8
 pd5sfhpPF6U/4ZFCYpH60HHNr+jYKib0L223TX/y2+InQ89IlFOE+b2Dq++VFywYl+euXFshz
 rL35XzgqhdzrSAWBz8o5D7HpqWeG/hmr8AEFYYsDQC+Xkhzaft04lyEczr8Z8Uq1i8un8Va3Q
 WGiPYOOFjtZ2rbIind940jTssGPR2BFHFifey/goJ/eUqXcOEetSkXmnM0Aog8fketUStp3Km
 gL2LK5ZR/ja81stgAJ077pdiRf9Yg5n+ndzUuwyUuHqGH+a09V7NnfkIXpTQdtW9BrstCiFjM
 fbkXAd8I1OkU/TPooX4a5lD2q/ENJttI0VDJYeZ1ZiEeE27EcfUuX8xhnCa3tImXkG9isf/Q1
 QIa0AtwnNih1Y+0MAWUy53AZXuGZxeba8iuMtH+7ZOhGjyKFAGqjXRvQ+BgcLPFosu58VXn4c
 7d8s5gke3ggI1b6zM0k007BMgwHYA+UCbJYcAqS8ymRn073xQM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sun, 26 Nov 2017, Jeff King wrote:

> On Sat, Nov 25, 2017 at 10:55:25PM +0100, Johannes Schindelin wrote:
> 
> > > Right, I went a little off track of your original point.
> > > 
> > > What I was trying to get at is that naming it "status --no-lock-index"
> > > would not be the same thing (even though with the current implementation
> > > it would behave the same). IOW, can we improve the documentation of
> > > "status" to point to make it easier to discover this use case.
> > 
> > I had the hunch that renaming the option (and moving it away from `git
> > status`, even if it is currently only affecting `git status` and even if
> > it will most likely be desirable to have the option to really only prevent
> > `git status` from writing .lock files) was an unfortunate decision (and
> > made my life as Git for Windows quite a bit harder than really necessary,
> > it cost me over one workday of a bug hunt, mainly due to a false flag
> > indicating `git rebase` to be the culprit). And I hinted at it, too.
> 
> I remain unconvinced that we have actually uncovered a serious problem.

You did not. A colleague of mine did. And it was a problem in Git for
Windows only, caused by the changes necessitated by yours (which even used
my tests, which made it easy for my conflict resolution to do the wrong
thing by removing my --no-lock-index test in favor of your
--no-optional-locks test, breaking --no-lock-index).

It cost me almost two work days, and a lot of hair. And all I meant by "I
hinted at it, too" was that I felt that something like that was coming
when I saw your variation of my patches making it into git/git's master.

This kind of stuff really throws my upstreaming back quite a bit, not only
due to lost time, but also due to the frustration with the caused
regressions.

Now, the report indicates that not only Git for Windows had a problem, but
that the new feature is unnecessarily unintuitive. I would even claim that
the --no-lock-index option (even if it does not say "--read-only") would
have made for a better user experience because it is at least in the
expected place: the `git status` man page.

> Somebody asked if Git could do a thing, and people pointed him to the
> right option.

If people have to ask on the mailing list even after reading the man
pages, that's a strong indicator that we could do better.

> That option is new in the latest release.

In Git, yes. In Git for Windows, no. And it worked beautifully in Git for
Windows before v2.15.0.

> > I really never understood why --no-optional-locks had to be introduced
> > when it did exactly the same as --no-lock-index, and when the latter has a
> > right to exist in the first place, even in the purely hypothetical case
> > that we teach --no-optional-locks to handle more cases than just `git
> > status`' writing of the index (and in essence, it looks like premature
> > optimization): it is a very concrete use case that a user may want `git
> > status` to refrain from even trying to write any file, as this thread
> > shows very eloquently.
> 
> Besides potentially handling more than just "git status",

... which is a premature optimization...

> it differs in one other way: it can be triggered via and is carried
> through the environment.

... which Git for Windows' --no-lock-index *also* had to do (think
submodules). We simply figured that out only after introducing the option,
therefore it was carried as an add-on commit, and the plan was to squash
it in before upstreaming (obviously!).

So I contest your claim. `--no-lock-index` must be propagated to callees
in the same way as the (still hypothetical) `--no-optional-locks` that
would cover more than just `git status`.

> > Maybe it is time to reintroduce --no-lock-index, and make
> > --no-optional-locks' functionality a true superset of --no-lock-index'.
> 
> I'm not against having a separate option for "never write to the
> repository".

Whoa, slow down. We already introduced the `--no-optional-locks` option
for a completely hypothetical use case covering more than just `git
status`, a use case that may very well never see the light of day. (At
least it was my undederstanding that the conjecture of something like that
maybe being needed by somebody some time in the future was the entire
reason tobutcher the --no-lock-index approach into a very different
looking --no-optional-locks that is much harder to find in the
documentation.)

Let's not introduce yet another option for a completely hypothetical use
case that may be even more theoretical.

> I think it's potentially different than "don't lock", as I
> mentioned earlier.

I don't see the need at all at the moemnt.

> Frankly I don't see much value in "--no-lock-index" if we already have
> "--no-optional-locks".

Funny. I did not (and still do not) see the need for renaming `git status
--no-lock-index` to `git --no-optional-locks status` (i.e. cluttering the
global option space for something that really only `git status` needs).

> But I figured you would carry "status --no-lock-index" forever in Git
> for Windows anyway (after all, if you remove it now, you're breaking
> compatibility for existing users).

I will not carry it forever. Most definitely not. It was marked as
experimental for a reason: I suspected that major changes would be
required to get it accepted into git.git (even if I disagree from a purely
practicial point of view that those changes are required, but that's what
you have to accept when working in Open Source, that you sometimes have to
change something solely to please the person who can reject your patches).

Sure, I am breaking compatibility for existing users, but that is more the
fault of --no-optional-locks being introduced than anything else.

I am pretty much done talking about this subject at this point. I only
started talking about it because I wanted you to understand that I will
insist on my hunches more forcefully in the future, and I hope you will
see why I do that. But then, you may not even see the problems caused by
the renaming (and forced broader scope for currently no good reason) of
--no-lock-index, so maybe you disagree that acting on my hunch would have
prevented those problems.

Ciao,
Dscho
