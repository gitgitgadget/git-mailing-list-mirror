Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEFAC433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EECA20872
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgIOWtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:49:07 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:43367 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgIOWsr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 18:48:47 -0400
Received: by mail-ej1-f68.google.com with SMTP id o8so7379804ejb.10
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 15:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZ4c8xJXkwxVkZ4jr9B/Gb14AEPuGfpv7HvvxyB6I6k=;
        b=b475QMkNU/f3UZccj9lDivFXL3L3ddeQXVGK+TGOp7VzdoIMMZZp7P2VQ/y3VFaSxD
         euidF85mR/UHS9AwKShlszcoYvkxqMXg29spr4NMI/04+ZrdlgDZ3xDsOl6TsICCbMxD
         fWL6CRTcHMXvHma/yteZCwrkwEecYzixmoJaGKvQS1t37mWdEXuncRqHwKbbTLeX9YqP
         wLy4U1+MFnTim82c0hXejHZI4uLlM0x0MJgfUSPJgQgKgXVxqHmbeLU6W4pOnJjCCinF
         VpGhM0SwSK3bWnqim0mg8OmH2gB+L7WlcoCWDWiB6USsNVKbhf02iuMK7fmNzkPGyQed
         Ma3A==
X-Gm-Message-State: AOAM532ri7UTMyw0D+5EiJJQdtIWky64R/XMjRK6LExTQGz/D9E2WZAl
        /xfutrcsNC+JsHL2h8SchaAvsV+pV4aaPEjOjBY=
X-Google-Smtp-Source: ABdhPJx5BeGcq7Rl+GfvDOykSsj/4CovykHlRURNZTkJ6GM3PiEfo8qW6eH8zbk4HIgLVUUfVTM2YcI5trxtDMzulO4=
X-Received: by 2002:a17:906:250a:: with SMTP id i10mr22021734ejb.202.1600210123504;
 Tue, 15 Sep 2020 15:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com> <CAPig+cQnnukVoJTgsu1sGFWkAYv7V38-0s-CgYuMyizYHhSFQQ@mail.gmail.com>
 <xmqqimcms06h.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimcms06h.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Sep 2020 18:48:32 -0400
Message-ID: <CAPig+cQenifmJ5TW1Sh0zimmbAGDXvfkJRTVDg0nyRJ1vfU+wQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 12:52 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >     "git worktree add" learns "-d" as short for "--detach".
>
> Thanks.

Since this thread is active again, I guess I'll nudge this a bit. The
es/wt-add-detach topic still seems to need the above tweak to prevent
it from being inaccurate[1]. (At least I don't see the updated merge
message in 'seen' yet.) Thanks.

[1]: https://lore.kernel.org/git/CAPig+cQnnukVoJTgsu1sGFWkAYv7V38-0s-CgYuMyizYHhSFQQ@mail.gmail.com/
