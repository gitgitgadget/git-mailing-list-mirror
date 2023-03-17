Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A2C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 21:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCQVNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCQVNp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 17:13:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0E113DB
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 14:13:38 -0700 (PDT)
Received: (qmail 26534 invoked by uid 109); 17 Mar 2023 21:13:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Mar 2023 21:13:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28736 invoked by uid 111); 17 Mar 2023 21:13:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Mar 2023 17:13:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Mar 2023 17:13:36 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/4] mailmap: drop debugging code
Message-ID: <ZBTYABsQUOCZ2mMe@coredump.intra.peff.net>
References: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
 <ZBS8illla36MVppa@coredump.intra.peff.net>
 <CAPig+cQ9MNjEFHA07CM+c+qfTzNm99D=npLPD9qY079kkCzH6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ9MNjEFHA07CM+c+qfTzNm99D=npLPD9qY079kkCzH6g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 04:08:43PM -0400, Eric Sunshine wrote:

> > In 2013, when somebody fixed some compilation errors in the conditional
> > code (presumably because they used it while making other changes):
> >
> >   https://lore.kernel.org/git/1373871253-96480-1-git-send-email-sunshine@sunshineco.com/
> >
> > And finally it seemed to have been useful to somebody in 2021:
> >
> >   https://lore.kernel.org/git/87eejswql6.fsf@evledraar.gmail.com/
> 
> Nit: s/2021/2020/

Oops. I'm not sure how I bungled that. :)

> > I'm cc-ing folks from those earlier threads. If somebody really wants to
> > salvage it, I can prepare a patch converting it to a trace variable
> > instead, but absent any outcry, I'd go with this approach.
> 
> As one of the mentioned anonymous "sombody"s, I have no objection.

Thanks!

-Peff
