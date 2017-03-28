Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D8920958
	for <e@80x24.org>; Tue, 28 Mar 2017 07:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754537AbdC1HYx (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 03:24:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:52782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754313AbdC1HYw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 03:24:52 -0400
Received: (qmail 26469 invoked by uid 109); 28 Mar 2017 07:24:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 07:24:47 +0000
Received: (qmail 437 invoked by uid 111); 28 Mar 2017 07:25:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 03:25:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 03:24:46 -0400
Date:   Tue, 28 Mar 2017 03:24:46 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/21] sha1-array: convert internal storage for struct
 sha1_array to object_id
Message-ID: <20170328072445.jxqh2v2c4a7jct5f@sigill.intra.peff.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170326160143.769630-16-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170326160143.769630-16-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 04:01:37PM +0000, brian m. carlson wrote:

> Make the internal storage for struct sha1_array use an array of struct
> object_id internally.  Update the users of this struct which inspect its
> internals.

Yay. I'm happy to see all those gross (*sha1)[20] bits go away.

-Peff
