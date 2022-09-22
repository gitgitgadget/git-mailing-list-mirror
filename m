Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC8C6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 06:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIVG1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 02:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiIVG0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 02:26:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34172AF0EF
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 23:26:23 -0700 (PDT)
Received: (qmail 4846 invoked by uid 109); 22 Sep 2022 06:26:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 06:26:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30869 invoked by uid 111); 22 Sep 2022 06:26:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 02:26:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 02:26:21 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "John A. Leuenhagen" <john@zlima12.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] clone: allow "--bare" with "-o"
Message-ID: <YywADT0aHRSoDeg3@coredump.intra.peff.net>
References: <YyvzIQL9H9aTYNch@coredump.intra.peff.net>
 <YyvzVdfQVdysvMp2@coredump.intra.peff.net>
 <CAPig+cTEF=jBoW07_eLQ_BAWxULfWtehVa-JbJKpS+8rPenSiQ@mail.gmail.com>
 <Yyv+GjjauvvcX3M1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yyv+GjjauvvcX3M1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 02:18:02AM -0400, Jeff King wrote:

> And yes, I think this is a case where using the right one is important
> (which is why I used the pwd program, and not $pwd in the test).

Er, of course I meant all-caps $PWD in the final sentence. ;)

-Peff
