Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5561F463
	for <e@80x24.org>; Thu, 26 Sep 2019 17:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfIZRmr (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 13:42:47 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38467 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfIZRmq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 13:42:46 -0400
Received: by mail-vk1-f194.google.com with SMTP id s72so634682vkh.5
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHqqZ6cp7f0q7VSJlkGLxuiElpMFPowMuiTH8EU2xTk=;
        b=d2VkH6HVVOD0SGIBslSecrHDH2OF+uU4U4fHp2W1j0Z6507QbB5O3S4Mtz1AW+C0RK
         mUWZEv4ALU0O45Dp07nZCrIcGhPtditz0Svwzwipz/VJZ+3TnVkwX9tVKmppblte1gtZ
         6Q1rg/QyBj3AqaCDXezg6KS3Rt7Xd9bBafkg3sN2NiYvDUPnOhNseoEANur8jjj1tbHe
         urml86GFEqaD63P4FuDoFU0l+xaaXSBKVt5P8D9+j2KrRFR7Q3Jr3vnD4uSXJhnfPtYv
         HItXfkGFdtBWgZ7isoFluleU73HF/KAGXROij/07nugl4rEoA3RDJs4Gk4zpSNgZ7WQd
         POiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHqqZ6cp7f0q7VSJlkGLxuiElpMFPowMuiTH8EU2xTk=;
        b=rro7f1k85jFca/ZvBduS7RxGHBunXs7fWCgdc59UoZ0946Sx0/HeOX33KQYo7terCH
         zu41nUPTUeRzVXfccOxeUUbknu6ekuwR5TNk7a9rs70JIS4n8UayteolHxYlMp1FkGAx
         JTQFW+h99C5XP+9kAqMaWSPN9VbdIpwfb+sIDq4FURM4htMVfS186IPTFhkGRYYJz/sa
         488G8ToHpsbbrFllH/Z8oHYe/I7Adog3rk8oHL2R8Vb/H87FbaQL2mjmmUllEdn6cE+L
         fODuhlIbeP2HwqcUJqrqNOgGZvkvS08xAF3QceZm8w3KuMeL8IIs7zyIEq0sxhxJOVY5
         o7bA==
X-Gm-Message-State: APjAAAUpjnDgVxoUYn6P+Fm5rd6aYzZFkX8OrbGH60DrwjUekt5+aF9f
        0tThNG5seVq2d3lTpsm9t+LlQImIHlHSTsxhvu4=
X-Google-Smtp-Source: APXvYqxSZqMx6kRt0Vy5KCbBneD1FONIVAwYjO4b5BsV3GRfNt3sfcInSzasDacPJszuF0fm+GucbYprWm/CsrPqsh8=
X-Received: by 2002:a1f:2192:: with SMTP id h140mr2216086vkh.92.1569519765153;
 Thu, 26 Sep 2019 10:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190924064454.GA30419@sigill.intra.peff.net>
In-Reply-To: <20190924064454.GA30419@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Sep 2019 10:42:33 -0700
Message-ID: <CABPp-BERhEp2At-ABPrkCHcqLfb32t+S0hPHs=d17QjcZR1wPA@mail.gmail.com>
Subject: Re: [PATCH] add a Code of Conduct document
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>, git@sfconservancy.org,
        Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 25, 2019 at 5:42 PM Jeff King <peff@peff.net> wrote:
>
> We've never had a formally written Code of Conduct document. Though it
> has been discussed off and on over the years, for the most part the
> behavior on the mailing list has been good enough that nobody felt the
> need to push one forward.
>
> However, even if there aren't specific problems now, it's a good idea to
> have a document:
>
>   - it puts everybody on the same page with respect to expectations.
>     This might avoid poor behavior, but also makes it easier to handle
>     it if it does happen.
>
>   - it publicly advertises that good conduct is important to us and will
>     be enforced, which may make some people more comfortable with
>     joining our community
>
>   - it may be a good time to cement our expectations when things are
>     quiet, since it gives everybody some distance rather than focusing
>     on a current contentious issue
>
> This patch adapts the Contributor Covenant Code of Conduct. As opposed
> to writing our own from scratch, this uses common and well-accepted
> language, and strikes a good balance between illustrating expectations
> and avoiding a laundry list of behaviors. It's also the same document
> used by the Git for Windows project.
>
> The text is taken mostly verbatim from:
>
>   https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
>
> I also stole a very nice introductory paragraph from the Git for Windows
> version of the file.
>
> There are a few subtle points, though:
>
>   - the document refers to "the project maintainers". For the code, we
>     generally only consider there to be one maintainer: Junio C Hamano.
>     But for dealing with community issues, it makes sense to involve
>     more people to spread the responsibility. I've listed the project
>     committee address of git@sfconservancy.org as the contact point.
>
>   - the document mentions banning from the community, both in the intro
>     paragraph and in "Our Responsibilities". The exact mechanism here is
>     left vague. I can imagine it might start with social enforcement
>     (not accepting patches, ignoring emails) and could escalate to
>     technical measures if necessary (asking vger admins to block an
>     address). It probably make sense _not_ to get too specific at this
>     point, and deal with specifics as they come up.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Obviously related to the discussion in:
>
>   https://public-inbox.org/git/71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com/
>
> After some poking around at various CoC options, this one seemed like
> the best fit to me. But I'm open to suggestions or more discussion. It
> seems to me that the important piece is having _some_ CoC, and picking
> something standard-ish seems a safe bet.
>
> I did find this nice set of guidelines in an old discussion:
>
>   https://github.com/mhagger/git/commit/c6e6196be8fab3d48b12c4e42eceae6937538dee
>
> I think it's missing some things that are "standard" in more modern CoCs
> (in particular, there's not much discussion of enforcement or
> responsibilities, and I think those are important for the "making people
> comfortable" goal). But maybe there are bits we'd like to pick out for
> other documents; not so much "_what_ we expect" as "here are some tips
> on _how_".
>
> If people are on board with this direction, it might be fun to pick up a
> bunch of "Acked-by" trailers from people in the community who agree with
> it. It might give it more weight if many members have publicly endorsed
> it.

Acked-by: Elijah Newren <newren@gmail.com>

(including the small update you sent elsewhere to individually list
the members of project leader team.)
