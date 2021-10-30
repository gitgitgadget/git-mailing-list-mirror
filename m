Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39F7C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 07:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F4F60FC0
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 07:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhJ3HwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 03:52:22 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42877 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhJ3HwW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 03:52:22 -0400
Received: by mail-ed1-f54.google.com with SMTP id w15so46518041edc.9
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 00:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npEJJV4UVTa9c0hA5pFeT5YUIoR0zxWCRlJRv/D6pbA=;
        b=fyNVRuM3u7ks4lDPbgFufMPmIKWU8dZjnz70mCXYJiPB5mGcTgNTDcQx2vuW1dOgFL
         9ZPb9L5WiBI34LiQlJW/71XghRxemWROv7Pcsx+J5/zZ+ys2+yF0b3VOIdfLB12jpl3R
         MNgvd6BjphMjYix48oiEHuwpOhwUcbWqT1IQtGZ0/9hwPRV1RRvfJh1J+OYUjZt8w/D0
         6SYrqi7Ts04lNrw6HyUvGVdh1fMRkmvkITnAaW1R6MfvdAKQ0NVGWchiDl31ru+HMDrm
         KypDeJt13xlrXblrdJ28sh/ehBj+ERthT/1s3mey4JKDttlBJuXcdSg79UeHcVOz3sqs
         LsJQ==
X-Gm-Message-State: AOAM531MUJuxcewwd+i6za5LBtN+YF08sxXtE5tapVU7SUmDB6GqEBVn
        ggz2E/eEARe+2Y1LvJ9igHgX72jVtUtZKJxiUWCS/tMT
X-Google-Smtp-Source: ABdhPJwzB/44WlZJzra53tgB7R3Xx7ei9TNzJMF36Icm5KaiFJgBl8OnfanGcEdzTHtaUOfUkxLe5xi7tNnI5Nnc6tM=
X-Received: by 2002:a05:6402:1d49:: with SMTP id dz9mr21405927edb.55.1635580191469;
 Sat, 30 Oct 2021 00:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
 <33cd9b2e8a675bf79132d312da8b7d8f4a2b84a3.1635343531.git.gitgitgadget@gmail.com>
 <224a256e-8700-047d-bc12-834524a3c8f3@gmail.com>
In-Reply-To: <224a256e-8700-047d-bc12-834524a3c8f3@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 30 Oct 2021 03:49:40 -0400
Message-ID: <CAPig+cQ2TXZtZphdkWQP9W218YUpL3mFbDo1j4Z+SjmACMfDEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: add headers in MyFirstObjectWalk
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 30, 2021 at 3:33 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On 27/10/21 21.05, John Cai via GitGitGadget wrote:
> > In several places, headers need to be included or else the code won't
> > compile. Since this is the first object walk, it would be nice to
> > include them in the tutorial to make it easier to follow.
>
> Patch title should be "#include missing headers" (dunno?)

If the series was being rerolled for some other reason, making the
commit subject slightly more precise like that might make sense, but
rerolling only for that reason is probably not worth the extra work
for the submitter, the maintainer, and reviewers.
