Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73BD20954
	for <e@80x24.org>; Mon,  4 Dec 2017 17:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdLDRc0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 12:32:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:47652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751283AbdLDRc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 12:32:26 -0500
Received: (qmail 1212 invoked by uid 109); 4 Dec 2017 17:32:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 17:32:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24958 invoked by uid 111); 4 Dec 2017 17:32:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 12:32:46 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 12:32:23 -0500
Date:   Mon, 4 Dec 2017 12:32:23 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171204173223.GF13332@sigill.intra.peff.net>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-3-lars.schneider@autodesk.com>
 <20171130205137.GC3313@sigill.intra.peff.net>
 <xmqqvahojssu.fsf@gitster.mtv.corp.google.com>
 <D3A5C7E6-A63C-431C-97B5-070632EE3540@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D3A5C7E6-A63C-431C-97B5-070632EE3540@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 03, 2017 at 01:47:04PM +0100, Lars Schneider wrote:

> I am on the fence here. I like consistency but I don't want to
> bother Git users.
> 
> @Peff: Do you lean into either direction? Could you imagine that
> novice/regular users are bothered? (I don't expect experts to be
> bothered too much as they would likely be able to find and set 
> the advice config).

I also am on the fence, and am OK with any of the options discussed.

But now I've said my reservations on the list, so I can say "I told you
so" if people complain (and naturally refuse to admit my objections if
people love it). :)

-Peff
