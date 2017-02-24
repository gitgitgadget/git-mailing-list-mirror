Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3FE201B0
	for <e@80x24.org>; Fri, 24 Feb 2017 09:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdBXJ13 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 04:27:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:33242 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbdBXJ1U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 04:27:20 -0500
Received: (qmail 32381 invoked by uid 109); 24 Feb 2017 09:00:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 09:00:37 +0000
Received: (qmail 4896 invoked by uid 111); 24 Feb 2017 09:00:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 04:00:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 04:00:35 -0500
Date:   Fri, 24 Feb 2017 04:00:35 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs/git-gc: fix default value for `--aggressiveDepth`
Message-ID: <20170224090035.ju7evvro7mixc52w@sigill.intra.peff.net>
References: <952cf1f2cb37b746d823f3b917bfb44171cbc465.1487925983.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <952cf1f2cb37b746d823f3b917bfb44171cbc465.1487925983.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 09:46:45AM +0100, Patrick Steinhardt wrote:

> In commit 07e7dbf0d (gc: default aggressive depth to 50, 2016-08-11),
> the default aggressive depth of git-gc has been changed to 50. While
> git-config(1) has been updated to represent the new default value,
> git-gc(1) still mentions the old value. This patch fixes it.

Thanks, this is obviously an improvement.

(I also grepped for "250" in Documentation; the results are thankfully
short, and the only other mentions I saw were referring to the window
size).

-Peff
