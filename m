Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B773F20248
	for <e@80x24.org>; Wed,  6 Mar 2019 09:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfCFJow (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 04:44:52 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:32922 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFJov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 04:44:51 -0500
Received: by mail-it1-f180.google.com with SMTP id f186so690473ita.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 01:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdPPWIvtkAYGatNIKwc/LyVXRDoyi25+7PnazSYANOw=;
        b=qYOMtCP9KTccwURHrZI4f4FBSM9FPae3B6hu82c14Q4EqOPWs2TCqHIqyJyVq332IF
         lnjE/WkOmDWmq5fKweAei+T8eIvBS04p8YKu0x1ooowX5mItL70xN4RuDxPmnr4OXZAt
         0VSHZ7dat/bqP5aL32Lx7ARsSuiYC6r6fWVaEa6XIXYk7NQUwnsqi/WbXTPsatNxfbms
         EtgaYA9PeLXA0frcjlb4NKndBJvHj6snBbEFwrNUX0NIQ0qEEfaEeUaUDySKfJ5kfM6q
         DIcaFKVbXt1NdoAYz21+vqJRD2nLq3iwKI8PCra+cpqaCtokqBGommJnOok134LS1hTH
         Nimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdPPWIvtkAYGatNIKwc/LyVXRDoyi25+7PnazSYANOw=;
        b=AV9FPKu9rU2aJGVi9Qe00SOnTgXi6xqPz3rB0dDskvuX684SaDad/F2NzPVgdx/juT
         hQHNJMawBQvOvwbBGerfY1MstF4Wxkt9VOg03sjZHkVwCYP50T1adn8YbPqSyuTjtR+3
         lVuD9dGf0ClGVtYHy/vJxOMe/+OmLmXeqS0PPfD5sm3tfcbqiJ0Wmxz8jA7FNRgRpb96
         NHkKQ52ykZriQ6Ypm+L1wYeb7SFrlU+GOMD3gO1fLzy3Dx94kKnfZPZMaCgSunsuKhC9
         I1nydW42qFYv1QYZYhnOnDxQMmNgig1VOdSJMeI7wdFE6mtlcwPEQNYprqqKhnwq0Lh8
         oZOg==
X-Gm-Message-State: APjAAAUHnL+VFo7ANWtxnAgm1IDHEwcRq1fIfgxgbcU4BynA3BfGW/+G
        fp1PvmW4Z0AgdLt8hro2ZkPEKZgJMuop5iKBMJs=
X-Google-Smtp-Source: APXvYqxoZ0qrDrezgddElW7TP/Iw3fR0bDG3tWp5k1nbN6NQ0uEghf+/FnBO+3Bdd6dy4CCAqxSRPx3rSpgzvbuKS0M=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr1487512itf.123.1551865490731;
 Wed, 06 Mar 2019 01:44:50 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Mar 2019 16:44:24 +0700
Message-ID: <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
To:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 6, 2019 at 8:34 AM Junio C Hamano <gitster@pobox.com> wrote:
> * tg/checkout-no-overlay (2019-02-04) 9 commits
>   (merged to 'next' on 2019-02-04 at 9968bcf4fb)
>  + revert "checkout: introduce checkout.overlayMode config"
>   (merged to 'next' on 2019-01-18 at 1e2a79ba5c)
>  + checkout: introduce checkout.overlayMode config
>  + checkout: introduce --{,no-}overlay option
>  + checkout: factor out mark_cache_entry_for_checkout function
>  + checkout: clarify comment
>  + read-cache: add invalidate parameter to remove_marked_cache_entries
>  + entry: support CE_WT_REMOVE flag in checkout_entry
>  + entry: factor out unlink_entry function
>  + move worktree tests to t24*
>
>  "git checkout --no-overlay" can be used to trigger a new mode of
>  checking out paths out of the tree-ish, that allows paths that
>  match the pathspec that are in the current index and working tree
>  and are not in the tree-ish.
>
>  Will hold.
>  Waiting for "restore-files" & "switch-branches" pair.
>  cf. <20190205204208.GC6085@hank.intra.tgummerer.com>

If it's ready for master, I'd love to see it merged. Either that or
topic is rebased on 'master'. There are separate checkout changes in
'master' (mine, sadly), and because switch/restore moves lots of code
around, I need to create a merge of this topic and master as the base,
or you'll get horrible conflicts.

I should send switch/restore again soon. There are still a few
unaddressed concerns for git-restore since last time. Probably time to
refresh those discussions.
-- 
Duy
