Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF86209B8
	for <e@80x24.org>; Wed, 13 Sep 2017 11:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdIMLiN (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 07:38:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:52287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbdIMLiM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 07:38:12 -0400
Received: from virtualbox ([37.201.203.107]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhiPD-1e5co72qu3-00MpFf; Wed, 13
 Sep 2017 13:38:08 +0200
Date:   Wed, 13 Sep 2017 13:38:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     Pavel Kretov <firegurafiku@gmail.com>, git@vger.kernel.org
Subject: Re: [idea] File history tracking hints
In-Reply-To: <E8C827ED458648F78F263F2F2712493B@PhilipOakley>
Message-ID: <alpine.DEB.2.21.1.1709131322470.4132@virtualbox>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com> <E8C827ED458648F78F263F2F2712493B@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:O0j+8acE/+RtjLBA/N35T5YGY5iyihARRbaiHm/zF9FWFGQkNsE
 YR2PmeXH6rQ0VNnLnLH8nkuLdwU3s3A+Or8JWvXoO1V4gGWzEZUfVgPvQhjI9PrH5n8VqDF
 HFsRVgn6ecnL9leR5QMgfNYgpID2vsAz49HoGmQzj2YApVrvw2PM2Tp4myO8wq4Y2dQpYTZ
 h1kz89+zPJ+NoS+8oesVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HAqhBhEeLf4=:7DO371PN3Eo/SEdXbcm3XP
 qbfnl20MEhIsX6gUORaJ/u6sEJLiPMVa2Q6NDq5JteFCVtv55/pBJMPvYgl/dkdFgIfocK5jB
 bYyljEcUKjEFYqj++B+Col+Vt8lv+sjcGadmPyeMzDEbElVi6bL/axgxSoqebeDZzecIp/8yF
 VQOtr0a2L6KeVTcRoZm2xFGrOe30vyOHODMe2Zm0slIualtmiiE/LOprrGFZZdpbs7nwCfLJd
 UIDSGKJCgYSrQWpEWjMXR+scUVq1cep7VeO61OoZMyDJNdhYtspsv+a87YAoxVae79BLkhhGz
 5UAcuGjPDz8rL95OfIuHHThtIgvu+or2DiSZV6tMcF4RkAZB7dCLRiELXD4lQFEQQI5dmpa4B
 ORK4qKK/baEA3/0wAMjZU46jO3aMXi5juNMpBwDguLLTefubtIhUF75lIrAxsYbT1sFeVyRTu
 GPPG5+Wub3no+dEmIO8NjIFvrXUMjJjS4I8/ICVKEPwTLd6ytLBejFyYxGE3x70Lj3xjB+IQd
 0yMULs62QvsVb9i4YC7Skh0sHZFlKSZQxrzUFP6HaobRksHkq28V7bpxA4pbqBBgekW1daQMj
 jVnW99d9kFPCOIyZh5R/9IPsMm4t8D7kMQJj78vrDJavcey9DDVq0agkNL53+2wZKbwDeHal5
 xh2V9VWLWe5cFL+5hSEzBSH1Ml9gxuwEip0cNvS4lAxXQ7iVAYM+hPehVxUA3n+6YdOF4ygdx
 sovHXzEK9yY00pgI5XWNdUF214fPJI804eCq02CU+Gp+ugIf4QXyApNdcmO7ZlqpiNdfZlCb6
 Gru8WChm9enYEx1nYJw01pR+TQ946kOAPWBkzt8inI57MiKrgg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Mon, 11 Sep 2017, Philip Oakley wrote:

> From: "Pavel Kretov" <firegurafiku@gmail.com>
> > Hi all,
> >
> > Excuse me if the topic I'm going to raise here has been already discussed
> > on the mailing list, forums, or IRC, but I couldn't find anything related.
> >
> >
> > The problem:
> >
> > Git, being "a stupid content tracker", doesn't try to keep an eye on
> > operations which happens to individual files; things like file renames
> > aren't recorded during commit, but heuristically detected later.
> >
> > Unfortunately, the heuristic can only deal with simple file renames with
> > no substantial content changes; it's helpless when you:
> >
> > - rename file and change it's content significantly;
> > - split single file into several files;
> > - merge several files into another;
> > - copy entire file from another commit, and do other things like these.
> >
> > However, if we're able to preserve this information, it's possible
> > not only to do more accurate 'git blame', but also merge revisions with
> > fewer conflicts.
> >
> >
> > The proposal:
> >
> > The idea is to let user give hints about what was changed during
> > the commit. For example, if user did a rename which wasn't automatically
> > detected, he would append something like the following to his commit
> > message:
> >
> >    Tracking-hints: rename dev-vcs/git/git-1.0.ebuild ->
> > dev-vcs/git/git-2.0.ebuild
> >
> > or (if full paths of affected files can be unambiguously omitted):
> >
> >    Tracking-hints: rename git-1.0.ebuild -> git-2.0.ebuild
> >
> > There may be other hint types:
> >
> >    Tracking-hint: recreate LICENSE.txt
> >    Tracking-hint: split main.c -> main.c cmdline.c
> >    Tracking-hint: merge linalg.py <- vector.py matrix.py
> >
> > or even something like this:
> >
> >    Tracking-hint: copy json.py <-
> > libs/json.py@4db88291251151d8c5c8e4f20430fa4def2cb2ed
> >
> > If file transformation cannot be described by a single tracking hint, it
> > shall
> > be possible to specify a sequence of hints at once:
> >
> >    Tracking-hint:
> >        split Utils.java -> AppHelpers.java StringHelpers.java
> >        recreate Utils.java
> >
> > Note that in the above example the order of operations really matters, so
> > both lines have to reside in one 'Tracking-hint' block.
> >
> > * * *
> >
> > How do you think, is this idea worth implementing?
> > Any other thoughts on this?
> >
> > -- Pavel Kretov.
> 
> Maybe use the "interpret-trailers" methods for standardising your hints
> locally (in your team / workplace) to see how it goes and flesh out what works
> and what doesn't. Trying to decide, a-priori, what are the right hints is
> likely to be the hard part.

I think this adds a very valuable insight to this discussion: the current
state of Git's rename handling is based on the idea that you either record
the renames, or you detect them. Like, there is either "on" or "off". No
middle ground.

However, if you understand that there is also the possibility of hints
that can help any erroneous rename detection (and *everybody* who
seriously worked on a massive code base has seen that rename detection
fail in the most inopportune ways [*1*]), then you are on to something.

So I totally like the idea of introducing hints, possibly as trailers in
the commit message (or as refs/notes/rename/* or whatever) that can be
picked up by Git versions that know about them, and can be ignored by Git
versions that insist on the rename detection du jour. With a config option
to control the behavior, maybe, too.

Ciao,
Dscho

Footnote *1*: Just to name a couple of examples from my personal
experience, off the top of my head:

- license boiler plates often let Git detect renames/copies where there
  are none,

- even something as trivial as moving Java classes (and their dependent
  classes) between packages changes every line referring to said packages,
  causing Git's rename detection to go for a drink instead of doing its
  job,

- indentation changes overwhelm Git's rename detection,

- when rename detection would matter most, like, really a lot, to lift the
  burden of the human beings in front of the computer pouring over
  hundreds of thousands of files moved from one directory tree to another,
  that's exactly when Git's rename detection says that there are too many
  files, here are my union rights, I am going home, good luck to you.

In light of such experiences, I have to admit that the notion that the
rename detection can always be improved in hindsight puts quite a bit of
insult to injury for those developers who are bitten by it.
