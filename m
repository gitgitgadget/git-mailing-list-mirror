Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B666C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 11:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F4D20735
	for <git@archiver.kernel.org>; Thu,  7 May 2020 11:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgEGLqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 07:46:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:40022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725903AbgEGLqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 07:46:31 -0400
Received: (qmail 30975 invoked by uid 109); 7 May 2020 11:46:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 11:46:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16171 invoked by uid 111); 7 May 2020 11:46:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 07:46:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 07:46:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Solomon Ucko <solly.ucko@gmail.com>, git@vger.kernel.org
Subject: Re: rebase -i: quick/inline reword
Message-ID: <20200507114630.GC3027470@coredump.intra.peff.net>
References: <CANtMP6oKN6Ueu=fqFYv2VhUP5S-ifbSzPTARvbEg4eV0pcRcHw@mail.gmail.com>
 <xmqqzhak4a9o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhak4a9o.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 09:52:19PM -0700, Junio C Hamano wrote:

> Solomon Ucko <solly.ucko@gmail.com> writes:
> 
> > ... It would be much easier
> > if there were a mode where any changes to the commit titles in the list
> > modified the commits' titles. Maybe `git rebase -i --reword`?
> >
> > Any thoughts, suggestions, questions, etc.?
> 
> It is probably a bad idea, as it encourages a single-liner commit
> message without any body.

There is another legitimate use (or at least one I have wished for many
times): when manipulating the todo list in my editor to choose patches
for editing, I sometimes notice a typo in the title and correct it. And
of course that does no good, and I get annoyed. You'd think I would have
learned after all these years, but I continue to make the same mistake.
;)

I've often wished that changes there would be quietly persisted. Your
"retitle" suggestion would help, but I'd have to remember to use it (I
could equally well just remember to use "reword", which I clearly
don't).

So I've thought about suggesting this myself in the past, but I held
back for the reasons you mentioned below (i.e., that it's not a
trustworthy version of the subject in the first place).

I'm not sure if it's solvable or worth solving, but I thought I'd add my
2 cents that the _desire_ at least isn't totally without merit.

-Peff
