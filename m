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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB061F461
	for <e@80x24.org>; Wed, 28 Aug 2019 18:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfH1Spl (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 14:45:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45508 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfH1Spk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 14:45:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so176530pgp.12
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05YiYk7Y2qppdl1eIfnkxiL8FUP9kx2BjHzAbX/fm8w=;
        b=uDRtJKNWwnnWkaFafVYwYdmzL+4OYTwzmzuPKXHjttg4SNfPybcBA9W44nqYpS/The
         gGo5jLp5oQ9djTzCzzwVp/4EbdM22Dp6kT8L++JLxMZDTFYto5KFdxgjK6AoIFCtwOvC
         ibjsgx2K+b5OCZNQtBVRfHZ1ZprxQTa/dWd0N9B+oUk0oBfjkhU5M7V7Zqy0dE/CY22V
         IKzE14ycf8BZDafIILlQl4pDohkCAJ4jkbKjDRcMffF0AByqjB7jgx+sR2M/F77GHAei
         QzVDpBQx+S+FXiI2buVk0dGABhA+SX9rvLzlTLQKf/P1mzwb5qzQ/JGq60duYgftbcjS
         PIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05YiYk7Y2qppdl1eIfnkxiL8FUP9kx2BjHzAbX/fm8w=;
        b=sFobThuwPuCGZg6JH4CKRXXPg4rzoOXGANzKeofz2AHN4FQZmOBGjP8nCobVHkr7gs
         /I316uCaxlr9mwnOEKinq29D0F3Oc+lOylm7e4y87l1OC8/5gdBIygY0YhVSAQ4vxzZ3
         bL75YSkK1D7+4bn7te9h+fiwYdXk6W9NF37GHiu/Lyv6yN84KVWYaDBj90dpklT8zNQW
         i26sMlc+byyd3Qt4kjf1QxzuCliSlTANbyN9wovzcWc7fVHcQ6JZ+FWOSRRDLj9b+FBG
         mA6SqOURPxIz4p/7xXhqOOgFLBdL6MSj2vmA5D192K4u1dbrqK2j1iM0549vzz6dBf5N
         aEaA==
X-Gm-Message-State: APjAAAX/gyvk1t5JfIKLqf/XBF/V11Ta4dKbcpk1X2b4bR7JkbIPeJwP
        lBV5zvTGw34UOUJAEjZ1kSm09vhe1AQTa7EtiH0=
X-Google-Smtp-Source: APXvYqzDWd4vTWnv3cg9bpljcRkWXn8soULfCr+LQFRuzfv4kvp3MAhgm5Q0cJ/5juEvchrCOfGS+K7aWsw7KE/2hxM=
X-Received: by 2002:aa7:87d8:: with SMTP id i24mr6358767pfo.88.1567017940164;
 Wed, 28 Aug 2019 11:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <877e6x3bjj.fsf@osv.gnss.ru> <20190828155131.29821-1-newren@gmail.com>
In-Reply-To: <20190828155131.29821-1-newren@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 28 Aug 2019 20:45:27 +0200
Message-ID: <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
Subject: Re: [PATCH v2] merge-options.txt: clarify meaning of various
 ff-related options
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 28 Aug 2019 at 17:52, Elijah Newren <newren@gmail.com> wrote:
> ---ff::
> -       When the merge resolves as a fast-forward, only update the branch
> -       pointer, without creating a merge commit.  This is the default
> -       behavior.
> -
> +--ff-only::
>  --no-ff::
> -       Create a merge commit even when the merge resolves as a
> -       fast-forward.  This is the default behaviour when merging an
> -       annotated (and possibly signed) tag that is not stored in
> -       its natural place in 'refs/tags/' hierarchy.
> +--ff::
> +       Whether to only allow resolving the merge as a fast forward
> +       (only updating the branch pointer to match the merged branch
> +       and not creating a merge commit), to never allow it (always
> +       creating a merge commit), or to prefer it when possible.  The
> +       default is --ff, except when merging an annotated (and

It would be great if you'd write this as `--ff` so that it got
monospaced in the rendered documentation. Same thing with `no-ff` later
in this paragraph and a few more times in the next three paragraphs that
you're adding.

> +       possibly signed) tag that is not stored in its natural place
> +       in 'refs/tags/' hierarchy (in which case --no-ff is the
> +       default).

I'd also write `refs/tags/`, but I realize that you're just inheriting
what is already here. If you'd rather punt on that, that's understood.
This whole document could need a look-over with respect to monospacing
anyway, but it seems unfortunate to introduce *new* non-monospaced
instances, especially for command-line options where it's pretty clear
how they should be handled (Documentation/CodingGuidelines, line ~610).

> ++
> +With --ff-only, resolve the merge as a fast-forward when possible
> +(when the merged branch contains the current branch in its history).
> +When not possible, refuse to merge and exit with a non-zero status.
> ++
> +With --no-ff, create a merge commit in all cases, even when the merge
> +could instead resolve as a fast-forward.
> ++
> +With --ff, resolve the merge as a fast-forward when possible.  When not
> +possible, create a merge commit.
>
> ---ff-only::
> -       Refuse to merge and exit with a non-zero status unless the
> -       current `HEAD` is already up to date or the merge can be
> -       resolved as a fast-forward.

I was sort of expecting these to be listed in the order "--ff, --no-ff,
--ff-only", and I see Sergey suggested the same ordering. The way your
proposed text reads does make sense though... Would it read as well
turning it over and going through the options in the other order? That's
the way it is before your patch, so you could argue "but people don't
grok that!". What your patch does well is to offer an overview before
describing each option in a bit more detail. Would that work with the
reversed direction as well (compared to this patch)? Dunno.

I wondered briefly whether it might make sense to float "The default is
`--no-ff`." to the top, but since it's really "The default ... unless
so-and-so", it would probably complicate things more than it'd help.

Martin
