Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A78A20248
	for <e@80x24.org>; Fri,  1 Mar 2019 15:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbfCAPCs (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 10:02:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:40533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbfCAPCs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 10:02:48 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZynd-1hOvQZ3DVF-00lkX0; Fri, 01
 Mar 2019 16:02:38 +0100
Date:   Fri, 1 Mar 2019 16:02:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
In-Reply-To: <20190208195459.GA32556@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903011557430.41@tvgsbejvaqbjf.bet>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com> <20180814223246.GA2379@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902080958190.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1902081024550.41@tvgsbejvaqbjf.bet>
 <20190208195459.GA32556@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1439165248-1551452558=:41"
X-Provags-ID: V03:K1:DhxrVvgyOWSS20oaLA8K06wLCdpV9s5WPu01x0OiUWlJzmVwStM
 YB3s6YEHLJWILDhwq2RtmOTOC41V2UT7wxSJAIiaYsWsS9dkAXr99+KDtlX2v0OwR/RAtOH
 cwSvaiaBxYA/b7SVE6Z9qVnyfbLdAoQ/NMs4BdIecy/mMrOZB1xtqc6/3AlToyoomDwiocW
 p+poVJL9BtXWOb1hBiWYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cWe9Mb8EWPM=:A51UTcdbJwSgkSC8rDgoJI
 7dsWrKS0599O0L3dEc2QTvituJO2FVyKpGrM9K63gZe/u/plhLk9ZLIrPTPKHH5oeE2PhX6Mq
 AMyJBe/40byZpqUry1X46pdF9UXYuZsglFEIeAU9Q0sVH5/gkgLKqjtrm5xUkSmx2dzvTN8C2
 YZswlOYZqdOsYoiHaaHfkzYisCX01iGvPeMw8FkNkrtZBm0B4LEo96g1g0HsjLdbF8qNZR7Bj
 UBLvD5xKNBfvGMzJEQ3d3Enk8L/8/sq6wkXLom8ta8GDCj9JG68IF6dKA8KBKaznkXDQw890o
 +rHKUXE+QsTE7cXEWc+F71pNlkXOBII+aNJEW2I80dr2vrsJ+MU83Gndq7vSbRtaOcsvQJr9s
 /qcEoDNN3xWPPt7S/l3VOMCaJMWCkEdbuDUJPJF1dYWFN65iFBNDknDgDEvxsa0LJLTO7HEP1
 rwglRlF20p4CxR55pINc8vl1O219nnMRzBJjrmdd8Y+0O6gUKQVmUqYLKPcWdf2oboZ/1lD0I
 4Jzl/bJ0dWStufSdS1Xwrtz5WJZ1HAJCIE6+qP2Ie6wQd9Vs0yXesH50cAKu3xkEpcVZ+TH58
 GcduNR2vnSmZ4UwSAZ7URArstCATTSB5tw2QY2+NWeSJE2EXOaLLs2XLX9RMw8jvjTEPa9xd5
 oSpCPxVrGHwfQLzPpHoZXOLDCnNGOjorVilDBpNLYd246bx9RVwLcI3Fjx6X3eFj6uUGYms4W
 ke3C4MsyqiQtUNT2oiYLX4KMynn+G/2Im1/rCFwpF47y9SPzLayUkbKiNreCIuW0S2Dx3RX6G
 7qVESSDACXJoZDTEuhQf4M5itx3qEWvMb7YR7Dz2cdLOie9NzwhQTD8dTTtkHEUVIuSGl9PbC
 3nAYPiTrDsJzJh9vGDIs2YSk2O62Tr/YhAQcNemJQa1cRsfAUiUaoav9s4KR8PStf7a2Z+ztd
 GLMy6elWiNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1439165248-1551452558=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff,

On Fri, 8 Feb 2019, Jeff King wrote:

> On Fri, Feb 08, 2019 at 10:28:12AM +0100, Johannes Schindelin wrote:
> 
> > On Fri, 8 Feb 2019, Johannes Schindelin wrote:
> > 
> > > I just had a look at the patch you provided below (for some reason, my
> > > previous search on public-inbox only turned up Gábor's mail to which you
> > > responded).
> > > 
> > > Admittedly, I do not really understand all aspects of it, but it applies,
> > > still, and I kicked off a stress test here:
> > > 
> > > 	https://dev.azure.com/git/git/_build/results?buildId=338
> > > 
> > > It seems that your patch fixes that t5570 flakiness on macOS, and more
> > > importantly, addresses an important issue on macOS.
> > > 
> > > Will play a bit more with it and keep you posted.
> > 
> > Alas, I was fooled. *Fooled*, I say. Apparently the --stress option makes
> > the script *succeed* when it fails?
> > [...]
> > So I am afraid that your patch does not fix the issue nor does it work
> > around it.
> 
> I think that patch does the write_or_die conversion to handle EPIPE, but
> it would still need to turn off SIGPIPE for the whole process.
> 
> So you'd also need to stick a:
> 
>   sigchain_push(SIGPIPE, SIG_IGN);
> 
> somewhere near the start of cmd_fetch(). (There may be a less
> coarse-grained place to put it, but at this point I think we're just
> trying to find out whether this approach even solves the problem).

This fixes it, it seems. I let the job run with `--stress=50` and even
after half an hour, it did not fail:

attempts ://git.visualstudio.com/git/_build/results?buildId=354

(I had to cancel it, I thought that `--stress=50` would stop trying after
50 runs, but I was obviously incorrect in that assumption...)

Reverting the patch made it fail within a hundred runs:

https://git.visualstudio.com/git/_build/results?buildId=356

So. Good, we have a diff that works. But you mentioned that you'd like to
put it somewhere else? I am a bit unfamiliar with the code paths of
`cmd_fetch()`, so I would be hard pressed to find a better spot. Any hint?

Ciao,
Dscho
--8323328-1439165248-1551452558=:41--
