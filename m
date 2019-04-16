Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3805E20248
	for <e@80x24.org>; Tue, 16 Apr 2019 21:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfDPVN6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 17:13:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46731 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPVN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 17:13:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id z17so24986511qts.13
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sl2fxE0wTkfSL4n1PYBizXqrJAEAmnq9raGtJCceqSE=;
        b=l35ifsH4mtsjLq7HxutqzUXdeBRe8z3HipymyLIIgYwii+VrHhA834Ngm7O9sFQT0Y
         XK/oJ58HOgBVe73165bql1FMt5srL7Gw7Vr/veMXtiSOMayKV1qOewbN90ENzBwNM6I2
         C05wN21LA2UYKqGfee6UOG2d5YegH4mpsH77pTcYUWGWCjxeJG51Zj7aqUqPV6+HTWt7
         Fjf7iTqXoe4f5AbSA8VVnpXMVw/AZS1ZUMk3B5ucwjz4Zqc+sbOQLFMcxCnkq+n0XQgP
         sdKPHHQyMBp9dr4SUpkeCWl8tpZIAilpE4TgHcbZGCBI3nQsxfvD5YVYiHjRHDhE1Xb/
         19oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sl2fxE0wTkfSL4n1PYBizXqrJAEAmnq9raGtJCceqSE=;
        b=eDCRaaHtx/T15HIflFxaCPY3gixS/8JACX6L+iZC0bhYc/BTebN4BdQXfTLMMislPV
         aKDQR8poYLX3Haa3As5c0yUCNhJUQ9AvRz4ZSlLLNQ/ntTjzYf9dywyF9sWKWU3uIYKW
         +oLtm6bMrG9w+1lRGnP+0dBGHK6QrYfccLQ0o4KUteOdU/KOzlKUVGBPY8vLX8je2udT
         lhfL5IHnJtMgjgo5iK5fVP/VkWzD4L5jNRq53lux5h7Al+OSSe6VrC+YpHFEVPrIBmwC
         neZyY0rf9HrIWy2ZXesiqb03n/IduoX3GrKh0qZMRyDBPwEv0J8Wifp/RTpAfBomChaT
         kp5g==
X-Gm-Message-State: APjAAAU+PCyqJVP8paGGOP/TZ46JjP7xfRJRnK6n4D74lGYMWyj97id0
        z8gSnbW3oSW3eTgzYclxNAB4m8NXfaW+EAfm02LsUg==
X-Google-Smtp-Source: APXvYqwVSrcaBJ7c3yUpDoY6Ay19TPsJe8S5K9/l7qXER0dMAzIdxkGhPb+7TmK7opkl6Wnvz6sfzQGMnoVTLlcFg3k=
X-Received: by 2002:ac8:6915:: with SMTP id e21mr137768qtr.350.1555449236746;
 Tue, 16 Apr 2019 14:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.177.git.gitgitgadget@gmail.com> <pull.177.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.177.v2.git.gitgitgadget@gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Tue, 16 Apr 2019 14:13:45 -0700
Message-ID: <CAJoAoZmrdXXssM_kP-Y8Up+5yFPTP+2oakSciOXr0qypcJcVeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] documentation: add lab for first contribution
To:     Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 16, 2019 at 1:26 PM Emily Shaffer via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> RFC. I am still working on adding a section on handling refs and objects.

Sorry for the spam; above line was stale in GitGitGadget. The relevant
section has been added
just before the help page. I think the change is complete pending
review comments.

I've also added instructions for using send-email in addition to GitGitGadget.

Thanks!
