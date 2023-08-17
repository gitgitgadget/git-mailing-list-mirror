Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE1CC531DC
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 19:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354753AbjHQTrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 15:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354759AbjHQTri (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 15:47:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88882D61
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 12:47:36 -0700 (PDT)
Received: (qmail 29372 invoked by uid 109); 17 Aug 2023 19:47:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Aug 2023 19:47:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32682 invoked by uid 111); 17 Aug 2023 19:47:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Aug 2023 15:47:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Aug 2023 15:47:35 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick <patrickf3139@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Force usage of pager for diff, show, etc when piping to non-TTY
Message-ID: <20230817194735.GA3032779@coredump.intra.peff.net>
References: <CAMRL+qYYGJ-LYG8qZpJOq+_=YO_C7JSTH4TPDpbEA4fRdANP7w@mail.gmail.com>
 <20230816025715.GB2248431@coredump.intra.peff.net>
 <CAMRL+qbGBOiR49A0FDYgZJmMbsfyeTZkzVmEdrCRYEanjv195A@mail.gmail.com>
 <20230817054405.GD3006160@coredump.intra.peff.net>
 <CAMRL+qbSn058AsMW7+d1nRbt4Ao6R+BZ6HYHxDrVQhURgWoy7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMRL+qbSn058AsMW7+d1nRbt4Ao6R+BZ6HYHxDrVQhURgWoy7Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2023 at 10:06:58AM -0700, Patrick wrote:

> Just to be really clear, the filter in `interactive.diffFilter` is
> meant as a filter for transforming (think a photo filter), as opposed
> to a filter that removes elements, correct? I think that's what I got
> tripped up on when you explained the first two times.

Yes, exactly. In retrospect, the name is a little ambiguous. :)
Glad you've figured it out.

-Peff
