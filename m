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
	by dcvr.yhbt.net (Postfix) with ESMTP id E70E81F464
	for <e@80x24.org>; Mon, 23 Sep 2019 11:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfIWLtT (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 07:49:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36616 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfIWLtT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 07:49:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id h2so12565994edn.3
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FncQz5HZ8GP/I1G8NkFy+0eulDj52LZl+vKeSvIX8dw=;
        b=eZ3gaDx2ysklE3UCohw1dVfUtowacCrHAVTomFSOa82D+hujLHNMb6DQxneVw2x+fe
         eOiWdx1Wis6j1hRPSbePMnJ6bNyz1S+vmmByssaP0/FkV02wtTRvipXQnZD/hnHISf5B
         XdoHsSPMb4YhLMb2DAG8g8vipf1HZ93Eu15Xl8yQt0+mTeEEsTHoKnpZ9duyjebiYoki
         AZzq1SHCuPdiPJbvlcEg9OBdy0P5JkvXGwLjaxhv1p5GN9bWb8Am4Wn52Jpoznac57Ri
         LE51C7gaFr2QPK2ZitYM39s7eSbM4oDawFAUaI5cjufawU3FY1sQp47TwW54ZLK93zYy
         b1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FncQz5HZ8GP/I1G8NkFy+0eulDj52LZl+vKeSvIX8dw=;
        b=CzLVVSwA4CcxnvrhhzIEJbRJobF/vo4yRaxf+lvnwF3OfNfnlsADa0qG0vo5uk7hVX
         0m0oM5Hqi1o7ddxoO64mYzHPZTTCPqOAoKIN2sGqmegGw19F8+qEAGob/h3P0CV+CRRY
         siKfQZ3KXmBH93vFcLKMpLqvEuavaS4SCaAmojyh6wEBE729/BCKELopr7lgL9hcIRgW
         tJBsEPIoQcy1Ho2fDcd1XCZzzHYoAiJZ7bOmHGNGbCX2sEuyfKIxFg+HRm87aE9uBu8y
         6Gtq2XceEMioe9F/v3b/jQbDq3WlDubEDKkS9Fxu4Ui7CZdkr1NrnmC37YOKrtw2Kr45
         98zw==
X-Gm-Message-State: APjAAAWmArnfFU2o6H8IRRGw8bL6fxoryIg9cvQJhTOSAhQE+O6TOUgD
        I+kmHsgnVGK+05z6BL6WiE48lMfLzGiYLA2ZtW7exiyCTd4=
X-Google-Smtp-Source: APXvYqzTxauedITr0lfOXuc/tXAVavVXTIKy7X8Dnfxkm+SSrphSNppJrNOY/AW9b9aI8WrTcUNDJUsu8eRpsLdwI8U=
X-Received: by 2002:a17:906:1c06:: with SMTP id k6mr30096497ejg.217.1569239357841;
 Mon, 23 Sep 2019 04:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190913205148.GA8799@sigill.intra.peff.net> <20190920170448.226942-1-jonathantanmy@google.com>
In-Reply-To: <20190920170448.226942-1-jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 23 Sep 2019 13:49:05 +0200
Message-ID: <CAP8UFD3NPYJr5PXLDyRD=qbEPft8E-HwtGUo_FxoG=q5jfY5Ng@mail.gmail.com>
Subject: Re: Git in Outreachy December 2019?
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 10:53 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Prospective mentors need to sign up on that site, and should propose a
> > project they'd be willing to mentor.

Yeah, you are very welcome to sign up soon if you haven't already done
so as I think the deadline is really soon.

> > I'm happy to discuss possible projects if anybody has an idea but isn't
> > sure how to develop it into a proposal.
>
> I'm new to Outreachy and programs like this, so does anyone have an
> opinion on my draft proposal below? It does not have any immediate
> user-facing benefit, but it does have a definite end point.

No need for user-facing benefits. Refactoring or improving the code in
other useful ways are very good subjects (as I already said in my
reply to Emily and Dscho).

> Also let me know if an Outreachy proposal should have more detail, etc.
>
>     Refactor "git index-pack" logic into library code
>
>     Currently, whenever any Git code needs a pack to be indexed, it
>     needs to spawn a new "git index-pack" process, passing command-line
>     arguments and communicating with it using file descriptors (standard
>     input and output), much like an end-user would if invoking "git
>     index-pack" directly. Refactor the pack indexing logic into library
>     code callable from other Git code, make "git index-pack" a thin
>     wrapper around that library code, and (to demonstrate that the
>     refactoring works) change fetch-pack.c to use the library code
>     instead of spawning the "git index-pack" process.
>
>     This allows the pack indexing code to communicate with its callers
>     with the full power of C (structs, callbacks, etc.) instead of being
>     restricted to command-line arguments and file descriptors. It also
>     simplifies debugging in that there will no longer be 2
>     inter-communicating processes to deal with, only 1.

I think this is really great, both the idea and the description! No
need for more details.

Thanks,
Christian.
