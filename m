Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 552AE209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 14:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbdINOim (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 10:38:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:38840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751133AbdINOim (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 10:38:42 -0400
Received: (qmail 21951 invoked by uid 109); 14 Sep 2017 14:38:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 14:38:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28963 invoked by uid 111); 14 Sep 2017 14:39:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 10:39:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Sep 2017 10:38:39 -0400
Date:   Thu, 14 Sep 2017 10:38:39 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] merge-base --fork-point fixes
Message-ID: <20170914143839.l5u7qof6xgwsojbd@sigill.intra.peff.net>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
 <cover.1505394278.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1505394278.git.git@grubix.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2017 at 03:15:17PM +0200, Michael J Gruber wrote:

> merge-base --fork-point does not quite work as advertised when the
> reflog is empty or partial. This series brings it in line with the
> documentation and, hopefully, with the original intent.
> 
> Michael J Gruber (3):
>   t6010: test actual test output
>   merge-base: return fork-point outside reflog
>   merge-base: find fork-point outside partial reflog

Patches 1 and 3 look sane to me. Your argument in patch 2 looks
plausible to me, but I'm not familiar enough with the mechanics of
fork-point to have a solid opinion.

-Peff
