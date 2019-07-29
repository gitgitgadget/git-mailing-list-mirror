Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95051F462
	for <e@80x24.org>; Mon, 29 Jul 2019 22:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfG2W3C (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 18:29:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:54866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727202AbfG2W3C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 18:29:02 -0400
Received: (qmail 29179 invoked by uid 109); 29 Jul 2019 22:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jul 2019 22:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1615 invoked by uid 111); 29 Jul 2019 22:30:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2019 18:30:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jul 2019 18:29:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christopher Head <bugs@chead.ca>, git@vger.kernel.org
Subject: Re: Push force-with-lease with multi-URL remote
Message-ID: <20190729222900.GA8665@sigill.intra.peff.net>
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
 <20190729102009.GC2755@sigill.intra.peff.net>
 <xmqq7e81vuc3.fsf@gitster-ct.c.googlers.com>
 <20190729192040.GD14943@sigill.intra.peff.net>
 <xmqqwog0tt27.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwog0tt27.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 02:44:00PM -0700, Junio C Hamano wrote:

> > Hmm, true. I'd almost argue that --force-with-lease, at least in its
> > default mode with no explicit lease source specified, should allow an
> > update from X to Y to be a successful noop if the remote "somehow"
> > already moved to Y.
> 
> I've already written the --force-with-lease that expects what you
> have on your remote-tracking branch off as a gross misdesign that
> should be deprecated in the longer term; I do not have a strong
> opinion on the tweaks to be done to the feature until it gets
> dropped ;-)

Well, that part I certainly agree with. ;)

-Peff
