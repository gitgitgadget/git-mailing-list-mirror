Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471181F453
	for <e@80x24.org>; Fri,  9 Nov 2018 02:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeKIM0i (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 07:26:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52667 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeKIM0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 07:26:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so624819wmb.2
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 18:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=5E7KRKq2CRZQdh+LgIl8C5PTtB5qxm8eNR9EoxEwM1E=;
        b=koQt0VK4YMbpPYHQsMV5VqZazO9bI2suuJyyFOAB4O7Ycx6SdPWG7dme6cGDgfUx/T
         uv2HtT++Jkvufv/xy0dLCergDC8C6e9BRagOqOulydH4cUVp2JrCpZK2p347RKcUUg+c
         yQhb5uKC5/Hu1BBtcYADzDLCUxBfeYleFEijcj1nczxNY3xcml7RLcbtiBcQfWjXaLgk
         4jiQFyVJhO610JDIdhj6F/NZDkkvlkStnNuBVk4e9qqzrsmRvtX4DxixUxkaQrbJnN9p
         /r7LgopSqqpuq2Uty0Fk2aH9cWSx5sKBRHYq+De6fKJIsSINR87+di5Ftvo2TSaeFN9+
         85NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=5E7KRKq2CRZQdh+LgIl8C5PTtB5qxm8eNR9EoxEwM1E=;
        b=IhSdIWgiHN5Ptr5BQtmivMR2sbSRqZgARHXVaoWsN7FuHlLk5irmy6UoHGseYWu3Zq
         X5ywbK2H/gbN6MYGrcbCLD5fJN6jSUTsgx8I+Xwnrk1OOcXuyyoOgd9FvIUfbAPYMQy7
         UhthDOpIc/g5SQ3L5zbr65JS8X62Y3ew9c6Tc8+0Wzhs7Vxk+MOi++U+8a62lvmRisV0
         bfGsvwTrR7xLh/abremejkbkOHBkBNd4narsepNp1LvuXzIOG8voEHyz0skqFnr7ngWC
         dnXvet2zdSSWEhTwtXZ2N0KxnrxxSmpE7tzlfoM+Tq6pvSmfQyqP4oqTq5kfXK/PXWXW
         iLNQ==
X-Gm-Message-State: AGRZ1gLbqNQQ6zfDk2b/jKjmsWtEann4jY67RkiRr6myZI/rjIuO0XiB
        lBOBhfJLBu/uRQSTT0gvcSk=
X-Google-Smtp-Source: AJdET5fHOvrAUKC5nK4N/wbtGT/YxQAl7O+asetiZi5Kn22C8cKeqmftiwnSozM85ovQQn5uAG85oA==
X-Received: by 2002:a1c:8b14:: with SMTP id n20-v6mr3271676wmd.34.1541731683107;
        Thu, 08 Nov 2018 18:48:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c184-v6sm156486wma.15.2018.11.08.18.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 18:48:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Update .mailmap
In-Reply-To: <b590a9bebf8ac10b6f1d85287bb8d7a8ac7082a6.1541696887.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 08 Nov 2018
        09:08:09 -0800 (PST)")
References: <pull.71.git.gitgitgadget@gmail.com>
        <b590a9bebf8ac10b6f1d85287bb8d7a8ac7082a6.1541696887.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 09 Nov 2018 11:48:00 +0900
Message-ID: <xmqq5zx76k67.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This patch makes the output of `git shortlog -nse v2.10.0`
> duplicate-free.

Did you mean "v2.10.0..master" or did you really mean this covers
authors recorded up to v2.10.0?  Judging from the cover letter, I
think you meant the former.

Can you say a bit more about how one among multiple addresses for
each person was chosen in the log message?  E.g. "After asking each
author which one is the preferred one", "Picked the one with the
most recent committer timestamps", "There were two for each but one
of them were bouncing", etc.

> @@ -150,6 +155,7 @@ Mark Levedahl <mdl123@verizon.net> <mlevedahl@gmail.com>
>  Mark Rada <marada@uwaterloo.ca>
>  Martin Langhoff <martin@laptop.org> <martin@catalyst.net.nz>
>  Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gmail.com>
> +Masaya Suzuki <masayasuzuki@google.com><draftcode@gmail.com>

It is a bit surprising that we can take an entry without SP in
between two addresses and still behave sensibley, but it probably
makes more sense to add one just to look similar to other entries.

Thanks for working on this.
