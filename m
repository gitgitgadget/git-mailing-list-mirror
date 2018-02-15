Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4AAF1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 01:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032350AbeBOBIJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 20:08:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:36023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032245AbeBOBII (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 20:08:08 -0500
Received: from minint-tb4pce7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0MACmL-1exQYk0mQT-00BIUY; Thu, 15 Feb 2018 02:08:03 +0100
Date:   Thu, 15 Feb 2018 02:08:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <87bmgt8k2k.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1802150207170.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <874lmqirma.fsf@javad.com> <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <874lmmerdu.fsf@javad.com> <nycvar.QRO.7.76.6.1802122118420.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87bmgt8k2k.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DXnh/6qjuixxXgBTDNMp4F3HDcrqlxH3ZBrLaFzJQQwub36QFzr
 aG9XyMtJswMxF5fb8VNhrvozrG8ng/+hzW2hIKwCJkuD8+zwBR3AlisjhFwK8qb4S0++ccj
 dIK3Cn5R6IA/Mk592+UZek1k0u5uSVQ37A++IjCMMjdBSxJAKQNHF9Ja/a3YB4o/NuUwg/q
 8DaHoWFwJ2kVs2ytZ8KUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q6aE4ep/Juw=:uj4IgjO6lNwz8Nvq61+B1X
 ZixJaAoCRHdIkpvoocj10k28A2Do3kYf1HkaUMxu1bMVXGRpAz38vmXUTz/3l4YazO6QkRslR
 sOBlJ5oIelsrnE9DTZvWSbvAAte/A/gjDSWYGk9gXzphEMsqJ+GWsisUo7l9ryfUvzjx4g/YC
 /eQsiWS0GZZ5W64wpiZoRoIFNlqaIpU/Vlxp/pnS0RIUdFyc5j9x7Q9MJCqghliKvE4ITjD/Z
 2FvvjQN/7q12fcpuoBb/yEgDm5pCuXOthzv53SvBCLoZpPw146EB5PHmAHw7r9CQUSBZlbuSC
 DjmChpEW0b7UU/jpGSdbbBDsqDasZQtHXnZFfVlyDAt2pODeqjqfJzxQFuG+sp20og0OyVxan
 4JWbarYD+Nc1sK4IxhTxlYLXvt4IVdro+4Swnu1e05MhkLsNDpCeRbllVPIGx3l0GF6LgKs9p
 +RNfmiLefBBHFK21P279nZWPKdbUNzWosHtFuEnZ6f1dqYzek+3w+mlqKvogSkg723p1LACQ6
 kwpj2Tq1mo7l7wftGpRs0Uuwr5xrauqII4CLEz/A0X7UmDRRpFfFSwRSNGgE0alfJdgtIvGKM
 4yFu0dHWBPvWOLDjGPFa5QH8/tgS80uYC8NZuSUAo9T1099MHNRl97N+x6IojBgk0emgFuv9M
 kOfnH+AbBSdiT2zUWKADQzYjh5FM3d2NLhydttZ05eors7KazcXM6jZEZYMPIXDkaSi+DqxHt
 qWuGByRpP/o46YCcBKKkikI8BYCMO7e7Sdxgx/p3Y1xUV5b6kzTi2uLl3YX76O8Ue5LhZ3agT
 RTeo7NuuG2h01tmz924GvNNAgSDS3wi9a1D/mBmlNtRSadDziE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 13 Feb 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The wording is poor either way, but you are also not a native speaker so
> > we have to rely on, say, Eric to help us out here.
> 
> Likely, but why didn't you keep original wording from --preserve-merges?
> Do you feel it's somehow poor either?

Yes, I felt it is poor, especially when --recreate-merges is present, that
is indeed why I changed it.

Ciao,
Johannes
