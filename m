Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01907207BD
	for <e@80x24.org>; Sat, 22 Apr 2017 11:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1043863AbdDVLs6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 07:48:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:57503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1043838AbdDVLs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 07:48:56 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUoiS-1cVzbq0MsG-00YAy0; Sat, 22
 Apr 2017 13:48:42 +0200
Date:   Sat, 22 Apr 2017 13:48:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
In-Reply-To: <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704221319580.3480@virtualbox>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com> <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704211135430.3480@virtualbox>
 <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rGTEQWvuJe8wvAUk6CHu8HG4blmGExrZWuqKr/vHFhQ2yDp7aQx
 gicbkQPPVrTjTaSseQPlviFzKZi+8PP5ICUdjcPiSq77VXhDtEFx6bs07jOBq4jLhwTDbUF
 R8BLvhX64x7qypnO6miUP9NOtRE3O/sk9rwTjDbX8CETihWiifcNwcThCt+QKLRora/cByt
 IzBv9ybnnzNQmqNhx9h3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WUjJ+KMxBjY=:nOZ4bc8Rck4OBSxIrCYQ5S
 qFns3ydNWhNL3D+3oTx76bLSAPVnYLrr6AQDHeWQwWhP5yNuE9Ao4uFXo70P6wmz5ZpwsMLQz
 ijJMsU64dIunXcA7hn+S/hD8OyEpuMglIvsuk3kU7A94vrVHHaw68FORavhq4+AZ+9s0fTwpq
 adojH1iqXLHi8NvkrsRV5HKIOgq2FBGCXRhwzNLsYe9+hhE92m64Ix8Nv1CPjig9iGPZZ4C16
 7tDZb3WT+aEWNdF5MCcABm8xd3Mq/NQRF321sCKRNjmmvpx0r13XObp8T4B8iURvwcUindej0
 cIOsFltyjX6VB6indEVqnG/FDyBDpg1Ydto0Drh26Ll4U+4/DFYWNC5uFdPe2KJTGC17SUDBd
 kUiuEcqWqx0x1f4iSqdHNIWFawuzowYDDVbEfsYwN3Slty06eERzxs9mmW0TROv4IjHkpesES
 hcijFzhXIJj49U6xsejMy6NSHDQvPEEoMAR8XzlRVN5ALPzHdayKmpI7XUn63uSdyerB1YCao
 AM9Gr73QJuEJr1HUqiaRK1lQrkXv2mc9csPWx8oH72/t1vdz10XxtrRGiZ92RCkGqD4637p0F
 +77V5idnkGORJhhpcHvVpLx3KIr5AwEMSNG0I33AI1cQN1+lRyZmiS3iMhOfcWCFmKLCpoxdj
 RFK4+Ypui5V0P70LWg0h2Vx8+Pdf+ZFPr27cp0oxaLq9IwriXM+OgmX74P7q9+36CzqE19Ia0
 38xTZTO4vR1wCEG7ZVWLGei1pH1wtdTcC8+5reGbDPUXKEg/c+J/5FfdR1Zrcr1JtCmTfvU4f
 Da6k6ck
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Fri, 21 Apr 2017, Christian Couder wrote:

> On Fri, Apr 21, 2017 at 11:50 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > (with all associated problems I reported earlier, as you apply some
> > patches on top of really ancient commits and bisect wants to test all
> > merge bases first)
> 
> First bisect should ask you to test merge bases only if there are
> "good" commits that are not ancestors of the "bad" commit.

Please note that this is a stateless job. The only "state" I have is the
branch name.

So when something goes wrong, I have *no* indicator what is a known good
state.

The strategy I implemented was to use knowledge about the branches and
their relations. So when there is a bug in `pu`, the script first tests
whether the same test passes in `next`. And if it does, that is my
known-good state.

In the meantime, I cheat and mark all merge-bases as known-good, too. But
that is by no means a correct assumption: sometimes Junio decides to base
a patch on top of a really ancient commit, one that may be broken on
Windows. So there you are, I cannot win, I just tried to implement
something that works reasonably well, most of the time. It still takes way
too long.

> Second yeah there is probably an old bug in bisect there. In theory in
> most cases bisect should ask you to test only one merge base, as:
> 
> - if the merge base is "bad", it means that the bug has been fixed
> between the merge base and your "good" commit, and bisecting will
> stop,
> - if the merge base is "good", it means that all the merge bases that
> are ancestor of this merge base are also good, so there is no need to
> test them

That is not necessarily correct. If there are two merge bases, one may be
broken, and then that one is the first bad commit.

> > because the required time *definitely* would let Travis time out all
> > the time. Those bisect results are even less visible than the Travis
> > results, see e.g.
> > https://github.com/git/git/commit/2e3a8b9035a#commitcomment-21836854.
> 
> Nice that they exists though!

Yeah, well, it took enough of my time to implement, too ;-)

Ciao,
Dscho
