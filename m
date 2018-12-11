Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9A820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 17:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbeLKRhB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 12:37:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40501 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbeLKRhB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 12:37:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id d3so13229944edx.7
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgEpi5g9oz6Ex2zsawFnhYO0LEa5kwpYj2gN9NaTcBs=;
        b=uVKmyqGUCQRChQQwNqDr4ZP3JgaxZKpC/oi2LICw2XGr6uunc40nZhqbpbZgtghwos
         nWpwYgBu59ypNXEzd5oQrpbxMu2OEwP3VByrkIxKPXIhP4XRUiK6SNopAPLV9xUjKMHn
         pad4rlGFhAz8NmXJCyh4qclg+Q5a/b7QNzAi6T7whvTQhJ49NTGKN8k08jZYqe7fd6vA
         RyU8Skl7wBCoNyfAPeqm1K6VMYtQfEq/IH+zo2C+J0NCHuEDgMRvW+UpNmtB4u9JYlY7
         OAwa//eN02MTWUUX+Bly1GMedghHRcMxw2KsdE7L8d6mlMiqpXP4rx32vXUC0Cqn4BK3
         mySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgEpi5g9oz6Ex2zsawFnhYO0LEa5kwpYj2gN9NaTcBs=;
        b=I4TFFh7SIvpVikPz8UyqN2Lc2nI8KvJQ9TCI64pX/02XI/SZ/1uSTT5WN05RBTPWiD
         IU5JFUxlM5UakV7gKbDnzsQ0VMQrHSpH2KfOFp8MPZv1Xjdr3vpVPjOPPPvABeuFVqJA
         SKz3pwCAr09rbO4BarwjHsfkpfUzyvqHq784xq4fItu5FAx+jz4F0FDhD6NytpKyuxr2
         ETjFjDIy9YMe/0xzkC1D7nezW1isJm4RZ29EVaoE5LYFOK2t+ukLzTza+yH4CuD2sLgE
         gJU2OXFj7YG+6V2S3iy7Fz1HaUHBEhsUE746fOUnh2pc04G74mWaZfwO2XeFDhxX8RIx
         3AZw==
X-Gm-Message-State: AA+aEWZJDL9vOSBeq6fkBI6nP0u7S4DScH2bwPFFwL54sAIZYLHJhbyt
        TxECZtAJ2Nc6TCw6LcXm3SENC+mUNDEAXyLAWUrdPg==
X-Google-Smtp-Source: AFSGD/Vi3mhfWiNi6EZJiJT32LyQOXSUyZnuyYltHUQa4gFPbvjzZX6gwIenBmAHhQqfX6Ye3vQh5gTRFYJLj8jbdwE=
X-Received: by 2002:a50:f70a:: with SMTP id g10mr15532325edn.25.1544549818207;
 Tue, 11 Dec 2018 09:36:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.90.git.gitgitgadget@gmail.com> <d2c317fd-d10a-19c1-8b4f-a7311c69a52f@kdbg.org>
 <CAGZ79kY18SCaCBvkWyeVd+oeJ4EhoJK4=QxGhJ9a77iX2sR8ew@mail.gmail.com> <nycvar.QRO.7.76.6.1812111119560.43@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1812111119560.43@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Dec 2018 09:36:46 -0800
Message-ID: <CAGZ79kZL5CRqCDRb6B-EedUm8Z_i4JuSF2=UtwwdRXMitrrOBw@mail.gmail.com>
Subject: Re: [PATCH 0/3] rebase: offer to reschedule failed exec commands automatically
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It is amazing to me how much my perspective changed when I actually had to
> teach Git to new users. Things that I live with easily all of a sudden
> become these unnecessarily confusing road blocks that make it *so hard* to
> actually use Git.

I see. Without the -y patch, this series looks good to me.

> My workflow with `git rebase -r --exec "make test"` is pretty similar to
> yours. With the difference that I would want those commands to be
> rescheduled *even if* the command is flakey. Actually, *in particular*
> when it is flakey.
>
> I really see myself calling
>
>         git config --global rebase.rescheduleFailedExec true

Me, too.

Thanks,
Stefan
