Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E60203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934600AbcLMSrI (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:47:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:55891 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932250AbcLMSrG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:47:06 -0500
Received: (qmail 23698 invoked by uid 109); 13 Dec 2016 18:47:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 18:47:05 +0000
Received: (qmail 17235 invoked by uid 111); 13 Dec 2016 18:47:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 13:47:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 13:47:02 -0500
Date:   Tue, 13 Dec 2016 13:47:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] handling alternates paths with colons
Message-ID: <20161213184702.psvwwj4rj6dnknxf@sigill.intra.peff.net>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
 <20161210085133.2pnkz6eqlxoxdckg@sigill.intra.peff.net>
 <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <xmqqvauo7p0r.fsf@gitster.mtv.corp.google.com>
 <20161213115018.quulwlheycjtlsub@sigill.intra.peff.net>
 <xmqqshpr4s41.fsf@gitster.mtv.corp.google.com>
 <20161213181755.wrgu6drm45v7xhnl@sigill.intra.peff.net>
 <xmqqbmwf4qn4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmwf4qn4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 10:42:39AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Right, but we also support relative paths via environment variables. I
> > don't think that changes the conclusion though. I'm not convinced
> > relative paths via the environment aren't slightly insane in the first
> > place,
> 
> Sorry, a triple negation is above my head.  "relative paths in env
> aren't insane" == "using relative paths is OK" and you are not
> convinced that it is the case, so you are saying that you think
> relative paths in env is not something that is sensible?

I think relative paths in env have very flaky semantics which makes them
inadvisable to use in general. That being said, when we broke even those
flaky semantics somebody complained. So I consider a feature we _do_
support, but not one I would recommend to people.

-Peff
