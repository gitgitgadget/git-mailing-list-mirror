Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B4AC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DEF36115B
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhDHVTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:19:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53784 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232488AbhDHVTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 17:19:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 146721F4B4;
        Thu,  8 Apr 2021 21:19:05 +0000 (UTC)
Date:   Thu, 8 Apr 2021 21:19:04 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Georgios Kontaxis <geko1702+commits@99rst.org>,
        Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5] gitweb: redacted e-mail addresses feature.
Message-ID: <20210408211904.GA16486@dcvr>
References: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
 <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
 <20210329014744.GA2813@dcvr>
 <8330ef0d7195de461f961d72f90998fa.squirrel@mail.kodaksys.org>
 <20210408171648.GA7133@dcvr>
 <xmqqmtu8sd2a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtu8sd2a.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > As a data point, none of the homograph@ candidates I posted here
> > on Mar 29 have attracted any attempts on my mail server.
> 
> That is an interesting observation.  All homograph@ non-addresses,
> if a human corrected the funnies in their spelling, would have hit
> whoever handles @80x24.org mailboxes.
> 
> I take it to mean that as a future direction, replacing <redacted>
> with the obfuscated-but-readable-by-humans homographs is a likely
> improvement that would help human users while still inconveniencing
> the crawlers.  It may however need some provision to prevent casual
> end-users from cutting-and-pasting these homographs, as you said in
> your original mention of the homograph approach.

Yes, exactly.

> But other than that, does the patch look reasonable?

I only took a cursory glance at it, but v6 seemed fine.
