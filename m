Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701EAC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 02:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547C560F14
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 02:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhHNC6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 22:58:42 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:34983 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236789AbhHNC6k (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Aug 2021 22:58:40 -0400
Received: from MTA-05-3.privateemail.com (mta-05-1.privateemail.com [198.54.122.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 6A2CB80639
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 22:58:11 -0400 (EDT)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
        by mta-05.privateemail.com (Postfix) with ESMTP id C18BD18000BB
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 22:58:08 -0400 (EDT)
Received: from mail-oi1-f174.google.com (unknown [10.20.151.203])
        by mta-05.privateemail.com (Postfix) with ESMTPA id AA31218000A8
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 22:58:08 -0400 (EDT)
Received: by mail-oi1-f174.google.com with SMTP id o185so18742722oih.13
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 19:58:08 -0700 (PDT)
X-Gm-Message-State: AOAM531hV84Q16K2RApU5q7wR1FJZ7MDN/OEDgsBa9PlC2M0Mwx26h74
        dCzz3CRisbgUck2k65qiU9HsJnVTe4VfJb7XTFA=
X-Google-Smtp-Source: ABdhPJxBBJ1hOaTatY8c4tr09AvZ5eKKIcQyg2QYr3JD4siUsyoEcvKYXgvpRN/hF2b8QN5443zplxAhdl0ETcLWFfQ=
X-Received: by 2002:a05:6808:b01:: with SMTP id s1mr4306367oij.105.1628909888247;
 Fri, 13 Aug 2021 19:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.1628640954160.gitgitgadget@gmail.com> <4f72cd3d-bcc7-a9b0-cc11-f0d7c5650365@gmail.com>
In-Reply-To: <4f72cd3d-bcc7-a9b0-cc11-f0d7c5650365@gmail.com>
From:   Azeem Bande-Ali <me@azeemba.com>
Date:   Fri, 13 Aug 2021 22:57:39 -0400
X-Gmail-Original-Message-ID: <CABye916n=EuKU3u2ybNtmT8Te9y0C__NsPR7Vdj9LKrf-y9coQ@mail.gmail.com>
Message-ID: <CABye916n=EuKU3u2ybNtmT8Te9y0C__NsPR7Vdj9LKrf-y9coQ@mail.gmail.com>
Subject: Re: [PATCH] help.c: help.autocorrect=prompt waits for user action
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Azeem Bande-Ali via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, David Barr <b@rr-dav.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 6:52 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> I think it's better to use bullet lists, e.g.:
>
> ```
> If git detects typos and ...
> <skip>
> ... git will try to suggest the correct command or even run the intended
> command. Possible values are:
>      - 0 (default): show the suggested command
>      - positive number: run the suggested command after specified
> deciseconds (0.1 sec).
>      - "immediate": run the suggested command immediately
>      - "prompt": show the suggestion and prompt for confirmation to run
> the command
>      - "never": don't show any suggestions nor run them
> ```

Thanks for the feedback. I agree the bullets do look much better!
