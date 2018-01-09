Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D55EC1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeAINQI (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:16:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:54373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbeAINQH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 08:16:07 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McDl1-1eGxna0ly3-00JZK2; Tue, 09
 Jan 2018 14:15:53 +0100
Date:   Tue, 9 Jan 2018 14:15:47 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
In-Reply-To: <20180109072044.GD32257@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1801091407480.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180108154822.54829-1-git@jeffhostetler.com> <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com> <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com> <20180109072044.GD32257@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:t8NAmshJHrWcZoF7pj2J49HJQq0nIyWYOeHF2EJsrV4jikmloJL
 iUqlXjcIt5kzzu/0mYb3/A4x6OBH91Rc4hZjQljitA2ZqYw9h1bhL4UqqTlcJq/Ul6pWZ2r
 7FWUKKznaN3MG5PB4KLmRAa65wW5ga4632rM7uEJY64OEtqk4S64Bc38Nrj670p3ufy/r1n
 uHcB+khTKi1iDm2IvWP6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h7r5sv0eqbk=:5eXrxN4wQjzYHvv30UjGiP
 H4DcmJHiYdHKavOcRiW2SxCklRBO8wwhDWNxcNChqDTDZaqsDULZWPr27t1y+GvfAut94aYeI
 Nmxey7WGXekrKRmQDOv40vXnypzRpJXit5cFIljhu8k6OdSNf3o1p7Sl/33FEbKzHkDgocxyg
 ZXDz27cyPgtWt71q2WyszFb1DwFGfVNhr71uw8Hg26EO7rB508438CFfFLfiWcRcgAbV0lJZI
 LWroFesoN9yKJnw0aV4k/KrFcsyCwWZ7RicP4dJOL7z7LXKq09jRzbMxM4gyJRw9qUkzWXw1m
 4FrMxpwnSOwWe0j8+P7iwPYieMKUnb7Fj7mFVNBXU6jXdgLIGb/ij+Z11cFur9n9cUhzv35Vf
 Z8x8d4kLlh5NUMhXLDIO2GCsnKXLW6r0NYhKulhlgtRZjdZ4EJmIYRluiMRTNXLuJoK0Xj0vz
 mJR+YeTowoB68myqtg2nJI6anUSISfiN4Oz0r5v8+92unLGyu8Yq11oV9oSIbjFY/M52vXha2
 89FNnYHTNW7mBXgF29T8NzOa4OeJvcn8cDgFty37R1GkM3XlB5A4tQCxpsoT2IXZPy8bXkKIq
 21Hz2/H0LMYani/FlYxjo/m4khc+PHTP6zQM6MZJA0J/r9K6LmTpsrIo1pwTi8ysEO92st3T3
 RrFD5NZoqDydn8mCdCbH5wN48unHTisrUdqXWXJkj3MMnuVVs1d79Gwycfu1LjANE1QWZ6PKl
 Yc42A3PYikwa3oD46XPmJH7/gxdkMghXgbKkUo7dSphaeUve7fg7RY/tWE2bN/qSH19uJY+hP
 bH4G/JDkAqsyAUB9d+AaZvEMjSPh+CLch+iD1T1Dfy9c0pqBpPq1h/DUym8BgksyZvYhZ9o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 9 Jan 2018, Jeff King wrote:

> On Mon, Jan 08, 2018 at 03:04:20PM -0500, Jeff Hostetler wrote:
> 
> > > I was thinking about something similar to the logic we use today
> > > about whether to start reporting progress on other long commands.
> > > That would mean you could still get the ahead/behind values if you
> > > aren't that far behind but would only get "different" if that
> > > calculation gets too expensive (which implies the actual value isn't
> > > going to be all that helpful anyway).
> > 
> > After a off-line conversation with the others I'm going to look into
> > a version that is limited to n commits rather than be completely on or
> > off.  I think if you are for example less than 100 a/b then those numbers
> > have value; if you are past n, then they have much less value.
> > 
> > I'd rather do it by a fixed limit than by time to ensure that output
> > is predictable on graph shape and not on system load.
> 
> I like this direction a lot. I had hoped we could say "100+ commits
> ahead",

How about "100+ commits apart" instead?

> but I don't think we can do so accurately without generation numbers.

Even with generation numbers, it is not possible to say whether two given
commits reflect diverging branches or have an ancestor-descendant
relationship (or in graph speak: whether they are comparable).

It could potentially make it possible to cut off the commit traversal, but
I do not even see how that would be possible.

The only thing you could say for sure is that two different commits with
the same generation number are for sure "uncomparable", i.e. reflect
diverging branches.

> E.g., the case I mentioned at the bottom of this mail:
> 
>   https://public-inbox.org/git/20171224143318.GC23648@sigill.intra.peff.net/
> 
> I haven't thought too hard on it, but I suspect with generation numbers
> you could bound it and at least say "100+ ahead" or "100+ behind".

If you have walked 100 commits and still have not found a merge base,
there is no telling whether one start point is the ancestor of the other.
All you can say is that there are more than 100 commits in the
"difference".

You would not even be able to say that the *shortest* path between those
two start points is longer than 100 commits, you can construct
pathological DAGs pretty easily.

Even if you had generation numbers, and one commit's generation number
was, say, 17, and the other one's was 17,171, you could not necessarily
assume that the 17 one is the ancestor of the 17,171 one, all you can say
that it is not possible the other way round.

> But I don't think you can approximate both ahead and behind together
> without finding the actual merge base.
> 
> But even still, finding small answers quickly and accurately and punting
> to "really far, I didn't bother to compute it" on the big ones would be
> an improvement over always punting.

Indeed. The longer I think about it, the more I like the "100+ commits
apart" idea.

Ciao,
Dscho
