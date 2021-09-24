Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D6FC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D90C61251
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbhIXRzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:55:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:54574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344909AbhIXRzt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 13:55:49 -0400
Received: (qmail 18964 invoked by uid 109); 24 Sep 2021 17:54:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 17:54:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10583 invoked by uid 111); 24 Sep 2021 17:54:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 13:54:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 13:54:13 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
Subject: Re: [PATCH 2/3] ls-remote: remove documentation for custom -h option
Message-ID: <YU4QxcORBBR01iV8@coredump.intra.peff.net>
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net>
 <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
 <patch-2.3-32b8dbecfe0-20210924T164820Z-avarab@gmail.com>
 <20210924171113.GA3311029@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210924171113.GA3311029@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 07:11:13PM +0200, SZEDER Gábor wrote:

> > diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> > index 492e573856f..6e241640bd9 100644
> > --- a/Documentation/git-ls-remote.txt
> > +++ b/Documentation/git-ls-remote.txt
> > @@ -21,7 +21,6 @@ commit IDs.
> >  
> >  OPTIONS
> >  -------
> > --h::
> 
> The description of this option contains the following:
> 
>   Note that git ls-remote -h used without anything else on the command
>   line gives help, consistent with other git subcommands.

Yup. That comes from this thread discussing an identical patch:

  https://lore.kernel.org/git/b0397b3285eab3448a3fd5dd2c50abb9@pascalroeleven.nl/

which in turn references more discussion of this behavior:

  https://lore.kernel.org/git/xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com/

It's gross and weird, but kept for backwards compatibility.

-Peff
