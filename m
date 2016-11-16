Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9644B2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 13:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbcKPNmf (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 08:42:35 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35669 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbcKPNmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 08:42:32 -0500
Received: by mail-yw0-f174.google.com with SMTP id i145so124552943ywg.2
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 05:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f035yeNbqehExKUt38lpB9odCYNwcWWHvuYll7/Ajsk=;
        b=yyv9UfF+4z2OiIo4Pz2Ph2su6PwAhTFhsL3NDHJ9EV/JO9J6by0N7kM4U9pMgI1Ywj
         M1kz18PQhYgGV87FrsQf1YSbPj+nrfC2neWUB4OdlDbvWtwid7qe3qVEUuZOPF9WbSmh
         z4yXE1EXhYZmVAxHwso2aJTHTqyBwQv0H2RaDSeHDzeJHgGvNbW8zQjF3Ew5hi4wBymK
         eVywO65q6vb/SWbsujBlXUKzgmIZUzi2sjBWi2HPy4ax771Iabp/mOeDraJY3EWR0XT8
         62IJNR5XRXAhVMV3eLpHV0XXvdIaC4AyNDWDrVLCbMTE/DP90hWnhoA7U+Gr6on7oIkv
         DV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f035yeNbqehExKUt38lpB9odCYNwcWWHvuYll7/Ajsk=;
        b=mHLXSqi4h83BYC7cbD8ZhT+DMuSm2yMpOTLbPwQsYkCLzB4HMSYhEXbr3uJU8R190H
         6PHxxUXDcZMwWrbBjkWO7lwl08Q+zpyJia7er4wApKll3iE8wG0BHGpy9XLNPrr7O7AG
         dFk7x1kL9G6W3l3bLL62RXd53+mt2OhTs4qAb03Y3vAVOAjAk13ih6PG3Enk4o7gnEbu
         c30SXJFBlpvxdFTcTH5IdGR3i4+sihJbp3vq3mjccAyI0GGIOVOBAUWDH0Hv1j8KOn72
         FgtLoU5/WuNKptyMLE/yoUt1PArMBgEO7Tzc5zM7kaflyHaGoRjTN8Ru1+Jw9noV5e1C
         plgg==
X-Gm-Message-State: ABUngvcL8hNA0UHR38zgW+96gYH1gXfmrgcKC2Pa7ok1KWfuUPdMfbScNodzU3YZ+OkvqHOQkOFUjxhV18p1dA==
X-Received: by 10.13.226.13 with SMTP id l13mr2840088ywe.77.1479303751822;
 Wed, 16 Nov 2016 05:42:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.9 with HTTP; Wed, 16 Nov 2016 05:42:01 -0800 (PST)
In-Reply-To: <20161114212122.rkgeoh4rj5cxdadf@sigill.intra.peff.net>
References: <20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net>
 <CACsJy8DwKxz14Dow9dEKeXnBriMzN_OptnGM7nPigPcS_pHX9w@mail.gmail.com> <20161114212122.rkgeoh4rj5cxdadf@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 16 Nov 2016 20:42:01 +0700
Message-ID: <CACsJy8APSV_ONDjYDU0PHogpHg3cPULuWUySESqiXA2Eic+0wg@mail.gmail.com>
Subject: Re: [RFH] limiting ref advertisements
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 4:21 AM, Jeff King <peff@peff.net> wrote:
> Thanks for responding to this.

Glad to help (or more precisely annoy you somewhat :D)

> I've been meaning to get back to it with
> some code experiments, but they keep getting bumped down in priority. So
> let me at least outline some of my thoughts, without code. :)
>
> I was hoping to avoid right-anchoring because it's expensive to find all
> of the right-anchored cases (assuming that ref storage is generally
> hierarchical, which it is now and probably will be for future backends).

Urgh.. I completely forgot about future refs backends. Yeah this would
kick both wildmatch and right-anchoring out of the window.

For the record I almost suggested BPF as well (to keep the server side
simple, but at the super high cost of client side). That would also go
out of the window the same way wildmatch and right-anchoring does.

>      But remember that these are "early capabilities", before the server
>      has spoken at all. So the client doesn't know if we can handle v2.
>      So we have to send _both_ (and v2-aware servers can ignore the v1).
>
>        advertise-lookup-v1=master
>        advertise-lookup-v2=master
>
>      But that's not quite enough. A v1 server won't look in refs/notes
>      at all. So we have to say that, too:
>
>        advertise-lookup-v1=refs/notes/master
>
>      And of course the v1 server has no idea that this isn't necessary
>      if we already found refs/heads/master.

We discussed a bit about upgrading upload-pack version 1 to 2 in more
than one session: the first fetch just does v1 as normal, the server
returns v1 response to but also advertises that v2 is supported. The
client keeps this info and skips v1 and tries v2 right away in the
following fetches, falling back to v1 (new fetch session) if v2 is
unsupported. Can it work the same way here too?

I'm in favor of this option 2 (without trying to be absolute backward
compatible with older lookup versions) since it allows us to optimize
for common case and experiment a bit. Once we know better we can make
the next version that hopefully suits everybody.

>      So I think you really do need the client to be able to say "also
>      look at this pattern".

What about the order of patterns? Does it matter "this pattern" is in
the middle or the end of the pattern list? I suppose not, just
checking...

But does this call for the ability to remove a pattern from the
pattern list as well, as a way to narrow down the search scope and
avoid sending unwanted refs?

> Of course we do still want left-anchoring, too. Wildcards like
> "refs/heads/*" are always left-anchored. So I think we'd have two types,
> and a full request for
>
>   git fetch origin +refs/heads/*:refs/remotes/origin/* master:foo
>
> would look like:
>
>   (1) advertise-pattern-v1
>   (2) advertise-pattern=refs/notes/%s
>   (3) advertise-prefix=refs/heads
>   (4) advertise-lookup=master
>
> where the lines mean:
>
>   1. Use the standard v1 patterns (we could spell them out, but this
>      just saves bandwidth. In fact, it could just be implicit that v1
>      patterns are included, and we could skip this line).
>
>   2. This is for our fictional future version where the client knows
>      added refs/notes/* to its DWIM but the server hasn't yet.
>
>   3. Give me all of refs/heads/*
>
>   4. Look up "master" using the advertise patterns and give me the first
>      one you find.

Well.. it sounds good to me. But I would not trust myself on refs matters :D

> So given that we can omit (1), and that (2) is just an example for the
> future, it could look like:
>
>   advertise-prefix=refs/heads
>   advertise-lookup=master
>
> which is pretty reasonable. It's not _completely_ bulletproof in terms
> of backwards compatibility. The "v1" thing means the client can't insert
> a new pattern in the middle (remember they're ordered by priority).

OK so pattern order probably matters...

> So
> maybe it is better to spell them all out (one thing that makes me
> hesitate is that these will probably end up as URL parameters for the
> HTTP version, which means our URL can start to get a little long).
>
> Anyway. That's the direction I'm thinking. I haven't written the code
> yet. The trickiest thing will probably be that the server would want to
> avoid advertising the same ref twice via two mechanisms (or perhaps the
> client just be tolerant of duplicates; that relieves the server of any
> duplicate-storage requirements).

Thanks for sharing.
-- 
Duy
