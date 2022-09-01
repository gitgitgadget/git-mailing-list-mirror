Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0744EECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 15:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiIAPuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiIAPuE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 11:50:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EC220E4
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 08:49:58 -0700 (PDT)
Received: (qmail 24693 invoked by uid 109); 1 Sep 2022 15:49:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Sep 2022 15:49:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10587 invoked by uid 111); 1 Sep 2022 15:49:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Sep 2022 11:49:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Sep 2022 11:49:57 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 3/3] add -p: ignore dirty submodules
Message-ID: <YxDUpVz6im0pcPUi@coredump.intra.peff.net>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
 <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
 <116f0cf5cabee3590957731740b33e800b762f34.1661977877.git.gitgitgadget@gmail.com>
 <YxDTrUI0kOkQr9q5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxDTrUI0kOkQr9q5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 01, 2022 at 11:45:49AM -0400, Jeff King wrote:

> On Wed, Aug 31, 2022 at 08:31:17PM +0000, Johannes Schindelin via GitGitGadget wrote:
> 
> > Thanks to alwyas running `diff-index` and `diff-files` with the
> 
> Not a big deal, but since it sounds like you're going to re-roll anyway:
> 
>   s/alwyas/always/

Doh, looks like I raced you sending the new version. :)

FWIW, the new iteration looks good to me.

-Peff
