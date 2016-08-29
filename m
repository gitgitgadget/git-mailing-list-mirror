Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE042018E
	for <e@80x24.org>; Mon, 29 Aug 2016 10:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757148AbcH2Krl (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 06:47:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:50459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756663AbcH2KrA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 06:47:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MH07e-1bs5TL1hli-00Dskk; Mon, 29 Aug 2016 12:46:53
 +0200
Date:   Mon, 29 Aug 2016 12:46:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <60e7feda-5376-e1f2-1797-9e6dedf3c0b0@gmail.com>
Message-ID: <alpine.DEB.2.20.1608291118500.129229@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160818204902.GA1670@starla> <alpine.DEB.2.20.1608191720040.4924@virtualbox> <20160819223547.GB16646@dcvr>
 <alpine.DEB.2.20.1608221509010.4924@virtualbox> <02c1c636-b0b4-8730-68a6-18f017ed3410@gmail.com> <alpine.DEB.2.20.1608251508280.4924@virtualbox> <60e7feda-5376-e1f2-1797-9e6dedf3c0b0@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1051190496-1472467613=:129229"
X-Provags-ID: V03:K0:pM3Sj2F1CpeoKiH8qw200An8flutt9GZXwqrzQ/f7scDd6camfC
 mLnCjLZ/RgoZcTh5xzHuLvGHhEn/850ptlVAC/bp6zjjvOCdgnimq26Y0kF3Ee3y5j4vvWF
 j2Z6ddMcQ42zo9mvblA0l2whzNwsL9EC6jDllt9zRauMUCyAcAJ0N5NiBqB1UvRxCyl9R/j
 yxnf1GitI9DTauYpIjYug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mnRFXbo7GnU=:VvFvsjXs+2h+zotZrBC/Uu
 tG4cusM6dGCMA71vNOYfz1SKj9SrdlCXz2tGoi7iyNdYXgdEU5RE7nnRECFCYyysmnKQoc4FL
 Kd78nlpzlZ6rXdH4qB/fix5rnHRAjAtIm/sCfcKGyrDhyp62y7AKs2csVrVM/GDiCOxZp/fng
 miDcmvKx+iLOVmWyGtQE13T+wsx7fQ4l7seqXSjDQoDqRPAXBZvJiHZXY3JEyaZ9PUY0fo66d
 qyAyO/5l5/x/CdEMMcv9S8/do8c5ux3IeGhSM6zD54Wz7sCSIm73FuVlAf0iLqvuI63Q0vsEV
 WrdnWsIfhb/c8x20KzeJw4scEZ/3XhuYzzW8qx17vjUcN+2tqQAFW2fjT4txLa/qJ2g8k/hf/
 g4sAiQVJ0Rykt3y3HhYlpCnZk7sB8rnyOVgaR44L5eQbngDZLgMyG8iRafD9wHZG3zZIA3e0x
 gcwptLjBDpJlAH3P0uxe5kYKZBT+BoSrrByP/HLR/YLSDGzjbh/PGM56jlGuTvwmXir5hI/nG
 kAi5kkXvCJnNMvd0Jhfd5+SxtqDOHu6DJcPKMIv/gAF9XTa/9WjLffZyrSgp41FlRrEOqD3W2
 LSYa06KG+pgEWm9xTlB/bgqfofXOiK75zxkaAe6TXjyx+KOzeBNF3aGwJQhkeEmdlR4bdMODX
 33taJNkI0fccZxN/c65HxzhM0QLEtzG/bm6nBxUAzSQw16gfZQ7wNgZfeDZC4ItoScEw6LIUb
 /znFoxBAIcbUEaIW2y26MLaI798IOhMS9pyIFSFJGB4khaG2iyFywewryrwwpDdqdtteyILUb
 DoE6E2E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1051190496-1472467613=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Sun, 28 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 25.08.2016 o 15:21, Johannes Schindelin pisze:
> > On Mon, 22 Aug 2016, Jakub Nar=C4=99bski wrote:
> >> W dniu 22.08.2016 o 15:18, Johannes Schindelin pisze:
> >>
> >>> So unfortunately this thread has devolved. Which is sad. Because all
> >>> I wanted is to have a change in Git's submission process that would
> >>> not exclude *so many* developers. That is really all I care about.
> >>> Not about tools. Not about open vs proprietary, or standards.
> >>>
> >>> I just want developers who are already familiar with Git, and come
> >>> up with an improvement to Git itself, to be able to contribute it
> >>> without having to pull out their hair in despair.
> >>
> >> What is lacking in using submitGit tool for those that have problems
> >> with sending patches via email?
> >=20
> > Where do I start? And where do I stop? Here is a *very* brief list of
> > issues from the top of my head (and the history of my web browser):
>=20
> Let me reorder those issues and group them into specific categories.

I am afraid that this is not the direction I was interested in.

You asked how submitGit fell short of my goal to provide a more convenient
and more efficient submission process, and I listed a couple of reasons.

I am really more interested in a better process, than in a point-by-point
discussion of the reasons I listed.

And some of those discussions really only distract. This comment, for
example, seems to be designed to veer off in a direction that, quite
frankly, does not matter for what I *really* wanted to discuss:

> > - submitGit requires you to go to a separate website to interact with t=
he
> >   submitGit web app. Would be so much nicer if it were a bot operating =
on
> >   PRs.
>=20
> [...]
>=20
> Also, for some people registering on GitHub is "yet another service"... ;=
-)

I am really curious how this is supposed to keep the discussion rational.

*Of course* I implied that it is bad enough to require contributors to
register with one web service, and that requiring to register with *yet
another service* is just excessive.

Sheesh.

> > - You cannot Cc: people explicitly:
> >   https://github.com/rtyley/submitgit/issues/31
> >=20
> > - submitGit does not include any interdiff
>=20
> These are, I think, mainly related to lack of support for series *iterati=
on*,
> for sending new version of patch series / of pull request.

Yes, of course. Because that is what makes the process so particularly
tedious, thankyouverymuch.

> I don't know how well GitHub pull requests deal with iteration and
> refinement, and what is available as API to apps such as submitGit.

Hmm. Then it may be a good idea if I let you find out before we continue
to discuss these bullet points that I never wanted to discuss.

> > - submitGit would require a substantial effort from me to learn how to
> >   extend/fix it, to run the web app locally and run its tests. That is =
a
> >   rather steep hurdle.
>=20
> Well, you cannot extend/fix GitHub at all yourself, isn't it? ;-P

Sure you can. There is an API and you can register hooks. You can do even
more advanced stuff [*1*].

> >> Submitting changes in Git comes in three phases:
> >>  - submit email with patches
> >>  - review and discuss patch
> >>  - apply patches from email
> >=20
> > You forgot a really crucial step. Maybe you did not go through dozens o=
f
> > iterations in your patch series as I regularly do, or something, so it =
is
> > probably easy for you to forget:
> >=20
> >   - find the commit in question, run rebase -i and patch it as suggeste=
d
> >=20
> > This is something that costs me quite some time to do. It is easily the
> > most annoying aspect of the mail list-based approach for me.
>=20
> I probably don't have as many topics in flight, and maybe the number of
> iterations is smaller, but I don't remember having troubles with that.

Well, aren't you lucky.

I bet you did not intend to sound condescending there, even.

> > It is only projects such as Linux, Cygwin and Git itself who refuse to
> > allow for tools that would let the majority of potential contributors
> > stick with their favorite way to read and write mails (I am talking
> > about users of GMail and Outlook, of course).
>=20
> Those are projects that started before GitHub (for obvious reasons), and
> which created a good enough workflow based on email.  It might be that
> they are ossified relics, or it might be that they don't want to trade
> advantages of email based workflow for advantages of web app based
> workflow.

Those are projects that started before Git was invented. Yet all three
projects traded the advantages of patches and tarballs for advantages of
using Git.

> First, email clients and Usenet news readers support threading.  I
> haven't found a good web app that supports threading well (though it
> might be a matter of small set of such apps examined by me).  They allow
> marking and labeling posts to return back later.
>=20
> Second, email allows offline work, and handle well sporadic Internet
> connection.  As far as I know web apps do not handle breaks in net
> access well, but I might be mistaken.  Hopefully this problem would
> vanish with improving broadband... though there always would be places
> without constant always-on Internet connection.
>=20
> Third, email (or rather conventions around email) allows to provide
>  - description of the whole series (in cover letter)
>  - comments for each commit individually (outside of commit message)
>  - make commit or series be a reply to discussion (useful with WIPs)
> For reviewer it allows to
>  - comment on the whole series in response to cover letter
>  - comment on individual commit
>  - comment on the commit message
>  - comment on the description of commit
>  - comment on changes
>  - start a discussion based on a commit
>  - propose improvements as patches

I find these reasons to be more a defense of "ossified practices" than
based in practical considerations.

For example, it is delusional to think that you can do any proper review
of any moderately complex patch without having access to a worktree
reflecting the revision after the patch.

So this entire idea that review is inherently something you would want to
be able to do without having access to a Git repository reflecting the
patches in question is an idea I reject flat out.

For the record, I have used GitHub Pull Requests *extensively*, as
contributor, as reviewer and as maintainer.

The Pull Request web interface has changed over time, but one thing
remained constant: it was always much more efficient to interact with than
going through the mail list.

The commit diff is naturally linked to *the commit*.

If I reply to notification emails when somebody left a comment, it is
automatically turned into a reply on the web.

If I do not want to reply via email, or if I need to see a bigger context,
the notification email has a link which opens the web interface, where I
can easily not only increase the diff context but also see other files in
the same revision, e.g. to check a signature in a .h file.

These are just a few things that are essential to efficient code review,
and that are simply impossible with a mailing list approach, unless it is
opinionated by requiring specific tooling to deal with the fact that code
is transported through a code-hostile medium.

So please understand that I am really interested in more efficient code
review instead of a lengthy philosophical discussions, and that I am
really saddened that I could not gain anything from your mail in that
respect.

I really hope that something constructive comes out of this whole
discussion, because if we simply stick with this unwieldy patch submission
process that costs so much of my time, then I really only lost time for
nothing in return.

Ciao,
Johannes

Footnote *1*: I wrote a little GreaseMonkey script to add a TOC button to
the GitHub wiki editor: https://tomancaklab.github.io/gfm-add-toc.user.js
Similar extensions can be implemented to augment the PR workflow to your
liking, with the advantage of being opt-in.
--8323329-1051190496-1472467613=:129229--
