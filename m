Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CCF11F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 13:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933378AbcIVNWV (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 09:22:21 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:60918
        "EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbcIVNWU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 09:22:20 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Sep 2016 09:22:20 EDT
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 8342913A0A50; Thu, 22 Sep 2016 09:15:26 -0400 (EDT)
Date:   Thu, 22 Sep 2016 09:15:26 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] docs/cvs-migration: mention cvsimport caveats
Message-ID: <20160922131526.GB6320@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
 <20160922072628.rs47hfiowtobw46s@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160922072628.rs47hfiowtobw46s@sigill.intra.peff.net>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net>:
> Back when this guide was written, cvsimport was the only
> game in town. These days it is probably not the best option.

It is absolutely not.  As I have tried to point out here before, it
is *severely* broken in its processing of branchy CVS repositories.

Nobody wanted to hear that, but it's still true. Recommending it
is irresponsible.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
