Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1711F45F
	for <e@80x24.org>; Mon,  6 May 2019 09:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEFJL5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 05:11:57 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:35920 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFJL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 05:11:57 -0400
Received: by mail-it1-f172.google.com with SMTP id o190so1676765itc.1
        for <git@vger.kernel.org>; Mon, 06 May 2019 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaOUW3BQ58qy/CtvRNtKY01XwSO79iNFaUvh7ZPahmY=;
        b=DVGQe72queNqNCH0Yk9k5/tBaGwNunT5man5C2yS0Uzr2dS4rpwmUyoIXfHaoLX+ul
         cWyAfq/Mte+J0GGOpGF/2iUJ++c2w5cIe0Hqy+QNGaGBQxA3YP331/FW27Vf4cCRHNiB
         xPRJgJDFtKHl7NiVelscugIrvdF1+1+RiwpHeGxHyVAWOGRMiiaAvoOHGUUvW0A3N2f4
         HoWaz12ju74/kgaj59syUYu+AaLMaJmoE7HHa/uwKn6BBWP5LZcEboi9/2XIpnAlTOOD
         HnVw4DZVkOBB41DZ8TkNomxDZRLN3eBR7dVuRHfjuH3TaXJNbeI/ViEM9j8HaS2CTnwX
         Zhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaOUW3BQ58qy/CtvRNtKY01XwSO79iNFaUvh7ZPahmY=;
        b=ZUHMsCbIB1qO1GjkZgQU3oi7B0BxvTULfdHlcO3OUUPldi1RwnIj4l9xbTWuExRmvb
         QSeDp8klTUBSGVe/n6WMON1wM80fOmSGsd4hgR3Y+uBjsUzvhLD4Wq2L2XVazXQTnT8x
         J3haqPTKQmrmWrFF734SJ0QVooUYfjmtkgcpzPcoUiz/BKP9i0UV0kEYfR8o50bWBGhD
         oN0cdwGtWap43xe6u5WbGU8rBs80wtBvznmKb2EErF4QXL58hH+vPRh3/xcVL/Qh+sVl
         07CxLC9hM1ZJ36C2w1UoLQMMm0AuawzZ9PdIqQlIztjKgR5JUtfPkOl4NcYGvJOf3Diz
         8+IA==
X-Gm-Message-State: APjAAAVUs+zBEZt6+G86s0/Kh7wK9PHc1rWwZ8D+tfMdTWzFzCBhoJic
        2iOjQxXlS/bbwn7r1ZrUws8qwolVl5TaN8zoifOi9A==
X-Google-Smtp-Source: APXvYqyNTyOfHsuAW5PDrLaaoqx0oVuDo266pbPoMKYLFxzfvaVNk0oX+pFmRbpQdEyI+02ORbLQQtyVm80I1ub9z3I=
X-Received: by 2002:a24:4d8a:: with SMTP id l132mr17242605itb.70.1557133916530;
 Mon, 06 May 2019 02:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 6 May 2019 16:11:30 +0700
Message-ID: <CACsJy8DcaxBLCa2vK=MfoxkaHS0gDmdUsmamyqE2yOaoG_Esog@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 8:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> * nd/config-move-to (2019-01-14) 7 commits
>  - config.h: fix hdr-check warnings
>  - config: add --move-to
>  - config: factor out set_config_source_file()
>  - config: use OPT_FILENAME()
>  - config.c: add repo_config_set_worktree_gently()
>  - worktree.c: add get_worktree_config()
>  - config.c: avoid git_path() in do_git_config_sequence()
>
>  Needs review.

Please drop this for now. I still want to make it work (because I need
it). But I'll try again with a full series of submodule/worktree
support. Hopefully that will catch some reviewer's attention.
-- 
Duy
