Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B0711F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392594AbfBNFxS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:53:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:43780 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732485AbfBNFxS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:53:18 -0500
Received: (qmail 994 invoked by uid 109); 14 Feb 2019 05:53:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:53:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6984 invoked by uid 111); 14 Feb 2019 05:53:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:53:28 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:53:16 -0500
Date:   Thu, 14 Feb 2019 00:53:16 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2019, #03; Wed, 13)
Message-ID: <20190214055315.GK20578@sigill.intra.peff.net>
References: <xmqq4l979h8d.fsf@gitster-ct.c.googlers.com>
 <20190214035944.GB7209@sigill.intra.peff.net>
 <xmqqzhqy9axy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhqy9axy.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 09:49:13PM -0800, Junio C Hamano wrote:

> > I'm not worried enough to suggest pulling it back, but it's something we
> > should keep an eye on during the -rc period.
> 
> True.  I actually think that it is probably a good idea to unleash
> this kind of thing as quickly as possible to the real world.  Those
> outside the project, or even inside it, tend to only discover issues
> after a feature release is made, so while I am generally in favor of
> merging a new and potentially disruptive change in an early batch
> after a feature release to 'master' (which would give us enough time
> to fix things up until the next release), I do not think that
> approach would help third-party interop issues very much.

Yeah, I do have the feeling that not many people really exercise our -rc
candidates. I'm not sure how to improve that. We could try to push
packagers to make them available (and I think Jonathan already does for
Debian's "experimental" track). But ultimately I think it is not a
packaging/availability question, but just that most people do not bother
until there is a real release.

-Peff
