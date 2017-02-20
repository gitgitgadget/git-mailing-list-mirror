Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0DA7201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 07:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbdBTHxV (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 02:53:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:58595 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbdBTHxU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 02:53:20 -0500
Received: (qmail 6303 invoked by uid 109); 20 Feb 2017 07:53:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 07:53:19 +0000
Received: (qmail 24074 invoked by uid 111); 20 Feb 2017 07:53:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 02:53:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2017 02:53:17 -0500
Date:   Mon, 20 Feb 2017 02:53:17 -0500
From:   Jeff King <peff@peff.net>
To:     pedro rijo <pedrorijo91@gmail.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>, e@80x24.org,
        Git Users <git@vger.kernel.org>
Subject: Re: git-scm.com status report
Message-ID: <20170220075317.uyqlmgopa62d53my@sigill.intra.peff.net>
References: <16F9F83D-5A7F-4059-9A27-DB25A8FB1E99@gmail.com>
 <20170203120838.ohxq5ac7dadlvy4s@sigill.intra.peff.net>
 <CAPMsMoAUcVteJGfyYrL1ZkNLnoRES0yZxkMZeL347Q_1Kx5VBQ@mail.gmail.com>
 <20170203222407.ctr6bchtpblelqgb@sigill.intra.peff.net>
 <CAPMsMoDpAeD0hpPuLeWO2T1VoEZDf_hD2gA2GDBqypMF9V6gAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPMsMoDpAeD0hpPuLeWO2T1VoEZDf_hD2gA2GDBqypMF9V6gAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 18, 2017 at 10:27:51PM +0000, pedro rijo wrote:

> I would say everyone did an amazing job, closing more than 150 old issues
> in a single week! I think the amount of issues is finally manageable (40
> issues currently).

Yes, thank you to all who have been helping. But especially you and
Samuel, who obviously spent a lot of time sifting through old issues.

> And if you agree, I would like to start looking at old PRs (some will
> probably don't make sense anymore), and will start reviewing them as soon
> as I have the time to setup the RoR app on my machine so that I can
> understand and see the changes introduced on the PRs.

Sounds good.

>  Many PRs seem to introduce small and innocent changes, but I always like
> to run the code to see :)

Yeah, many of the display-oriented changes are pretty obvious from
reading the code, but I have caught a couple of regressions just by
running the PRs and making sure the rendered result is sane.

-Peff
