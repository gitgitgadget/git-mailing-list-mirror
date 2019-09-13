Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6EE1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 21:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389717AbfIMVco (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 17:32:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47044 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388719AbfIMVco (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 17:32:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id e17so28395984ljf.13
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fvKXWhCzTaasEYDSef7rZcH/lxO3cQgWiiugBwz0+U=;
        b=tu9zn58yStLtYromjPGYMK+DjSQf7vPx5qHGHe4W6Wo0TPirRaTOUJye30BZnMWe0r
         ZH191X+nL+DnMPFiBRpr7JHNsCOn7nkxGUIiIlfAGQjBmr01qUpWbtKw/jw5NtK5xwXo
         Icb/KYjFho2y9b0UqJlQ+oMihVlxfMjCiq36q7HvlrnGD/zkqwyYHKdoMziR8FVf0TSW
         PEji6sjEuEvC1o4l01TGoU2dCLokE3xEMxKI8Yn73P7ofyrb5r4bWcVrdnYUO46Gh9J8
         cV+ZdeQcJa/KZQbuqC0sOOvFEii7Z5u1rXPQ+LRBxqCibK/P1pgBHNyM5SIy91y4Sfew
         6hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fvKXWhCzTaasEYDSef7rZcH/lxO3cQgWiiugBwz0+U=;
        b=hMS7ijWNbGMk9i3qIncXT3KumyieZu2uGge6Z/9v7WY1IPvCbxQB2F8EXXpOxeZsJT
         U1SPM40sbj8DBRw5rzJY6i4TRIF81Ke5Ydz5Y3HU9JwgrAVmm9PYCuKPUje5a/q6ityo
         g25Vkwi5dGvOB5+KbmhY8Y0LvYGnTtoBH+yZ+sV3I878SynFbpIahBY6vz8oGunqz7Sv
         CCvL4lrupuILSWndm+1hbcCxVWgQUYGvaAHOdXKzVsv/AlxuD7KYovKsxdrkVUdRTdpI
         tIkg7KbEYwP3so5QJn/X+IYlRbz48pVLmJydYycZNiMSuf6N0d57Mr99WCH71xwOw+Oe
         wF4g==
X-Gm-Message-State: APjAAAUlqB+j8ljr9lcm0zAVsaB6zCWUgFAn7y4O8hn7uvgP5Ap0ihqt
        gr6/5ODZHjYGXkGtokdebqw4R7JCUp1/9lKQoKo=
X-Google-Smtp-Source: APXvYqw3/DqXZPI3J1CEhDDOhPEN9jRCMra+wRik1lhW+av07g5ssM79r7sjW/JITtp8abbFwaiCvUad2mGo8g0Zi3Y=
X-Received: by 2002:a2e:95d0:: with SMTP id y16mr13622715ljh.166.1568410361331;
 Fri, 13 Sep 2019 14:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190913143740.5zkrclivsvyj6k2o@yadavpratyush.com> <20190913211152.8860-1-birger.sp@gmail.com>
In-Reply-To: <20190913211152.8860-1-birger.sp@gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Fri, 13 Sep 2019 23:32:28 +0200
Message-ID: <CAGr--=JhBYmYCJNNm8DyL+MKU0V0V-cwzH4WABX-dvE+uXNwDw@mail.gmail.com>
Subject: Re: [PATCH v4] git-gui: add hotkey to toggle "Amend Last Commit"
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 4:37 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Hi Birger,
>
> I'm afraid you are working on an older version of this patch. You should
> be re-rolling [0], which works well with Bert's "amend check button"
> change.
>
> [0] https://public-inbox.org/git/b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com/

Forgive me, I get a little bit confused. Should my patch be based on
"next" or "master" branch?
Also, is it an issue that this patch won't work unless you merge
Bert's 1/2 patch[0]?
Your feedback cannot be too specific, I want to learn how to do this
properly :-)

[0] https://public-inbox.org/git/ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com/


Birger
