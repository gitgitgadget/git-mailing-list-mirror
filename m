Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3678BC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AD76147F
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhELHgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 03:36:53 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:38772 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHgx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 03:36:53 -0400
Received: by mail-ed1-f46.google.com with SMTP id n25so25880123edr.5
        for <git@vger.kernel.org>; Wed, 12 May 2021 00:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQcU4nsn7RNQS5CFtNDWrmrt4lRje/HZGZDX5cNOIY4=;
        b=VKcH68gqbjCfME0DjMS0zh5dvMGaKncBNp3IxbaHBWi6/fu//To4HsQJrGzMHVYiNl
         hqWU9J3+OJ5/gKH5c+PRyi5gS8xhVFWfRVN16eHq8F3a2D0G5PUfQfnmKDPS/MwdyPi8
         vdpVyLsgNrbobTQ7Svx86srnV86eRLZ8fhoE4TaAMkaiIkai6GjUX8xZbMmWxZolZuZ+
         xxGeWH7rrhAwebaN7raTytU8P2Mj5yVX8ngEysTULSh0GXZW39e+zuXUvJywPouTl2vI
         UhFScFyiICsk7jNmXIpjVd2QwK8BPW3+hI1Drwt7aHJ50Ul00QhNdAzKPCjZou8Z8pcM
         SbHw==
X-Gm-Message-State: AOAM530E7g5LEzhpHnP1XcBhqoMmg5LOX1JqAoxHct7IFYpx7s2p8nO9
        ngLojTNCx0ihIKqOx3ntsfQL7fAmdNFuEyj4YEn0qMZI5bs=
X-Google-Smtp-Source: ABdhPJx00OI7oaKYQQGHwq9tykkWMZ9wp1XnkUEC6D1MNcrF7bgG48VF44jLcf+sthne5UUkzCICY6WWPlCXBRJHp+Y=
X-Received: by 2002:a05:6402:1587:: with SMTP id c7mr40955297edv.181.1620804943961;
 Wed, 12 May 2021 00:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
 <20210512031821.6498-1-dwh@linuxprogrammer.org> <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <80e0215a-cd00-57f9-afb6-b85b33dba91d@gmail.com> <609b797a818bb_6d897208ce@natae.notmuch>
In-Reply-To: <609b797a818bb_6d897208ce@natae.notmuch>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 May 2021 03:35:32 -0400
Message-ID: <CAPig+cQvnsRe0fdPaBe9hJ4LbPFmHmGVNdiGYLqi2JM7A5GmjA@mail.gmail.com>
Subject: Re: [PATCH v2] Writing down mail list etiquette.
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, stefanmoch@mail.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 2:45 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Bagas Sanjaya wrote:
> > In practice, the maintainer could instead merged v5 (without having me to
> > send v6 [final]), because v5 is merge-ready in absence of maintainer's
> > email address in either To: or Cc:.
>
> Generally you don't need to worry about this, that's Junio's job. If
> your patch is ready, Junio will merge it... But not always.
>
> So no, you don't need to send v6, Junio will pick v5. If he doesn't,
> it's most likely because it slipped through the cracks, and you can see
> that in the next "What's cooking in git.git".
>
> If you don't see your merge-ready patch series in "what's cooking", then
> by all means send it again as v6, or reply to the "what's cooking" or
> something. But generally there's no point in sending a v6 identical to a
> v5.
>
> But if you already sent a v5 that is is merge-ready, there's no need
> to send an identical v6.
>
> All these suggestions are of course based on my own experience. Others
> might have different experiences.

This has been my experience, as well. I've never sent a v6 with Junio
as an explicit recipient, but which was otherwise identical to v5.

Another reason to avoid sending v6 which is identical to v5 is that it
potentially wastes reviewer bandwidth.

The advice which seems to have triggered this particular discussion
comes from Documentation/SubmittingPatches:

    After the list reached a consensus that it is a good idea to
    apply the patch, re-send it with "To:" set to the
    maintainer{current-maintainer} and "cc:" the list{git-ml} for
    inclusion.  This is especially relevant when the maintainer did
    not heavily participate in the discussion and instead left the
    review to trusted others.

It's not the first time this advice has resulted in confusion. Perhaps
now would a good time to retire it altogether, or at least rewrite it
to mention the points you gave above about responding to "What's
Cooking" or by sending a "ping" to the original patch email (which may
result in Junio either picking up the patch or responding with an
explanation as to why he didn't).

Following the above SubmittingPatches paragraph is another which also
seems to mislead people frequently:

    Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:`
    and `Tested-by:` lines as necessary to credit people who helped
    your patch, and "cc:" them when sending such a final version for
    inclusion.

In fact, a submitter should almost never add a Reviewed-by: trailer
because Reviewed-by: is explicitly given by a reviewer only when the
reviewer is satisfied that the patch is merge-ready, in which case no
more re-rolls are expected. Instead, these particular trailers are
almost always added by Junio based upon reviewer responses he sees
when picking up a patch. So, it may be time, too, either to remove
this paragraph or to revise it to mention other trailers more
appropriate for use by the patch submitter, such as Helped-by:,
Suggested-by:, perhaps Co-authored-by:, etc.
