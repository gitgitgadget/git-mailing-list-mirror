Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96C2C433E6
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 01:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8002565287
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 01:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCIBEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 20:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhCIBDw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 20:03:52 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFF6C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 17:03:51 -0800 (PST)
Received: from vapier (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id E2E4E340806;
        Tue,  9 Mar 2021 01:03:50 +0000 (UTC)
Date:   Mon, 8 Mar 2021 20:03:51 -0500
From:   Mike Frysinger <vapier@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] contrib/rebase-catchup: helper for updating old branches
Message-ID: <YEbJd3Y/8ep1d5gc@vapier>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20210308230345.28498-1-vapier@gentoo.org>
 <xmqqk0qh43ob.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0qh43ob.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08 Mar 2021 15:38, Junio C Hamano wrote:
> Mike Frysinger <vapier@gentoo.org> writes:
> > For people who want to rebase their work onto the latest branch
> > (instead of merging), but there's many conflicting changes.  This
> > allows you to address those conflicts one-by-one and work through
> > each issue instead of trying to take them all on at once.
> 
> I wonder how well this compares or complements with Michael
> Haggerty's "git imerge".

thanks, hadn't heard of that before

> > If there's no interest in merging this into contrib, then this is more spam,
> > and anyone interested can use https://github.com/vapier/git-rebase-catchup
> 
> The thinking during the past several years is that the Git ecosystem
> and userbase have grown large enough, and unlike our earlier years,
> individual add-on's like this (and "imerge" I mentioned earlier) can
> thrive without being in-tree to gain an undue exposure boost over
> its competitors, so I doubt that adding more stuff to contrib/ would
> be a good direction to go in the longer term.

i'm totally fine with "no".  thanks for the info.
-mike
