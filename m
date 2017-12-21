Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F373D1F404
	for <e@80x24.org>; Thu, 21 Dec 2017 02:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756443AbdLUCaK (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 21:30:10 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34550 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755868AbdLUCaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 21:30:09 -0500
Received: by mail-wm0-f51.google.com with SMTP id y82so18134112wmg.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 18:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iveVxSti2I+S3sKODpVEbUdpkcyztonDdvJPDVhL8VY=;
        b=VQ8vx2IocKfErXZB9gJqqUxkCHbfHZVgf5ZsgWMqXl1xqyOr1RM1YdSoS5YYdsqVi9
         2VVymVgtgWXj7hxallR1oBDQMUFcOtVtaFheM82auLx2B0x0K1Vq7ZOfy3US/9U0z/vl
         rNLCwMkrXoxHzTGu5uoXP5X7LJMF2StOqt9xf4wRMjM9jPRrEPyEcV/fZ5zTqlnPFrpE
         9zFYeM7TGsHQT5T1xGVgJCCFzRY9WtSjZcLolRcj1L5w8OalURA68nbm98azECInlDM4
         pLYG058f3BY2H/DcrLMyVjcRsXeUL7YAAUqE3F8zgskyHcddz3f2PtCh/kOWz0uIH1FI
         vKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iveVxSti2I+S3sKODpVEbUdpkcyztonDdvJPDVhL8VY=;
        b=gfyG2j7AGvuf3ERNooTFdZZQSsytsOEqeVc+lKJ8mSD+Jgo7zluvk3w3SXlsty65VC
         dtfoitSk0vCGsE+4nn0CE3+28y412SSkZggPLECUztVRNnZE9nR4voBQNPnIj12xBTxu
         CsxvfYEEzcg5qU00PauN9rv/niRRwX+3+QyaG5KvwPZS1K8i3CZ/+P4LzB4L6AtQJnVe
         hWJ+jGqJxJSD2rT/3Rwq6awmJDoeUDiaAf760JnDOoEHhL0TlEirAMU5FFYCuWA2wE1D
         ycIVdBsxiUOcQg6lyW7fDGEJedW7Q1wGAqKVJYt7YumTIs9IJf6LGbuNY6gt5PK2m30B
         EQbg==
X-Gm-Message-State: AKGB3mKyxIRnJsmP7ujzWfHw3jiqceRyId0RWC+J+oEcFG3fORffzTJA
        IEpL6ThMrBPA6Ej0HKx7zDE7gEZTxiBvm+Kn0R4=
X-Google-Smtp-Source: ACJfBotwQSf2oTj/hmzU6TnLpCWW3R5uGE1ZbYLpb1tNMSCoCQ4w+W9VU5PXpiBNZhoc00Tt4V8/JXbPQiCWVYXzsgA=
X-Received: by 10.80.137.106 with SMTP id f39mr8323416edf.148.1513823408512;
 Wed, 20 Dec 2017 18:30:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Wed, 20 Dec 2017 18:29:47 -0800 (PST)
In-Reply-To: <CAEW+b659_v02v8z_dgWzVayb8ArBOD+O_Oky-F50JbJSP8vCKQ@mail.gmail.com>
References: <CAEW+b659_v02v8z_dgWzVayb8ArBOD+O_Oky-F50JbJSP8vCKQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 20 Dec 2017 18:29:47 -0800
Message-ID: <CA+P7+xojknncFrP5qCB4EKG0MAoTUqFWS5g3Bj+Jq2_RO0fA3A@mail.gmail.com>
Subject: Re: Usability outrage as far as I am concerned
To:     Cristian Achim <brancoliticus@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 8:40 AM, Cristian Achim <brancoliticus@gmail.com> wrote:
> All I will do is paste the stackoverflow question below. It covers the
> commands I made in chronological order and the way I would have
> expected git to behave differently.
>
> So I did
>
> git pull home_subfolder
>

This by itself should be attempting to pull from a remote named
home_subfolder. Can you show the output of "git remote" and also
clearly explain with details the layout of what the folders are and
what is or is not a repository? I can't really make heads or tails of
your problem without more details.

> I do not want to resolve merge conflicts because git doesn't error out
> with a sane message of the situation when it should. I just want to
> get the home_subfolder and usb_subfolder repositories state to where
> it was before my breakage generating git pull and git clone commands.
>
> Ubuntu 14.04 64 bit, git 1.9.1.
>
> Thank you for your time.

So you have home_subfolder and usb_subfolder which are repositories?
Are they submodules within a parent project? Are they simply folders?
Were you trying to merge the two together?

Without knowing more of what you intended to do, vs what you did, and
without more information about the setup it's not really possible to
understand the situation or what broke.

From the looks of it, I think you might have tried to do something
like try to pull from usb_subfolder directly into the home_subfolder.

Are these two repositories nested? ie: you have "home_subfolder" as
"/home/subfolder" and you have usb_subfolder as
"/home/subfolder/usb/subfolder"?

That might explain why git pull would interpret such a command as a
path from which to do a file based pull...

Thanks,
Jake
