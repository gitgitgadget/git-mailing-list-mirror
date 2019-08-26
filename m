Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719CF1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbfHZSQd (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:16:33 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42540 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfHZSQd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:16:33 -0400
Received: by mail-vk1-f195.google.com with SMTP id t136so4158915vkt.9
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hedhZXevI40Xjb9NfnnCxYtQpfIPru8tAer637WHuhU=;
        b=W4DPlDWd2AKkuXd9KU5xW9yEbCGO2U+U4Vw3nMyv+5TH2K2Ek/ivoOEgkIcBoR0baz
         kvxexpAXEIFcXPY5PBy9xCza5pmh6+PGRapvQqhSL3Ch45X3WF/zBMfaQ1Tb+NGeIeXN
         4aEWETWndmEvy9DoLIuFC8b/hZ4ATkB83E6DXqR4bnBBxi+rzQWMo0CwtYu9X6n/+2fS
         DzQULpF5KkL5qZQQ97gh/CMKckAfVAh2wUKfazcnYoMHu+fZMe2picgoCiZBV3KE5rEU
         qrM9hsojWd6UT+gjpOJoExjMOkbQGi/s9LMkLszo2J8PnRzlfEp9Rv9SSVC/GlMGe4m4
         QMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hedhZXevI40Xjb9NfnnCxYtQpfIPru8tAer637WHuhU=;
        b=H+E8jUY3XyAG2sJxXieaCQdfqX5S17nOoNaD+ht3zBpIbt4/X0hu8wTy+u36iVXyy0
         tG4hw2AJW1aWJqT8VljnUb21XmNuZRJyJPANrCHvMc4vdXK0HwvoU4TsA8Mi0aOrhJ/j
         /wbmZ5oRQoaT5ViWSGPRPOzBB6gDqlMCWCBBZTDG0w9m0EIal0k9MBXVu/FXYMNv8UO5
         lg/zunL6iRMWQi80aPDntLiI156c/2RBTECGYTSow9O5YT+ICqT0oUpxA9hBZbnphUnd
         qUKYYbDoEAnMKz2mrVhrKlKpiHJru8THB1ku4UA+G0vk62Ajie1oBPqumMKrPBhKyL+c
         WZow==
X-Gm-Message-State: APjAAAVJrqeBaQRRoRabSkCZrg3xFJX9gzAqfSI2hBrJzRLedEwx3F/Z
        X/Xoi2kFw763IRUDc4N6sNTNb5m9tne9Ywdut/Y=
X-Google-Smtp-Source: APXvYqxNTKc2cLstccEc52iqzME6Q92zJK9p49g3regw5R06TWb7ZG5zfSWcOpn1aJGwkRyMNnPAwbjx/KscBXhnSAw=
X-Received: by 2002:a1f:4bc5:: with SMTP id y188mr8406659vka.92.1566843391963;
 Mon, 26 Aug 2019 11:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com>
 <08bd295b-ec5a-3128-42cf-acb24971d679@gmail.com> <CABPp-BG8GtdaogbCCZqPXYkhMAqseyAXX0ppjUbg_1hVShGG=Q@mail.gmail.com>
 <c919513a-f41f-2ce8-60ed-e0b0733c0c7f@gmail.com>
In-Reply-To: <c919513a-f41f-2ce8-60ed-e0b0733c0c7f@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Aug 2019 11:16:19 -0700
Message-ID: <CABPp-BFGcuf6jnLndi_s_LGA9M4FAb1_GGOYo=Bxky5pv5CWug@mail.gmail.com>
Subject: Re: [PATCH 0/9] [RFC] New sparse-checkout builtin and "cone" mode
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 6:29 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/24/2019 1:40 AM, Elijah Newren wrote:
> > On Thu, Aug 22, 2019 at 6:10 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 8/21/2019 5:52 PM, Elijah Newren wrote:
> >>> On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
> >>> <gitgitgadget@gmail.com> wrote:
> >

> >> In this series, I turn `core.sparseCheckout` into a tri-state, and only
> >> try to validate the sparse-checkout when `core.sparseCheckout=cone`.
> >> This avoids spending time on the validation when someone is content using
> >> the existing feature.
> >>
> >> The _intent_ of using the sparse-checkout file and no extra data structure
> >> was to let other clients (or an older client) read the sparse-checkout data
> >> and result in the same working directory. One thing I realized after
> >> submitting is that the tri-state config variable will cause old clients
> >> to error on parsing the non-boolean value. Instead, in v2 I will introduce
> >> a new boolean config variable "core.sparseCheckoutCone" that will do the
> >> same thing as the current series when `core.sparseCheckout=cone` and will
> >> fix this compat scenario.
> >
> > Once we are forced to use yet another config variable, we may as well
> > use yet another config file ($GITDIR/info/sparse-checkout-cone or
> > something; or maybe a less specific name with greater future
> > compatibility via some version marking in it).
>
> I'm hesitant to include a second "source of truth," as that can cause
> issues when users modify the sparse-checkout file directly. Since the
> existing way to interact with the sparse-checkout is to directly edit
> the file, I want to be as careful as possible around users who modify
> that themselves. The caveat is that if they specify "cone" mode then
> they will get warnings and worse performance if they modify it outside
> the limited patterns we allow.

Wait...does that mean you allow mixing and matching both regular style
sparse-checkout declarations with cone-mode style declarations within
the same file?  Are the non-cone mode entries ignored?  Does it
fallback to non-cone mode for all entries?  Or does that mean you
allow checking out both old and new styles of filesets, where you
optimize the cone-mode style declarations with your hashsets, and have
the remaining ones fall back to the old O(N*M) matching?  (I think it
does the last of those, right?)

If you support both, it sounds like you naturally support doing cone
mode with allowing people to also grab a handful of additional files
without the rest of their directories or parents.  It's just that
folks who want to do that will ask for a way to turn off any warnings
you spew, and if you turn the warnings off, then people who meant to
get cone behavior but mistyped stuff might complain about no warnings.
Hmm....

(Just trying to think things through out loud; I don't necessarily
know what's good or bad here, just voicing what I think might happen.)
