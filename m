Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878E91F404
	for <e@80x24.org>; Mon, 19 Mar 2018 20:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971288AbeCSUQ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 16:16:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:34944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S971213AbeCSUQr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 16:16:47 -0400
Received: (qmail 5477 invoked by uid 109); 19 Mar 2018 20:16:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Mar 2018 20:16:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24794 invoked by uid 111); 19 Mar 2018 20:17:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Mar 2018 16:17:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Mar 2018 16:16:44 -0400
Date:   Mon, 19 Mar 2018 16:16:44 -0400
From:   Jeff King <peff@peff.net>
To:     Nick Hunt <nhunt11@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Potential git bug
Message-ID: <20180319201644.GA25618@sigill.intra.peff.net>
References: <CAJ-HmiZFpGbe_kLUFoOibMgc2dtf=n5VXb=ReZjN2wNsja1Lrw@mail.gmail.com>
 <CAJ-HmiZtHZ0qR9KdZ5mxzok18Ad6R8zLd3xwrvt+GQHu-qDrGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-HmiZtHZ0qR9KdZ5mxzok18Ad6R8zLd3xwrvt+GQHu-qDrGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 04:14:31PM -0400, Nick Hunt wrote:

> oh, wait, switching branches didn't vaporize my changes, it auto-committed them.
> which is still weird and possibly a bug?

Are you sure that the changes were not already present on the
switched-to branch?

-Peff
