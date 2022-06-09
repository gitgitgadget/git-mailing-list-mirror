Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97671C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 15:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbiFIPHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbiFIPHN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 11:07:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3486139D96E
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 08:07:11 -0700 (PDT)
Received: (qmail 11212 invoked by uid 109); 9 Jun 2022 15:07:11 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jun 2022 15:07:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 9 Jun 2022 11:07:10 -0400
From:   Jeff King <peff@peff.net>
To:     rsbecker@nexbridge.com
Cc:     "'R. Diez'" <rdiez1999@gmail.com>, git@vger.kernel.org
Subject: Re: How to watch files in a Git repository
Message-ID: <YqIMno8xpZdOk7SV@coredump.intra.peff.net>
References: <68627d29-8ffd-2e22-46ca-c28c9e980177@gmail.com>
 <YqE27RU45kjNRwxf@coredump.intra.peff.net>
 <007301d87bc8$69608b00$3c21a100$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <007301d87bc8$69608b00$3c21a100$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 09, 2022 at 02:16:03AM -0400, rsbecker@nexbridge.com wrote:

> I am unsure this solves the question. Is the OP looking for anyone who
> modifies any set or subset of files in any clone or in the upstream
> repo? This is generally considered a "watch" function and is sometimes
> available on the upstream repo manager, like GitHub/GitLab/BitBucket
> rather than in core git, so take into account changes made anywhere.

In the original message the OP said they wanted to watch repos to which
they only have read access. So I think any solution has to be "fetch and
check for changes".

-Peff
