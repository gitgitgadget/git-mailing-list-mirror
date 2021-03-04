Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C32C433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 03:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7184B64EEF
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 03:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhCDDnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 22:43:02 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:35314 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhCDDml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 22:42:41 -0500
Received: by mail-ej1-f54.google.com with SMTP id dx17so19047137ejb.2;
        Wed, 03 Mar 2021 19:42:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWjGkxRM9xTK3Oxe58Zk6wy2u5TkskdEma3Q5K5bnV0=;
        b=cD7KcsD92IHbazc0lPeiBdZNyecvbUMGh6T4AT5Ww5ZjSnyQ7olr5MnXwCgA20HxxP
         pRCi/eTd2nI831PqpWghqlX2ZV+7uRnrfbgzzUZAECt/24nISAuKD1GOHRgHBnDwGQQc
         a5hIFvfN4/tOlgAF8OyFT16/V8rESVYr/FYY9o1kXKxK8R+s2jYz0yi9bPrBc532J71V
         ZfxFzPUZ37WAeYBHc7alLsDFnS3AsZR95crQx90jiOE6cDPy5HMegcA9YWFKQoT+qm3R
         WiQ3hellC7Vu2dSgbhtNbowxQud8YJs+oU5OCG2L/hOMKge3M8k6DCXn3syr5LsX0R7Z
         28eA==
X-Gm-Message-State: AOAM530CVS1IBghEPH2HTBfVo8wfVwEv/5FevtYByKnRePpJmgaG26wn
        x0xRnyS4m7zGA0RKO1nEGnTFZSytejcr+P9XAqk=
X-Google-Smtp-Source: ABdhPJxNs0kWsKEcqBHTKza6uK/Ep/qWjS3ZdqweJtG+HT6UWS0Gk+XXDm3Bpf4w8Um9XD1M4IEnWzBuIES5LJ9aCGk=
X-Received: by 2002:a17:907:76b3:: with SMTP id jw19mr1991870ejc.202.1614829319883;
 Wed, 03 Mar 2021 19:41:59 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1kwk0h9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1kwk0h9.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Mar 2021 22:41:49 -0500
Message-ID: <CAPig+cRqED-d_hFN80UuPhS+77k6qw_G9Q-m9tWUZsNynQfVvA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.31.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 3, 2021 at 7:23 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine (3):
>       worktree: teach `repair` to fix multi-directional breakage

The merge message associated with this change is:

    "git worktree repair" learned to deal with the case where both the
    repository and the worktree moved.

which seems worth mentioning in the v2.31.0 release notes, so it's a
bit surprising that it is not mentioned anywhere. I haven't
investigated how the release notes are generated from the merge
messages, so it is unclear if this is a mere oversight, an intentional
omission, or a tooling error.
