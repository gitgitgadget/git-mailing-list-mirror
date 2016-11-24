Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21561FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 20:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941320AbcKXUnZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 15:43:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:46932 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941305AbcKXUnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 15:43:24 -0500
Received: (qmail 14596 invoked by uid 109); 24 Nov 2016 20:43:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Nov 2016 20:43:18 +0000
Received: (qmail 13451 invoked by uid 111); 24 Nov 2016 20:43:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Nov 2016 15:43:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2016 15:43:16 -0500
Date:   Thu, 24 Nov 2016 15:43:16 -0500
From:   Jeff King <peff@peff.net>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: request async autosuspend at the end of
 enumeration
Message-ID: <20161124204316.sqxjpc7uzbrzhvho@sigill.intra.peff.net>
References: <1479987242-32050-1-git-send-email-tomas.winkler@intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B5433132E@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B5433132E@hasmsx108.ger.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2016 at 04:10:49PM +0000, Winkler, Tomas wrote:

> > Cc: <stable@vger.kernel.org> # 4.4+
> 
> Looks like git send-email is not able to parse this address correctly
> though this is suggested format by Documentation/stable_kernel_rules.txt.
> Create wrong address If git parsers is used : 'stable@vger.kernel.org#4.4+' 
> 
> Something like s/#.*$// is needed before parsing Cc:

This should be fixed by e3fdbcc8e (parse_mailboxes: accept extra text
after <...> address, 2016-10-13), which will be released next week as
part of v2.11. As a workaround, you can also install the Mail::Address
perl module.  See [1] for the gory details.

-Peff

[1] http://public-inbox.org/git/41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net/
