Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB501F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 09:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCTJxt (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 05:53:49 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:56207 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751508AbeCTJxs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Mar 2018 05:53:48 -0400
Received: from [194.72.166.2] (helo=bokrug)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1eyDxf-0003Hh-49; Tue, 20 Mar 2018 09:53:43 +0000
Message-ID: <1521539621.2474.60.camel@hellion.org.uk>
Subject: Re: [PATCH] filter-branch: use printf instead of echo -e
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Jeff King <peff@peff.net>, CB Bailey <charles@hashpling.org>
Cc:     Michele Locati <michele@locati.it>, git@vger.kernel.org
Date:   Tue, 20 Mar 2018 09:53:41 +0000
In-Reply-To: <20180320042245.GA13302@sigill.intra.peff.net>
References: <20180319144905.11564-1-michele@locati.it>
         <20180319153945.kchupu43cpcbg25n@hashpling.org>
         <20180320042245.GA13302@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2018-03-20 at 00:22 -0400, Jeff King wrote:
> Author cc'd in case there's something more interesting going on.

That code was written years ago, if I had a good reason at the time
I've forgotten what it was and I can't think of a fresh one now.
Switching to printf seems like a reasonable thing to do.

Perhaps switch the remaining `/bin/echo` (there are two without `-e`)
uses to just `echo` for consistency with the rest of the file?

Ian.
