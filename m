Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797E4E7E643
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 14:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjIZOpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 10:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbjIZOpX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 10:45:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A94FE6
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 07:45:17 -0700 (PDT)
Received: (qmail 19290 invoked by uid 109); 26 Sep 2023 14:45:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Sep 2023 14:45:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25738 invoked by uid 111); 26 Sep 2023 14:45:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Sep 2023 10:45:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Sep 2023 10:45:15 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/6] coverity: allow overriding the Coverity project
Message-ID: <20230926144515.GB1897653@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <6c1c82862814f40a408231cb249fb4b653276b52.1695379323.git.gitgitgadget@gmail.com>
 <20230923070019.GD1469941@coredump.intra.peff.net>
 <a839daf1-9e32-96f8-4eab-7c845e128488@gmx.de>
 <20230925121157.GB1623701@coredump.intra.peff.net>
 <4e0f404e-0c49-b085-c35d-be53b0381402@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e0f404e-0c49-b085-c35d-be53b0381402@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 04:02:27PM +0200, Johannes Schindelin wrote:

> > > > This may not matter all that much, because I don't expect most
> > > > people to set this up for their forks
> > >
> > > Except, of course, Git for Windows. And that has been the entire
> > > motivation for me to work on this here patch series in the first
> > > place, so it would be rather pointless if I could not override this in
> > > the git-for-windows/git fork.
> >
> > I didn't at all mean that it should not be possible to override it.
> 
> Aha! The "This" in "This may not matter all that much" was referring to
> the `git` instead of the `COVERITY_PROJECT` part. That had not been clear
> to me.

I think we are on the same page now, but I wanted to elaborate here
because this miscommunication interested me. The "this" in what I wrote
was actually the "X" in:

  This may not matter because of $FOO, but X.

The X got snipped in what you quoted, but was "But I just wondered if a
better default would would be...". I certainly did not help with
readability by inserting a huge parenthetical phrase and putting in a
full-stop and starting the new sentence on "But" (my ninth grade English
teacher would be horrified).

I mention it mostly as a note to myself about trying to make sure I keep
my writing clear and readable (and a cautionary tale for others!).

-Peff
