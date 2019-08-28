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
	by dcvr.yhbt.net (Postfix) with ESMTP id 207FC1F4B7
	for <e@80x24.org>; Wed, 28 Aug 2019 09:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfH1JzX (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 05:55:23 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:32991 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfH1JzX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 05:55:23 -0400
Received: by mail-io1-f50.google.com with SMTP id z3so4727752iog.0
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 02:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UyjWxlTffumZ9PEBc0JxIPESxGhrad5mIxeRa+8Uvg=;
        b=O5mqLySXUeCSLYdHHkibfhUH9ShO8Lhmy38ZwmMEFvuPtVVoqh9d3CFw47P3XXibNs
         f+UUrrS3fnDwRW7NGqJyaHqt2BXxPlAbacNnHosR5KszoK9Yl2Ju8jyPnnHofMIAA36N
         Aq7KlooFwSurzmFch9LZUON+2ojvYN4SGol7wOyEryx4+sjVDqBG4a7rl06OsdHRaBjx
         s4Sa4omNE/ir3+C43UdJERUE9Brb1bSopkHR3LN+K62+9xogTeShBr6722X+Tcfzd6Xh
         eTgwjjevsL8DWMFBCYY1mfFkV6eFNEGeBno6spqk3+4mPtQS2Jifdp37vC1sa6Dvt9Qh
         kZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UyjWxlTffumZ9PEBc0JxIPESxGhrad5mIxeRa+8Uvg=;
        b=RNEOojWo5lcTyjZkeaXvBeZCdPt5Mkho7ilo+18Wxyb3V+5uSvlCLyCBbsgTuLUeoA
         GGKIyeVCL6g39jIGNgMlaIF+FUyUh1BigZwnuUKs8jU4YnzovR+ljXb3hBtPP10OAWrk
         JVfVIgcumP2bW8TNje3WsuQ5cWrBosIHSi6nU5pHFeibcCCQgZU5HfAcxkmRyC27543k
         WjLvRWCceEAxBqRBTe6DZc2pjCQzQyHT8laclOx5iXD0ZxYWhXKVg6u0MFgVPYtujZHY
         TwaY7SU5QhuqTmZH5uT8F1IS8LEI7xq5jWGs/ReenigJy+HrPiecRHgpEamVVEPA5lfe
         XQnQ==
X-Gm-Message-State: APjAAAV6stg/vf01+0OCpRgcm1GiUzb8iQ+7MUfvfwwU3JPmmHzJ3yx5
        Uv+MvRRbPW3X/6CFfZ2gbDb0eX/F0WUePqgqe90=
X-Google-Smtp-Source: APXvYqyurIeYKZV15eJfJ86OpivMCk8VlLYdeR/yBKL6SKmqpsxhAfU1wfoPgF+GvH96rXmC4uAnfoAj7jh99iBQhMA=
X-Received: by 2002:a6b:bcc4:: with SMTP id m187mr3520892iof.16.1566986121318;
 Wed, 28 Aug 2019 02:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnkvl61q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnkvl61q.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 28 Aug 2019 02:55:06 -0700
Message-ID: <CAPUEspi0z7cjdH7J5=VKcG1jXbhi0EeJecs-ApT39PyhAWp2Qg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2019, #06; Fri, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 6:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * cb/pcre2-chartables-leakfix (2019-08-06) 3 commits
>  - grep: avoid leak of chartables in PCRE2
>  - grep: make PCRE2 aware of custom allocator
>  - grep: make PCRE1 aware of custom allocator
>
>  WIP

this was v3 and doesn't sufficiently address the issue raised on
windows so might be better to drop it and requee it later on top of
jk/drop-release-pack-memory (so xmalloc could be used safely),
rs/nedalloc-fixlets (for maintanability) and ab/pcre-jit-fixes (to
avoid conflicts)

we have two alternative versions of v6 that could be used as a reroll
if you would rather do that, but will still not address the full set
of issues that will be required to stabilize it into next.

Carlo

Carlo
