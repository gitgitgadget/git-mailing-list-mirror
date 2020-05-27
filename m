Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A13C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 10:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9078207CB
	for <git@archiver.kernel.org>; Wed, 27 May 2020 10:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgE0Kcj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 May 2020 06:32:39 -0400
Received: from westphal.uberspace.de ([185.26.156.72]:55690 "EHLO
        westphal.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbgE0Kcj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 06:32:39 -0400
Received: (qmail 32697 invoked from network); 27 May 2020 10:32:37 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by westphal.uberspace.de with SMTP; 27 May 2020 10:32:37 -0000
Date:   Wed, 27 May 2020 12:32:34 +0200
From:   Merlin =?UTF-8?B?QsO8Z2U=?= <toni@bluenox07.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Question about behaviour of git-checkout --patch option
Message-ID: <20200527123234.737efc3f.toni@bluenox07.de>
In-Reply-To: <20200527080009.GB4006373@coredump.intra.peff.net>
References: <20200525221100.31d36d4d.toni@bluenox07.de>
        <20200527075648.GA4006373@coredump.intra.peff.net>
        <20200527080009.GB4006373@coredump.intra.peff.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Wed, 27 May 2020 04:00:09 -0400
Jeff King <peff@peff.net> wrote:

> Trying your case with:
> 
>   git -c add.interactive.usebuiltin=true checkout -p master .
> 
> shows that it does not list the added file at all. I suspect the form of
> the fix will be similar, but it may have to plumb through the file
> addition from the diff layer, as well.

Thanks a lot for your explanation! Good to know what's going on there.

Out of curiosity: How does the git community keep track of open bugs?
On https://git-scm.com/ I read that bug reports should be just send to
the mailing list. But if they are not fixed within a few days, wouldn't
they just get lost...?

Thanks.

-- 
Merlin Büge
