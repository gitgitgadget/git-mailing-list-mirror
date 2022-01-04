Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC2C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 15:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiADPfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 10:35:51 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:39548 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiADPfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 10:35:50 -0500
Received: by mail-il1-f179.google.com with SMTP id q6so28566375ilt.6
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 07:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1SZI22GK1GBwzY2uLWfxHqXijM1EE/06x5kxbjZIZI=;
        b=5FP54Nat4c3PrpTjBfBuo/03OechKq9XmEKyxlm6z8WATxk/X2QjH9s+EGNxdyDxDp
         0Kxaj7B84LDjrQ+UsWdS4DMujXOyBoC3DeLVEs8GlDGA48mmdNkTMg623xnOisZE1x+P
         3NrscQXX/ggm5ZWES04fFAB5I3rutU9VgjhRnbMfn3URQr9TXrKIxV4ctHUs0REO+Jmv
         qUN2rA41/F99tp1fE5Seb9Yf3HfDJhUifiPoYnJyTlmSOWziKRAKdH0WXUX8LzwWMFSc
         fpUc5XFn2ccyQByvPbW3ucMMX3BxMXkNk/pxzRGflkOVjjJEeokwF2UyxhpNYeuIve3G
         qUKA==
X-Gm-Message-State: AOAM530bno95kq47RIO0rd+azwLt42d9iNVcFGW2TQagIufVi4I9nCjQ
        0Hb88cGEYVYnOQSU/7h1oF7o7+FLtSNvn3PcSXMJxv/9/Uc=
X-Google-Smtp-Source: ABdhPJzR+ibdlyCxMVUYrNogr47vSKykMms/HetCIRGkuIBpYxOxdeocHdP6v+7swQPm68THtNyVtLAsRh5RKdMvUi8=
X-Received: by 2002:a05:6e02:92d:: with SMTP id o13mr22874566ilt.49.1641310550208;
 Tue, 04 Jan 2022 07:35:50 -0800 (PST)
MIME-Version: 1.0
References: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
In-Reply-To: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 4 Jan 2022 16:35:14 +0100
Message-ID: <CA+JQ7M_tOu5ahQSPZk5Be10rY_NDOmqLWj9b1On=KW8Rq2mk2w@mail.gmail.com>
Subject: Re: Bug using `fetch` with blank `-c` arguments to git
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minor clarifications

On Tue, Jan 4, 2022 at 3:48 PM Adam Dinwoodie <adam@dinwoodie.org> wrote:
>
> While investigating some issues with a different project, I discovered
> the command `git -c config.helper= fetch` was working with the Debian
> ...
> I see the same behaviour with `-c config.helper=`, `-c
typos for "credential.helper" ?

> Notably the behaviour does not affect all other git commands; `git -c
> core.autocrlf= log -1` works as expected.
You've only seen this with "git fetch"?
