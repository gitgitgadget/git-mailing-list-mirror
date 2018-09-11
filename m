Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F461F404
	for <e@80x24.org>; Tue, 11 Sep 2018 21:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeILCEi (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 22:04:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:46418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726870AbeILCEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 22:04:38 -0400
Received: (qmail 18624 invoked by uid 109); 11 Sep 2018 21:03:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Sep 2018 21:03:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21786 invoked by uid 111); 11 Sep 2018 21:03:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Sep 2018 17:03:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Sep 2018 17:03:30 -0400
Date:   Tue, 11 Sep 2018 17:03:30 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] trace: add trace_print_string_list_key
Message-ID: <20180911210330.GA3825@sigill.intra.peff.net>
References: <CAGZ79kbObDXyaRLADQpvMMSitOLCDwb030Q6UBiX-7Y-XWnqog@mail.gmail.com>
 <20180910215831.17608-1-sbeller@google.com>
 <xmqq36uhrnjk.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kY2XpB4nJOJc0LLueqsutpncgwdN8uC=Wj0Uxu9Yjgd8A@mail.gmail.com>
 <xmqqy3c8rh3d.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbRrPnQnPs0FX7_TeiekpmmLzDoSsQpi2fDjc-WkqBf_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbRrPnQnPs0FX7_TeiekpmmLzDoSsQpi2fDjc-WkqBf_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 08:08:35PM -0700, Stefan Beller wrote:

> > So the choice being offered are:
> >
> >  (0) take 2/2 only, keeping zero unused helper.
> >  (1) take 1/2 only, keeping two unused helpers.
> >  (2) do nothing, keeping the simple unused helper we had from the
> >      beginning of time.
> >  (3) take 1/2 and 2/2, replacing one simple unused helper with
> >      another unused helper that is more complex and capable.
> [...]
> 
> Yes, I think (0) is the way to go, actually.
> 
> I wrote patch 1/2 to show Peff and you to prove otherwise that I am
> not contributing "only grudgingly".

I am perfectly happy with 0. But for reference, your new trace helper
looks completely reasonable from a quick view. Perhaps we can let it
live on in the list archive, and somebody may find a good use for it in
the future (though there is a significant chance that they would not
think to search the archive -- it could even be of value to commit and
revert it so that they find it in "git log", but that may be getting
pretty hypothetical).

-Peff
