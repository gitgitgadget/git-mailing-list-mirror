Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A0E71F859
	for <e@80x24.org>; Mon, 22 Aug 2016 19:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755309AbcHVTgq (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 15:36:46 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:37893 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755731AbcHVTgp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 15:36:45 -0400
Received: by mail-it0-f52.google.com with SMTP id n128so97718045ith.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mBQWp2J3KRigOcjxzwnvEsAo3gX+iNPd6oud2V1No4E=;
        b=npD+F/JY+zn9HLKXaOyoES34byi7DozGIAs/6wVHEqfhyCfsRnoiRxMbpUZzO98HiX
         xkmOyOKTImdwy1WFEDPAoZf1cUAI4M8ZdW3VE/vhAEuREyOkbNo2m0qTl0jwAPZqUCeB
         F/dD43US2byIt9wSZvOf+eZ/bk+mxBaL9XXTT/ntxAGG/LskiRA3deXJDiwT5jtgSInZ
         PQH8biRtpElujFTApFfOHfhARJr2gnDvK3rA3a9gkD0oJ9yvRAgeeqhdYK4W+wZa85Qp
         Ep8IamimOP0aqHrxs02oJbOTCjoh7AXt8ZeAd/oE6LyBtvpNCp74wlNqvTG+kWeRb/pl
         vOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mBQWp2J3KRigOcjxzwnvEsAo3gX+iNPd6oud2V1No4E=;
        b=NEGIw8BjrezlsIa79vpu9Id1F8OH1hA6dARwkHjT9T7XcCUoJIo6r3LXHidTXimlyF
         OKvxSnJP6Dt7aoC3ZYMQJBC1SeZdtZZZbFy0ZfbPe+1XlJsVmTag0qeuqtskor0yeoBX
         fVUYUTltLczUUY3b4lL1sfNF6igj2PnHjkNpQxA7cSfZ6cirRpqPoNi7BTvU6Z/sTFkv
         4GnKKvMkG7HQtxKf0KgfWsdDF41SbPim0d1lC6aNhjR9iFUO0SnhbwQNkw+tBaZ1dniW
         HkPDHMaIoiya+jkutwb8A5TNHHFs7GOf6EJwDg7YmSulRo+GbZVHrB1UBZai9QjYLXya
         LCkw==
X-Gm-Message-State: AEkoous6v0assR5esZxMCnjbxw9tiqwba6owl/33wizks1g2KOscs6QtduW2RWe7lsZaxOJUfaQJ5Y2l7P3l3g==
X-Received: by 10.36.149.193 with SMTP id m184mr23791752itd.94.1471894604608;
 Mon, 22 Aug 2016 12:36:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.5 with HTTP; Mon, 22 Aug 2016 12:36:44 -0700 (PDT)
In-Reply-To: <20160822191622.6cok5tbbbc3ysu6f@x>
References: <CAB2VqoZh6zZV3Lk2B7dBPVE5h6H1LCwyxWrUo4yJFhqB=hAjig@mail.gmail.com>
 <20160821020537.eiyh4vnhmnuctgtz@x> <CAB2VqoZdj1rhdt-4gUhXTAMQjJTOqCuwXiO6yfB2Fzyy_qSWHg@mail.gmail.com>
 <20160821140710.qpbm37nhhvbkmxgz@x> <CAB2Vqoa+1QKD-7zjNUJBuu2qNowgY7n9fLM77zUdzf8aJi4XaQ@mail.gmail.com>
 <20160822191622.6cok5tbbbc3ysu6f@x>
From:   Richard <richard.maw@gmail.com>
Date:   Mon, 22 Aug 2016 20:36:44 +0100
Message-ID: <CAB2VqoaG=8hJ8=FG5K_rS6rtMQhk2rEWowdMD2t5kk77SXfV2A@mail.gmail.com>
Subject: Re: Adding more namespace support to git
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 August 2016 at 20:16, Josh Triplett <josh@joshtriplett.org> wrote:
> On Mon, Aug 22, 2016 at 07:36:31PM +0100, Richard wrote:
>> On 21 Aug 2016 15:07, "Josh Triplett" <josh@joshtriplett.org> wrote:
>> > I'd like to see it work more automatically than that.  Perhaps a
>> > separate environment variable to set the client-side namespace?
>>
>> How about a config option? That could be set globally, per repository, in
>> the environment or on the command line.
>
> That might work, though you wouldn't normally want to set it globally or
> per-repository (since it affects access to a repository and you'd
> typically want to use multiple different values or it wouldn't have much
> point).

Globally is a bit contrived, but could be used to keep the top-level
namespace clean
so you might opt to default to fetching into a namespace called "main"
so that if you need to temporarily fetch into a different namespace it
wouldn't be problematic.
Perhaps it's a kernel tree from a vendor with a messy branch naming scheme
so you don't want to fetch it into your primary namespace and make it
difficult to find your branches,
but you don't know which of their branches you need until you've got them all.
So you fetch into the different namespace rather than a fresh clone
to avoid re-fetching everything (numerous alternative solutions exist)
Then once you've found out which branch you need,
you make a note, switch back to the "main" namespace and re-fetch just
that branch.

A per repository default namespace could also be useful
if an upstream repository has multiple namespaces (code vs
documentation maybe) you could fetch them all
and then switch between them when you need to work on different parts,
and if it's config rather than an environment variable it will persist
between shell sessions easier.
