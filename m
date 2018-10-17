Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F194C1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 08:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJQQR6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 12:17:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:43172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726691AbeJQQR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 12:17:57 -0400
Received: (qmail 15903 invoked by uid 109); 17 Oct 2018 08:23:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 08:23:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18137 invoked by uid 111); 17 Oct 2018 08:22:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 04:22:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 04:23:22 -0400
Date:   Wed, 17 Oct 2018 04:23:22 -0400
From:   Jeff King <peff@peff.net>
To:     Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Typo `dashes ?` -> `dashes?`
Message-ID: <20181017082321.GA31932@sigill.intra.peff.net>
References: <01020166741c381f-bd183f7f-725d-4b4f-9f5f-804560b2b00b-000000@eu-west-1.amazonses.com>
 <20181015172041.GC1301@sigill.intra.peff.net>
 <CAAwZSqAk+D-6y9ArT_tAychwLnNUANinLPYX-ciXJDmyv+J7FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAwZSqAk+D-6y9ArT_tAychwLnNUANinLPYX-ciXJDmyv+J7FA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 09:31:54PM +0200, Jacques Bodin-Hullin wrote:

> I've just updated the PR with the `error(` change.
> 
> Also I did the change for the question mark at the end, because you are
> right, when we read it, it sounds better.
> 
> Do I need to put back the patch in this thread? It's here:
> https://patch-diff.githubusercontent.com/raw/git/git/pull/540.patch

The commit looks good, though you may want to expand the commit message
a little (it's not really a typo, but more of a style fix).

The next step would normally be to send the patch to the list (ideally
in this thread), with "[PATCH v2]" in the subject.

It looks like you're using SubmitGit. I don't remember offhand how it
works for sending re-rolls like this, but I think it's possible. If you
run into trouble, you might try instead using GitGitGadget, which is a
similar PR->mail gateway that is a little more featureful:

  https://github.com/gitgitgadget/gitgitgadget

-Peff
