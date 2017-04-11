Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00F91FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbdDKKca (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:32:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:59785 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753332AbdDKKbI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:31:08 -0400
Received: (qmail 23637 invoked by uid 109); 11 Apr 2017 10:31:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:31:08 +0000
Received: (qmail 786 invoked by uid 111); 11 Apr 2017 10:31:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:31:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:31:05 -0400
Date:   Tue, 11 Apr 2017 06:31:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 09/12] test-lib: rename the LIBPCRE prerequisite to PCRE
Message-ID: <20170411103105.256mhk5hwwrdswzh@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170408132506.5415-10-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:25:03PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Rename the LIBPCRE prerequisite to PCRE. This is for preparation for
> libpcre2 support, where having just "LIBPCRE" would be confusing as it
> implies v1 of the library.
> 
> None of these tests are incompatible between versions 1 & 2 of
> libpcre, it's less confusing to give them a more general name to make
> it clear that they work on both library versions.

OK. I don't think LIBPCRE is all that confusing, but it doesn't hurt to
be on the careful side.

-Peff
