Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7754E95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 15:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377082AbjJIP4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377080AbjJIP4H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 11:56:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603DA99
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 08:56:05 -0700 (PDT)
Received: (qmail 21364 invoked by uid 109); 9 Oct 2023 15:56:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 15:56:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15563 invoked by uid 111); 9 Oct 2023 15:56:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 11:56:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 11:56:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] doc/cat-file: clarify description regarding various
 command forms
Message-ID: <20231009155603.GA3251575@coredump.intra.peff.net>
References: <20231003082513.3003520-1-stepnem@smrk.net>
 <20231003200659.GC1562@coredump.intra.peff.net>
 <20231005132018+0200.47596-stepnem@smrk.net>
 <20231005171827.GC975921@coredump.intra.peff.net>
 <20231005194852+0200.262756-stepnem@smrk.net>
 <20231005210125.GA981206@coredump.intra.peff.net>
 <20231009103651+0200.580831-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009103651+0200.580831-stepnem@smrk.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 10:36:51AM +0200, Štěpán Němec wrote:

> > Ah, true, I was thinking that the DESCRIPTION section would be the first
> > thing users would read, but I didn't notice the headline. I agree that
> > what it says is probably sufficient (though arguably "type and size" is
> > slightly inaccurate there; I said "details" in my proposed text but
> > maybe that is too vague).
> 
> We could also leave the NAME vague(r) and put an additional sentence at
> the beginning of DESCRIPTION:

Yup, that is a good suggestion. Do you want to wrap all of this
discussion up as a patch?

-Peff
