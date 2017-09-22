Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9B8202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 04:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbdIVEXE (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 00:23:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:46606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751329AbdIVEXD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 00:23:03 -0400
Received: (qmail 27749 invoked by uid 109); 22 Sep 2017 04:23:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 04:23:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1240 invoked by uid 111); 22 Sep 2017 04:23:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 00:23:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 00:23:01 -0400
Date:   Fri, 22 Sep 2017 00:23:01 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Santos <daniel.santos@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: KDevelop developers obviously don't use git :(
Message-ID: <20170922042300.6g472aegvkxn2es2@sigill.intra.peff.net>
References: <1469bc42-0a21-8cc4-f9bb-000c3737fe19@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1469bc42-0a21-8cc4-f9bb-000c3737fe19@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2017 at 11:03:53PM -0500, Daniel Santos wrote:

> So first I need to inquire if there is a current mechanism to say "git
> status, but please fail if you're busy with a non-atomic operation".  If
> there is not one, then it would seem that there should be and how do I
> go about requesting it?

You might be interested in this patch from yesterday:

  https://public-inbox.org/git/20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net/

-Peff
