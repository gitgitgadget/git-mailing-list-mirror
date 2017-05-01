Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C53571F78F
	for <e@80x24.org>; Mon,  1 May 2017 19:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdEATbC (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 15:31:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:43315 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbdEAT3p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 15:29:45 -0400
Received: (qmail 19105 invoked by uid 109); 1 May 2017 19:29:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 19:29:45 +0000
Received: (qmail 4658 invoked by uid 111); 1 May 2017 19:30:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 15:30:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 15:29:43 -0400
Date:   Mon, 1 May 2017 15:29:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (May 2017, #01; Mon, 1)
Message-ID: <20170501192942.lhed5ygwj3micjz4@sigill.intra.peff.net>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 04:25:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > * ab/grep-pcre-v2 (2017-04-25) 20 commits
> [...]
> > * ab/grep-threading-cleanup (2017-04-16) 8 commits
> [...]
> >
> >  Needs review.
> 
> Between these two series there's 27 patches, and I understand it's a
> bit of a PITA to review/get comments on it.
> 
> Anything I should be doing differently here other than just waiting
> for 2.13 to come out so they can be cooked further & merged down to
> next & then master if there's no objections?

These are both on my todo list to review. That's not a promise of
timeliness, but at least they didn't get dropped into a void. :) If you
haven't heard anything post-2.13, I think reposting them then would be
reasonable.

-Peff
