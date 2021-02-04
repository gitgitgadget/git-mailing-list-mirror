Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F9C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 01:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E195964F46
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 01:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhBDBXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 20:23:01 -0500
Received: from mout02.posteo.de ([185.67.36.66]:34003 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233750AbhBDBXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 20:23:00 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 114AA2400FB
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 02:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1612401722; bh=iMb85nkExp1yKuCmRYwli6I5e+qTWdRyCH3xZZUQv7Q=;
        h=Date:From:To:Cc:Subject:From;
        b=nai/O1ikfS+3uNAB40ErQL+c2PRupPV6Ji8YE5rhR+NHqoEHCvLwVsH9ACHasTDS8
         wBDRZ8y9HHeIm9GYnbOCPL9v/BkK1V4+yb8jAeILWl+0Yzw7MbkSpgL2ksabJ4dh4H
         wcnXSY7HXUY0Z8wIiygDBaEaBtFFim4cqb5r25vWyU6eRKVanGQe/eHU1dYwPcKB30
         rjcHVNWfW5uDF5i/FaKKKfEa3AFbSuGJy7DJVoWDIKxkBfnwDvZROq1VNFIJJ7mbiU
         a4S6SBGUXShrrLsVbw5YoMv7oWpbqFzdlzX9LrS735e9mQqRZrpjWU9ArISGZJTY1G
         L7zZ2X4T5PrJg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DWLPP0Ykwz9rxD;
        Thu,  4 Feb 2021 02:22:00 +0100 (CET)
Date:   Thu, 4 Feb 2021 02:21:59 +0100
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] doc/git-branch: fix awkward wording for "-c"
Message-ID: <YBtMN91HMmVE9JTe@HP>
References: <YBsQlC03pJgYUHde@coredump.intra.peff.net>
 <YBsR+DALwV4Xxgvf@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBsR+DALwV4Xxgvf@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 04:13:28PM -0500, Taylor Blau wrote:
> On Wed, Feb 03, 2021 at 04:07:32PM -0500, Jeff King wrote:
> > The description for "-c" is hard to parse. I think the big issue is lack
> > of commas, but I've also reordered the words to keep the main focus
> > point of "instead of renaming, copy" together.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> 
> Much clearer, thanks. I'm only responding to acknowledge that it reads
> more clearly to me, too.

I second that, much better. Thanks.
