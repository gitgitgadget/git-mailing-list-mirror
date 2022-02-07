Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECBAC433FE
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 12:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiBGMDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390525AbiBGLy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 06:54:57 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3557AC03FEC5
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 03:54:31 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p5so38963801ybd.13
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 03:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCKCrFFR/H/DPkq9FBBUfSI/88ATvl4B6z6Lz9DIa5A=;
        b=KHkw7tWmeLr1Bk9TPP7v/VKt3ayT5KXwv+nZhaFQLB0LTKAUAPW7wsDVBJYb8wbtov
         XXVpEXrsQCB3wN0NsQVZxFEJ6E1MaxVYANWNkia7Y5LcJxwZit7rQ5rKOFyQMXYtRz/B
         YpgLef0J5N9XPz8faTXkVE1Kb69gIklIK2mSvbCKXn1FlV2du0TWfoc6kIqnN38LMCGK
         DcSfYHF15kXT1WP2807jZfPp54jbo4KZaaBJYz/yk/DRHhuvmmfxsssEx+amILkLKHnS
         20Yp4UYmeC5khgdRN9gn5Ip9ZQpX6P3B57fu1zNViPMxCfPouHLvCXWAFHNZIvH0uuNf
         o8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCKCrFFR/H/DPkq9FBBUfSI/88ATvl4B6z6Lz9DIa5A=;
        b=iQp8aqnQKhqRuu+CFMSYTuCGMAPxWGOaVcK37wV5Ajvprhe1Zx10RWdFWQGBXjW/Ys
         lL4H7dcsCfRvu/9tiX9Nx7kO1S93tPN2alu/afzYELNRJS4cvSy/cejniQtjalKzQnAq
         pRugGfhyOZqBF2qn2PuzlT8ELmZO1Remb8WhZG4OPBkXhQCH9p56w9HRbgUBIBhjwiXG
         ltekVnQBRVTedVCq2zIQs8r5uCOyyDgC76t6PZHxUBxoGznuL35PLPPCIKUqfBo1Z3fK
         LCes99z8gOrRiVnE4Oa+eDy5rn7XBXwMhRYG+gDohJCwSw15kuFc5tgzU5hji0PLtph5
         /Osg==
X-Gm-Message-State: AOAM533Mzylkb0IjCBac9mbdblvw4NjTzVxARqCGBSZniauuhGMUzwe0
        3vXNelvIVPXPiJ2ucGEpagKEbbp0QnI5pz1i/2o=
X-Google-Smtp-Source: ABdhPJx/6QcZIuFMmTvEZIJG9QSkMWMh4QLcvUpvglx19mlcmRQDfEl9tbuAC3QnZAGLAdFzVzjv+MmunoXyRBHUQZo=
X-Received: by 2002:a25:a1a1:: with SMTP id a30mr9902519ybi.50.1644234870308;
 Mon, 07 Feb 2022 03:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <20220202064300.3601-1-shaoxuan.yuan02@gmail.com> <20220202064300.3601-2-shaoxuan.yuan02@gmail.com>
In-Reply-To: <20220202064300.3601-2-shaoxuan.yuan02@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Feb 2022 12:54:19 +0100
Message-ID: <CAP8UFD0c=TeBwcyWo_GKLKV7Y8837beHLk7JGqfF9_DU79NWig@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t/lib-read-tree-m-3way: indent with tabs
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 6, 2022 at 10:51 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>
> As Documentation/CodingGuidelines says, our shell scripts
> (including tests) are to use HT for indentation, but this script

Documentation/CodingGuidelines talks about "tabs" for indentation not
"HT", so it would be more consistent to talk about "tabs" here too, or
at least to say something like "are to use HT (horizontal tab) for
indentation".

> uses 4-column indent with SP. Fix this.

Same for "SP" here vs "space" in our doc. (Also note that `man ascii`
talks about "HT" and "SPACE", not "SP".)

> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
