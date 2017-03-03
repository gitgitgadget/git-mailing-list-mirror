Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF412023D
	for <e@80x24.org>; Fri,  3 Mar 2017 09:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbdCCJTd (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 04:19:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:37815 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751143AbdCCJR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 04:17:29 -0500
Received: (qmail 15452 invoked by uid 109); 3 Mar 2017 07:56:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 07:56:07 +0000
Received: (qmail 25624 invoked by uid 111); 3 Mar 2017 07:56:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 02:56:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 02:56:05 -0500
Date:   Fri, 3 Mar 2017 02:56:05 -0500
From:   Jeff King <peff@peff.net>
To:     "Devin J. Pohly" <djpohly@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] p7000: add test for filter-branch with --prune-empty
Message-ID: <20170303075605.3pqqzmjcqdtv2bjd@sigill.intra.peff.net>
References: <20170223082736.31283-1-djpohly@gmail.com>
 <20170223082736.31283-4-djpohly@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223082736.31283-4-djpohly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 02:27:36AM -0600, Devin J. Pohly wrote:

> +test_perf 'noop prune-empty' '
> +	git checkout --detach tip &&
> +	git filter-branch -f --prune-empty base..HEAD
> +'

I don't mind adding this, but of curiosity, does it show anything
interesting?

-Peff
