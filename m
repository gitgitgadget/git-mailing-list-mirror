Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1809E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbeHOUrp (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:47:45 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35549 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbeHOUro (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:47:44 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so3413278oic.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOu7XCki+KAXpIJFPJMwGmVIWxKXQIOpo7T8ruxlUUU=;
        b=MeL5DdFaSBe0mx5WOkGXpwml6UBIHLYsIq3bV6inicfWPtAIQSP/9F/QD6TcseBgKz
         NzhJGdjdqT3vUqD9nHNSl8M1A+TRG+8CfyAtw5+/EjwbxI2u2asoyRatbdhNeEAQGulj
         81QIjuYTjWdfAP7OWaZhkr5zq4DgAQxtz8QJXJuvzx42xmAb8ALXsEGfqtdcMI/7wHH7
         vn6L/5neSCR9WErFSleo4wjh4kQZwg8kRoJ35c2wkx3OfrcIcM4yU7oMd8/0/aumolSp
         IBGx4dvdsy+bCqvXu89VL2/47iDQaeYajvMO+SehtZgbId2N40zQ8mgYwAGgzk+Z8FY1
         Qtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOu7XCki+KAXpIJFPJMwGmVIWxKXQIOpo7T8ruxlUUU=;
        b=hsqeuq2j8GuvmZYeFnSL5LsM2F+xIUGZ4xJ7unT0GheI0UIAML+q7PTcwA+Zuubjsw
         YowNk4cYblLHDh9ZxjdPTOyDrliuGnPf/z18do+EYCtJ9kWNHgpEu+OD43T6jY6ECArT
         kd7Zv1mOIT02wmzhFzcGbWkklmzZ29ELYgv5f+bAnPCbYe8/7bLI+mO14/qspvkwbl6G
         XOSOgxsmstiaUU0u4PUoMfUaJTvHpSzHdCG6/wNxebj5F5aX7QbfCmxUPV6SzdAWb+Ru
         eNHogoOkRO7A4qw2iBDhFEKzVJmmm+rpf2YTmuyjnhmOgHfFpxqnQmmzJ1Yqv1OBstFT
         WPWg==
X-Gm-Message-State: AOUpUlFVb89ENy+FGiNnOCJMAbuRjtF76MfRPezFnnxeQB67H+rUkGd0
        n+wXw0B8FvNBvU97XjAAm3J1GelDFZiJv9gl0yVdnA0fig==
X-Google-Smtp-Source: AA+uWPwqP+xcSUfjWe1dl6fJj7lKWmvN0w08CwCsM2JDJXwbwwVLZ84yNP3U3GDh8UCnuSj5KubSH3OODG/+Pt2GVj0=
X-Received: by 2002:aca:390a:: with SMTP id g10-v6mr29278623oia.145.1534355675770;
 Wed, 15 Aug 2018 10:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534267611.git.matvore@google.com>
 <05e69ef260ca2b28b2444b94850bddf44ca0388a.1534267611.git.matvore@google.com>
 <20180814200154.GF28452@sigill.intra.peff.net> <CAMfpvhJM2hUXTfTgY9jA4aB+bgx44xbCktCacpy_yWacyjk00w@mail.gmail.com>
 <20180815012224.GA4745@sigill.intra.peff.net> <xmqqr2izk3j0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2izk3j0.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 15 Aug 2018 10:54:24 -0700
Message-ID: <CAMfpvhJA3h8cFB_Weh_cDdqQBHccYfCrjs-S-T_nyDG=JVi6Tg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 9:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > Right, I'd agree they probably want the minimum for that traversal. And
> > for `rev-list --filter`, that's probably OK. But keep in mind the main
> > goal for --filter is using it for fetches, and many servers do not
> > perform the traversal at all. Instead they use reachability bitmaps to
> > come up with the set of objects to send. The bitmaps have enough
> > information to say "remove all trees from the set", but not enough to do
> > any kind of depth-based calculation (not even "is this a root tree").
>
> If the depth-based cutoff turns out to make sense (on which I
> haven't formed an opinion yet), newer version of pack bitmaps could
> store that information ;-)
>
> How are these "fitler" expressions negotiated between the fetcher
> and uploader?  Does a "fetch-patch" say "am I allowed to ask you to
> filter with tree:4?" and refrain from using the option when
> "upload-pack" says "no"?

I couldn't find a feature like that for the existing features, but
adding such a think seems reasonable to me. (thinking in terms of
protocol v2,) There could be a filter-check command which takes a
single argument: the filter string (like "tree:4"), and responds with
a single line: either "ok" or "unsupported".
