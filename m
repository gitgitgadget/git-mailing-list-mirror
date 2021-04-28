Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6DEC433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BDA613C0
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhD1HGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:06:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37228 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1HGD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 03:06:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 34F921F5AE;
        Wed, 28 Apr 2021 07:05:19 +0000 (UTC)
Date:   Wed, 28 Apr 2021 07:05:19 +0000
From:   Eric Wong <e@80x24.org>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
Message-ID: <20210428070519.GA13114@dcvr>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YHhfsqfTJ9NzRwS1@C02YX140LVDN.corpad.adbkng.com>
 <20210419025754.GA26065@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419025754.GA26065@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Son Luong Ngoc <sluongng@gmail.com> wrote:
> > 3. Isssue with archive:
> > 
> > - I don't find the ML archive trivial for new comers.  It took me a bit
> >   of time to realize: 'Oh if I scroll to bottom and find the "Thread 
> >   overview" then I can navigate a mailing thread a lot easier'.
> 
> (I'm the maintainer of public-inbox, the archival software you
> seem to be referring to).
> 
> I'm not sure how to make "Thread overview" easier to find
> without cluttering the display near the top.  Maybe I'll try
> aria labels in the Subject: link...

I think I made [thread overview] easier-to-find without adding
more clutter:

	https://public-inbox.org/meta/20210428065522.12795-1-e@80x24.org/

Not sure about title attribute or aria labels (my version of w3m
doesn't support that, yet).  Anyways, an an example of it
deployed:

	https://public-inbox.org/git/20210419025754.GA26065@dcvr/
