Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FEDC05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 11:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbjAZLaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 06:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbjAZLaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 06:30:02 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C42E5A36E
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 03:29:53 -0800 (PST)
Received: (qmail 20852 invoked by uid 109); 26 Jan 2023 11:29:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 11:29:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22713 invoked by uid 111); 26 Jan 2023 11:29:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 06:29:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 06:29:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
Message-ID: <Y9JkMLueCwjkLHOr@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com>
 <xmqqwn5bg695.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn5bg695.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2023 at 10:03:02AM -0800, Junio C Hamano wrote:

> Victoria Dye <vdye@github.com> writes:
> 
> > Matthew John Cheetham via GitGitGadget wrote:
> >> Updates in v6
> >> =============
> >> ...
> > I've re-read the patches in this version; all of my comments from v5 have
> > been addressed, and the additional updates w.r.t. other reviewer feedback
> > all look good as well. At this point, I think the series is ready for
> > 'next'.
> >
> > Thanks!
> 
> Thanks, both.  Let's merge it down.

Sorry, I'm a bit late to the party, but I left some comments just now
(this topic had been on my review backlog for ages, but I never quite
got to it).

Many of my comments were small bits that could be fixed on top (tiny
leaks, etc). But some of my comments were of the form "no, do it totally
differently". It may simply be too late for those ones, but let's see if
Matthew finds anything compelling in them.

-Peff
