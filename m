Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88BBC1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 08:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755173AbcIAIEd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:04:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:49521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754879AbcIAIDB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:03:01 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LmKOI-1b5UB21vJC-00Zux6; Thu, 01 Sep 2016 10:02:54
 +0200
Date:   Thu, 1 Sep 2016 10:02:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 08/22] sequencer: remove overzealous assumption
In-Reply-To: <xmqqd1ko225w.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609011002160.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <3c8c60e0799fdf176c72e7e17c257d33b2a362bc.1472457609.git.johannes.schindelin@gmx.de> <09fd1436-301a-b0e1-c32a-81a47e4eb351@gmail.com> <alpine.DEB.2.20.1608311706400.129229@virtualbox>
 <xmqqd1ko225w.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eCVeqQ4FB0vFET40ZdtNCZ2Td+K90fRTtkUuZApS5LYZwwyxWS4
 QDpMx8CVBo3fgAYWbTaIB5nnPu4u/UFLOVigFB/c3PFnfL8YGqDZiNRAcXpjF0JAP4nCEVz
 m4xYeAqiWJZP4fSYCm/A0drwvvbVHckxUJb7dOYUezW4IHoWZr+xxTGuSsDhWiYUpjrqPqQ
 bFIaWSlTGS0sef3GQ4sLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k/NCQqVobCs=:7Bk/NXP7t2AhRZ+QWqilFH
 G/Fg//4lB/Vve5CTA5xPEL71tSehZs9lSvnvF9EF8cl8IMlA4wDI8PceyciXPlxds2ZlejTrK
 GwLxFAGBPdtilU/Wq0RjAtjTp+G472wlGXjBqm4yFUCpC7p+sDdGOPBCY5KEUpJIXsHC+cjrn
 3ch5vTYTcnHuCsu6ZDROrEmmxhbLPMSOLyzYI8/B+V/HnhXXWe22JDfcaY7pw1+24wIl8S0v6
 iww095UDPZ/JwF/wbbP5MIpyppdte8598Jahuwy/WtCD9R+RfA2yUCSmEtR4xBrLHiEGztHgN
 Hmd+ljDJ8Iv87Y7mdE2kL6MlB6w7eBbSRkKfKHGyXDHL3FmhXPJ2v4Rg8IiNeyOQ6la6TAgFE
 kl3UiuSSZUWFIT5dRxNrzI8jSwnuAfb5oIZDq2WNr3kY0o6W9CHNTHzvdNlhfs/llw/6c5dhB
 VsDlNJwwH0RF5ezLsq+JPX1MC81FIqIVHBFSnhkgPYL0qCOY3h4yXacDt2Adp/SIL+8HzyyG+
 eB8+yutranVcYX6+R3In0iSVKreEEXGrmwoR9dmH1Ib0oJqCvGXvbTFNcwaqLiOASDr4G9ChA
 nyju2lVxLr20GXA6IG4wkt24DEw34th3BUsVo+dV1B4+RDsHQGJRSdvWxaoq4vu//W9cmn5/7
 DLTNLzCZVsTYv0DrxsPYpuNkT66Boq39JQJeXJlB/8hUNjMGQMd+Dk3RermrN7WjNWiB/oYHX
 b60TFddBk5wJio+8JuAvXjLOMLDdUR5UhggNcv0zgruMyabTjd2P2k2gP4Ay6soikWCv3Aa+X
 6r4iaxJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 31 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So if you must have a patch that disagrees with this overzealous
> > check, the "revamp todo parsing" one is probably the first. But it is
> > better to think of this at a higher level than just patches: it is
> > wrong to limit the todo script to contain only identical commands.
> 
> So if you think of this at even higher level, the check done in
> parse_insn_line() that _assumes_ that opts->action must match the
> actions on each line is _WRONG_, but what this test expects to see is
> perfectly reasonable, I would think.
> 
> It is a different matter if it makes sense to _verify_ that the user
> didn't make nonsensical change to the generated insn and error out when
> s/he did.  I tend to think it is pointless, and I wouldn't object if
> this test is removed due to that reason.

Fine. I will reintroduce that check. I guess I have the time ;-)

Ciao,
Dscho
