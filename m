Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFA0C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED13611C1
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhIJLli (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:41:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:43776 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232885AbhIJLlf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:41:35 -0400
Received: (qmail 5431 invoked by uid 109); 10 Sep 2021 11:40:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 11:40:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23781 invoked by uid 111); 10 Sep 2021 11:40:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 07:40:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 07:40:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
Message-ID: <YTtEJ8qSEfwzYkgo@coredump.intra.peff.net>
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
 <YTOW352xtsbvJcKy@coredump.intra.peff.net>
 <20210907211128.mauwgxupbredgx7w@meerkat.local>
 <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
 <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
 <64a5aaf1-64af-3599-8520-ff3b55411e2a@gmail.com>
 <xmqqilz9ugz2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilz9ugz2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 10:39:29PM -0700, Junio C Hamano wrote:

> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
> > I agree it's nice to make it work out of the box, without the web server
> > admin having to configure anything. But, I'm not sure we should completely
> > drop the documentation patches: your patch will only affect future versions
> > of git-http-backend, and users of previous versions will be left without
> > any documentation as to how to configure it for protocol v2. So I would think we should
> > keep the documentation patches, maybe with a mention "this should not be necessary
> > in Git 2.34 and later versions" or something like that (since your
> > commit message mentions that it "generally" should work like that depending
> > on the web servers).
> 
> Thanks, exactly my thought on the need for docs.

OK. I'll try to cook something up here.

-Peff
