Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68ED6207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161762AbcIZRiU (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:38:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:48219 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966666AbcIZRiS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:38:18 -0400
Received: (qmail 6248 invoked by uid 109); 26 Sep 2016 17:38:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 17:38:18 +0000
Received: (qmail 6803 invoked by uid 111); 26 Sep 2016 17:38:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 13:38:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 13:38:16 -0400
Date:   Mon, 26 Sep 2016 13:38:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
        Gustavo Grieco <gustavo.grieco@imag.fr>
Subject: Re: [PATCH] unpack_sha1_header(): detect malformed object header
Message-ID: <20160926173815.rnup2fqynrmja4x5@sigill.intra.peff.net>
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
 <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
 <xmqqshsnuvvz.fsf_-_@gitster.mtv.corp.google.com>
 <20160926140309.l2h4b65gpqyutepn@sigill.intra.peff.net>
 <xmqqfuomvdqe.fsf@gitster.mtv.corp.google.com>
 <xmqqoa3atviv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa3atviv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 10:34:32AM -0700, Junio C Hamano wrote:

> And the second one, that no longer checks SP in unpacker, looks like
> this.

This looks good from a cursory read (but I am about to go to sleep, so
might be a bit less careful than usual :) ).

-Peff
