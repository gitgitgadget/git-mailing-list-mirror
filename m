Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE522018E
	for <e@80x24.org>; Fri, 12 Aug 2016 07:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbcHLHKa (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:10:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:54027 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750922AbcHLHK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:10:29 -0400
Received: (qmail 5532 invoked by uid 109); 12 Aug 2016 07:10:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Aug 2016 07:10:28 +0000
Received: (qmail 17119 invoked by uid 111); 12 Aug 2016 07:10:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Aug 2016 03:10:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Aug 2016 03:10:27 -0400
Date:	Fri, 12 Aug 2016 03:10:27 -0400
From:	Jeff King <peff@peff.net>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v5 04/12] doc: revisions: give headings for the two and
 three dot notations
Message-ID: <20160812071026.gkpyxksl2kr3zhlv@sigill.intra.peff.net>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
 <20160812070749.2920-5-philipoakley@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160812070749.2920-5-philipoakley@iee.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 08:07:41AM +0100, Philip Oakley wrote:

> We do not quote the notation within the headings as the asciidoc ->
> docbook -> groff man viewer toolchain, particularly the docbook-groff
> step, does not cope with two font changes, failing to return the heading
> font to bold after the quotation of the notation.
> [...]
> The docbook folks have confirmed that \fP would only work across one
> level, so they cannot use it for their XSLT conversion which must be
> multi-level, so they always return to the default font.

Thanks for digging into the root cause. I think your workaround (to
avoid quoted bits in headers) is reasonable, and a rule we can keep in
mind for future patches.

-Peff
