Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156452022D
	for <e@80x24.org>; Fri, 24 Feb 2017 00:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdBXAXt (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 19:23:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:33071 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbdBXAXt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 19:23:49 -0500
Received: (qmail 31011 invoked by uid 109); 24 Feb 2017 00:16:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 00:16:04 +0000
Received: (qmail 7125 invoked by uid 111); 24 Feb 2017 00:16:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 19:16:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 19:16:02 -0500
Date:   Thu, 23 Feb 2017 19:16:02 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stefan Beller <sbeller@google.com>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] add collision-detecting sha1 implementation
Message-ID: <20170224001602.vks3lvbrbarcccmk@sigill.intra.peff.net>
References: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <20170223230536.tdmtsn46e4lnrimx@sigill.intra.peff.net>
 <CAGZ79kZHPdBTKEqJeAa5xDcsC5v9x4DdUuDOiRNSgOV5aCx9Kw@mail.gmail.com>
 <20170224000143.cate5yncjq74hsys@sigill.intra.peff.net>
 <CA+55aFx4gXEXqr-z12E4gz5fm2fye-vVio_Td7EbKxymGF2QUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFx4gXEXqr-z12E4gz5fm2fye-vVio_Td7EbKxymGF2QUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 04:12:01PM -0800, Linus Torvalds wrote:

> On Thu, Feb 23, 2017 at 4:01 PM, Jeff King <peff@peff.net> wrote:
> >
> > You know, I didn't even look at the LICENSE file, since it said MIT and
> > had a link here. It would be trivial to copy it over, too, of course.
> 
> You should do it. It's just good to be careful and clear with
> licenses, and the license text does require that the copyright notice
> and permission file should be included in copies.
> 
> My patch did it. "Pats self on head".

And that's why yours crossed the 100K barrier. :)

But yeah, I agree it is better to be safe (and that's we should contact
the authors). I'll point them out-of-band to this thread, and cc them if
it ends up being re-rolled.

-Peff
