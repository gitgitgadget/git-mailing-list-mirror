Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E84B1F859
	for <e@80x24.org>; Mon, 22 Aug 2016 20:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756049AbcHVUiG (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 16:38:06 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:26273 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755919AbcHVUiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 16:38:05 -0400
Received: from PhilipOakley ([92.22.27.170])
        by smtp.talktalk.net with SMTP
        id bvysbrNiCY8RwbvysbyLCx; Mon, 22 Aug 2016 21:38:03 +0100
X-Originating-IP: [92.22.27.170]
X-Spam: 0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=/APvtVBpJdUUAfvyVOMH7A==:117
 a=/APvtVBpJdUUAfvyVOMH7A==:17 a=5rxgeBVgAAAA:8 a=IkcTkHD0fZMA:10
 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=ufrnOf0g8FIATOeDVSwA:9
 a=PwKx63F5tFurRwaNxrlG:22 a=6kGIvZw6iX1k4Y-7sg4_:22 a=Bn2pgwyD2vrAyMmN8A2t:22
Message-ID: <B21604E7033C458EAC5EA0651CFEA8E9@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Duy Nguyen" <pclouds@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Jeff King" <peff@peff.net>, "Stefan Beller" <sbeller@google.com>,
        <meta@public-inbox.org>, <git@vger.kernel.org>,
        "Eric Wong" <e@80x24.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net> <alpine.DEB.2.20.1608221450250.4924@virtualbox> <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect core.hooksPath in --git-path]
Date:   Mon, 22 Aug 2016 21:38:07 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfKe4mGHd3V3PwoSiO7ZnKVHu5UAnunuUHheXsln1+ni014esLdxBj3gkwaUq5HsWA5kTHaKNtgRHpi6yia3daeACOHkWp0LhOYhDPrzW2RUUVN28K2GV
 9jo2KTrr8T+YdO8wyB/79v0H4pP/WZcOSM0zMKUhKepQqRCi3qZfH5ipCj22Gmk1SdpVlwHWNaDBZGn0oPpSrxphnV3ZzwTVuV9wta/VF9A0oRvJKDjBXkhN
 avhTXD/wo6EFDfFab+9Z52P4dQPetlHHodHCFfao0cfzjGqmaP0hVx4CFcNX972rzls6Xr7xI+1nPyI/FQgLAeGcKIxM+kdP5CjeoOtshZx88s08xBapvUMs
 4BTX9Icz8ipEISttQVnUwELjxH4RYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Duy Nguyen" <pclouds@gmail.com>
> On Mon, Aug 22, 2016 at 8:06 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> My point stands. We are way more uninviting to contributors than
>> necessary. And a huge part of the problem is that we require contributors
>> to send their patches inlined into whitespace-preserving mails.
>
> We probably can settle this in the next git survey with a new
> question: what's stopping you from contributing to git?
> -- 
One has to be careful that some of this is preaching to the choir.

Those who have difficulty won't be anywhere near the survey. Those that are 
near the survey will have enough nouce to contribute to the level they 
manage.

Also the argument here has started to be at cross purposes about the issues 
vs the solutions.

I do note that dscho's patches now have the extra footer (below the three 
dashes) e.g.

Published-As: https://github.com/dscho/git/releases/tag/cat-file-filters-v1
Fetch-It-Via: git fetch https://github.com/dscho/git cat-file-filters-v1

If say I used that, and sent my patch series via Outlook Express (<sigh>), 
with it's white space damage, would those footers help once the content has 
been reviewed (rather than white spacing style) in the applying the patch?

Even, Is there a way of accepting email that has HTML embedded by the 
client, rather than [vger, etc.] simply deleting the email as 'not 
acceptable'. Unless users can get past these sort of (to them) petty and 
awkward restrictions, it's going to continue to be difficult to encourage 
participation.

--

Philip

PS Sudden though about the 'Published-As: Fetch-It-Via: ' stuff. I don't 
think we have a method of 'Fetch-As-A-Series' so that what is received from 
the server (e.g. GitHub, as a git command equivalent) is just those 
patches/commits in the series, and the recipient can then see if they apply 
cleanly at the point they want to apply them? This would almost be a 'pack 
file' that is all commit deltas, that can be given to say 'rebase' (or 
'apply'). It could also be expanded back into an mbox format if required...



