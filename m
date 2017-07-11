Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E41220357
	for <e@80x24.org>; Tue, 11 Jul 2017 09:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbdGKJZw (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 05:25:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:36762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752344AbdGKJZv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 05:25:51 -0400
Received: (qmail 32615 invoked by uid 109); 11 Jul 2017 09:25:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 09:25:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14439 invoked by uid 111); 11 Jul 2017 09:26:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 05:26:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 05:25:48 -0400
Date:   Tue, 11 Jul 2017 05:25:48 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
Message-ID: <20170711092548.upb3zessq6kqfhen@sigill.intra.peff.net>
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
 <99EB15B6-CAA1-4C78-88B6-C934C8FBD8F8@gmail.com>
 <20170711091108.3qj35d4yk5el5xxa@sigill.intra.peff.net>
 <A334F9D4-E884-4A8F-A0DA-C07214CF9001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A334F9D4-E884-4A8F-A0DA-C07214CF9001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 11:18:17AM +0200, Lars Schneider wrote:

> Thanks for the explanation! I looked at the Git release calendar [1] and
> realized that 2.14-rc0 is scheduled for this Thursday. My assumption was
> that either on this date 2.14 will be cut from the tip of master or master
> would not change significantly after the rc0 date until the 2.14 release.

Yeah, certainly forking off a 2.14-rc branch would be a reasonable way
to do the release management. It just happens to not be the way we do
it.

One nice thing about keeping "master" as the stabilizing
release-candidate branch is that it encourages more people to run it
(versus having people manually switch to building a 2.14-rc branch).

-Peff
