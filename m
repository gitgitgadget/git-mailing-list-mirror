Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1788201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 17:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbdBURuZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 12:50:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:59360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754279AbdBURuY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 12:50:24 -0500
Received: (qmail 20695 invoked by uid 109); 21 Feb 2017 17:50:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 17:50:23 +0000
Received: (qmail 14033 invoked by uid 111); 21 Feb 2017 17:50:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 12:50:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2017 12:50:21 -0500
Date:   Tue, 21 Feb 2017 12:50:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: Re: [PATCH v2] config: preserve <subsection> case for one-shot
 config on the command line
Message-ID: <20170221175021.znvpfvnlfjh4jsrf@sigill.intra.peff.net>
References: <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
 <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
 <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
 <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
 <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
 <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
 <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
 <20170221073813.w4zrkky2d4drnwbs@sigill.intra.peff.net>
 <xmqqino3h3zv.fsf@gitster.mtv.corp.google.com>
 <xmqqd1ebh3ak.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1ebh3ak.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 09:17:07AM -0800, Junio C Hamano wrote:

>  * Changes from v1:
> 
>    - update the comment before the second loop to find the last
>      dot.
> 
>    - move two new tests into existing t1300 (at least for now).
> 
>    - make it clear that the second of the new tests check two
>      aspects of "three level vars" by setting up the expectation for
>      the first half near the actual tests and adding comments on
>      what it tests before the second half.

Thanks, this addresses all of my (admittedly minor) concerns.

-Peff
