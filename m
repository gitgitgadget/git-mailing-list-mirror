Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A8C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 01:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKXBLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 20:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKXBLk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 20:11:40 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53253D9BBC
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 17:11:39 -0800 (PST)
Received: (qmail 24354 invoked by uid 109); 24 Nov 2022 01:11:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Nov 2022 01:11:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21520 invoked by uid 111); 24 Nov 2022 01:11:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Nov 2022 20:11:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Nov 2022 20:11:38 -0500
From:   Jeff King <peff@peff.net>
To:     Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v5 0/3] git-jump: support Emacs
Message-ID: <Y37Eyqxrrfe5OkTY@coredump.intra.peff.net>
References: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
 <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 07:04:10AM +0000, Yoichi NAKAYAMA via GitGitGadget wrote:

> Add an optional argument 'stdout' to print the quickfix lines to standard
> output. It can be used with M-x grep on Emacs.
> 
> Detect emacsclient by GIT_EDITOR and invoke the function. Tested with
> EDITOR="emacsclient" and EDITOR="emacsclient -t".

Thanks, this version looks fine to me. I see your response to Phillip
may result in a v6 where the loop within the emacs code is moved, but I
have no opinion on that. :) So assuming that is the only change, my
review will still stand.

-Peff
