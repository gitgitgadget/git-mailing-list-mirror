Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8652023D
	for <e@80x24.org>; Mon, 22 May 2017 14:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933750AbdEVOCA (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:02:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:53219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933598AbdEVOCA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 10:02:00 -0400
Received: from virtualbox ([95.208.58.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQyxa-1dOEd10Rvq-00ULSz; Mon, 22
 May 2017 16:01:57 +0200
Date:   Mon, 22 May 2017 16:01:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     stefan.naewe@atlas-elektronik.com
cc:     j6t@kdbg.org, git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix warnings on access of a remote with Windows
 paths
In-Reply-To: <122838f4-5f6b-6921-9242-2724bb6d8c95@atlas-elektronik.com>
Message-ID: <alpine.DEB.2.21.1.1705221600100.3610@virtualbox>
References: <cover.1495261020.git.j6t@kdbg.org> <122838f4-5f6b-6921-9242-2724bb6d8c95@atlas-elektronik.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:laHgTQf03PSG7d0vqCtftnoTA4XmA14DFOG0P49IIBPWV+9xXDY
 thOnovM7rAzW98eejWotRNZyhg7/+OPpzIE6IFceaVnndxxkgq1FOGWjHeP4gG+caD8jlmH
 fjW/TnPGlZjnB4x11bQ5ZWXn20WeA+NthMO6xIfKWUamQQLFy1x0gjsu+4igA+GU4h6LTKL
 Z6vLS6Na19+dxcTY6Q+jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Js5XgMTI2Ok=:7MU7GU++w8jv3LfVCjoNm7
 5/NWLRQbscgFnzTzoVRK9MutpcLmjeXPylYfa1dyGGxi/IvM7pmxPL95UPzYJlWnlPSRMpjEf
 EQabaEBF1nghEKg1mwlgJtjVm6p75ChM1JblXoW0hwsdwBuIR2QkieEPBVTyzG9pCYc4mv71n
 s1/j4GL0ebu93TJnqdvYxiRW+afXD+FutsvZNd4tBFwCFaiWXulWTaIx5LjgCOP2VGnBVsuUa
 1YiPd01jJayXAyVnEKU6V9SgPVHO2kFwJ9rZweiXN7GR4sPwjYDEFiFxtXqK338PBODEj0OnT
 H3p4Ul5UgUfiwkxolKj1PfNk48dUdUTWGXtYjplLVbvKrkO5FVwuVvxhXt8SvOnZl7xeHucd/
 SlYiz53yIc/tRTBeGgkb2tbweLI9NcdLUfdVCnuYz7O/1JhC5sU/xZ5tqXuUEx3xirO61B+uA
 +z1JQmHW4Ra3bC9QR/eGlbxKyqhy8pD8kDRvyuNHQ+rFi7BQQLDLodbw4N580uwszwl6RhljR
 DDdHc7NY5JG8KKPt42qE0E0YIqAwtlBTU5Mc4xOn6DEzYgBoz3rGS3QIoTNAGB9d0rlWf3FL4
 +zY0vVZ8QiqFHX5xXbTTZ5kpsdt18xhtGyQ6rDe23ZKnUU/PnJRvIb0N1joQNfxaplVsJZ/ii
 tn3Hcxz6gpGps8OAuIht2OrVLf3pBdQOTSgO6yHniKLv/oqdEAGsuLYNMwfsm7en85ki7+6H2
 VflBstpNWBsZ30JofPHsA0E1pLb0pBK75frs/ISsAa31PW4Doj1tArpuERPzGhJ+9gM8zY5av
 WbX16dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 22 May 2017, stefan.naewe@atlas-elektronik.com wrote:

> Am 20.05.2017 um 08:28 schrieb Johannes Sixt:
> > This small series fixes these warnings on Windows:
> > 
> > C:\Temp\gittest>git fetch C:\Temp\gittest
> > warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid argument
> > warning: unable to access '.git/branches/C:\Temp\gittest': Invalid argument
> > From C:\Temp\gittest
> >  * branch            HEAD       -> FETCH_HEAD
> 
> What is the exact precondition to get such a warning ?
> 
> Just wondering, because I'm not able to reproduce that warning
> (with Git4win version 2.13.0.windows.1).

I had tested this also, and came to the conclusion that only Hannes'
MSys-based custom version is affected that is much closer to git.git's
`master` than to Git for Windows' fork.

Still, the patches are good in my opinion.

Ciao,
Dscho
