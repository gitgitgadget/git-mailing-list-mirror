Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C94E1F859
	for <e@80x24.org>; Fri,  2 Sep 2016 06:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbcIBGlr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 02:41:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:36964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750992AbcIBGlr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 02:41:47 -0400
Received: (qmail 1873 invoked by uid 109); 2 Sep 2016 06:41:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 06:41:45 +0000
Received: (qmail 22728 invoked by uid 111); 2 Sep 2016 06:41:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 02:41:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2016 02:41:44 -0400
Date:   Fri, 2 Sep 2016 02:41:44 -0400
From:   Jeff King <peff@peff.net>
To:     Arumuga <gjarms@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bitmap creation failed
Message-ID: <20160902064143.vniym6pmjsqu33lg@sigill.intra.peff.net>
References: <1472753809733-7657450.post@n2.nabble.com>
 <20160902010900.yvsrwe3tkq3fmvea@sigill.intra.peff.net>
 <CAJ23aQE2YsizuKywGmKn83jspL0JZin93drPc=QzFLo+hp8EwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ23aQE2YsizuKywGmKn83jspL0JZin93drPc=QzFLo+hp8EwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2016 at 12:04:54PM +0530, Arumuga wrote:

> So I understand now, the following.
> 
> 1. reducing the pack file size will increase the clone time
> 2. Single pack file is expected to better use bitmap feature.
> 
> Am i correct ?

Yes, on both.

-Peff
