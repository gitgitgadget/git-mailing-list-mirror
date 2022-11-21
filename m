Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48FFC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 19:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiKUTNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiKUTNC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 14:13:02 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D142649B
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:13:01 -0800 (PST)
Received: (qmail 12492 invoked by uid 109); 21 Nov 2022 19:13:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 19:13:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26552 invoked by uid 111); 21 Nov 2022 19:13:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 14:13:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 14:13:00 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] lib-httpd: extend module location auto-detection
Message-ID: <Y3vNvGI4fXun4m5O@coredump.intra.peff.net>
References: <pull.1426.git.1668999695898.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1426.git.1668999695898.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 03:01:35AM +0000, Eric Sunshine via GitGitGadget wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> Although it is possible to manually set LIB_HTTPD_PATH and
> LIB_HTTPD_MODULE_PATH to point at the location of `httpd` and its
> modules, doing so is cumbersome and easily forgotten. To address this,
> 0d344738dc (t/lib-http.sh: Restructure finding of default httpd
> location, 2010-01-02) enhanced lib-httpd.sh to automatically detect the
> location of `httpd` and its modules in order to facilitate out-of-the-
> box testing on a wider range of platforms. Follow that lead by further
> enhancing it to automatically detect the `httpd` modules on Void Linux,
> as well.

Yeah, this makes perfect sense. There is really no downside to checking
in more places. :)

-Peff
