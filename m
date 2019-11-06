Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790B51F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfKFE2H (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:28:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:40168 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725768AbfKFE2H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:28:07 -0500
Received: (qmail 17815 invoked by uid 109); 6 Nov 2019 04:28:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Nov 2019 04:28:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19676 invoked by uid 111); 6 Nov 2019 04:31:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Nov 2019 23:31:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Nov 2019 23:28:06 -0500
From:   Jeff King <peff@peff.net>
To:     Nathan Stocks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nathan Stocks <cleancut@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] t: fix typo in test descriptions
Message-ID: <20191106042806.GF4307@sigill.intra.peff.net>
References: <pull.448.git.1573013889.gitgitgadget@gmail.com>
 <5729dd380708da7b40805f75c5d475ff4c0b28c5.1573013889.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5729dd380708da7b40805f75c5d475ff4c0b28c5.1573013889.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 04:18:09AM +0000, Nathan Stocks via GitGitGadget wrote:

> From: Nathan Stocks <cleancut@github.com>
> 
> Fix two test descriptions which stated "git -ls-files" when the actual
> command being tested was "git ls-files".

Thanks, this is obviously an improvement.

I was curious if there was any backstory here. They came from 54e1abce90
(Add test case for ls-files --with-tree, 2007-10-03). That was around
the time of transitioning from "git-ls-files" to "git ls-files", so
maybe that caused the confusion. :)

-Peff
