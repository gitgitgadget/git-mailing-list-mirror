Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D20A520562
	for <e@80x24.org>; Mon, 30 Oct 2017 18:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932738AbdJ3SJB (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 14:09:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:40404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932538AbdJ3SJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 14:09:00 -0400
Received: (qmail 10101 invoked by uid 109); 30 Oct 2017 18:09:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 18:09:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25603 invoked by uid 111); 30 Oct 2017 18:09:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 14:09:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Oct 2017 11:08:58 -0700
Date:   Mon, 30 Oct 2017 11:08:58 -0700
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
Message-ID: <20171030180858.e6kp5uwac3kkoaae@sigill.intra.peff.net>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
 <xmqq8tg4djkm.fsf@gitster.mtv.corp.google.com>
 <8F505EA8D16F4A0F890AE9DEEB91434B@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8F505EA8D16F4A0F890AE9DEEB91434B@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 01:26:41PM +0100, Philip Oakley wrote:

> > Totally offtopic, but is it only me who finds these "section
> > headers" in cover letters from some people irritating and/or
> > jarring?
> 
> Personally I find that, for significant patch series, that clearly breaking
> out these distinct sections is of advantage. At this stage (the very first
> patch 0/n) there is no specific conversation, so the subject line is a short
> 'hello' to the topic, and then the contributor is (it is to be hoped)
> setting out their proposal in a clear manner.
> 
> So I do like these headings for larger series, though there is some
> judgement to be made as to when the subject line alone is sufficient.

I can live with fancily-formatted cover letters. BUT. I would say if
your cover letter is getting quite long, you might consider whether some
of its content ought to be going elsewhere (either into commit messages
themselves, or into a design document or other place inside the repo).

> As a separate follow on, one thing that does annoy me is that in subsequent
> versions of the various patch series, folk tend to drop all explanation of
> why the series is of any relevance, leaving just the 'changed since last
> time' part. This means that new readers who try and pick up / review /
> contribute to a series later on in its development are not told the purpose.
> When the list is active it can, accidentally, do a disservice to the
> potential contributors who may feel that only core contributors are able to
> contribute.

I actually have the opposite opinion. I find it annoying to have to wade
through the same unchanged content for each round just to find the
little snippet of "here's what's changed".

I don't mind following a link to the previous iteration to read the
back-story if I wasn't involved (it's a good idea to do that anyway to
see what previous reviews have already discussed).

I do often just post my "v2" as a follow-up and assume people can find
the original by following the thread backwards. But I imagine that not
everybody can do so. It's probably a good practice to at least put a
link to the prior version (and also to v1 for the original motivation)
if you're not going to repeat the cover letter in full.

-Peff
