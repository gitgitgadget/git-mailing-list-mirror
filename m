Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DA1211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 19:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLCTDh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 14:03:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:60151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbeLCTDh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 14:03:37 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYLKn-1gyING1O4X-00V5Te; Mon, 03
 Dec 2018 20:03:23 +0100
Date:   Mon, 3 Dec 2018 20:03:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Jeff King <peff@peff.net>, Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
In-Reply-To: <20181203175322.GA3892@duynguyen.home>
Message-ID: <nycvar.QRO.7.76.6.1812032002340.41@tvgsbejvaqbjf.bet>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com> <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet> <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com> <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet> <20181201200209.GC29120@sigill.intra.peff.net>
 <20181203175322.GA3892@duynguyen.home>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tLkfK6dCswQry9huYTPBLqdMZbVr2Xvulhlj8ozRydnW6X7TI7E
 HTt6eZyjUBEuOcl2mpG10cHRVU9KvQPgrtcsnBlEtZxtFDK7DEjfIDTq5gU5ZerpgYsXw07
 ZR1vF7nvvjeDJymsYAf3tVqEg3PwNLu5pWX5W0Not2RB6OA89+AXiJL7PGJoq4gBQiRza2t
 6qVqLIB/Cv2/2XCpfdBWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rTrt/KUSQ2M=:UduKvC0KmJKMGjNBeuX8NS
 MRHH81DXK3J0D++08mutT9pmVxpJiM+WRnhpb7hBzjL5Wv9NleM6rLPE4p+44ZaERPyyAUXd4
 n/NG4iXszcDfKDBAWFJzYbv+vAoa4lSTpvD/ULNRtI09e9fsuNU/hozszp8WyL6+6aGDeItpc
 TDGGavI1EqTCve0A6lfd6h5ZzREUSJJqaHBbt6uYCpricT/b8VNowiP/dIKMcKLpnwYO618kW
 AD5cAuSi/lRNw0CkqeR4cZWLmiVPLpwPpiOKz2SfnXB0ehj9krH04Gd7Evf0L2H9tk2efczV4
 w86IdEJc8PPDV44KLMbhEfhPtaKYb0FQg2sDk4IG2Q30rmVpS4cIrNZNeCUpsq28aSWQnvliF
 SelI5EJxOfQ2puQ6RKwf9XJ8PIJVQ6zWttdWSseMEU9s4wrYtCmLMjs5vzughA8iIfe/RQksp
 fc9XxH59Kpz0sQxhIb8zgCEpmqeBh0MrbfQy/vSPZTLStqbAZCdp4kYgSSRh52FfI3aOQqDKc
 3X+P9PBqD5EODNHNjVkWBzsgXdTNls94vrzPCO7/3OPiKiaBbS2gEchlDGYoGhdIjoVbNPhs+
 lUsNk4t8LXiv7x2FQmg/gHFjl19J8tIvmCySNlHc/BocSiAAOf10WzwOaJ893TAprjnoTtYM+
 /I7PxNArspgXaJcmDRSkwHgwmkEGzJTX7nJEYH3U0TcQOdJatE3EFHItgzF98vznCz2iXNXiZ
 PReAJVLk/2xZwEqvzhIRRQV3KoFzBaF5Ijlz3rGaFszbhvUyY1XEaXfZZzredg2XTI7ok7GfB
 MC97E8SMITsZ0pDIs9SzqDxzWDoCcvICN49/bFGskonENTJVdO9qPKzYfY85g2s+cFZLvOv87
 AbRCqwOafDgvlqrPXfgdwmom3WDY8vPQd2j94++AVVOBmz0I590TUBBaETQMIq+egnCPghJ/K
 oEJEiU5Wv8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Mon, 3 Dec 2018, Duy Nguyen wrote:

> On Sat, Dec 01, 2018 at 03:02:09PM -0500, Jeff King wrote:
> > I sometimes add "x false" to the top of the todo list to stop and create
> > new commits before the first one.
> 
> And here I've been doing the same by "edit" the first commit, add a
> new commit then reorder them in the second interactive rebase :P
> 
> This made me look at git-rebase.txt to really learn about interactive
> rebase. I think the interactive rebase section could use some
> improvements. Its style looks.. umm.. more story telling than a
> reference. Perhaps something like this to at least highlight the
> commands.

And maybe, just maybe, that "story telling" is more useful for users who
want to learn about the interactive rebase, just like yourself, when
compared to a mere "reference".

Ciao,
Johannes
