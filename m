Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC69C433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 08:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhLZIo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 03:44:56 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:40648 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhLZIoz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 03:44:55 -0500
Received: by mail-il1-f172.google.com with SMTP id c4so3274544iln.7
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 00:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyMlu+6WnfgFlah3rs0g8+5JqmhZFmFrqUxpvCe093s=;
        b=MX/hQAs0A46k5oJD6bhsfsPu0JwopZYWD5vvcmfdBi2odkjimGKb7fC7OfZGxk8Tvi
         GEg5iHsHni0KKbPJu/4ivdqjNKbqpyIS6ESNgZVOw3WjhcXigEwAzDMOCd5RaiVfWTSf
         bT59T04WIzlkzY7AJ3C8ySDiJf5q0TjBUxfCgB8hZ0v/pNGgnFCoL+ckKvmdwnTOZ8OQ
         HoNGx0PFYGkiP980CSM7iU3YFxTvDV1HMKu3jisw4eupugIbagTPypRLOHkIwiz0gl1V
         4ad72CdfZgZysdJpPO3ebFNPgw7mtDIImgrWqR0YwP/A56QEw2uFDfg3M55w2bQ9NscG
         Q4Ww==
X-Gm-Message-State: AOAM53057mEQM6x2GaR58hZV7dHf/UA0od803K3TmJYkW8mEhbKR8cli
        O+Z7yfFzfQWPGy0LgcDseAeM7X6Msm4qZO9gj8M=
X-Google-Smtp-Source: ABdhPJwZdRJCIuuEz98Yk/r2Jm/yTkqHZkbThDOH85vVqAnlEJu+/KvcY+a/MqTMkmLytsuOeU2odHit0xaF1q56A1Q=
X-Received: by 2002:a05:6e02:92d:: with SMTP id o13mr5520256ilt.49.1640508295153;
 Sun, 26 Dec 2021 00:44:55 -0800 (PST)
MIME-Version: 1.0
References: <71b51bc8-172f-48de-7c3f-cf55dc45b39a@gmail.com>
 <xmqqlf0cjuwx.fsf@gitster.g> <d51b7981-5034-b34c-42d6-ad8b80a378c1@gmail.com>
In-Reply-To: <d51b7981-5034-b34c-42d6-ad8b80a378c1@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Sun, 26 Dec 2021 09:44:18 +0100
Message-ID: <CA+JQ7M_GhE=vcpoCSPEnSPoLA1xZM3uVMuGw4goPe4AmQip2hg@mail.gmail.com>
Subject: Re: Rebasing commits that have been pushed to remote
To:     Lemuria <nekadek457@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Alright. I'll take this into account. Unfortunately, before you got to
> me, I reworded the commits on my local and pushed them to the remote,
> which resulted in a messy history with duplicate comments.

This easily happens
Usually when you merge old history back onto rewritten history
It's easy to confuse what is what when rewriting history

If you find yourself rewriting and force pushing a lot
you might find the following script helpful
https://gist.github.com/CervEdin/2e72388c3f7d9b30d961ec3b64d08761
It shows:
- The graphs of differences between local and upstream of a branch
- The difference between local and upstream
- Prompts to force push with lease

> But at least my GitHub page has more green on it!

If you want green you can fork
https://github.com/cervEdin/vanity
