Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49BEE1F42D
	for <e@80x24.org>; Mon, 21 May 2018 10:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeEUKeP (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 06:34:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:37903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752621AbeEUKeM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 06:34:12 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LxPNC-1gQHUt3oU6-016zZO; Mon, 21
 May 2018 12:33:58 +0200
Date:   Mon, 21 May 2018 12:33:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <3cefc6b3-3dbd-9cb1-20d0-193116191726@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805211153370.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet> <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet> <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com> <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet>
 <20180507074843.GC31170@sigill.intra.peff.net> <3cefc6b3-3dbd-9cb1-20d0-193116191726@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4d0Hpc8EgvoFtXtJOwQzKFrYgP5LAfKIgbu4S4oCZZ64qDAeLI+
 IfkoS69/iUtWBAcWsq/aIzL4UFnlg8Q40Cglz1GzPcE5NtwblofjXQkzKH60EthfmYU+r5/
 9S1OSotBnG8xeyp2anmY1C/O1/FZArYXMCcWWHGxeE8osDrNsf0SDSTGw4FfeHxCtY2uKfb
 OUu3moXiALjz++mZ3fjFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ep+9RQNZN8Y=:9mWoa2pZDkAzwzpAAoFt8C
 wn7VFJCNirlaFMz0j6yeuWVZPKKxkyZv69PfMYq189K7KTIWYHCxfA4ocFmp/v7LHRgLB362N
 cud5EfIkoIqa2FSRv0TX3KED72J620AWe8h5g6rXebV70q6B4jKZ+kjmWRk/tywLMICiwBtcE
 GX3z9J3dGmKLIimWJbGowg8Ot6jlQ16aoUtSS/0pE3AqOrbmtTM9cGtFrfCVrSifxX9C14Wok
 Fln3HqGNhT0Fyg84kr0dhBUs5L2nq/dL1eKF9rEwyzkclrjrY35VturxpwhbVBHDdXaOla5Ax
 X82pJcuL0TEf5BQQlEIkSHDF26qSQnqfeUUjiwwRn6y8Cm/6f4uqE6MVq8QaEP51PP0XJGNqU
 pBShsjQv2W2/elgypwYPJyP2jywz3zWDsnRgbcu5r8CdL8Owha25RBHb6Bradlrx0k/k7J72S
 BCQztAi5q8Au4GG9SlJXAsh9+ukwDngwgsERcoigWDnaKbEj+d4AePXi3gPpIlM0VTlKDup4n
 +W5oksGZtsmHMAocm8dW9te7eCoidtj2M3NPTgGZKMiQZJ407tPYbPD+RrV1gji2jq+mmh/AO
 u23gEZHw4OZ9u3rT9BmI7xPOEZSE3Fo/L7uUNNY+uBWyz51Xb46+QOUilstYgo1JQeCUU+UiQ
 ZdSnK3DSIe542lmIZU2e0B8lHaoYVc0oxXJGljyUAYw3wRlcZ7mmRjp3iIpLl1ay88HEszdO1
 OP5MxlZTlpY0V7G/pzZUcTt7zohMQi0rj6GeeIBiuE7gEsww5p9fNJlHBu/dISFUQv/l8LP7m
 NRtiojh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Mon, 7 May 2018, Igor Djordjevic wrote:

> On 07/05/2018 09:48, Jeff King wrote:
> > 
> > > > Let's, please, not fall into the trap of polluting git-branch with
> > > > utterly unrelated functionality, as has happened a few times with
> > > > other Git commands. Let's especially not do so merely for the sake of
> > > > tab-completion. git-branch is for branch management; it's not for
> > > > diff'ing.
> > >
> > > I totally disagree. `git branch` is *the* command to work with branches.
> > > Yes, you can manage branches. But you can also list them. And now you can
> > > also compare them.
> > 
> > One of the things I don't like about "git branch --diff" is that this
> > feature is not _just_ about branches at all. E.g., I could do:
> > 
> >   git tbdiff HEAD~10 HEAD~5 foo
> > 
> > Or even:
> > 
> >   git tbdiff v2.16.0 v2.17.0 my-rewritten-v2.17.0
> > 
> > Those arguments really are just commitishes, not necessarily branches.
> > One of the current interface rules for "git branch" is that the branch
> > names we hand it are interpreted _exactly_ as branch names. You cannot
> > "git branch -m v2.16.0", and there is no ambiguity in "git branch -d
> > foo" if "foo" is both a tag and a branch.
> > 
> > But this new mode does not fit the pattern at all.
> > 
> > If we were to attach this to an existing command, I think it has more to
> > do with "diff" than "branch". But I'm not sure we want to overload
> > "diff" either (which has traditionally been about two endpoints, and
> > does not really traverse at all, though arguably "foo...bar" is a bit of
> > a cheat :) ).
> > 
> > > > Of the suggestions thus far, Junio's git-topic-diff seems the least
> > > > worse, and doesn't suffer from tab-completion problems.
> > >
> > > Except that this is too limited a view.
> > 
> > Right, I agree with you. Topic branches are the intended use, but that's
> > not what it _does_, and obviously it can be applied in other cases. So
> > since "branch" is too specific, I think "topic branch" is even more so.
> > 
> > It's really "diff-history" or something, I think. That's not very
> > catchy, but I think the best name would imply that it was diffing a set
> > of commits (so even "diff-commit" would not be right, because that again
> > sounds like endpoints).
> 
> This is exactly what I feel as well, thanks for concise and 
> to-the-point spelling out.
> 
> From user interface perspective, I would expect something like this 
> to be possible (and natural):
> 
> (1) git diff topic-v1...topic-v2

No, we cannot. The `git diff topic-v1...topic-v2` invocation has worked
for a looooong time, and does something very different.

We should not even allow ourselves to think of such a breakage.

> (2) git diff --branch topic-v1...topic-v2

From my point of view, `git diff --branch` indicates that I diff
*branches*. Which is not really something that makes sense, and definitely
not what this command is about.

We are not comparing branches.

We are comparing versions of the same branch.

> (1) is what we are all familiar with, providing a diff between two 
> revisions with focus on file changes, where (2) shifts focus to 
> history changes.
> 
> It`s all still a comparison between two revisions (pointed to by 
> "topic-v1" and "topic-v2" branch heads in this specific example), but 
> it differs in what we are comparing - (1) set of files contained in 
> endpoints, or (2) set of revisions contained in (or "leading to") 
> endpoints.

It is very much not about comparing *two* revisions. It is very much about
comparing two *ranges of* revisions, and not just any ranges, no. Those
ranges need to be so related as to contain mostly identical changes.
Otherwise, `git branch --diff` will spend a ton of time, just to come back
with a series of `-` lines followed by a series of `+` lines
(figuratively, not literally). Which would be stupid, to spend that much
time on something that `git rev-list --left-right topic1...topic2` would
have computed a lot faster.

> Hmm... what about `git diff --history`? :/ It does seem more "true" 
> to what it does, though I still like `git diff --branch` more 
> (catchier, indeed).

It certainly is catchier. But also a ton more puzzling.

I do not want to compare histories, after all. That would be like saying:
okay, topic1 and topic2 ended up at the same stage, but *how* did they
get there?

What I *want* to ask via the command implemented by this patch series is
the question: there was a set of patches previously, and now I have a set
of revised patches, what changed?

Most fellow German software engineers (who seem to have a knack for
idiotically long variable/function names) would now probably suggest:

	git compare-patch-series-with-revised-patch-series

I hope you agree that that is better *and* worse than your suggestions,
depending from what angle you look at it: it is better because it
describes what the command is *actually* doing. But it is much worse at
the same time because it is too long.

Ciao,
Dscho
