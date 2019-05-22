Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35A71F462
	for <e@80x24.org>; Wed, 22 May 2019 04:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbfEVE5G (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 00:57:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:35732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725796AbfEVE5G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 00:57:06 -0400
Received: (qmail 15381 invoked by uid 109); 22 May 2019 04:57:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 May 2019 04:57:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20037 invoked by uid 111); 22 May 2019 04:57:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 May 2019 00:57:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 May 2019 00:57:04 -0400
Date:   Wed, 22 May 2019 00:57:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] hash-object doc: stop mentioning git-cvsimport
Message-ID: <20190522045704.GA29933@sigill.intra.peff.net>
References: <20190520215312.10363-1-avarab@gmail.com>
 <20190520215312.10363-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520215312.10363-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 11:53:10PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Remove a reference to git-cvsimport in the intro. As can be seen from
> the history of this command[1] it was originally intended for use with
> git-cvsimport, but how it uses it (and that it uses it at all) is
> irrelevant trivia at this point.

Yeah, this is definitely obscuring the main point for most readers. The
patch looks good.

-Peff
