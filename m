Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E22BC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B58561100
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351951AbhIHQ5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:57:08 -0400
Received: from mta-07-4.privateemail.com ([68.65.122.27]:16551 "EHLO
        MTA-07-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350135AbhIHQ5I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:57:08 -0400
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
        by mta-07.privateemail.com (Postfix) with ESMTP id E2CB418000AA
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:55:57 -0400 (EDT)
Received: from mail-oi1-f182.google.com (unknown [10.20.151.243])
        by mta-07.privateemail.com (Postfix) with ESMTPA id CA30C18000A3
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:55:57 -0400 (EDT)
Received: by mail-oi1-f182.google.com with SMTP id p2so3927763oif.1
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 09:55:57 -0700 (PDT)
X-Gm-Message-State: AOAM53159vnO5bmtXpOOx0KqQNTRkgiA1N/X/xEjvl5OkVynMeFYw4jl
        MuXl+vcbLSvNFmnMHvb9iE+FA5i5hRRQOCyiz9o=
X-Google-Smtp-Source: ABdhPJyfQKv7Trg1CnYFDJDsZkpmwlrdTRjat9yV12Ng8lQ9muLHgrzMWJMR9gKdL0n7BD4YbVOkrtXuozhJPwersgc=
X-Received: by 2002:a05:6808:1892:: with SMTP id bi18mr2999488oib.105.1631120157298;
 Wed, 08 Sep 2021 09:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsfyf5b74.fsf@gitster.g>
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
From:   Azeem Bande-Ali <me@azeemba.com>
Date:   Wed, 8 Sep 2021 12:55:20 -0400
X-Gmail-Original-Message-ID: <CABye917yakh8sfGAmuLRiBXmYwTMo-zxquoAJTmve8cZme+G-w@mail.gmail.com>
Message-ID: <CABye917yakh8sfGAmuLRiBXmYwTMo-zxquoAJTmve8cZme+G-w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 11:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * ab/help-autocorrect-prompt (2021-08-14) 1 commit
>  - help.c: help.autocorrect=prompt waits for user action
>
>  The logic for auto-correction of misspelt subcommands learned to go
>  interactive when the help.autocorrect configuration variable is set
>  to true.
>
>  Will merge to 'next'.

Just a minor issue with the description: help.autocorrect will have to
be set to "prompt" for this setting to work.
