Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D17ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 20:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIMUkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 16:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIMUkp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 16:40:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0A171BC4
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:40:43 -0700 (PDT)
Received: (qmail 888 invoked by uid 109); 13 Sep 2022 20:40:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Sep 2022 20:40:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27072 invoked by uid 111); 13 Sep 2022 20:40:43 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Sep 2022 16:40:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Sep 2022 16:40:41 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] chainlint: colorize problem annotations and test
 delimiters
Message-ID: <YyDqycOlUYJO3332@coredump.intra.peff.net>
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
 <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2022 at 04:01:47AM +0000, Eric Sunshine via GitGitGadget wrote:

>     Reverse video certainly makes the "?!FOO?!" annotations pop out and draw
>     the reader's attention. I find that I don't have a strong preference
>     between this version and v1 which merely used bold-red, but I suspect
>     that v2 with its reverse video is probably the better approach.

I find this one slightly uglier, but they are equally
attention-grabbing. And as I hope to rarely see them in the first place,
I am fine either way. :)

Thanks again for adding this.

-Peff
