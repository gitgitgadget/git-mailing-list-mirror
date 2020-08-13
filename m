Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7B4C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EB4205CB
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHMRk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:40:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:58104 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHMRk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:40:28 -0400
Received: (qmail 21268 invoked by uid 109); 13 Aug 2020 17:40:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 17:40:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16832 invoked by uid 111); 13 Aug 2020 17:40:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 13:40:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 13:40:27 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/5] Makefile: drop builtins from MSVC pdb list
Message-ID: <20200813174027.GB1598703@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145719.GA891370@coredump.intra.peff.net>
 <20200813150428.GA2244@syl.lan>
 <20200813150828.GA891963@coredump.intra.peff.net>
 <f8b7889a-ea1b-702c-acd4-1eb79e445197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8b7889a-ea1b-702c-acd4-1eb79e445197@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 12:37:40PM -0400, Derrick Stolee wrote:

> We create PDBs for our microsoft/git installers, such as in this
> recent build: [1]
> 
> [1] https://dev.azure.com/gvfs/ci/_build/results?buildId=18994&view=artifacts&type=publishedArtifacts
> 
> Unzipping, I see PDBs for the git-* files listed in this command,
> minus the ones that don't exist. So if this line is what creates
> the PDBs, then it is not erroring out when trying to create the
> PDBs for commands that don't exist.

Ah, thanks for the explanation. The good news is that this list should
be up to date after my series. ;)

-Peff
