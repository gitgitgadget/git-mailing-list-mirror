Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A97EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 21:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjFOVVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjFOVVW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 17:21:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C02961
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 14:21:20 -0700 (PDT)
Received: (qmail 13116 invoked by uid 109); 15 Jun 2023 21:21:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jun 2023 21:21:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26361 invoked by uid 111); 15 Jun 2023 21:21:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jun 2023 17:21:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Jun 2023 17:21:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v4 0/2] credential: improvements to erase in helpers
Message-ID: <20230615212116.GA39325@coredump.intra.peff.net>
References: <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
 <pull.1525.v4.git.git.1686856773.gitgitgadget@gmail.com>
 <xmqqh6r8v3es.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6r8v3es.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2023 at 02:09:15PM -0700, Junio C Hamano wrote:

> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > M Hickford (2):
> >   credential: avoid erasing distinct password
> >   credential: erase all matching credentials
> >
> >  Documentation/git-credential.txt   |   2 +-
> >  Documentation/gitcredentials.txt   |   2 +-
> >  builtin/credential-cache--daemon.c |  17 +++--
> >  builtin/credential-store.c         |  15 +++--
> >  credential.c                       |   7 +-
> >  credential.h                       |   2 +-
> >  t/lib-credential.sh                | 103 +++++++++++++++++++++++++++++
> >  7 files changed, 128 insertions(+), 20 deletions(-)
> 
> It is helpful to reviewers to describe/summarize, in your own words,
> what changed since the previous version, in the cover letter.
> 
> The range-diff generated for the versions can serve as a good
> supporting material, and it would help you while writing that
> summary, but not a substitute for the summary.

Yeah, I agree that would have made reviewing much easier. :)

That said, I just re-reviewed the patches themselves, and everything now
looks good to me.

-Peff
