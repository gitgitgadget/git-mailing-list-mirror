Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B457B20248
	for <e@80x24.org>; Tue,  9 Apr 2019 18:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDISWv (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 14:22:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39840 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDISWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 14:22:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so7079744pfo.6
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3hz37XpYppBz8M7ZI5UmCaA3ea9Nyw858XRFAF8O+yY=;
        b=fYxa4vUdyTmVVMpklUZaATLvgiW0tf5MRrw7NoY0DdrqCwGs4Xzmw8gy/GvuW/tUfF
         DgVTazQxnTSPH2FeA9HwirQpjFvl2s2RgUZgRNhz2LBgA6KT9OQlAePZ86YQrrBOPeOd
         GoxJdCxFOEC0B0PsPXnFhrpa9LoMq5L+EQ/CK7FXjLuzOwFOqtiL23myO34lOZJx3SQd
         v7pZ9YRnXV4E3GArd/wILJlffmXB7c7cFA9T/8K0XA9GhENFTK/Qk9HQeTEZslMYNvLa
         9zKNspz9sS6NEvI7GF5oj9q0prxxyQqMMIAMXjWbsvr6JWud+79Mts/BWXa8ZnIpN4c8
         lIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3hz37XpYppBz8M7ZI5UmCaA3ea9Nyw858XRFAF8O+yY=;
        b=ZANGTYeN4nbfSR+JUaVbY0e4azwlFjv7GkqoiWcOA4yfXNWWry4EByjD3vrbHFbPpb
         vCN+tfONp9nuk+/xF9KPp7AoiQYmqU3Ok4e8fCRoT62/ZTGUpLI11Cr5wirstzVkkpXu
         I7rdYjAU3O0pxG8UHQcwUS936WPr7T9u+brD0T0DDp4C7ITlU8z8GNWnykZb/GlLMukQ
         JXkfP+DClafDvvL3l4ZdHjIJk3qXdNW4pa8EYMeIFJSF90LHqg0J5T2utYwAGknVQ7LH
         SM3XDQxH8dmYdxEsQE58lyHAnEwL2esR+0Yy756+X01eewJMK+x0kXRpxNIa5agrPvMn
         t/QA==
X-Gm-Message-State: APjAAAWZXvyjN7LVIO43O1tK9/6FZN3mECkenZcmoaf6Fm0BO8EBeL7a
        XmfD44GQrbU4zjrvCzKmpGIPem9R
X-Google-Smtp-Source: APXvYqyEpRzaPzvzzX/Rw20Wy0/wHGKFJeN8cYbGtrhvNSQ5kg+5/VPILQSlfmbXFOvXhAZvy0CS6Q==
X-Received: by 2002:a63:6786:: with SMTP id b128mr36495457pgc.318.1554834170050;
        Tue, 09 Apr 2019 11:22:50 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id k186sm27534248pfc.137.2019.04.09.11.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 11:22:49 -0700 (PDT)
Date:   Tue, 9 Apr 2019 11:22:47 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
Message-ID: <20190409182247.GA7317@dev-l>
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Apr 10, 2019 at 03:08:09AM +0900, Junio C Hamano wrote:
> * dl/submodule-set-branch (2019-02-08) 3 commits
>  - submodule: teach set-branch subcommand
>  - submodule--helper: teach config subcommand --unset
>  - git-submodule.txt: "--branch <branch>" option defaults to 'master'
> 
>  "git submodule" learns "set-branch" subcommand that allows the
>  submodule.*.branch settings to be modified.
> 
>  Needs sign-off on the tip commit; other than that it seems OK to be in 'next'.

This has been here for a while. Did you need my explicit sign-off for
this? If that's the case, here you go:

Signed-off-by: Denton Liu <liu.denton@gmail.com>

> * dl/merge-cleanup-scissors-fix (2019-03-21) 11 commits
>  - cherry-pick/revert: add scissors line on merge conflict
>  - sequencer.c: define describe_cleanup_mode
>  - merge: add scissors line on merge conflict
>  - merge: cleanup messages like commit
>  - sequencer.c: remove duplicate code
>  - parse-options.h: extract common --cleanup option
>  - commit: extract cleanup_mode functions to sequencer
>  - t7502: clean up style
>  - t7604: clean up style
>  - t3507: clean up style
>  - t7600: clean up style
> 
>  The list of conflicted paths shown in the editor while concluding a
>  conflicted merge was shown above the scissors line when the
>  clean-up mode is set to "scissors", even though it was commented
>  out just like the list of updated paths and other information to
>  help the user explain the merge better.
> 
>  Needs review.
>  cf. <cover.1553150827.git.liu.denton@gmail.com> (v9)

Phillip Wood left some comments for me here[1] and off-list. I haven't
had time to address his concerns yet but whenever I do, I'll probably be
sending another re-roll.

Thanks,

Denton

[1]: https://public-inbox.org/git/69e3e5b7-58ec-4507-bc5c-c162393368c4@gmail.com/
