Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4EA71F453
	for <e@80x24.org>; Thu, 27 Sep 2018 17:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeI1ARw (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:17:52 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54100 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1ARw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:17:52 -0400
Received: by mail-it1-f196.google.com with SMTP id q70-v6so8984995itb.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRbiGPrkTx7nAHycgEeVJQIsptDk+D4QiZ6kFh8bOE4=;
        b=TPdip0sxjIY7jcLDW0mXQqzayXLIQcJQWHpH410EbDs/Q+zPD6c4Ahd2FFGWnpByaz
         DqgIUjj67SrqSNJvT6nEg+pOnJ/Fv1fZXjcVFftWN+bmC0HlEgfUzUogYqlzskIyPXYc
         EaFWUXV2H4kTxnerk9tK5wwFM8GsQORMy7FwrMKoQ1/Z8eIRaCGgOwu8CSapvX5hughZ
         Pto+HIX+F47o3YX6EP98sbGKj4d4l7SY9QwHj1Xs6nqYn5PuSlQa5DxhQ7EYeXI6M1v8
         2aVpcXbg9BbFjQ+cPjb1gkuXU8B/4dEXkupHx09Fcg9oQdqWDeeKVEVKTYrnauOD2w1E
         I86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRbiGPrkTx7nAHycgEeVJQIsptDk+D4QiZ6kFh8bOE4=;
        b=WZanrX7V1dKYekhglNU7T+u2ZmsgXsseTyBR86AlBuzzbejxptvNMywU3pNJWMN1Jw
         Ny0B1T4ersxZxeBpkA2A9puSmd2dcZ6Ek8h8aC3FlHy39qDJdK0JTIs/1f6gfavKKP6M
         10dAFSUCvQtkBLvDPyAFC9+7KFVD1n4YmTNe5/IuDRsyxUKWKC4t7t/JT8QKchDA5B+S
         ZQ3QFtAXVoEN8/eSq28L/e1SOqOz9e/KaZ6PKY0FQrxQDgaxECjqVn/L3BCc0Pv3+S+c
         omGpQNA5FBF6j/d5nbolQfl30EjA5V0EwIU5os1qvrQ+mTS7MSYAlpngsNBVr5h+EZWR
         M63w==
X-Gm-Message-State: ABuFfoihsgZPrYEpky/nXapDB+r5iQt+IalqkVSBsOQIXqI+gPS4vGOi
        OVa8rnsaYIfYvbVW4wjBomk+lxu5imUj/xfB5lJ+mg==
X-Google-Smtp-Source: ACcGV62TilGvZcHmAzn4N+Io1fAjdirThM9Of7jWaYIPaJiGLvyjp2PoFmjx1/Vc0owtMpWqUmyi0+KYuEGKfaveEXs=
X-Received: by 2002:a24:aa41:: with SMTP id y1-v6mr10138252iti.91.1538071106338;
 Thu, 27 Sep 2018 10:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Sep 2018 19:58:00 +0200
Message-ID: <CACsJy8AQ9uGoJUvDo8+9n7HbvsHsNRSyntxRZ5tUFRVxFGAS0w@mail.gmail.com>
Subject: Re: [PATCH] branch: colorize branches checked out in a linked working
 tree the same way as the current branch is colorized
To:     nbelakovski@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 5:15 PM Nickolai Belakovski
<nbelakovski@gmail.com> wrote:
>
> In order to more clearly display which branches are active, the output
> of git branch is modified to colorize branches checked out in any linked
> worktrees with the same color as the current branch.

My first thought was "how do I know which branch I'm on then if they
are all green?" but then the current worktree's branch would have a
"*" in front while other worktree's do not. Perhaps worth mentioning
in the commit message.

It may be better though to have a different color code for other
worktree's branch, we can still default the color to green, but people
who rely on colors rather than "*" can choose a different color.
-- 
Duy
