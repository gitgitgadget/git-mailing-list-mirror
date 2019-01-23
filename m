Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0A01F453
	for <e@80x24.org>; Wed, 23 Jan 2019 05:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbfAWFk3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 00:40:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:45392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725899AbfAWFk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 00:40:28 -0500
Received: (qmail 6310 invoked by uid 109); 23 Jan 2019 05:40:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Jan 2019 05:40:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15455 invoked by uid 111); 23 Jan 2019 05:40:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 23 Jan 2019 00:40:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2019 00:40:26 -0500
Date:   Wed, 23 Jan 2019 00:40:26 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?S=C3=A9rgio?= Peixoto <sergio.peixoto@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] attr: do not mark queried macros as unset
Message-ID: <20190123054026.GA19443@sigill.intra.peff.net>
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net>
 <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
 <20190118165800.GA9956@sigill.intra.peff.net>
 <20190118213458.GB28808@sigill.intra.peff.net>
 <xmqqlg3ce545.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlg3ce545.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 01:48:10PM -0800, Junio C Hamano wrote:

> > When 06a604e670 later refactored the macro code, it dropped maybe_real
> 
> I think 60a12722ac is what you meant here.

Yes indeed, too many 6's, 0's, and a's. :) I see you marked it up when
you picked up the patch. Thanks.

I should also have added:

  Reported-by: Sérgio Peixoto <sergio.peixoto@gmail.com>

to the original, if it's not too late.

-Peff
