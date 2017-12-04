Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E3C20954
	for <e@80x24.org>; Mon,  4 Dec 2017 16:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbdLDQ46 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 11:56:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:47484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752597AbdLDQ4z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 11:56:55 -0500
Received: (qmail 32289 invoked by uid 109); 4 Dec 2017 16:56:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 16:56:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24420 invoked by uid 111); 4 Dec 2017 16:57:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 11:57:15 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 11:56:53 -0500
Date:   Mon, 4 Dec 2017 11:56:53 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com
Subject: Re: [PATCH v2] sha1_file: use strbuf_add() instead of strbuf_addf()
Message-ID: <20171204165652.GA12701@sigill.intra.peff.net>
References: <20171201223945.GB17334@sigill.intra.peff.net>
 <20171204140603.180079-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171204140603.180079-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 04, 2017 at 09:06:03AM -0500, Derrick Stolee wrote:

> Thanks for the feedback on v1. This version fixes the cruft_cb
> bug and streamlines the strlen(). I would include an inter-diff
> but it was the same size as the patch.

Thanks, this version looks good to me. One procedural nit:

> Thanks,
> -Stolee
> 
> ---

When you put your cover letter first, you need to use "scissors" like:

-- >8 --

to separate it from the commit message. Using three-dashes means "git
am" will include your cover letter as the commit message, and omit your
real commit message entirely.

-Peff
