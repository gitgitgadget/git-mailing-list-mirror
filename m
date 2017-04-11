Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299AC1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbdDKK1g (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:27:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:59763 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752232AbdDKK0R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:26:17 -0400
Received: (qmail 23152 invoked by uid 109); 11 Apr 2017 10:26:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:26:16 +0000
Received: (qmail 572 invoked by uid 111); 11 Apr 2017 10:26:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:26:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:26:13 -0400
Date:   Tue, 11 Apr 2017 06:26:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 06/12] log: add -P as a synonym for --perl-regexp
Message-ID: <20170411102613.g2twgjkcrshxdszd@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170408132506.5415-7-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:25:00PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Add a short -P option as a synonym for the longer --perl-regexp, for
> consistency with the options the corresponding grep invocations
> accept.
> 
> This was intentionally omitted in commit 727b6fc3ed ("log --grep:
> accept --basic-regexp and --perl-regexp", 2012-10-03) for unspecified
> future use.
> 
> Since nothing has come along in over 4 1/2 years that's wanted to use
> it, it's more valuable to make it consistent with "grep" than to keep
> it open for future use, and to avoid the confusion of -P meaning
> different things for grep & log, as is the case with the -G option.

Like Junio, the "well, nothing else has come along" triggered my
initial reflexes.  But I think the consistency argument you make here is
a good one. The "-P" option is tainted whether we do this or not.

-Peff
