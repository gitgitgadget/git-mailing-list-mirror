Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08EA61F453
	for <e@80x24.org>; Fri, 21 Sep 2018 02:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeIUIVn (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 04:21:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727141AbeIUIVn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 04:21:43 -0400
Received: (qmail 25141 invoked by uid 109); 21 Sep 2018 02:35:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 02:35:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 748 invoked by uid 111); 21 Sep 2018 02:34:59 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Sep 2018 22:34:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2018 22:35:04 -0400
Date:   Thu, 20 Sep 2018 22:35:04 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Add an EditorConfig file
Message-ID: <20180921023503.GA29606@sigill.intra.peff.net>
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
 <xmqqtvmm42es.fsf@gitster-ct.c.googlers.com>
 <20180920000013.GZ432229@genre.crustytoothpaste.net>
 <CAPig+cTQuwMDMpHe4inO61=Mq2+q1OdGsEG_hpii+dNmjXHZLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTQuwMDMpHe4inO61=Mq2+q1OdGsEG_hpii+dNmjXHZLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 10:26:47PM -0400, Eric Sunshine wrote:

> On Wed, Sep 19, 2018 at 8:00 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > (I am having trouble getting make style to work, though, because it
> > seems to invoke clang-format as a git subcommand, and I don't think that
> > works.  I may send a patch.)
> 
> You're probably missing this piece:
> https://llvm.org/svn/llvm-project/cfe/trunk/tools/clang-format/git-clang-format

I've been confused by this, too. In Debian they ship it with the version
number. E.g., /usr/bin/git-clang-format-7, which is a symlink to
/usr/lib/llvm-7/bin/git-clang-format.

We might want a Makefile variable to let you override this path (I think
I just ended up putting another symlink in ~/local/bin).

-Peff
