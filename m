Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18681FEB3
	for <e@80x24.org>; Tue, 10 Jan 2017 05:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbdAJFNl (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 00:13:41 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35315 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdAJFId (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 00:08:33 -0500
Received: by mail-lf0-f50.google.com with SMTP id m78so86870834lfg.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 21:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LvFKpgEmjgpHwPPge2+blc+XbZ1vK8fngOwtwofwyXU=;
        b=A6B4VXcX6/ThvOja2uGeu37/5SWocrxcY2pYLvPVyaKGoFuPttWTUc8OgGqjyTBq0z
         /WBqh+kAF4GOb/spe64KBJZLA0i8W+NDIWsY62rbBCPJchWATJt1gCghfwvXohevNhET
         ilndYg8RYkJUoM55hr+zYiX0ozYcIDq9tK3HaKac9Pe9i5RGxC4wPSA4JO9tkF7kHHPA
         p78VRoooPYd3pV9g0G6ueGLjvFcrCTw5SrwKScPNtO1Ur4YxQXlLOV4JPdTfEfuU9mpY
         SIA9gUDsdk4s0beevcA1Eljd8lmR0xQDm39HmFyh32fV15IiBhJZsZ3mpOMQeBuxnrEx
         dY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LvFKpgEmjgpHwPPge2+blc+XbZ1vK8fngOwtwofwyXU=;
        b=YMqoVXttbFm3ukNanqHal2Ux7Nf+H0nEqOGIOD7JYkveLWe/9z+yUSy2W5FAR0cAL6
         P6B2IgF3HiG64V1tY/rEZirJmxntfB8EwMw5fq0s4SVlRL7zb8J5Xat0xiteNV1TqSfA
         QT1m6LC2LTiaKMMc6S6fZAA2Jb4gGSzpI7+BZBC0hQpUpX0DIjlmMi6dKaEEz7ZezUDR
         /wK5DmUoBNtsUQwwDhhcjK/eA3UPcKcAOyZiOyDBbGbANDMSYB2a6eb7aMj7Bj7FvpzQ
         s+pxUXyZ1ikZfLNLhOKXy1LAQlqM0HHttr3O+2pe4+0EqhZRn2QnECO4uF0a9ctNojwQ
         DMEA==
X-Gm-Message-State: AIkVDXL/+HNNTQm9Hnr3DcFHQPaLFUqIbCiJOk6QpGn4S6ZzVtfN9uZ49FzHLhdKND2WT8I2MSYRW5DOcQR7Xw==
X-Received: by 10.25.160.20 with SMTP id j20mr382345lfe.66.1484024911731; Mon,
 09 Jan 2017 21:08:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.79 with HTTP; Mon, 9 Jan 2017 21:08:11 -0800 (PST)
In-Reply-To: <CACsJy8AfcZOR966ypfbZa1+7=tr2RVxPUk8+XmQkGeoMBJ7Z0g@mail.gmail.com>
References: <4D106F0FF3D29E4FA1D91C1A31CE4C3501B8DEF2E6@email.novomind.com>
 <CAGZ79kaLpf1nzSAgRJQamMGk-327LO+qQYihYVVcU+86n92ivg@mail.gmail.com>
 <CACsJy8C6QWeHSwhsYyJnupkue=aoCG+3Tecytb_0p+gB-CuVKg@mail.gmail.com>
 <CA+P7+xofFufcUMBJFqEcP=C5r80HCr1-j4210gOm7t=aLYw2zw@mail.gmail.com> <CACsJy8AfcZOR966ypfbZa1+7=tr2RVxPUk8+XmQkGeoMBJ7Z0g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 9 Jan 2017 21:08:11 -0800
Message-ID: <CA+P7+xqOrRwJsnskfGQpLYyQFjce=4z24zuhrEBd2P4gBLh0Qw@mail.gmail.com>
Subject: Re: git branch -D doesn't work with deleted worktree
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Roland Illig <rillig@novomind.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2017 at 2:07 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Jan 9, 2017 at 10:44 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Why not just update the documentation to be "when you are done with a
>> work tree you can delete it and then run git worktree prune"?
>
> The document does say that (a bit verbose though):
>
> When you are done with a linked working tree you can simply delete it.
> The working tree's administrative files in the repository (see
> "DETAILS" below) will eventually be removed automatically (see
> `gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
> `git worktree prune` in the main or any linked working tree to
> clean up any stale administrative files.
> --
> Duy

Right, so maybe we can make it more clear since it's not quite as
simple as "deleting the work tree" because of stuff like stale
branches.. or would it be worth re-scanning worktrees when we do
branch deletion? (obviously ignoring the ones that are marked as on
removable media)

Thanks,
Jake
