Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC591F935
	for <e@80x24.org>; Sat, 24 Sep 2016 19:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935526AbcIXTFo (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 15:05:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:59876 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935303AbcIXTFm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 15:05:42 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LrvBu-1aodpB2TR0-013cEL; Sat, 24 Sep 2016 21:05:36
 +0200
Date:   Sat, 24 Sep 2016 21:05:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #07; Fri, 23)
In-Reply-To: <xmqqlgyiz0lr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609242101100.129229@virtualbox>
References: <xmqqlgyiz0lr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:x1FEFJMLwj9JCNUn6l14tIQ/pMlAULTcqSXgmjv1Ifs9yM8TLVm
 XlAb2UbRcneSAloe7Uz5pe/f0oif2VvjSz6tlL1RTioiigoTcpmqNTfFiI9KYaGALyHYbyf
 dmwIv73zdIlONZx94Q05NTCfYv4jMaen2MogOaRZyOhmhTgPv9YeypJAaHILECcj8hGKSX6
 P13TQXq7TNPHzdzK9oFHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ilChU/FxjaU=:gG2hXrOr2YX0Wmv8//7wla
 85PHZVEobKtqLmdjU+nfWy3hRBxJ0aXvM3TxObo6WL2O+gmXjnePjgnWe7Z53hN5nuOrkC49U
 wY59LNoi7fwf4pdjHw5rIcKXGmbWu7d+XchhYLOPiZi12d1AxtSgZrrxNJy3iEPe68n6GHsVw
 iLDNKg/I1moTajwNisDIkJgxPsVIFYs1v373F2uQbICzJkCYXLehIw2eL6ZLXCKDLP82OHjDF
 DcHrHuEavP+V4SUaYb1BDK5rfngawNWoV2C2dGiTdAa6ZQRtpZF/XF5UG0wny98LvBVLQdsZH
 VU7S8tPdYyeGbxp//swh69v486I5ACMA4cIJbzUGtSY5WfS3W0JSnJ6Pj8YZN9P7p+CFWkoy7
 tALKqmILyjFEJ0yj5+SxiPjbtOjeQB4tWax/ELJeYcywfd02BW/84l5K8Rwii8hGfLWhnbHeN
 +gOzZC/JJRHjtyNKycO0+mr5Cu79QejgKHSOO3vJqgyZtCs+9OTPI2Sf3tL3tc0II6eehj/eC
 4k8qgCOEzOd1Ko3JZl3YeX0hyVdWdGfp8+0818AHyF/iL7LVOtYSR62P8hy9mSZrwDE4LqRS7
 YNr4T8gd/SMKnjojD/7ZiPXN3PG+eg+6U8DqbpLCUpDPJNjwYzVS3FXToZZIJB5HjpvQtRuvf
 3HC9kFiD75beEG2Si5+P5LW6BR2j5UjMc9UzHrDsRtAsH8XzHVWf4GC7CiL3QbZ9/9uw2Dxgl
 amVSPadDLPeaLb7rRt6uHcOtRQeJP6JSft179D9iQJcHN0TQtii25+DwifLT+Cc6b0kYesoI3
 iUZSpeD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 23 Sep 2016, Junio C Hamano wrote:

> A bunch of topics have graduated to 'next', including a few that
> were so far marked as "needs review" or "will hold", as I think
> giving them a greater visibility and guinea pigs would be the most
> efficient way to get feedback from the real world ;-) Some of them
> may be "Meh" topic, which might be why they weren't getting any
> feedback so far, but at least this way we'd know if there are
> breakages in them (in which case we can just revert and discard
> them).

In your previous kitchen status ("What's cooking") you hinted at a
possible v2.10.1 soon. I have a couple of bugfixes lined up for Git for
Windows and would like to avoid unnecessarily frequent release
engineering... Any more concrete ideas on a date for this version?

Also, I found https://tinyurl.com/gitCal very convenient a URL to point
to, do you plan to update that for v2.11.0?

Thanks,
Dscho
