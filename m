Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55E91F954
	for <e@80x24.org>; Sun, 19 Aug 2018 00:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeHSDzU (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 23:55:20 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41121 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeHSDzU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 23:55:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id p4-v6so1810893pll.8
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 17:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a9pmXEr4+SuObHQWW55xlxWaqrGIuWTIkheWnALuSPk=;
        b=LcvlK/e2JtjrZ2sjxv+QXfOwahKObWTX0b/Z7kgwuevRUgxClWP7DiQzhKbLEUkINY
         yscDI+UHgkDcVM2+4ucrTB9fuWKiGVktURBZQ8zXErwWHj8L3tJkzy2uO19TdXaF/7X3
         exEs47c/iZKj4VykBIKKqy6uDSQc9CCqsM3Bqa5Q7uV6XH+bcK9I1ptbEpKElNOH83Gh
         x65/ZFV8prcA3jeM1fOd43xxN06xJW/qUQ1lKee0SoAZKGzyf1D981RcnTvNR71cYcja
         pyTnQ6FnPKZEJ5z1WXlXzyZ4OG0Ptq7pOdGfvYYLQD9WHu+01+PgA8VkTC7jT+qgJ09S
         aM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a9pmXEr4+SuObHQWW55xlxWaqrGIuWTIkheWnALuSPk=;
        b=r5OoYtfLYqEQSZTkbCzpovxEfOYo6uS7idGnhzQO7pcYcMUZ8DqyI3UR3+6MR7fyqU
         FAZrJ4iPJjpMpqYJOXV73Thru3jX0MoTESPEwtmGqxOysxE1IJLVQN//USh12EvW1Qm8
         5xI9ESuzw+mfeHAxxwvwbkM5/XIeJcH4fM3UQZxNJSh89Lt73aBzd8MwkI9jKZ7yh2oo
         kS5+KnAsWX9GPv1q/gIkXrlGcyxngudQrod1CgE+uaK1bvyAGdMLW8FiLx3bvfHdl5Zx
         Cd5npI39YbQy4CHE7+WMjwIE3PLI5iKRdsI/vSOhVhtYQkpBH9+kH9iSV7PleaTbUVZO
         J9qg==
X-Gm-Message-State: AOUpUlEuRrAkiGh16B9YsKI4pPfR6PDQTF825OqelKOHFWV9EPxTz+dU
        QnqlZOYpCTMifkrBN2R0CZcIeRprGBi1aoMXwxs=
X-Google-Smtp-Source: AA+uWPwMh4fE6nXTmJNMmi5+cl1ug2QGJeMt/LB/Fyr0fO7SvDdWBTpDzWQY/0ASU1iiQk0E5I74EaTFWF6qxS1YOzA=
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3-v6mr39307186plt.252.1534639545883;
 Sat, 18 Aug 2018 17:45:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de05:0:0:0:0 with HTTP; Sat, 18 Aug 2018 17:45:05
 -0700 (PDT)
In-Reply-To: <20180818225052.GE144170@aiede.svl.corp.google.com>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
 <20180818225052.GE144170@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?Michael_Mur=C3=A9?= <batolettre@gmail.com>
Date:   Sun, 19 Aug 2018 02:45:05 +0200
Message-ID: <CACSZ0PzcvYNtZEHqWCrU-5+hT=YeJ4DHpJ0j83QYn1qVEs5fjg@mail.gmail.com>
Subject: Re: git-bug: Distributed bug tracker embedded in git
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here was my reasoning for the naming choice:

- I need something meaningful
- I need something that encompass the idea and features of a bug
tracker because the narrower ideas and actions will be in sub commands
- other projects already used other words, in particular "issue"
- it kind of sounds and looks good

You say that it's a namespace grab and I understand that, but in the
other hand, there is not that much freedom when choosing a name. Sorry
if I'm stepping on someone's toe :-|

2018-08-19 0:50 GMT+02:00 Jonathan Nieder <jrnieder@gmail.com>:
> (cc-ing Elijah Newren for the points about merging)
> Hi again,
>
> To avoid the other thread shadowing more important things:
>
> Michael Mur=C3=A9 wrote:
>
>> Someone suggested in the Hacker News thread [0] to post it here as well.
>
> Thanks to =C3=86var for that.
>
> [...]
>> git-bug use as identifier the hash of the first commit in the chain
>> of commit of the bug.
>
> Clever!  I like this approach to the naming problem.
>
> [...]
>> Git doesn't provide a low-level command to rebase a branch onto
>> another without touching the index.
>
> Thanks for pointing this out.  There's been some recent work to make
> Git's merge code (also used for cherry-pick) less reliant on the index
> and worktree.  See https://crbug.com/git/12 for some references.
> There's also been some heavy refactoring of "git rebase" code to be in
> C and be able to make use of library functions instead of being a
> shell script.
>
> That's all to say that we're in a pretty good place to consider
> introducing commands like
>
>   git cherry-pick --onto=3D<branch> <revisions>
>
> In absence of that kind of thing, you can run commands that need to
> touch the index (but not the working tree) by setting the GIT_INDEX
> environment variable to point to a temporary index file.
>
>> I'd love to have some feedback from you. Contribution are also very
>> much welcomed.
>
> Can you say more about the federation model it intends to support?
> For example, do you imagine
>
> - having multiple copies of a git bugs repo that automatically fetch
>   updates from each other
>
> - having explicit "pull request" synchronization moments when the
>   owners of one copy of a bug tracker push or request a fetch of
>   changes that have been happening on another
>
> - individual contributors using an offline copy of the bug tracker
>   and pushing push/pull mostly to synchronize with a single
>   centralized copy
>
> - something else?
>
> Thanks,
> Jonathan



--=20
Michael
