Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537811FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753740AbdDKKzd (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:55:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:59868 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752722AbdDKKyL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:54:11 -0400
Received: (qmail 26145 invoked by uid 109); 11 Apr 2017 10:54:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:54:10 +0000
Received: (qmail 1122 invoked by uid 111); 11 Apr 2017 10:54:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:54:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:54:08 -0400
Date:   Tue, 11 Apr 2017 06:54:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] connect.c: handle errors from split_cmdline
Message-ID: <20170411105408.332krulfrbqqi42k@sigill.intra.peff.net>
References: <20170409191117.25175-1-avarab@gmail.com>
 <20170409191117.25175-3-avarab@gmail.com>
 <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
 <20170411003023.ynzc76yzdmomxthp@sigill.intra.peff.net>
 <20170411003554.2tjnn65vfco376kj@sigill.intra.peff.net>
 <CACBZZX4LxL_ZBnFwkwXSMfBPGcKvOtHe3LeMtG9n2xRqWVZBkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4LxL_ZBnFwkwXSMfBPGcKvOtHe3LeMtG9n2xRqWVZBkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 11:27:57AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Junio: If you're not in some rush to pick this up I'll take this, fix
> up a bunch of other bugs & tests failures on odd --root directories
> and submit this and Jeff's \r patch (after adding tests etc) along
> with it.

That's fine by me. We may want to pick up the segfault one separately
(though I don't think it's security-interesting).

-Peff
