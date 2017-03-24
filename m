Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257E71FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935497AbdCXSQZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:16:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:51173 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934600AbdCXSQU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:16:20 -0400
Received: (qmail 21036 invoked by uid 109); 24 Mar 2017 18:16:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 18:16:15 +0000
Received: (qmail 26915 invoked by uid 111); 24 Mar 2017 18:16:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 14:16:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 14:16:13 -0400
Date:   Fri, 24 Mar 2017 14:16:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170324181613.beivhhmfug324dc4@sigill.intra.peff.net>
References: <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
 <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
 <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
 <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net>
 <20170322225108.wub4bmr63hk2sp33@LykOS.localdomain>
 <xmqqfui3ac2f.fsf@gitster.mtv.corp.google.com>
 <20170323234922.ot2vqblcnljacdtn@sigill.intra.peff.net>
 <xmqqlgru8vyt.fsf@gitster.mtv.corp.google.com>
 <20170324164943.7vvtcj5sqadj625o@sigill.intra.peff.net>
 <xmqqvaqy7dqs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvaqy7dqs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 11:04:27AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It seems like t7030 should just skip_all when the GPG prereq is not
> > met (it's not wrong to mark each test that's added, but it would have
> > made this particular mistake harder).
> 
> I'd leave that to be done by others after the dust settles ;-).
> 
> Here is what I have right now (proposed log message has updates to
> match rather obvious changes to the tests).

Thanks, this looks good to me.

-Peff
