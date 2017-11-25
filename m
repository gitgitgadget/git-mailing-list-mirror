Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015AE20954
	for <e@80x24.org>; Sat, 25 Nov 2017 21:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdKYV43 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 16:56:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:59444 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbdKYV42 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 16:56:28 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaF8e-1eY3QC0tA0-00JoA0; Sat, 25
 Nov 2017 22:56:12 +0100
Date:   Sat, 25 Nov 2017 22:55:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: git status always modifies index?
In-Reply-To: <20171122220627.GE2854@sigill>
Message-ID: <alpine.DEB.2.21.1.1711252240300.6482@virtualbox>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org> <20171122153028.olssotkcf3dd6ron@LykOS.localdomain> <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org> <20171122161014.djkdygmclk227xmq@LykOS.localdomain> <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com> <20171122211729.GA2854@sigill> <20171122215635.GE11671@aiede.mtv.corp.google.com> <20171122220627.GE2854@sigill>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wdC16RBQ1BSFC3pOCA/wl/m0p5VrSwQnPFHxvqE2z1MZ6U3KzKH
 B2eDUuQ/bhPmfJgSIPctREWIajzpQWlQI9iNO63DIwIIhFxFx3NMoHlMTTYeWhw794nc0Uf
 +qGo94scaWjBRzb5AxdiC/MeyjaL5L/qdtcNGpWstp0qNKLDYTvBDJcYojKwpsyWZzDPnxK
 cdrt4FubSFt6GHKeZBcNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u6LViXNJO/s=:px4tSBJTIJJ3Gqel2pLo9q
 4T4KrlsP9aR2mCi+jCbmhYB+/3arTQxJ/XPORCh+Q59+mdPNyXMWTNyouXZbsZY5hOTeW6w2O
 mDxpCd+Bdb9taMlQbomq3LXH/me9ilCfcT6UZCeAdTb2u6ViyMMknkrRAmEe8sUE1QEhC95Vv
 P0oPBXo8BR6dl1vybmUE9pcYaQVIQLPDF4xA5z+KPJenJm7BJJ8+o20zVweqm6nqF+2rkCrX1
 +9qwjAtetT87omzwKYw3VzVP4QS5M/KZn8HMa0V1Npl01sehQ1tnM5L61rC2x8OAA8VeQODt5
 6J3kCNg7X5gPANgWvRiC4YtDr6Xe+c+j9RdaJTgmvjQkAE0vQnREKaK2x01DbRwoNWaBgEQ2D
 1PegVtZgQiqo+WsFdNeHGjxqvw8Q8stmOkDaTYHgF6Gy7xvi9HCf4CCnFFOPmzPIFtTjTCzpq
 Nf2FCDuC64/a/qQaoeJQg5zFINZiI+D5uBKyvwCayG0kL9l/ewh+06NDKpG2bQIdFLxnCvZcK
 I+++P07Bty92n0lxr7eTaeFE3WjTJi9spOz1VCH3KfOfXJCcjgv5h69pil3HyQGt5WNsC0YIt
 VJ+HvTcvSkD7h1YCKjyyCwEwtHvLNxG89YX1ihhD7E6T0yAjTWE27lU4QI7lRj03bOLDznTrp
 +tp4h4069rUz9Hyp6fXsASOW3ntq9bdI2H5vj6674Hl5YK21+j0arOTgD6To23gdjM/535PNu
 /1akf6uI9CWEwhndzaJKhwBv4VF1JU+Bhuhe2roBNQ5rJv4MCbY1qhFfFDSpCxMzm5Z/LyRdo
 rAHW6BV23HpKHddAL8DzxWml4LbOfShqceQuURIcFvZkELn63rd20FcUnY7qM1p2Xx7C+g8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 22 Nov 2017, Jeff King wrote:

> On Wed, Nov 22, 2017 at 01:56:35PM -0800, Jonathan Nieder wrote:
> 
> > Jeff King wrote:
> > > On Wed, Nov 22, 2017 at 12:27:20PM -0800, Jonathan Nieder wrote:
> > 
> > >> That said, I wonder if this use case is an illustration that a name
> > >> like --no-lock-index (as was used in Git for Windows when this feature
> > >> first appeared) or --no-refresh-on-disk-index (sorry, I am terrible at
> > >> coming up with option names) would make the feature easier to
> > >> discover.
> > [...]
> > >         Or maybe just living with the minor philosophical rough edges,
> > > since it seems OK in practice.
> > 
> > To be clear, my concern is not philosophical but practical: I'm saying
> > if it's a "git status" option (or at least shows up in the "git
> > status" manpage) and it is memorably about $GIT_DIR/index (at least
> > mentions that in its description) then it is more likely to help
> > people.
> 
> Right, I went a little off track of your original point.
> 
> What I was trying to get at is that naming it "status --no-lock-index"
> would not be the same thing (even though with the current implementation
> it would behave the same). IOW, can we improve the documentation of
> "status" to point to make it easier to discover this use case.

I had the hunch that renaming the option (and moving it away from `git
status`, even if it is currently only affecting `git status` and even if
it will most likely be desirable to have the option to really only prevent
`git status` from writing .lock files) was an unfortunate decision (and
made my life as Git for Windows quite a bit harder than really necessary,
it cost me over one workday of a bug hunt, mainly due to a false flag
indicating `git rebase` to be the culprit). And I hinted at it, too.

Maybe I should trust my instincts and act on them more. It is not like it
was the first time that I had doubts that turned out to have merit, see
e.g. the regression introduced into the formerly rock-solid
set_hidden_flag() patches due to changes I made reluctantly during
upstreaming, or the regression introduced during v1->v2 in my regex-buf
patches that caused problems with mulibc and AIX.

I really never understood why --no-optional-locks had to be introduced
when it did exactly the same as --no-lock-index, and when the latter has a
right to exist in the first place, even in the purely hypothetical case
that we teach --no-optional-locks to handle more cases than just `git
status`' writing of the index (and in essence, it looks like premature
optimization): it is a very concrete use case that a user may want `git
status` to refrain from even trying to write any file, as this thread
shows very eloquently.

Maybe it is time to reintroduce --no-lock-index, and make
--no-optional-locks' functionality a true superset of --no-lock-index'.

At least that is what my gut feeling tells me should be done.

Ciao,
Dscho
