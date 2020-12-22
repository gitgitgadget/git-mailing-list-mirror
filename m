Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F97C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 23:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4184022AAF
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 23:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgLVXZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 18:25:41 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48472 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgLVXZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 18:25:41 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2020 18:25:41 EST
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id AED861F4B4;
        Tue, 22 Dec 2020 23:17:02 +0000 (UTC)
Date:   Tue, 22 Dec 2020 23:17:02 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
Message-ID: <20201222231702.GA17661@dcvr>
References: <20200901074355.GA4498@dcvr>
 <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
 <20200901144323.GA14554@dcvr>
 <xmqqbleliq58.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbleliq58.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > Thanks for the comments, will wait a few days for comments
> > before sending out v2.
> 
> This has seen some review suggestions and as far as I remember, can
> be summarised as:
> 
>  - there was a rough consensus that this was a desirable feature.
> 
>  - a one-off hardcoded list of "false" would rather want to be
>    consistent with config.c::git_parse_maybe_bool_text().
> 
>  - documentation is missing for the configuration variable.
> 
> It has been almost three months; has a v2 been posted that I missed?

Can somebody else take this over?  Sorry my brain isn't working
well these months and I'm behind on other things :<
