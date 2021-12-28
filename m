Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BC0C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 17:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhL1RQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 12:16:05 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:41727 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbhL1RQD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 12:16:03 -0500
Received: by mail-io1-f54.google.com with SMTP id y18so14988937iob.8
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 09:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMzMcHj3qC0mMuEq/yTsrJT/b0B6bOT9QW/g/WGw3gw=;
        b=xRS9JW0B5UBhJBPxM8zT7DRuM7CzYdAogIAixgzjvqM04800AznUQehU4nAED/Ec0n
         GUuOT3VWB3ToPHWOzgQvjQS93kH+Rt3IWRDMCr32ssB7CCaock2FjUnEEKVYyQES+Dii
         N8B4Vb8H4Dio9f2kFgDJvKxzRVDCLEKsLA0HD+qUM7k/u5psElTwJW7J0/ySelvEWXEc
         RyWNO8Qr9A3+tq4Z9PRVluqAc9asfwDRzPj1qAqJNAVFogOiBqSoJwIpYBvQlEeaCQmX
         pPkiU1cuVukQjs2GVkVJGo0Xf0gNvVRC5Ub16/MlgyPUQP9lWlJU8JoYLdU0oGDVzp2v
         rsGQ==
X-Gm-Message-State: AOAM532JyjSHxQlV0l0EKOEDOrRUGqRxlD+Zd432mLVtoy65k7eLp4wh
        eC5AcuzOPZYsiiU7TdH4c91ohRc2KnBn1qq0x6s=
X-Google-Smtp-Source: ABdhPJxSbwfifE7tUlbLgZq3no1+g+0ixv3nT2z+8PGPzxrX8rnFFOUcc/R2yZrOycbsBIqANAtHRGYpt1+qcknNZn4=
X-Received: by 2002:a05:6638:142:: with SMTP id y2mr10372202jao.195.1640711763203;
 Tue, 28 Dec 2021 09:16:03 -0800 (PST)
MIME-Version: 1.0
References: <7w7c2MDOBpV9yIlD5yZZb801w-eaz0qhErkCN-De51h892xRFL14N-LCXH0O8wvDp_51A3hC86EMXonBkjNdoTZ-iy8xzoKLVecN6D6Zpq4=@protonmail.com>
 <004601d7fb3c$c9d359c0$5d7a0d40$@nexbridge.com> <J-VncZqqtXGSpnkopiYEtOET-oeVZX1tk3jBX9c3oSaOrcH1N_ciDdzQFvk50CkibrWFCboQNDeegBNMGZ247duUXwnPFY_0HbFvEWI0hVg=@protonmail.com>
 <000001d7fb3e$7c0e8730$742b9590$@nexbridge.com> <FKMNcEoH2PMBw4wcDkxzCDdl41kpWkZyh5SkiRlDi6seiVchbCuBbMmc38SFYR8gAgDhk_vo3xJSCiPSdYRIvhOQ1cB4uoZksClDYey2LXs=@protonmail.com>
 <000801d7fb5b$12ec49f0$38c4ddd0$@nexbridge.com>
In-Reply-To: <000801d7fb5b$12ec49f0$38c4ddd0$@nexbridge.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 28 Dec 2021 18:15:26 +0100
Message-ID: <CA+JQ7M94QXWbFnJfzewqecvETmJC9fVkFAb-+RHFuswj=FdnpA@mail.gmail.com>
Subject: Re: Quick login of git
To:     rsbecker@nexbridge.com
Cc:     zhiyiren2009-subscription 
        <zhiyiren2009-subscription@protonmail.com>,
        zhiyiren2009@protonmail.com, snakamoto1975@protonmail.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On December 27, 2021 11:07 AM zhiyiren2009-subscription wrote:
> Why not add a quick login method like VSCode and CLion in git? Login
> to
> GitHub/ GitLab with one click, without privete key.

I believe you're referring to this?
https://code.visualstudio.com/docs/editor/github#_authenticating-with-an-existing-repository

This is using PATs,
so the same authentication can be used in CLI.

I recall seeing a github login window when I was playing around with https
authentication in Git for Windows.
Not sure what happens if you login through that as I quit that window.
I believe the default credential helper already saves username/password
for https remotes.

It should be noted that many prefer to authenticate using ssh-keys
but ssh isn't viable for all remotes/environments :/
