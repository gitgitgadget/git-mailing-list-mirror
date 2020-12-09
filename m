Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B53C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 18:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C856423C90
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 18:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbgLISgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 13:36:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:55800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbgLISgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 13:36:14 -0500
Received: (qmail 19156 invoked by uid 109); 9 Dec 2020 18:35:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 18:35:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17671 invoked by uid 111); 9 Dec 2020 18:35:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 13:35:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 13:35:29 -0500
From:   Jeff King <peff@peff.net>
To:     Julien Richard <julien.richard@ubisoft.com>
Cc:     Julien Richard via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Julien Richard <jairbubbles@hotmail.com>
Subject: Re: [PATCH] doc: 'T' status code for git status
Message-ID: <X9EY8fBoLHIa68WY@coredump.intra.peff.net>
References: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
 <X9ELRf7s9sBcs9CD@coredump.intra.peff.net>
 <BYAPR17MB26461C4578004C8C223249DB9DCC0@BYAPR17MB2646.namprd17.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR17MB26461C4578004C8C223249DB9DCC0@BYAPR17MB2646.namprd17.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 06:01:36PM +0000, Julien Richard wrote:

>  > Perhaps "type changed (e.g., a symbolic link becoming a file)" would be more descriptive
> 
> In fact I'm not sure how get the typechange, I always see the symbolic
> link example but in my case  I have a 100% repro on a repository but
> ZI have no clue why its does so.
> The file is just modified but appears as a type change :-S
> 
> Could it be a bug?

Possibly. If you have a reproduction recipe, share it and we can comment
further.

> About the changes you mentioned should I make the adjustements myself?

Yes, usually you'd squash in any changes you want to make using "commit
--amend" (or "rebase -i", but you only have one patch in the series),
and then you can resubmit via GitGitGadget.

-Peff
