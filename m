Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFEDC433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 19:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A076564DAF
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 19:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhCNTsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 15:48:51 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:34346 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhCNTsu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 15:48:50 -0400
Received: by mail-ed1-f49.google.com with SMTP id y6so14826533eds.1
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 12:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHQTy/x6cRYPd0/waD16gU2kBdfAwMOHDmgDDtAYlS0=;
        b=SFX98KKNX7Z39iVWw9cmXzggSf+vqyG/vb/mCgi+SLLf6Ob0UCDrpWmAP2f04lUp3T
         X9NUF/19t4GfaeFmqkic/c33rNGvk7OeVW5VDyK6LVEyG06R3TzFjnF2SB3+K90KA1Hy
         7gc/QOJ187STyKx5Akgs0qOuF3tjfYhqf4Gp7IC+MB/aE4AjczF4cGIVx6K2o3lJ1RV0
         5E0US+PnUNZy3TystseAptirEBfSVF3Meixswu7MfYpji7kKHqOUDDSnWKSYP0cUE0JP
         03hFdJJag3dRaNUof1aV8ycD7I3BBnbrKIHtwNkd81RFjajMCL44hOFrwvxZemH6eV4e
         jf+A==
X-Gm-Message-State: AOAM532yyBiG4twbrIsCgCq+rA9fmAhNPEcibXhwmjxhuSmBH5WJ6bI5
        MoLaedQFdSkF2kj1H+KpFNEVp6lcPmzW4h51dt0=
X-Google-Smtp-Source: ABdhPJyzciq4b4z+6BD0OwEJXxYhVuw2RqBUuYjuuAFsWUMiKR+PAEx+7IFj+NG/i+ZUD7uXesnKRtQ4riE9ysmnFVo=
X-Received: by 2002:aa7:c551:: with SMTP id s17mr26418674edr.291.1615751329160;
 Sun, 14 Mar 2021 12:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <pull.899.v2.git.1615747662.gitgitgadget@gmail.com> <4397c1fd80205d142fbd184c6d13fd07c4dbfa21.1615747662.git.gitgitgadget@gmail.com>
In-Reply-To: <4397c1fd80205d142fbd184c6d13fd07c4dbfa21.1615747662.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Mar 2021 15:48:38 -0400
Message-ID: <CAPig+cQe8hgz-3D6oN-YoG2KB8F=R0q-eJTdCjOFZo74XnsiOQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] parse-options: don't leak alias help messages
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 14, 2021 at 2:49 PM Andrzej Hunt via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> preprocess_options() allocates new strings for help messages for
> OPTION_ALIAS. Therefore we also need to clean those help messages up
> when freeing the returned options.
> [...]
> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
>
> fold
> ---

Unwanted "fold".
