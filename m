Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF681FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 12:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999861AbdD2Mk7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 08:40:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:42201 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2997860AbdD2Mk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 08:40:58 -0400
Received: (qmail 32261 invoked by uid 109); 29 Apr 2017 12:40:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Apr 2017 12:40:54 +0000
Received: (qmail 29442 invoked by uid 111); 29 Apr 2017 12:41:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Apr 2017 08:41:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Apr 2017 08:40:52 -0400
Date:   Sat, 29 Apr 2017 08:40:52 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/3] Make diff plumbing commands respect the
 indentHeuristic.
Message-ID: <20170429124052.yhgwofbbd5pkd24p@sigill.intra.peff.net>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
 <20170428223315.17140-1-marcnarc@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170428223315.17140-1-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 06:33:12PM -0400, Marc Branchaud wrote:

> v2: Fixed up the commit messages and added tests.
> 
> Marc Branchaud (2):
>   diff: make the indent heuristic part of diff's basic configuration
>   diff: have the diff-* builtins configure diff before initializing
>     revisions
> 
> Stefan Beller (1):
>   diff: enable indent heuristic by default

Thanks, these look fine to me. I'd like to get an ACK from Michael, in
case he had some other reason for omitting them from git_diff_ui_config
(from my recollection, it's probably just a mix of conservatism and
following what the compaction heuristic had done).

-Peff
