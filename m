Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A48D11F576
	for <e@80x24.org>; Wed, 14 Feb 2018 09:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966925AbeBNJhW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 04:37:22 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:34215 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966693AbeBNJhV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 04:37:21 -0500
Received: by mail-ot0-f174.google.com with SMTP id l10so19857328oth.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 01:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YlhHSxK8C2mLKJ2kNxgW7qT2F19X7M9DSzg8iOaWOq4=;
        b=JW8/13jYuYMt3/IuskpLZxCAI01xaWcsPsOvV1mDH7ovEXWP5nOuHU7yn3bIfOhlom
         CBQYNEYmu5YIVXAttpLYsf3i7nPkk1ADsYTtSF0FLSYv84q3PtVtemH46ZxZgfn8CuE4
         6imHbrm/Jc4MoWUtlwBe6cM2hO95abbeAcSa9Tew3trtMOAxJlzYnH0YEROCRUaC1Jkh
         ievq0zZY/1ph8PMWP4yA9n3NIw0/2IB9bSt1vmhZ6Fit1mGmU0j8uiRR1+0mvJ306VcG
         w6/k4/O6rhN+Kv6EQjG5OaOqw2B6V51AKKhOZo+SASXOFDgNvdOeUtbxom9PSfMm2V4Y
         4Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YlhHSxK8C2mLKJ2kNxgW7qT2F19X7M9DSzg8iOaWOq4=;
        b=EUIWNGIi3+x2LohcCrvcJoHPWGx94SsDJj1dvj3BM/azHkR0xxBWpuoMf5Yy3643Ll
         /6Peob4PDfziUBdgE4WuasF2KCcfQC3uDmn0E9+EgIme54+IJQTaKV9P2yRr+jVVxder
         FGY8uBWLkJ7FkaUOS5qItYVbEglchrtNF8M3aXueqvAOeV5X1HLGXAmhg+TDh8yBfULz
         TIriobYVphEkwBJNfTltZMKCgIAvtIyUZKlbWvmWtsArgGbpnEc1OtJmXgIOLRT7mwni
         pAS0eiAlKy0c0HGCkJ8FeHOgn+eG0sBvA0YfRWCQPMhTZlufI50btk5J5p03OtyYiKp7
         eU4Q==
X-Gm-Message-State: APf1xPAc/VizS7p1MhPqATAi9z5GtqQlJnjgb0ECtBdAqvjYPLdTcSaK
        bxpcAOjSngDUA5HOr/KYJgO54gNFonH0BdMvmAE=
X-Google-Smtp-Source: AH8x225F+aiJ5a7Z8A3ZvSKB5+W0uoWFtjwjyEyPICKc9eB/AaV+qtJjq3e71SLODPGQwsdXcXOe0ajTslfFTvoEKJ0=
X-Received: by 10.157.2.8 with SMTP id 8mr3195582otb.106.1518601040825; Wed,
 14 Feb 2018 01:37:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Wed, 14 Feb 2018 01:36:50 -0800 (PST)
In-Reply-To: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
References: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 14 Feb 2018 16:36:50 +0700
Message-ID: <CACsJy8ASyntVwHfES_Rk4Fj6ftQC+moFd1gwgB3rzYhpdYOX9A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2018, #02; Tue, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 8:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/parseopt-completion (2018-02-09) 42 commits
>  - git-completion.bash: add GIT_COMPLETION_OPTIONS=all config
>  - completion: use __gitcomp_builtin in _git_worktree
>  - completion: use __gitcomp_builtin in _git_tag
>  - completion: use __gitcomp_builtin in _git_status
>  - completion: use __gitcomp_builtin in _git_show_branch
>  - completion: use __gitcomp_builtin in _git_rm
>  - completion: use __gitcomp_builtin in _git_revert
>  - completion: use __gitcomp_builtin in _git_reset
>  - completion: use __gitcomp_builtin in _git_replace
>  - remote: force completing --mirror= instead of --mirror
>  - completion: use __gitcomp_builtin in _git_remote
>  - completion: use __gitcomp_builtin in _git_push
>  - completion: use __gitcomp_builtin in _git_pull
>  - completion: use __gitcomp_builtin in _git_notes
>  - completion: use __gitcomp_builtin in _git_name_rev
>  - completion: use __gitcomp_builtin in _git_mv
>  - completion: use __gitcomp_builtin in _git_merge_base
>  - completion: use __gitcomp_builtin in _git_merge
>  - completion: use __gitcomp_builtin in _git_ls_remote
>  - completion: use __gitcomp_builtin in _git_ls_files
>  - completion: use __gitcomp_builtin in _git_init
>  - completion: use __gitcomp_builtin in _git_help
>  - completion: use __gitcomp_builtin in _git_grep
>  - completion: use __gitcomp_builtin in _git_gc
>  - completion: use __gitcomp_builtin in _git_fsck
>  - completion: use __gitcomp_builtin in _git_fetch
>  - completion: use __gitcomp_builtin in _git_difftool
>  - completion: use __gitcomp_builtin in _git_describe
>  - completion: use __gitcomp_builtin in _git_config
>  - completion: use __gitcomp_builtin in _git_commit
>  - completion: use __gitcomp_builtin in _git_clone
>  - completion: use __gitcomp_builtin in _git_clean
>  - completion: use __gitcomp_builtin in _git_cherry_pick
>  - completion: use __gitcomp_builtin in _git_checkout
>  - completion: use __gitcomp_builtin in _git_branch
>  - completion: use __gitcomp_builtin in _git_apply
>  - completion: use __gitcomp_builtin in _git_am
>  - completion: use __gitcomp_builtin in _git_add
>  - git-completion.bash: introduce __gitcomp_builtin
>  - parse-options: let OPT__FORCE take optional flags argument
>  - parse-options: add OPT_xxx_F() variants
>  - parse-options: support --git-completion-helper
>
>  Will see another reroll.
>  cf. <CACsJy8BoPxbt=hqAd9fS7MLiF33FVtAk0=Fr_q7UgYy1YvEg0w@mail.gmail.com>

Well, the next reroll would just drop 42/42, which may be easier for
you to do it yourself. I don't think I can work out what all
git-completion.bash needs to rewrite 42/42 in a couple days.
-- 
Duy
