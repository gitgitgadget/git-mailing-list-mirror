Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C471211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 19:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeLCTBw (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 14:01:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:38621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbeLCTBw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 14:01:52 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lmr1w-1h8hKt2PLo-00h4aH; Mon, 03
 Dec 2018 20:01:43 +0100
Date:   Mon, 3 Dec 2018 20:01:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     Jeff King <peff@peff.net>, Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
In-Reply-To: <20181203172743.kq5zfbfnvjadeikj@ltop.local>
Message-ID: <nycvar.QRO.7.76.6.1812031957060.41@tvgsbejvaqbjf.bet>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com> <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet> <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com> <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet> <20181201200209.GC29120@sigill.intra.peff.net>
 <20181203172743.kq5zfbfnvjadeikj@ltop.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TdlUEpwJkMF1FA8TaoTHBJENF3NgiavWxiV8ASMLnRzsKSTDUN7
 zEhfVmTwHHqiy1GSONWLouGvdkAq1fgQd7B2t0vUDkR1qEADBNDs11rAPRJn417c/+jz0YG
 0XUyLpq5ZIFVk3yWncU2QIRTw35+F5Ajk0MVF+NOk2ygpZ8nwo86FYnrQap8MQsg8HFcQtc
 TX1121/1xII1ThLe9n99w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mmg4dQJwoNg=:XDkjticVqlTpvBZDqGLjoW
 EuMTby7mY0YM8km8jI6PAynYV2OFvRNNHBkG7A85FmGl+bdd8FpIxtdmqIIwx3Tde3wimJims
 MDDsqYTIsatNPFbt7ImhXQ5+nuxCZ1sb927y/qNY60EiQ4Va86dcXCfsfofcOZEvLNJjiwt1w
 WnktCm+yI2d15rt6CwjyWJU1YSBURMCxY+orNrPyiDKHvqloEYy0fJQrljQ9k2H8XoQkji4vx
 i0ekWrYXl8u2PGOKAWDand5Cy+OrRt5pV8aeSecFvudL0+eCc+WkwjM8ARLl4eOWG9mTaFXD1
 azCkX70z6Z+/5PPQ/bX4Oi0RyhioSqditzFYBbu7ydlJi3dhoqwliYrX+gf0ySY498xbkzTMW
 c+Q+HM/ymJvxssTaSzN8kejxMyMHUmMOqvNsF0P6Q4GkBHUus24tw0Uq4ibsbkfW1Bv701VeX
 SEqOJUnSZJP9lM3c/Apf6FeeiO0c+gqdy6j7jU9jgjW2+RdmI4zTqkZvpjoij3ucO5FdYvS5U
 4U8sFZLqlHLgR4sWbnYYerF7gcjYTdw46dQl1EOks5JPjJsPlLIbeFa5BaZnSQ/Zh3yVyzjBF
 M9CKp+mbhVsTOhybRZR6lp3tkDRS8hCMfMiqcG9yeyhbgb48/5Bjxw7OJGT7xoMN6slmxsCIy
 VYjKizXrRzwpphg04MxwKxKE40qUhTJpu9KNH7qz/sDCRlbwwXU4QaeDg2w7CSuPsqL6Rvjvw
 gZeRKPO8lAYHN3OCBmjrkTmjeYTSR1oBynH4blyFP0UKsaPKuSoAJEBwwniZEqE56Ad823RWi
 u2mVUPucm2OnpTxkEV+g2Lqq/Rz3EWlUxjRsNfeW2TrYaG/5m/nbdCZapf3b/x2881YZOhiWn
 23yN02bFM3RhKXToA+Mo6WFgox6iEcT0O8OsuZ8lYVtXySH28Zg0RqZ2t8E450Hv3CRWnMrmf
 hVPhGH+loZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luc,

On Mon, 3 Dec 2018, Luc Van Oostenryck wrote:

> On Sat, Dec 01, 2018 at 03:02:09PM -0500, Jeff King wrote:
> > On Thu, Nov 29, 2018 at 09:32:48AM +0100, Johannes Schindelin wrote:
> > 
> > > > > Would it not make more sense to add a command-line option (and a config
> > > > > setting) to re-schedule failed `exec` commands? Like so:
> > > > 
> > > > Your proposition would do in most cases, however it is not possible to
> > > > make a distinction between reschedulable and non-reschedulable commands.
> > > 
> > > True. But I don't think that's so terrible.
> > > 
> > > What I think is something to avoid is two commands that do something very,
> > > very similar, but with two very, very different names.
> > > 
> > > In reality, I think that it would even make sense to change the default to
> > > reschedule failed `exec` commands. Which is why I suggested to also add a
> > > config option.
> > 
> > I sometimes add "x false" to the top of the todo list to stop and create
> > new commits before the first one. That would be awkward if I could never
> > get past that line. However, I think elsewhere a "pause" line has been
> > discussed, which would serve the same purpose.
> > 
> > I wonder how often this kind of "yes, I know it fails, but keep going
> > anyway" situation would come up. And what the interface is like for
> > getting past it. E.g., what if you fixed a bunch of stuff but your tests
> > still fail? You may not want to abandon the changes you've made, but you
> > need to "rebase --continue" to move forward. I encounter this often when
> > the correct fix is actually in an earlier commit than the one that
> > yields the test failure. You can't rewind an interactive rebase, so I
> > complete and restart it, adding an "e"dit at the earlier commit.
> 
> In this sort of situation, I often whish to be able to do nested rebases.
> Even more because it happen relatively often that I forget that I'm
> working in a rebase and not on the head, and then it's quite natural
> to me to type things like 'git rebase -i @^^^' while already rebasing.
> But I suppose this has already been discussed.

Varieties of this have been discussed, but no, not nested rebases.

The closest we thought about was re-scheduling the latest <n> commits,
which is now harder because of the `--rebase-merges` mode.

But I think it would be doable. Your idea of a "nested" rebase actually
opens that door quite nicely. It would not *really* be a nested rebase,
and it would still only be possible in interactive mode, but I could
totally see

	git rebase --nested -i HEAD~3

to generate and prepend the following lines to the `git-rebase-todo` file:

	reset abcdef01 # This is HEAD~3
	pick abcdef02 # This is HEAD~2
	pick abcdef03 # This is HEAD~
	pick abcdef04 # This is HEAD

(assuming that the latest 3 commits were non-merge commits; It would look
quite a bit more complicated in other situations.)

Ciao,
Dscho
