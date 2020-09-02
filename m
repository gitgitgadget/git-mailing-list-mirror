Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D594C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 00:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE0320707
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 00:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgIBAdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:33:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:47018 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBAdl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 20:33:41 -0400
Received: (qmail 30946 invoked by uid 109); 2 Sep 2020 00:33:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2020 00:33:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 883 invoked by uid 111); 2 Sep 2020 00:33:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2020 20:33:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Sep 2020 20:33:40 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] ci: fix indentation of the `ci-config` job
Message-ID: <20200902003340.GB3294015@coredump.intra.peff.net>
References: <pull.719.git.1598991568.gitgitgadget@gmail.com>
 <b5363e282f69570e34ffb806f7a62e00e39b98bc.1598991568.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5363e282f69570e34ffb806f7a62e00e39b98bc.1598991568.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 01, 2020 at 08:19:26PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The section added in e76eec35540f (ci: allow per-branch config for
> GitHub Actions, 2020-05-07) contains a `&&`-chain that connects several
> commands. The first command is actually so long that it stretches over
> multiple lines, and as per usual, the continuation lines are indented one
> more level than the first.
> 
> However, the subsequent commands in the `&&`-chain were also indented
> one more level than the first command, which was almost certainly
> unintended.

Yeah, I'm pretty sure this was unintentional in my original (and got
carried through the recent re-indentation).

-Peff
