Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EBAC636D3
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 02:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBKCmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 21:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBKCl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 21:41:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08222FCD6
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:41:58 -0800 (PST)
Received: (qmail 21880 invoked by uid 109); 11 Feb 2023 02:41:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Feb 2023 02:41:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30565 invoked by uid 111); 11 Feb 2023 02:41:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Feb 2023 21:41:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Feb 2023 21:41:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Blevins <wblevins001@gmail.com>, git@vger.kernel.org
Subject: Re: Unexpected (bug-like) behavior in `git ls-remote` matching.
Message-ID: <Y+cAdZTs5y0yiTkM@coredump.intra.peff.net>
References: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
 <xmqqedr0vd1l.fsf@gitster.g>
 <CALJHx12DetwZ=+aMEG6Ss4P3fMTeLN2styXuPw93C5N6yg98NA@mail.gmail.com>
 <Y+POCxHMzrZj2bwz@coredump.intra.peff.net>
 <xmqq357gt5s9.fsf@gitster.g>
 <Y+Tx3Z45SlMJqDfh@coredump.intra.peff.net>
 <xmqq357eocah.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq357eocah.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2023 at 11:43:02AM -0800, Junio C Hamano wrote:

> > But I would hold off on all of that until somebody has a concrete case
> > that shows why their preferred matching scheme is useful.
> 
> True, too.

Let's not forget to fix the documentation, though. Here's a brief
series.

  [1/2]: doc/ls-remote: cosmetic cleanups for examples
  [2/2]: doc/ls-remote: clarify pattern format

 Documentation/git-ls-remote.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-Peff
