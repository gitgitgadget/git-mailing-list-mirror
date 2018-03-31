Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1291F424
	for <e@80x24.org>; Sat, 31 Mar 2018 09:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeCaJkD (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 05:40:03 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34985 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbeCaJkC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 05:40:02 -0400
Received: by mail-oi0-f51.google.com with SMTP id z8-v6so9427290oix.2
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2w7gM8CZtPfnkuHy/dkJKr0EaDObZrxgasySQJWAKmc=;
        b=LYpbx9m8WzP+EY9TegZFxJ9mVW1jr8NiJewyi50Vkzk0+t0bj3s8eygS4WcU2kuf7j
         6LvwRKK62YDrbxoB8aJGm1CEh1TyXh8fIi58HvEmVathasW3tYrs21RRrc44zy+I/Gpj
         RvOA+uDVoF0vUj/GmpnallM7AkCQCnOYkaZGKf3rBssE4R/wuH650PIN1vOlqkd8Ja9n
         1NqmN5gumO0q+Okp5P/8/+CFV8CEq0S98uxtBH9KmjtPBEb+KaYQmgUHGjQbH7tczmyT
         LWd64F/0S9Yp3ZGM2zKNqhFTz0FWLGCCQer+BuTia1lOd+oCU/KfZUgV/Tgk4Jr6daCx
         iWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2w7gM8CZtPfnkuHy/dkJKr0EaDObZrxgasySQJWAKmc=;
        b=ntiJja+UdddwUaASVvxC/c+cKp1NoYSH3z+jkyZ7QKb/A/LioQ2y1jcNEcxM7m+VNk
         weSvte/xHIR1U8fke+OKQTin7L5Y74YUABgFHAa0EEMcyHy66b+EW6+GYJag/QCQeLVb
         jxNWLaTnr6XKAazISFnr6bf/ygwu6uHDQXUZbDkGy/LNGI1OpB6l2VAhYCrrBZ8+RcMW
         0+FEtuNGJGXf9hX6UGRJHCmpwFhBjK6It+5FykWtYPt8gkF9y4IZ/3N+ooSjqIf9+9TE
         EjtmQgOZUwrUfZ8px87YjaSqnFcC8JTLC0Vfg1eTnrX8rDPSqdcdXzkXiiLsNSSSWitg
         OMYA==
X-Gm-Message-State: ALQs6tDX2zv8v3N4W5RwroLjJEjJ/bzt54NXtlmZb6kO3jRmEGsoy248
        U0C1Fl/7mQeuMW4WMHpU1C+ojtV9RobDERBf5l8=
X-Google-Smtp-Source: AIpwx4/+iuVb7MIe/NBaXLbj8sIl+ncxixjYEu4Eko6/VqD5NkwZFwJKTZuJ9BQHRAfTL6mjq3VKjuvShgp3oe6KORQ=
X-Received: by 2002:aca:4055:: with SMTP id n82-v6mr1168082oia.30.1522489201994;
 Sat, 31 Mar 2018 02:40:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sat, 31 Mar 2018 02:39:31 -0700 (PDT)
In-Reply-To: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
References: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 31 Mar 2018 11:39:31 +0200
Message-ID: <CACsJy8C2YuxfjBannunoTr8zERf8hC1z568KLAbfhtQYQyf+FQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #06; Fri, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/repack-keep-pack (2018-03-26) 7 commits
>  - pack-objects: show some progress when counting kept objects
>  - gc --auto: exclude base pack if not enough mem to "repack -ad"
>  - gc: handle a corner case in gc.bigPackThreshold
>  - gc: add gc.bigPackThreshold config
>  - gc: add --keep-largest-pack option
>  - repack: add --keep-pack option
>  - t7700: have closing quote of a test at the beginning of line
>
>  "git gc" in a large repository takes a lot of time as it considers
>  to repack all objects into one pack by default.  The command has
>  been taught to pretend as if the largest existing packfile is
>  marked with ".keep" so that it is left untouched while objects in
>  other packs and loose ones are repacked.
>
>  Reroll exists, but it seems to be still slushy.
>  cf. <20180316192745.19557-1-pclouds@gmail.com>

The next one v4 [1] should be less slushy.

[1] https://public-inbox.org/git/20180324072507.21059-1-pclouds@gmail.com/#t
-- 
Duy
