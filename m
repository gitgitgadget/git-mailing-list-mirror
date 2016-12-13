Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB86F203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934346AbcLMTNC (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:13:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:55935 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753120AbcLMTMt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:12:49 -0500
Received: (qmail 25437 invoked by uid 109); 13 Dec 2016 19:12:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 19:12:48 +0000
Received: (qmail 17641 invoked by uid 111); 13 Dec 2016 19:13:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 14:13:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 14:12:45 -0500
Date:   Tue, 13 Dec 2016 14:12:45 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/2] t5547-push-quarantine: run the path separator test
 on Windows, too
Message-ID: <20161213191245.we6422xpapfgd2gt@sigill.intra.peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
 <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 08:09:31PM +0100, Johannes Sixt wrote:

> Am 12.12.2016 um 20:53 schrieb Jeff King:
> > Johannes, please let me know if I am wrong about skipping the test on
> > !MINGW. The appropriate check there would be ";" anyway, but I am not
> > sure _that_ is allowed in paths, either.
> 
> Here is a version for Windows. I'd prefer this patch on top instead
> of squashing it into yours to keep the $PWD vs. $(pwd) explanation.
> 
> The result is the same as yours in all practical matters; but this
> version I have already tested.

Yeah, I'm happy to have this on top. The patch itself looks obviously
correct. Thanks!

-Peff
