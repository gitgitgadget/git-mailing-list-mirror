Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE4D81F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933051AbeFUUlc (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:41:32 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44831 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbeFUUlc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:41:32 -0400
Received: by mail-vk0-f68.google.com with SMTP id x4-v6so2668120vkx.11
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eFWpTr28yhi/wp9ihRjBZeQN/eQGqDcCU5Fh07VZbuw=;
        b=L6+46sOQST5nGqDanyGX2gvJBgHCPtO0h4BG61vpKUi5nkYIlPdMf6mc6I8e72iT5b
         P4NJ1vz2ISOG/6OrJ4DkpnlMxpxye6pTFWzS7bIZ5VOYKPTej1awMZFjTpV0MeJpRAB/
         g5dQZVmNE3xWdLtiT+uskNCceiCz/8wFIO52ZLSqJWIlw8ma6US+A2cT4cHes0mI01+Y
         hSsDH6i4kUkdWK46lCqY7OwJ62O4MHzpcNDHYjSUSNOhed0ILQ8LLOX3pW0+K3TA0yoC
         C/CGVRg6Dft36cSrkWYrjrPy95ydeE7purrZWw6vtdGZvaqTibI8RhJOFRgCH2fraYIo
         /Tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eFWpTr28yhi/wp9ihRjBZeQN/eQGqDcCU5Fh07VZbuw=;
        b=U9sB7ulwFhV20eP2eFVU6rfmDgag/b8w5Mh3crrMByytQbdDpIEmp4Rewf9DITpUqD
         8zN63drxOxEUGR6pr0bDyJlS5o7Dew5hw7sdm82VpkJ7LjEaT3fhZfpWpiLJYVWGMcx/
         SOpEDxHG8CzHe2D6WtsKqIe26/8jjcOSgy672F4PkJvgotfY8K0g165OkUjxjzeTN2Ye
         rsgV0Ccj41Ha6YC4fGN9avl64V/vDVZixxSHRjUvn3zyUhf2r0dOLCRyKO4sHsu/R68E
         2VvUwxXPA6HX+hsPK+bUprm+wS7ANtkRBXysZU7mxYsN4sN7s7Hu3v7jJrBdN9kbrmrQ
         LskQ==
X-Gm-Message-State: APt69E2P3JJTFwswUL1QeEkir/ML+4NUEbNb2JFt1bBaoWiLQVSA4TLf
        xx1FMWIDLxw0bXXTuJFWoW00VBa4xpveVex+cDaXOA==
X-Google-Smtp-Source: ADUXVKI7MBJ2J1WgEIi7LgKr/UfUGhFEqb+zGXSezgD5Ae5hEmKu6EzNq3K2uB5dRlTGmTd9jdOrW2AaDVwjdLOatRE=
X-Received: by 2002:a1f:2c0d:: with SMTP id s13-v6mr15780830vks.106.1529613691376;
 Thu, 21 Jun 2018 13:41:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 13:41:30
 -0700 (PDT)
In-Reply-To: <xmqqr2kzsx1l.fsf@gitster-ct.c.googlers.com>
References: <20180617055856.22838-1-newren@gmail.com> <20180621150023.23533-1-newren@gmail.com>
 <20180621150023.23533-5-newren@gmail.com> <xmqqr2kzsx1l.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jun 2018 13:41:30 -0700
Message-ID: <CABPp-BEbVhG_=DzfhNd+rA1mOyN0QLKNYOXRVx7Arj_LjjwLXg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] git-rebase: error out when incompatible options passed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 1:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> +if test -n "$git_am_opt"; then
>> +     incompatible_opts=$(echo "$git_am_opt" | sed -e 's/ -q//')
>
> This is probably just a taste-thing, but I'd probably prefer to see
> the "sed" filter out "-q" alone, and make an effort to leave future
> things like "-qx" alone, e.g.
>
>     $(echo " $git_am_opt " | sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
>
> or something like that.

Makes sense.

>> +     if test -n "$interactive_rebase"
>> +     then
>> +             if test -n "$incompatible_opts"
>> +             then
>> +                     die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
>> +             fi
>> +     fi
>> +     if test -n "$do_merge"; then
>> +             if test -n "$incompatible_opts"
>> +             then
>> +                     die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
>> +             fi
>> +     fi
>> +fi
>
> Not making --merge and --interactive incompatible as the proposed
> log message said makes this hunk at manageable complexity, I guess
> ;-)

Right, and since --interactive essentially handles --merge just fine
and I'm planning to soon simplify anyway[1], at least once ag/rebase-p
merges to master, I didn't want to make it any more complex.

[1] https://public-inbox.org/git/20180607171344.23331-3-newren@gmail.com/
