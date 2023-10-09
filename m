Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327BBCD611E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 18:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377561AbjJISeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378058AbjJISd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 14:33:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BFDA3
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 11:33:54 -0700 (PDT)
Received: (qmail 22379 invoked by uid 109); 9 Oct 2023 18:33:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 18:33:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17076 invoked by uid 111); 9 Oct 2023 18:33:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 14:33:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 14:33:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] doc/cat-file: make synopsis and description less
 confusing
Message-ID: <20231009183352.GA3270793@coredump.intra.peff.net>
References: <20231009155603.GA3251575@coredump.intra.peff.net>
 <20231009175604.2361700-1-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009175604.2361700-1-stepnem@smrk.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 07:56:04PM +0200, Štěpán Němec wrote:

> > Yup, that is a good suggestion. Do you want to wrap all of this
> > discussion up as a patch?
> 
> Certainly, here it is.  I just wanted to hash out some of the details
> first and found the plain text more fit for that purpose.

This looks good to me. Thanks for taking the time to collect and fix all
of the issues.

-Peff
