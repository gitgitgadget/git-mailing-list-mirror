Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5DCC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E210164EAC
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhBIQ67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:58:59 -0500
Received: from cpanel8.indieserve.net ([199.212.143.3]:56654 "EHLO
        cpanel8.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhBIQ66 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 11:58:58 -0500
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:56806 helo=fedora)
        by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1l9WL8-0000Vt-Ea; Tue, 09 Feb 2021 11:58:15 -0500
Date:   Tue, 9 Feb 2021 11:58:10 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
To:     Jeff King <peff@peff.net>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how to most effectively cherry pick by selective patch hunk?
In-Reply-To: <YCK6w/VbfUtM68Ad@coredump.intra.peff.net>
Message-ID: <4fe5247a-96d6-c4a-97f8-9ede175adf90@crashcourse.ca>
References: <566b38df-307c-f342-b583-3a50a81b5057@crashcourse.ca> <YCK6w/VbfUtM68Ad@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 9 Feb 2021, Jeff King wrote:

> On Tue, Feb 09, 2021 at 08:58:06AM -0500, Robert P. J. Day wrote:
>
> >   what would be great is some sort of "-p" (patch selection) option
> > with cherry-pick, but i don't see that.
>
> We have "checkout -p", but of course the problem there is that it's
> picking out of the whole state of that commit. So you might see
> other changes not introduced by that commit.

  this is probably what i'll use since i can use <pathspec> to grab
only the patch file from that commit, then add and commit it manually
from there.

rday
