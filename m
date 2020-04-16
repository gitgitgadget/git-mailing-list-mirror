Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C5BC2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4D9206D5
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgDPVa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:30:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:56974 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726065AbgDPVaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 17:30:25 -0400
Received: (qmail 30274 invoked by uid 109); 16 Apr 2020 21:30:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Apr 2020 21:30:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9178 invoked by uid 111); 16 Apr 2020 21:41:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2020 17:41:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Apr 2020 17:30:09 -0400
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
Message-ID: <20200416213009.GA1721147@coredump.intra.peff.net>
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
 <20200416211208.xqnnrkvcl2jw3ejr@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416211208.xqnnrkvcl2jw3ejr@doriath>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 11:12:08PM +0200, Damien Robert wrote:

> From Junio C Hamano, Wed 15 Apr 2020 at 16:01:52 (-0700) :
> > * dr/push-remoteref-fix (2020-04-06) 2 commits
> >   (merged to 'next' on 2020-04-15 at ecf60dc488)
> >  + remote.c: fix handling of %(push:remoteref)
> >  + remote.c: fix %(push) for triangular workflows
> 
> Hi Junio,
> 
> I just sent a new version of this series, which drop the second patch for
> now. As outlined in my cover letter in
> https://public-inbox.org/git/20200406175648.25737-1-damien.olivier.robert+git@gmail.com/
> the triangular workflow patch still leaves some corner cases (and for now
> is missing reviews).
> 
> I'd prefer to fix all of them at once, rather than have an almost working
> patch. Jeff seems to be of the same opinion in
> https://public-inbox.org/git/20200406214607.GA1251506@coredump.intra.peff.net/

Yeah, I'm sorry I haven't looked at the latest revision of the series.
The security fix and some other stuff has been keeping me busy. If
somebody else has time to review, please don't wait one me. But
otherwise, it is on my list and I'll get to it eventually.

-Peff
