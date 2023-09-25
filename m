Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95771CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 12:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjIYMOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 08:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjIYMOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 08:14:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C710B
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 05:13:54 -0700 (PDT)
Received: (qmail 5002 invoked by uid 109); 25 Sep 2023 12:13:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Sep 2023 12:13:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12675 invoked by uid 111); 25 Sep 2023 12:13:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Sep 2023 08:13:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Sep 2023 08:13:52 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/6] coverity: allow running on macOS
Message-ID: <20230925121352.GC1623701@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <782cf2b440313fcad0492ee352fa66d1a3534ac4.1695379323.git.gitgitgadget@gmail.com>
 <20230923070647.GB1471672@coredump.intra.peff.net>
 <736713f0-ec71-0270-fab7-9300b09ad4ea@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <736713f0-ec71-0270-fab7-9300b09ad4ea@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 01:52:52PM +0200, Johannes Schindelin wrote:

> > > For completeness' sake, let's add support for submitting macOS builds to
> > > Coverity Scan.
> >
> > I don't have any real problem with this, and it will check a few extra
> > bits of platform-specific code not covered elsewhere.
> 
> Just to make sure: The patch series, as presented here, will only build on
> `ubuntu-latest` by default, unless that is specifically overridden in the
> repository variables of `git/git`. It makes most sense to me that way.

Yeah, that makes sense to me, too. But then I wondered why we have this
macOS code if nobody is going to run it. On the other hand, maybe it
eventually will come in handy, and you already did the work, and it is
not hurting anybody in the meantime.

-Peff
