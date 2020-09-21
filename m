Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9EEC4727C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB01F23A63
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgIUWZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:25:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:36186 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgIUWY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:24:59 -0400
Received: (qmail 10985 invoked by uid 109); 21 Sep 2020 22:24:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Sep 2020 22:24:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26513 invoked by uid 111); 21 Sep 2020 22:25:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Sep 2020 18:25:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Sep 2020 18:24:58 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] Inclusive naming, part II
Message-ID: <20200921222458.GB3533110@coredump.intra.peff.net>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
 <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 21, 2020 at 10:01:21PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Changes since v1:
> 
>  * Instead of using the name primary for the adjustments to 
>    t/test-terminal.perl, we follow Python's lead (which uses the
>    parent/child nomenclature).
>  * The changes to t3200 no longer use variations of the name main as branch
>    names; Instead, the renamed branches are independent from any current or
>    future default branch name.

Thanks, I think that does look nicer. Shouldn't the latter bullet apply
to most of the ones in patch 4, though?

I wonder if they should simply be "s/master/topic/" instead of
"s/master/main".

-Peff
