Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B951F453
	for <e@80x24.org>; Wed, 24 Apr 2019 18:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbfDXSPu (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 14:15:50 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:42258 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387416AbfDXSPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 14:15:49 -0400
Received: by mail-qt1-f181.google.com with SMTP id p20so21400294qtc.9
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JflPqW1ZsUvonliPDFg8/vUiLFXPT12RKStzu8j7a1E=;
        b=Bc7EHTENxRJueDo31pJr+Pj12WAoRmmnaetVRhTz0F/SEIxB7EfesPcFvUlRA8QtTd
         BonurcCv0fhpYL1dhUTA7N3bFgh1KM9ubcCZADWmqv5OYdV0O5i1MLPp81gCJTVRyOuT
         IQDd2nw2GBfmKL4GAwsoE58mCtcd2ESquDZKNhoIbq2BKsfyeVmcThBYrfLGHXLQ61y1
         Om72RQA3BKC1kY0rZNGSIkD4v9WfFM/f9okiJuuBLmjZBH07NIR1JIFrbvxeL6SFuhUi
         CSE30p4nqhZLaeLiMTFnfdVEHUbSLcjc2XE6ankwZ63GiYqJMW9Nvx6132+pas6tsrSx
         lH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JflPqW1ZsUvonliPDFg8/vUiLFXPT12RKStzu8j7a1E=;
        b=s7Vtc+OkT1i3uc54A3IcKS4k+ZdeScpaIvpRpTn+HK/bdn7ZpVYiaNwXv5SP29VqMk
         gXbjnIsicCHNmCqyCcNSeuNROBxowTHc47Hvwp4gTIybeeMPXYURFjHBAJQdKnRT7Mfg
         sGUFMEgauqu7sKL0SDCiZKbQ6A0gzKsj2BgZoGx51rnUFDU+sO7foM3tj6/KX8nnsRJG
         savUoBKRU9pMM6tbK5v3zSxrfmpnJO27OqzaJkdFVZP/pwgnfb9WMcy3dSwiRxH6F08O
         mkrepogE5Lp+TnsmTDzd7eu5dEMOQBRUmD0SqKQhETq0s09hw7EvQs0tFFyU+Stn28zT
         Dg1g==
X-Gm-Message-State: APjAAAWko5aZedIKidVhDh+/4lROjTw7t/Ar24eUb6bwM2VKOf3AkFsh
        I01ObuLc6TmLbhq/cRoI0DIvcGT/xj4gpsjoqJ3Gauz5
X-Google-Smtp-Source: APXvYqzjQOjMtUHo6yvnIVsgLvVrWw5PJP9KlpKfDWrIICShI9Rp+wuoLcByhjbXjBfFTWwfRKSbYz7ybW6u8M15S/I=
X-Received: by 2002:ac8:2cb0:: with SMTP id 45mr26564198qtw.92.1556129748860;
 Wed, 24 Apr 2019 11:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01CsoJZMJ86mpybukqT0hVnvXi0FuRjZ23akM5kNPBdT754Q@mail.gmail.com>
 <xmqq5zr31poo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zr31poo.fsf@gitster-ct.c.googlers.com>
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Wed, 24 Apr 2019 20:15:37 +0200
Message-ID: <CAA01CsrsSQ-_bhS_T5gxDqtPa0XKbHp1c7WCgdxLVvEA3fBSGA@mail.gmail.com>
Subject: Re: Checkout file without changing index?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 24, 2019 at 3:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
> > I was familiar with "git checkout revision -- file".
> >
> > But it updates both working tree and index. I had some changes in
> > index (staged) and "git checkout HEAD -- file" silently overwritten
> > it. Well, probably my mistake, it's documented.
>
> We'd invite you to live on the leading edge and try
>
>     $ git restore --source=<revision> <pathspec>
>
> which by default checks things out only to the working tree, but not
> to the index (you say --staged if you want to restore to the index,
> and you say --worktree if you want to restore to the working tree,
> or you can say both, which would be the same as "git checkout").

Thanks, looks nice. git-checkout is a bit inconsistent at what it
does, and I understand the git-restore and git-switch are a better
replacement for it.


> I think the new command is now on the 'pu' branch, but in a few
> weeks hopefully it will appear on the 'next' branch.

Is it possible to get a Windows build?


-- 
Piotr Krukowiecki
