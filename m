Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B13C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04B22081E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAFVXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:23:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:58250 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726683AbgAFVXo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 16:23:44 -0500
Received: (qmail 3236 invoked by uid 109); 6 Jan 2020 21:23:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Jan 2020 21:23:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25292 invoked by uid 111); 6 Jan 2020 21:29:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2020 16:29:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Jan 2020 16:23:43 -0500
From:   Jeff King <peff@peff.net>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     John Lin <johnlinp@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Reduction in blanks in `git status` makes output pretty cramped
Message-ID: <20200106212343.GC980197@coredump.intra.peff.net>
References: <CA+dzEB=m94egho+1UOGeDSFjjzwXYA-HncM-9C7NLLP=E3U2Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+dzEB=m94egho+1UOGeDSFjjzwXYA-HncM-9C7NLLP=E3U2Jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 31, 2019 at 03:18:17PM -0800, Anthony Sottile wrote:

> This is a comment on 7b098429355bb3271f9ffdf73b97f2ef82794fea
> 
> https://github.com/git/git/commit/7b098429355bb3271f9ffdf73b97f2ef82794fea

I don't have much of an opinion myself (I didn't even notice, as I think
it only affects the case where advice.statusHints is enabled). But
there's more discussion in this thread:

  https://lore.kernel.org/git/20190430060210.79610-1-johnlinp@gmail.com/

about whether to add or remove blank lines. ;)

+cc people who expressed opinions there
