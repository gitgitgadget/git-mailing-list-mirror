Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0D3F1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 03:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeJaMwg (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 08:52:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:33718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728467AbeJaMwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 08:52:36 -0400
Received: (qmail 6454 invoked by uid 109); 31 Oct 2018 03:56:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 03:56:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6824 invoked by uid 111); 31 Oct 2018 03:55:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Oct 2018 23:55:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2018 23:56:18 -0400
Date:   Tue, 30 Oct 2018 23:56:18 -0400
From:   Jeff King <peff@peff.net>
To:     chris via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        chris <chris@webstech.net>
Subject: Re: [PATCH 1/1] Use correct /dev/null for UNIX and Windows
Message-ID: <20181031035618.GA31247@sigill.intra.peff.net>
References: <pull.59.git.gitgitgadget@gmail.com>
 <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 11:26:36AM -0700, chris via GitGitGadget wrote:

> From: chris <chris@webstech.net>

You might want to adjust your user.name. :)

> Use File::Spec->devnull() for output redirection to avoid messages
> when Windows version of Perl is first in path.  The message 'The
> system cannot find the path specified.' is displayed each time git is
> run to get colors.

Thanks, makes sense, and the patch looks good to me.

-Peff
