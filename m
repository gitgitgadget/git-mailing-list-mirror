Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8D6C77B7A
	for <git@archiver.kernel.org>; Fri, 19 May 2023 00:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjESAXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 20:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjESAXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 20:23:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479C171F
        for <git@vger.kernel.org>; Thu, 18 May 2023 17:22:43 -0700 (PDT)
Received: (qmail 6241 invoked by uid 109); 19 May 2023 00:21:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 00:21:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26846 invoked by uid 111); 19 May 2023 00:21:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 20:21:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 20:21:28 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/9] fetch: use `fetch_config` to store "fetch.prune"
 value
Message-ID: <20230519002128.GD2442034@coredump.intra.peff.net>
References: <cover.1684324059.git.ps@pks.im>
 <1fa4922bea12ef0363e2638bbb5c70218c6ec357.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fa4922bea12ef0363e2638bbb5c70218c6ec357.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 01:48:56PM +0200, Patrick Steinhardt wrote:

> Move the parsed "fetch.prune" config value into the `fetch_config`
> structure. This reduces our reliance on global variables and further
> unifies the way we parse the configuration in git-fetch(1).

Makes sense, and I like the end result. Since the other patches in this
series are all variants of this, I won't bother to respond individually
to each one (though I think you were right to split them out). They all
look good to me.

-Peff
