Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FCC1FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 06:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeCOGb0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 02:31:26 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:34561 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeCOGbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 02:31:25 -0400
Received: by mail-ot0-f173.google.com with SMTP id v4-v6so2635815otj.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z+q+5v/H7msLPr2PT66EkjhjEB5IMz//qnbTz7qotdo=;
        b=TVuaQ6f+/PQNHRmpwavPl5UBr4R0Xsckdh7z/+QkepympVj5X/I5eNLxKobiGBTi7l
         Scph20MAyvVhrZdQ9IPDvmfzSp+FGq5w+iT/itCGWdM6wJvNmFyFzZqA9Uvm+rL4uPK3
         dWASXbJUl8aClG6u15M/UEnx8+5rp3TtVBy93muTbGv1hlXYFMC2IEeSDoNPPesFmA5r
         2netUhz8Ati414cblVaA+k4Rpu4RQ1rffLxDP+VyZzYcgU62h3x6Mdm209Bw3vUv9tEz
         xUBW3tWYexuyTMl66oeFv+mZjdVje6KCzEFAi5JzpmYg28kNUasrgayU0yNYtcY/c+5w
         PjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z+q+5v/H7msLPr2PT66EkjhjEB5IMz//qnbTz7qotdo=;
        b=mZOJu2InD+jKannnUFxx4nt7ycYWyEh5aPjuoliHirIC8BvV8Yl7wB/iyWxkQci4KX
         C2KfFkYH+faUgYLUHtGAfU35VUMehkI75E+txo3LVYxhPM01MH8ZYO2rtb8YrZ4B9o5r
         vBJS8zWu2wfq3TL0FwbUZTcLvCBmQ6DgKqGdRefcwddA0Xhvb9U3X0T7rzyNVGA0nuyy
         JLZJcTIXkdEMsmw79FtBpKFLOEYfDPXuSWlbSTMlonSNdp6VNtJBWuXa/tOfGCl/X6/f
         XzG1cmvfdrMmjxzLgDb/OExPF5fYMihpzECG/j7m5Z59WjA5hmftUMq0JlEFFHYC/UKW
         IeiA==
X-Gm-Message-State: AElRT7ECLVfYLLobmZwQ5ekgfmnCXlPCif7jg5S3+qs0U6UPjIlNVfYv
        cpSCPk4uoBqMIuqKkF/3/lYhbV9Ygvsy6njemQ4=
X-Google-Smtp-Source: AG47ELtQuBdTOVdPIXRLyvVskSDDX3AeSjJb/hoe4zjzC00pM+oTszIrAM3CugdKyy6sX6U12MYGyxYsii4RCaMK0tM=
X-Received: by 10.157.54.204 with SMTP id s12mr5000811otd.304.1521095483949;
 Wed, 14 Mar 2018 23:31:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Wed, 14 Mar 2018 23:30:53 -0700 (PDT)
In-Reply-To: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 15 Mar 2018 07:30:53 +0100
Message-ID: <CACsJy8D9-OaU5F+bugpgaPBPV_cdtqeYJ_5iYYMcrDj5d-9z5Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 2:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/pack-objects-pack-struct (2018-03-05) 9 commits
>  - pack-objects: reorder 'hash' to pack struct object_entry
>  - pack-objects: refer to delta objects by index instead of pointer
>  - pack-objects: move in_pack out of struct object_entry
>  - pack-objects: move in_pack_pos out of struct object_entry
>  - pack-objects: note about in_pack_header_size
>  - pack-objects: use bitfield for object_entry::depth
>  - pack-objects: use bitfield for object_entry::dfs_state
>  - pack-objects: turn type and in_pack_type to bitfields
>  - pack-objects: document holes in struct object_entry.h
>
>  "git pack-objects" needs to allocate tons of "struct object_entry"
>  while doing its work, and shrinking its size helps the performance
>  quite a bit.
>
>  Will merge to 'next'.

Hold it. A reroll is coming. I'm a bit busy this week and can't really do much.

> * nd/worktree-prune (2018-03-06) 3 commits
>  - worktree prune: improve prune logic when worktree is moved
>  - worktree: delete dead code
>  - gc.txt: more details about what gc does
>
>  The way "git worktree prune" worked internally has been simplified,
>  by assuming how "git worktree move" moves an existing worktree to a
>  different place.
>
>  Will merge to 'next'.

Same.
-- 
Duy
