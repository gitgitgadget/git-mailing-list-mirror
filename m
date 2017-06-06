Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8911209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdFFSx0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:53:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:35536 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751460AbdFFSx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:53:26 -0400
Received: (qmail 21836 invoked by uid 109); 6 Jun 2017 18:53:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 18:53:25 +0000
Received: (qmail 26765 invoked by uid 111); 6 Jun 2017 18:54:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 14:54:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jun 2017 14:53:24 -0400
Date:   Tue, 6 Jun 2017 14:53:24 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        David <bouncingcats@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: What does this output of git supposed to mean ?
Message-ID: <20170606185324.ocedi4e3teqi3ayk@sigill.intra.peff.net>
References: <D0E8FF50F1E74043AA0BD71E80C365E5@PhilipOakley>
 <20170606114355.30749-1-szeder.dev@gmail.com>
 <20170606184200.4xohdrwxqqvxgkr7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170606184200.4xohdrwxqqvxgkr7@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2017 at 02:42:01PM -0400, Jeff King wrote:

> > "Waiting for initial commit" is much better even in this case, but I
> > still don't like that "initial", though I can't say why, and don't
> > have any better suggestion either.  Though users experienced enough to
> > create an empty unborn branch would probably not be confused by that.
> 
> I agree. If the state we are describing is limited to the current
> branch, how about saying so? Like "Your current branch has no commits".

Actually, something like "does not yet have any commits" might be
better.

There is a slight complication, though. There's similar text in "git
status -sb", which shows:

  ## Initial commit on master

Should that also change to use consistent terminology? If so, we need a
phrasing short phrasing that matches (and the --porcelain and
--porcelain=v2 formats of course would need to remain the same).

-Peff
