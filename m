Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85631FAFC
	for <e@80x24.org>; Sat,  4 Feb 2017 00:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbdBDAtu (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 19:49:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:48997 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753138AbdBDAtt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 19:49:49 -0500
Received: (qmail 32750 invoked by uid 109); 4 Feb 2017 00:49:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Feb 2017 00:49:49 +0000
Received: (qmail 30199 invoked by uid 111); 4 Feb 2017 00:49:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Feb 2017 19:49:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2017 01:49:45 +0100
Date:   Sat, 4 Feb 2017 01:49:45 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] document behavior of empty color name
Message-ID: <20170204004944.cnhy3lthcuocgltm@sigill.intra.peff.net>
References: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com>
 <20170201002129.xb62hmxwrzwgp6vg@sigill.intra.peff.net>
 <20170202091615.GA22337@ash>
 <20170202124238.53k74cedpp2rcmzo@sigill.intra.peff.net>
 <20170203092430.GA10987@ash>
 <20170203122859.753bexioxxkibfzb@sigill.intra.peff.net>
 <xmqqy3xnf8jm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3xnf8jm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2017 at 10:12:13AM -0800, Junio C Hamano wrote:

> > Right, I think that's the correct behavior. The empty color name is a
> > real color ("none"), and you can put it in your list just like any other
> > color.
> 
> Makes me wonder if we have a non-empty string that spells the same
> "do nothing", because ...

I don't think we do. "plain" or "none" or something would work. Or I
suppose "reset". That is not the same thing, but for practical purposes
it probably is.

> The above is just me "wondering"; I do not think what we have needs
> further tweaks--an empty after the final comma that means "do-nothing"
> is fine, I would think.

Yeah. I think doing anything more fancy opens more questions than it
answers.

-Peff
