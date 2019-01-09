Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4521F803
	for <e@80x24.org>; Wed,  9 Jan 2019 10:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfAIK2j (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 05:28:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:58988 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729222AbfAIK2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 05:28:39 -0500
Received: (qmail 25733 invoked by uid 109); 9 Jan 2019 10:28:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Jan 2019 10:28:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20210 invoked by uid 111); 9 Jan 2019 10:28:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 09 Jan 2019 05:28:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jan 2019 05:28:37 -0500
Date:   Wed, 9 Jan 2019 05:28:37 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
Message-ID: <20190109102836.GA6743@sigill.intra.peff.net>
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 07, 2019 at 03:34:10PM -0800, Junio C Hamano wrote:

> * jk/proto-v2-hidden-refs-fix (2018-12-14) 3 commits
>  - upload-pack: support hidden refs with protocol v2
>  - parse_hide_refs_config: handle NULL section
>  - serve: pass "config context" through to individual commands
> 
>  The v2 upload-pack protocol implementation failed to honor
>  hidden-ref configuration, which has been corrected.
> 
>  Will merge to 'next'.

Sorry I didn't catch this before it hit 'next', but I think we were
planning to scrap this in favor of:

  https://public-inbox.org/git/20181218124750.GC30471@sigill.intra.peff.net/

-Peff
