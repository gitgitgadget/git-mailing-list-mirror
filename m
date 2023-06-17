Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C5DEB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 05:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjFQFs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 01:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQFs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 01:48:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA1F1FF7
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 22:48:25 -0700 (PDT)
Received: (qmail 13513 invoked by uid 109); 17 Jun 2023 05:48:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jun 2023 05:48:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6881 invoked by uid 111); 17 Jun 2023 05:48:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Jun 2023 01:48:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Jun 2023 01:48:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] tests: mark as passing with SANITIZE=leak
Message-ID: <20230617054823.GG562686@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 01:27:47AM +0200, Rubén Justo wrote:

> This is the second version of this series.  However, a subset of the
> patches from the first version have already been merged to 'next'.
> Therefore, those are not included here.
> 
> These are the rest of them, which address Peff's reviews.

These all look good to me. I'd probably have split the config.c refactor
into its own commit, but I don't think it's worth going back for.

Thanks Rubén for fixing these!

-Peff
