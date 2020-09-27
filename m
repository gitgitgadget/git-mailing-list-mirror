Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A3DC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1C523977
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgI0Ipg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:45:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:42464 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgI0Ipg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:45:36 -0400
Received: (qmail 29251 invoked by uid 109); 27 Sep 2020 08:45:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:45:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4231 invoked by uid 111); 27 Sep 2020 08:45:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:45:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:45:35 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Inclusive naming, part II
Message-ID: <20200927084535.GB2465822@coredump.intra.peff.net>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
 <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
 <20200921222458.GB3533110@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009260629120.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009260629120.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 26, 2020 at 06:29:50AM +0200, Johannes Schindelin wrote:

> > Thanks, I think that does look nicer. Shouldn't the latter bullet apply
> > to most of the ones in patch 4, though?
> >
> > I wonder if they should simply be "s/master/topic/" instead of
> > "s/master/main".
> 
> Yes! I did that in 4/5. In 5/5, we need a branch name that starts with the
> same two letters as `maint`, though. I amended the commit message
> accordingly.

That makes sense, and your commit message is clear. All of your v3 looks
good to me. Thanks for your patience on these rather tedious changes. :)

-Peff
