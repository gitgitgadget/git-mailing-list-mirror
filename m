Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566C71F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeHMU3f (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:29:35 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:40818 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbeHMU3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:29:35 -0400
Received: by mail-yw1-f54.google.com with SMTP id z143-v6so14177240ywa.7
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cK1ElsQgIin9O9rmFAOmoG24obrOeHpwVbq0XJY943E=;
        b=kirRrgA/vUF3OBtOhC99wruxZrxFZY5E1ZaHLpUemG7O8seHzzyaFrUNWxRv9PO33k
         yB9aiKYbVJ7Sl17QGNBshfVkS2xY+AEUiTKvwMlyXCHHmxQrKkdISaujHCy6phXX+SHj
         tqg3H5PnIB3Rvrgg5vNn4epDNXeotj6Ka8DQHcOQ2KZEtXQlLiqjcPY2GPn/j+F4dDPa
         SAdAFlz/P6KdxDWkm7yPUm4uJUHgz57JYqdwh/6iHBMxf2ljhw9P6qhbxB8mVFFxt4NV
         smefFvbGYa5hfckoGnrIPjtD7/yXXtfDe01r6avuqnhG665kawQ/hFTSLaBBdj745ca1
         kF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cK1ElsQgIin9O9rmFAOmoG24obrOeHpwVbq0XJY943E=;
        b=CRWrSLStu+xJUz6ABvfi+l7dbZrvdGx95Zn0pLtGXScYRR3rcl6dSFX/Bvue6fNC7z
         wEN/eHlS4OpmLBTCJsdy6E0p99gVWYDLgMPZkC54bxU+l8hgqU1QcQfgTH6PnzD+9VsP
         Cz+dU2cBOlIVAnPcm0pMdyL93QBgH3Jtckza6GAKHAaIbxIYgU0VwHKBPlcIyL7Vlu/O
         dA/gNk6GL0ytCA/8nacvZXC2Z86uGG9c5fC6cDA5rBsV9rgjSWqNODjSf4WnjWgKlNrM
         RgGAteaT+v4ZVsoLsH4ZNrZEPHTqclRBTpnCAB6PWC03Fecb9v9B/i3e+L4W8zpPI6Ya
         AaTw==
X-Gm-Message-State: AOUpUlFX1XwTKyyTCGbpBI+HKzLQAWS2FgO/PJHDQaVbPjE2OFNII+IG
        sMJZVOhkb0YcFnjLi2gXlaB7RdpVxNTrPy9SQktjLofW
X-Google-Smtp-Source: AA+uWPxaHi9lJ3PRS83SrkMi8zYiwqaTfsP9w8bSGu6BG38RdHDrGRoAQTYfzytvEIqG5fQHD10VMrIg4exV40S1RY4=
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr9866938ywd.414.1534182381658;
 Mon, 13 Aug 2018 10:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180813163108.GA6731@sigill.intra.peff.net>
In-Reply-To: <20180813163108.GA6731@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 10:46:10 -0700
Message-ID: <CAGZ79kYMV0DCd89Pw3v4d48GyQN9iQzt=XZ9=aGswHFHWhas3g@mail.gmail.com>
Subject: Re: Contributor Summit planning
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 9:31 AM Jeff King <peff@peff.net> wrote:
>
> For the past several years, we've held a Git Contributor Summit as part
> of the Git Merge conference. I'd like to get opinions from the community
> to help plan future installments. Any feedback or opinion is welcome,
> but some obvious things to think about:
>
>   - where, when, and how often?
>
>     Plans are shaping up to have Git Merge 2019 in Brussels right after
>     FOSDEM in February (like it was two years ago), with a contributor
>     summit attached.
>
>     Are there people who would be more likely to attend a contributor
>     summit if it were held elsewhere (e.g., in North America, probably
>     in the Bay Area)? Are people interested in attending a separate
>     contributor summit not attached to the larger Git Merge (and if so,
>     is there any other event it might be worth connecting it with,
>     time-wise)?  Are people interested in going to two summits in a year
>     (e.g., Brussels in February, and then maybe some in North America
>     later in the year), or is that diminishing returns?

We have been kicking around the thought of reviving the GitTogethers
like back in the olden days (I only know them from hearsay), in
Mountain View or Sunnyvale at the Google Campus, but we have not yet
spent enough thought to make it so.

I think twice a year is fine for the community and has not reached the
point of diminishing returns.

As most contributors are from North America (estimated), I would not
mind a conference somewhere here.

I'd be looking forward to Brussels next February!


>   - format
>
>     For those who haven't attended before, it's basically 25-ish Git
>     (and associated project) developers sitting in a room for a day
>     chatting about the project. Topics go on a whiteboard in the
>     morning, and then we discuss each for 30-60 minutes.
>
>     We could do multiple days (which might give more room for actually
>     working collaboratively instead of just discussing). We could do
>     something more formal (like actual talks). We could do something
>     less formal (like an all-day spaghetti buffet, where conversation
>     happens only between mouthfuls). The sky is the limit. Some of those
>     ideas may be better than others.

Personally I think the way is fine; we could collect topics in advance on
the list to have a head start, but the whiteboard is totally fine, IMHO.

Stefan
