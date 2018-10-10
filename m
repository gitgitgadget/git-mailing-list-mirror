Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31DD1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 20:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeJKETh (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:19:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:36054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725930AbeJKETh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:19:37 -0400
Received: (qmail 7652 invoked by uid 109); 10 Oct 2018 20:55:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Oct 2018 20:55:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21709 invoked by uid 111); 10 Oct 2018 20:54:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 16:54:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 16:55:42 -0400
Date:   Wed, 10 Oct 2018 16:55:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] i18n: remote.c: mark error(...) messages for
 translation
Message-ID: <20181010205542.GC12949@sigill.intra.peff.net>
References: <20181010104145.25610-1-avarab@gmail.com>
 <20181010104145.25610-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010104145.25610-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 10:41:44AM +0000, Ævar Arnfjörð Bjarmason wrote:

> Mark up the error(...) messages in remote.c for translation. The likes
> of "unable to push to unqualified destination" are relatively big
> parts of the UI, i.e. error messages shown when "git push" fails.
> 
> I don't think any of these are plumbing, an the entire test suite
> passes when running the tests with GIT_GETTEXT_POISON=1 (after
> building with GETTEXT_POISON).

So obviously the second patch is much more interesting, and I focused
most of my comments there. ;)

But this one seems like an obvious improvement.

-Peff
