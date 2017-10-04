Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67672036C
	for <e@80x24.org>; Wed,  4 Oct 2017 21:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdJDVRl (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 17:17:41 -0400
Received: from mout.web.de ([212.227.15.3]:56843 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbdJDVRk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 17:17:40 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6V2p-1d7CrM02WJ-00yMlB; Wed, 04
 Oct 2017 23:17:35 +0200
Date:   Wed, 4 Oct 2017 23:17:34 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
Message-ID: <20171004211734.GA25379@tor.lan>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
 <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
 <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
 <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:NkUS65xuNNW42sFX4EUUUWYgGy6dR3qV22twgqGO/r+tXNHq0Kg
 fV66LOu545Fpvmtpm8E5XVgHDvNiqR3SXM+YazYJ7zj6TQoRsrXE1qi+it1gs+Ii1tssVpY
 0SQOaRsRCyEBjZ4sgi5oIhT+GXrJIctn1Z8+i1pEBNuklR1/1wS/JI53F9y/0XbgR90yd2R
 YUhm6Ck4HPDw6y6Z4ZlGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sUpn2I8PQoY=:w96SFUc27TQEC9IP8K0CdD
 GFN9tnfr75j9x+f5NsPAvgSs/FcI2ONuz9nBsv6CVFWrvBoenebv07XMYOVfJAvKtHT7/dFW4
 Mjcg+59i1jWitie2mJm747rPMsdMiujndgJwHb6hYJ/LlbffqLhWgsPq0zTcLxoIiXUDpdwUG
 vNTXigj/WGjNNsiWLe7G8UW4yOaEg2uP7MvsNkfRXs81hZYHluLn62mUV3VAySlb2AIc064iB
 KcUlVztw5TCTdxBMfBjN6XT0IMWyusaYKKEADn2sWoMCrgkEIUGjqXa4dMB6/ZnSsVTuxhl/O
 R97xqkon3seKNRKQGxC8porqwnR90IICDvtAskX+yJJDT0Xg47MjHyKCzJR9YnKmodGFwiX+x
 7Irv7qfJ8SGXFxGTsgzOBTj3cVJVE0r8GosmCF3fKtBhecyYkbBoxUc8bcMoSDVM0KGqemkr1
 HkGJoligD7EIwB9yR4wsxrR/MYUWY+bTOrLksyTxJzC1WCYNQ6a/d9H8MOoWM+M1D26ZjVwKR
 /Lkry0omm0+WvrB84cPJKqMzke6Cn70da3EATiwwWowyUSktgFqv2Z803dMzoWliVXe7/trfN
 mSuKJXjoQXyY0gdbpu2v5iGgqiw0guHVt1qKHMOsiOS4EpWaoLp/yTgOZDji4HV2rqpxzfZI7
 vicipDlqMLC0f1SW43qA5n1tEe9SwphNbi18xg5TqOye6crSd1UHADpBzKU3hwp9mYbNVpMZI
 ifCiTvw46kY6OosWBfHIvxOaR6q1uha9VfwBiYkbM5z3AlmzhhKZzOW8e8D1fJvNnA7ka34Jt
 Jlxk5998ZJVR0AzkFr1RTbToqgmtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 11:26:55AM -0500, Robert Dailey wrote:
> On Tue, Oct 3, 2017 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Torsten Bögershausen <tboegi@web.de> writes:
> >
> >>> $ git rm -r --cached . && git add .
> >>
> >> (Both should work)
> >>
> >> To be honest, from the documentation, I can't figure out the difference between
> >> $ git read-tree --empty
> >> and
> >> $ git rm -r --cached .
> >>
> >> Does anybody remember the discussion, why we ended up with read-tree ?
> >
> > We used to use neither, and considered it fine to "rm .git/index" if
> > you wanted to empty the on-disk index file in the old world.  In the
> > modern world, folks want you to avoid touching filesystem directly
> > and instead want you to use Git tools, and the above are two obvious
> > ways to do so.
> >
> > "git read-tree" (without any parameter, i.e. "read these 0 trees and
> > populate the index with it") and its modern and preferred synonym
> > "git read-tree --empty" (i.e. "I am giving 0 trees and I know the
> > sole effect of this command is to empty the index.") are more direct
> > ways to express "I want the index emptied" between the two.
> >
> > The other one, "git rm -r --cached .", in the end gives you the same
> > state because it tells Git to "iterate over all the entries in the
> > index, find the ones that match pathspec '.', and remove them from
> > the index.".  It is not wrong per-se, but conceptually it is a bit
> > roundabout way to say that "I want the index emptied", I would
> > think.
> >
> > I wouldn't be surprised if the "rm -r --cached ." were a lot slower,
> > due to the overhead of having to do the pathspec filtering that ends
> > up to be a no-op, but there shouldn't be a difference in the end
> > result.
> 
> You guys are obviously worlds ahead of me on the internals of things,
> but from my perspective I like to avoid the "plumbing" commands as
> much as I can. Even if I used them, if I have to tell the rest of my
> team "this is the way to do it", they're going to give me dirty looks
> if I ask them to run things like this that make no sense to them.
> That's the argument I have to deal with when it comes to Git's
> usability within the team I manage. So based on this, I'd favor the
> `git rm -r --cached` approach because this is the more common result
> you see in Google, and also makes a little more sense from a high
> level of thought perspective. However, this is just my personal
> opinion. `read-tree --empty` is far less self explanatory IMHO.
> 
> Also let's not forget the second part of the command chain that
> results in the different behavior. In one case, I use `git add` which
> results in proper line ending normalization. In the other case, I do
> `git reset --hard` which does *NOT* result in the line endings
> normalized (`git status` shows no results). In both cases, I'm still
> doing `git rm -r --cached`, so I am doubtful that is the root cause
> for the line ending normalization piece. I'm still trying to
> understand why both give different results (root cause) and also get
> an understanding of what the correct (modern) solution is for line
> ending normalization (not necessarily which is the right way to
> clear/delete the index, which is really AFAIK just a means to this end
> and an implementation detail of sorts for this specific task).

Hopefully I am able to give a useful answer.

"git reset --hard" works like a hammer
and may destroy work that has been done,
in our case the cleaning of the index,
which is needed for normalization since Git 2.10 (or so)

Back to the question:
One solution, which you can tell your team, is this one:
$ git rm -r --cached . && git add .

And as Junio pointed out, this may be slower than needed.
And we don't want "slow" solutions in the official documentation ;-)

Whatever you find on search engines may get stale after a while,
so that we appreciate direct questions here.

(And I will open an issue on Github the next days)

The background is that the CRLF handling in Git changed over the years,
and one effect is that "git reset" is not "allowed" any more.

For the interested reader:
https://github.com/git-for-windows/git/issues/954

