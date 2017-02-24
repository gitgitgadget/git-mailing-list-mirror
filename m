Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823B62022D
	for <e@80x24.org>; Fri, 24 Feb 2017 04:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdBXESQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 23:18:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:33168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbdBXESO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 23:18:14 -0500
Received: (qmail 14471 invoked by uid 109); 24 Feb 2017 04:18:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 04:18:10 +0000
Received: (qmail 11069 invoked by uid 111); 24 Feb 2017 04:18:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 23:18:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 23:18:07 -0500
Date:   Thu, 23 Feb 2017 23:18:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     bs.x.ttp@recursor.net, git@vger.kernel.org
Subject: Re: [PATCH 4/4] ident: do not ignore empty config name/email
Message-ID: <20170224041807.5g3yogfnsoqegqkl@sigill.intra.peff.net>
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
 <20170223081708.ge34zjkmpsolocqx@sigill.intra.peff.net>
 <xmqqfuj47hfk.fsf@gitster.mtv.corp.google.com>
 <20170224010823.my4wmdyezjuqajfx@sigill.intra.peff.net>
 <xmqqlgsw5iu8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgsw5iu8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 08:11:11PM -0800, Junio C Hamano wrote:

> > So I dunno. I could really go either way on it. Feel free to drop it, or
> > even move it into a separate topic to be cooked longer.
> 
> If it were 5 years ago, it would have been different, but I do not
> think cooking it longer in 'next' would smoke out breakages in
> obscure scripts any longer.  Git is used by too many people who have
> never seen its source these days.

Yeah, I have noticed that, too. I wonder if it would be interesting to
cut "weeklies" or something of "master" or even "next" that people could
install with a single click.

Of course it's not like we have a binary installer in the first place,
so I guess that's a prerequisite.

-Peff
