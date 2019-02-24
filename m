Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED65B20248
	for <e@80x24.org>; Sun, 24 Feb 2019 05:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbfBXF1l (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 00:27:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36221 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBXF1l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 00:27:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so5226812wmj.1
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 21:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HJjr7AC6v+3w8A0h8pWTQvCvj2UFwgE1B3KhC4aXUB4=;
        b=fgYQYHTUhmQANkANJ8iFPjar79+LACJLDnmWBjXs228D/zyTRJgWbZjVSdff6T6Rmw
         M9imG4z7K/mX8IFWlUPXYTcGiI9ANR18WP4Q0NpBwI/kgCN7Lbu4+61IcMB4H5Mm/B78
         uQSOF0TgJQADja6+EDmjyeohBuGt96WUiXOF02LR3sHYNPDZFaPJl3xITNu0R/g1DNdY
         Jz1aD/2IlqdGU4cCpCTJRsGJj4N7S36/UAk9dF0CwfCUW00C6CHHaIYeVGp5cBv9NueS
         eF6UgzdSeJtrQ/2+PAn8OTLujr1wvPtYE3vvB552BVJRJAj6RPIhQqHU6ajuk0xmQGGL
         nDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HJjr7AC6v+3w8A0h8pWTQvCvj2UFwgE1B3KhC4aXUB4=;
        b=dnAPU6PCqCu653tZ8buWNik+Oc/MNLm9t++yhDLxUKC3Xx5bN45EHri+OzLYcsKQGz
         XDGJUyR4K90ZuW3tBV8dEuLu7q3YEDgX4NcgD6zhBeZjCopS4DCq5tfO1knj2BNPgy2r
         esmCXvevGhrgWwCLYPG3OQh7AyPypq5ZHIeJYoaZTs/oj6DpvXC1y4oXGG5uZ2X8SWRJ
         cI3p7tr6gSPupG5H7pKV780fWyocqdyOx9Tm0xhFtymTnX0QJlywyXAqwlyMYBr/4TXC
         hj4VOtIgzfJ9T9tR3CJW1FnZ3KDxKgCJDz/3kWf4gARe0w6qQIvHwY0nuG6n05xtmdOu
         nNqQ==
X-Gm-Message-State: AHQUAuY20uPJDfxONLnjRN/kCk6yXOdVIj/6K9JYQ1QdE1m37PkWe1pS
        I8d5t4TxX21aiHHtIsn0qBM=
X-Google-Smtp-Source: AHgI3Ib3GUQ7wG7gMhRjsENlmMXJ06SzIzg0NIzNP6Nbf+p8ma/+e1ctFjwGnDa6S8pNcHeIaIKEGg==
X-Received: by 2002:a1c:f20a:: with SMTP id s10mr6540465wmc.123.1550986058967;
        Sat, 23 Feb 2019 21:27:38 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j41sm17632162wre.9.2019.02.23.21.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 21:27:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] README: adjust for final Azure Pipeline ID
References: <pull.128.git.gitgitgadget@gmail.com>
        <b9997a4a3c7577d745a6084ca007d188ba9ff6c4.1550933361.git.gitgitgadget@gmail.com>
Date:   Sat, 23 Feb 2019 21:27:38 -0800
In-Reply-To: <b9997a4a3c7577d745a6084ca007d188ba9ff6c4.1550933361.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sat, 23 Feb 2019
        06:49:23 -0800 (PST)")
Message-ID: <xmqqa7iloiwl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> During the six months of development of the Azure Pipelines support, the
> patches went through quite a few iterations of changes, and to test
> those iterations, a temporary build definition was used.
>
> In the meantime, Azure Pipelines support made it to `master`, and we now
> have a regular Azure Pipeline, installed via the common GitHub App
> workflow. This new pipeline has a different name (git.git instead of
> test-git.git), and a new ID (11 instead of 2).
>
> Let's adjust the badge in our README to reflect that final shape of the
> Azure Pipeline.

Always happy to see declaration of victory ;-).

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  README.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 764c480c66..88f126184c 100644
> --- a/README.md
> +++ b/README.md
> @@ -1,4 +1,4 @@
> -[![Build Status](https://dev.azure.com/git/git/_apis/build/status/test-git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=2)
> +[![Build Status](https://dev.azure.com/git/git/_apis/build/status/git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=11)
>  
>  Git - fast, scalable, distributed revision control system
>  =========================================================
