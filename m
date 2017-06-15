Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631731FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 08:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbdFOImv (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 04:42:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:40537 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdFOImu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 04:42:50 -0400
Received: (qmail 5709 invoked by uid 109); 15 Jun 2017 08:42:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 08:42:49 +0000
Received: (qmail 21103 invoked by uid 111); 15 Jun 2017 08:42:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 04:42:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 04:42:48 -0400
Date:   Thu, 15 Jun 2017 04:42:48 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
Message-ID: <20170615084248.elfsh4of5qdsk3pa@sigill.intra.peff.net>
References: <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
 <1497084241.8531.2.camel@gmail.com>
 <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
 <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
 <1497255003.1718.1.camel@gmail.com>
 <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
 <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net>
 <xmqqshj4nb9u.fsf@gitster.mtv.corp.google.com>
 <20170612213759.f2scl3r46vboolna@sigill.intra.peff.net>
 <1497514760.2394.6.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1497514760.2394.6.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 01:49:20PM +0530, Kaartic Sivaraam wrote:

> What about, "not making any assumptions" about what the user would
> think when he views the output of `git status` ? Why not try some
> general messages like, 
> 
> * Staged changes
> * Unstaged changes
> 
> instead of the messages such as 
> 
> * Changes to be committed, Changes already in the index
> * Changes not staged for commit, Changes not yet in the index
> 
> which seem to make assumptions about the user who view the output ?

Saying just "staged changes" is definitely accurate. I don't know if
some users would find that too terse, too. The phrase "not staged for
commit" gives more information if you don't know what "staged" means in
the Git world.

-Peff
