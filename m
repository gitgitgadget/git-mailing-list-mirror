Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CADC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiKVTyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiKVTx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:53:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460EDA2897
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:53:54 -0800 (PST)
Received: (qmail 18932 invoked by uid 109); 22 Nov 2022 19:53:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Nov 2022 19:53:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6489 invoked by uid 111); 22 Nov 2022 19:53:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Nov 2022 14:53:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Nov 2022 14:53:53 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: gc/resolve-alternate-symlinks (Re: What's cooking in git.git
 (Nov 2022, #05; Tue, 22))
Message-ID: <Y30o0aHIEYRVw/pA@coredump.intra.peff.net>
References: <xmqqfseargo4.fsf@gitster.g>
 <kl6lk03merud.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kl6lk03merud.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 11:01:30AM -0800, Glen Choo wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > * gc/resolve-alternate-symlinks (2022-11-22) 1 commit
> >  - object-file: use real paths when adding alternates
> >
> >  Resolve symbolic links when processing the locations of alternate
> >  object stores, since failing to do so can lead to confusing and buggy
> >  behavior.
> >
> >  Will merge to 'next'.
> >  source: <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
> 
> I plan to do another reroll based off Ævar's feedback (thanks!), let's
> hold off on merging until then?
> 
> Separately, I'd also prefer to hear from Peff regarding my reading of
> 37a95862c6 (alternates: re-allow relative paths from environment,
> 2016-11-07) and whether we want to continue 'supporting' broken paths in
> the environment. I doubt it, but since he initially suggested it in his
> fixup patch [1], his opinon would be reassuring :)

I just left a review there. I agree with your approach, but I think
there are a few small bits that will require a re-roll.

-Peff
