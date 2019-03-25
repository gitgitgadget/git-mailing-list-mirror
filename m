Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8269820248
	for <e@80x24.org>; Mon, 25 Mar 2019 13:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfCYNub (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 09:50:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45489 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCYNub (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 09:50:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id 5so6034345lft.12
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=DoRMm+FGMJgqkvzKRS7bjvoEDAkInJHi7kzK1+PDt54=;
        b=OHXWEymK4NWug3hQlfvThI0jxZHbsSkBmweg72k1t2rMKv/Pld8kbX1X1WIvbZwYRp
         6j7pUgFHfA9Sh1V1h7+craPu7imE9g7k9rggKAtL0W0GXHhR53/QmovmdHMja0RU2fu6
         ecj3XzusubabLdwnNLxvWzpnM64KGERt7jJn7lauU8CSitg/5BX3dRB8D2Nqe1KnorHI
         Zgpo1EYsy2Il2x+Teiu9qcTXjJY7pen2Tpf0wpnXomGt0pMTYCgXBq3FWut3GpHdyeUn
         qlYsBiqMXDWXutdvB3dl0QcHi49ecKBUvKCRdH2lEhjD7dZGf8EKURJqcIdZwQXvYbSr
         RkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=DoRMm+FGMJgqkvzKRS7bjvoEDAkInJHi7kzK1+PDt54=;
        b=ZTYjQAeoU9kJmD6P89zodYV3KNKjMIA1BUU9MyWnnkW8rxlz4jsi2tZt/sCOMhWDEs
         xV/OIiSlEpdiHEaAlMXZKg94QpbIkioSyvp1z8Wd7v0UAqFnGgQLEqJ3hBrtJHmllIb7
         T1BzJJU2V2r37A0V9nFfL2TWHt/ohO8ofNT7q4dGRWo3lHRbgBxkTCrRjOZ6O1RQ2GLj
         WOTTpDtkp7TGX4w1GcWGEvFYrIMGYCE9SiEGAquc0g5CdE6bLwI7kGt5M50U0+as+MVr
         /gtdnjLH4wpQXDxmvz+p9m66W31EMz36tSFQfirP6cRKxxk6vt4qlCDlc8DUjpA25CtQ
         22NQ==
X-Gm-Message-State: APjAAAXkGyEtP/kgQJgtbWRZhTlUF0BrerySUy6pz8eOyRFrv2zcetDF
        ur2Vdcjx5OJPDsEs3QHPDsrzPB1AgCh2d7UJ8t8=
X-Google-Smtp-Source: APXvYqwOtQ6pwTn3/l9hvBltuphim/F6/PHV0b8T0dLWbp1GocDkYWHLysV18uN++ijXp9yR1b0hWVa2j0xAMWEIWv0=
X-Received: by 2002:ac2:4298:: with SMTP id m24mr8569676lfh.2.1553521827568;
 Mon, 25 Mar 2019 06:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
 <20190321192928.GA19427@sigill.intra.peff.net>
In-Reply-To: <20190321192928.GA19427@sigill.intra.peff.net>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 25 Mar 2019 08:50:14 -0500
X-Google-Sender-Auth: wMkEc9Ormb4RfC66z3WGH_UPyqw
Message-ID: <CAHd499BTACjf91Ohi34ozFQE_NOn-LVf-35t7h4CTtDFoMCpWw@mail.gmail.com>
Subject: Re: Strange annotated tag issue
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 2:29 PM Jeff King <peff@peff.net> wrote:
> Tags can point to any object, including another tag. It looks like
> somebody made an annotated tag of an annotated tag (probably by
> mistake, given that they have the same tag-name).
>
> Try this:
>
>   git init
>   git commit -m commit --allow-empty
>   git tag -m inner mytag HEAD
>   git tag -f -m outer mytag mytag
>
>   git show mytag
>
> which produces similar output. You can walk the chain yourself with "git
> at-file tag 4.2.0.1900". That will have a "type" and "object" field
> which presumably point to the second commit.
>
> My guess is that somebody was trying to amend the tag commit message,
> but used the tag name to create the second one, rather than the original
> commit. I.e,. any of these would have worked for the second command to
> replace the old tag:
>
>   git tag -f -m 'new message' mytag HEAD
>
>   git tag -f -m 'new message' 2fcfd00ef84572fb88852be55315914f37e91e11
>
>   git tag -f -m 'new message' mytag mytag^{commit}
>
> If the original tag isn't signed, you could rewrite it at this point
> using one of the above commands, coupled with GIT_COMMITTER_* to munge
> the author and date.  But note that fetch doesn't update modified tags
> by default, so it may just cause confusion if you have a lot of people
> using the repository.

Thanks for explaining. This is very helpful. Am I naive to think that
this should be an error? I haven't seen a valid _pragmatic_ use for
tags pointing to tags. In 100% of cases (including this one), it is
done out of error. As per your example, users try to "correct" an
annotated tag pointing at a wrong tag or commit. What they expect is
the tag to point to the other tag's commit, but that's not what they
get.

From a high-level, pragmatic perspective, doesn't it make more sense
to change the git behavior so that annotated tags may only point to
commit objects? And in the `git tag -f -m outer mytag mytag` case in
your example, this would automatically perform `mytag^{}` to ensure
that the behavior the user expects is the behavior they get?
