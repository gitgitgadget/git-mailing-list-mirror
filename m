Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4F8201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935131AbdBQWNU (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:13:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:57494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934956AbdBQWNT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:13:19 -0500
Received: (qmail 26067 invoked by uid 109); 17 Feb 2017 22:13:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 22:13:19 +0000
Received: (qmail 6683 invoked by uid 111); 17 Feb 2017 22:13:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 17:13:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 17:13:17 -0500
Date:   Fri, 17 Feb 2017 17:13:17 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     hIpPy <hippy2981@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: git alias for options
Message-ID: <20170217221317.e5kby2jwutdznnlk@sigill.intra.peff.net>
References: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
 <CACBZZX4Zmwb8ZHGBXCpm6=yH_uxc-K1X1vv1jQ+wwnUPneqM4A@mail.gmail.com>
 <20170217204227.kreormjoo5lr6zu4@sigill.intra.peff.net>
 <CACBZZX7nJkRmSxTdvhgXz5Zuk0KeovSZM1D_eGqbBn7i20+ePQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7nJkRmSxTdvhgXz5Zuk0KeovSZM1D_eGqbBn7i20+ePQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 11:10:08PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > A first step in that direction would probably be an environment variable
> > to tell Git to suppress command-aliases. Scripts would set that to
> > ensure a more vanilla experience. It doesn't fix _existing_ scripts, but
> > if that option were introduced, then over time scripts would start to
> > use it. Then eventually it would be safe(r) to introduce something like
> > command aliases.
> 
> The most gentle first step would be to try to turn the existing config
> options where you can override cli-options into some declarative thing
> from the current ad-hoc code we have for each one.
> 
> That would be no change in behavior, but would make it easier to
> migrate more things in the future.

Yeah, I'd agree with that. It does not change anything for the users,
but it makes the implementation less annoying.

-Peff
