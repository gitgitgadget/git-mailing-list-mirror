Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C36C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 04:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA1C230FE
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 04:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbhAGEKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 23:10:07 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:41279 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAGEKG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 23:10:06 -0500
Received: by mail-ed1-f41.google.com with SMTP id i24so6407474edj.8
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 20:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9FCrXVtXgEXCLpb0nqqPiAofWeqo6PwQhKjgFDRogo=;
        b=XBxuQPYvm7qmROMxIOirAG1RRQsHlkJV6B9J+FL/h6qAJL7GSmN52B1jooFGG5Fcps
         Jwn3vfVLQk2+rAsNYdYxjpzLkAf6YjuWBlvUbFHgyoij+IP2Whj6mvu4SvN+dglZaT+u
         WVfUbKEcvnDqf4w5/MTHymtwvfLaqyGzzEBZGPqyRCFMiUf9SEqu2qUqhSaptyymMTf8
         /DeQu5WiprR9KbM4A39No6ActhLETdV2lNoaDcIM5RhDxWTkm4n4LUNADfRQFPK4fCJK
         XTjzYULbsnyYToV2JOZqHEBnaDE6ptQlddn7bYyk/Tl9M3f7FC44f2pTZ8fggmBTT+Ig
         Ndlw==
X-Gm-Message-State: AOAM5309kJBvw4/MetfwZZjN4rB0jxgsr6Py/d6wjULz8k7DVDqf9qUK
        1J61g9aH86ZLzOwJxqTzrOKUJdeOFvYGaBPnBbI=
X-Google-Smtp-Source: ABdhPJyEA4Xqgu+fX1B6ukfIYbO/dzIYiX7haJxrnaEc3HlM2lLa4iZpAt2LtGOtTITA8K9BpQgNPYiD+sm0nBRrlbE=
X-Received: by 2002:a50:f0dc:: with SMTP id a28mr201748edm.291.1609992564876;
 Wed, 06 Jan 2021 20:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-7-rafaeloliveira.cs@gmail.com> <CAPig+cRysXpK0e1xXOuVd+EtkeyTk8FR6MUrL=Bg3W4ve8jdNA@mail.gmail.com>
In-Reply-To: <CAPig+cRysXpK0e1xXOuVd+EtkeyTk8FR6MUrL=Bg3W4ve8jdNA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 23:09:14 -0500
Message-ID: <CAPig+cSTCnJR0BPdYOw=Kkd=p52kEPKZXefKsW5SXTuiEHytdA@mail.gmail.com>
Subject: Re: [PATCH 6/7] worktree: add tests for `list` verbose and annotations
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 4:39 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Finally, I haven't tried it myself, but I was wondering if it is
> possible to make a test which shows both "locked" and "prunable"
> annotations for the same worktree. Would that be possible by
> specifying a particular value for `--expire`? If it's too much work,
> don't worry about it.

Ignore this stupid question/suggestion. A locked worktree will never
be considered prunable. Don't know what I was thinking when I asked
it.
