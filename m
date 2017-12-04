Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA4320C13
	for <e@80x24.org>; Mon,  4 Dec 2017 17:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdLDRZO (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 12:25:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:47574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751821AbdLDRZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 12:25:07 -0500
Received: (qmail 887 invoked by uid 109); 4 Dec 2017 17:25:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 17:25:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24867 invoked by uid 111); 4 Dec 2017 17:25:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 12:25:27 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 12:25:04 -0500
Date:   Mon, 4 Dec 2017 12:25:04 -0500
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171204172504.GC13332@sigill.intra.peff.net>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-3-lars.schneider@autodesk.com>
 <20171130205137.GC3313@sigill.intra.peff.net>
 <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com>
 <20171201182924.GB27688@sigill.intra.peff.net>
 <aacb7604-edc3-a920-da43-701b57045956@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aacb7604-edc3-a920-da43-701b57045956@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 02, 2017 at 09:15:49AM +0530, Kaartic Sivaraam wrote:

> > Or given that the goal is really just making it clear that we've spawned
> > an editor, something like "starting editor %s..." would work.
> 
> There was already discussion related to the "continuous tense" used in the
> phrase.
> 
> Extract from [1]:

Thanks, I missed that one. I agree with the argument there.

-Peff
