Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC41A1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 09:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeIEOTm (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 10:19:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33018 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeIEOTl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 10:19:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id z78-v6so4430317qka.0
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 02:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRJyWjvCd0Htt+2aVSumfl4/aYfP9elvZ731qz1XPPg=;
        b=P6DwesJTgaMlkxDJcsKC2QUNlF/uqWiXJPVNv/JSWA9aJVHyI+/M0L2a6zEOUSg0f+
         HhsdUdr98MUNopFm5D8YjimYZqyD6guU+8CpC6OQGeOjinjMTiio4elz3j+rURji9Hss
         9DnqFVk7Lpp4mfcQ+HyULz/l2q3r8F+dGRzKbqM88YoBULKONNA3iR7NMdKUIYBgW3gK
         e0EQAtAxjtwh+HUUJt2jHZBCsbpQvSmZdT9z+8DAOC8dh6WlcmjGfAn8kX6xHoP9B5vX
         R5rYdB2epKwAjHK0SKq5qtR0bPesuStz32gYEUvMwEW7MjdOia5driHh5Ew0zoniFTkm
         Hmbw==
X-Gm-Message-State: APzg51ALIpOcJvOahAdHJbl4iX61OgPNkHF6dJ57h3SEuxAxML4nTXGU
        Wd3cTkfse5VhUaXWDAvnDHHL0EDtUOJ1SqDtqgg=
X-Google-Smtp-Source: ANB0VdYkw9vSXXk5n6X2nJAv5AVSdMst0c56Nby5Ytm6cTs+7B7ROju8t3DLufytaoZVU7RwWCfnYItxatQIh10WArE=
X-Received: by 2002:a37:1be4:: with SMTP id m97-v6mr31998258qkh.12.1536141015203;
 Wed, 05 Sep 2018 02:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Sep 2018 05:50:04 -0400
Message-ID: <CAPig+cSETNc5nRxf_zQq6JE8zNyUvKmdPWNsm6=NMSOXm2DV=A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/worktree-forced-ops-fix (2018-08-30) 9 commits
>  - worktree: delete .git/worktrees if empty after 'remove'
>  - worktree: teach 'remove' to override lock when --force given twice
>  - worktree: teach 'move' to override lock when --force given twice
>  - worktree: teach 'add' to respect --force for registered but missing path
>  - worktree: disallow adding same path multiple times
>  - worktree: prepare for more checks of whether path can become worktree
>  - worktree: generalize delete_git_dir() to reduce code duplication
>  - worktree: move delete_git_dir() earlier in file for upcoming new callers
>  - worktree: don't die() in library function find_worktree()
>
>  Various subcommands of "git worktree" take '--force' but did not
>  behave sensibly, which has been corrected.

This series is missing a patch[1] from Peff which he wanted placed at
the end of the series. It was probably overlooked since he embedded
it as a reply in that thread rather than sending it as a standalone
patch.

[1]: https://public-inbox.org/git/20180830075431.GF11944@sigill.intra.peff.net/
