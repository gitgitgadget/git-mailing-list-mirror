Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CB820248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfCCBY3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:24:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38982 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:24:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id z84so1464119wmg.4
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=qAAk09SOL0tROb9UIbOo6qtOlre6AP9e4mZj4swqvu4=;
        b=U9g96BRofk82HFlpQLmt0FG46RWlnkVTsdTysZFrGAU2UPFvZw6vWjH7ezY51w7an9
         ZZA7EDk4JBx/I+8b0Y0Xs5HMPqgZfJu56n7YaeYQ1JrbszMVhoEet1xODC+BHs9kVFa1
         Jb6a+JWn9axtqjozA2/bwYRynuaky6C0TYmFL1wD0RLZxS8naVQaROhyoiL8b2EGOc2E
         ztJtYKx6mjfKZw3qb8/neI8nXeD/MqJdc+XhZzgkedcg+hk4GZWSB7MwJwBOdIQsYojf
         Kv38WA59XGVmR/Bh9WepLh0m0CkcCB4dAhXVfZ3pwYQA08bd3qHmwYwa8MUDvxpmZS7+
         7r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=qAAk09SOL0tROb9UIbOo6qtOlre6AP9e4mZj4swqvu4=;
        b=fj/rYybutE4033SvKlnBqaV6UUvy085aOJgd3QTW8uL7tVXMJgzB9tM4LP61r9C8xs
         20jVlCofI+8PZrYkABAiLTwIk0uTx92rf1X14FXS9CVG7VmhbMLcPQl55Rld6BzVLTQA
         NSf6BhTDViN+G5QTALyimhT+QmRcup0g359DBuTtsE1dTcw2Paz7G2Mb+Xf3V2vUftcX
         3nHrcGFjKk0PZ9bQW7jqnsmBmu117aTrpDtnqhQo1V2vzOb5K6gDNYHRmkJdUG4UuPSR
         E6sTl4s0MG26m4rgRd5bxqVQ6tCIBIXEx6UYBv5vYcpcms+kswDsxjPHEpCkdXvNY3Po
         eZSw==
X-Gm-Message-State: APjAAAXUvtafLVhQa+CtKsKPe9yE92RNOtKj1yqIiAzenWj/Dk/ac0ZK
        v5RgJuhEop4/tpkHr8qP5xk=
X-Google-Smtp-Source: APXvYqwMR5i7qShhw7rBCzMuKl+JZzfgsTOzc0AleuKsp215MUjtpqlAMLWHI36z2T5C6z2JtaH7dA==
X-Received: by 2002:a1c:dc8a:: with SMTP id t132mr7807952wmg.48.1551576266886;
        Sat, 02 Mar 2019 17:24:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t202sm6141552wmt.0.2019.03.02.17.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:24:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase docs: fix "gitlink" typo
References: <20190228024315.1470303-1-kyle@kyleam.com>
        <CAN0heSo5qsd4t_mgt90ws2hCp3O0qch_9MgXuzj-4FS2gG+bkA@mail.gmail.com>
Date:   Sun, 03 Mar 2019 10:24:26 +0900
Message-ID: <xmqq1s3o4unp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> On Thu, 28 Feb 2019 at 03:44, Kyle Meyer <kyle@kyleam.com> wrote:
>
>> Change it to "linkgit" so that the reference is properly rendered.
>
>>  have `<upstream>` as direct ancestor will keep their original branch point,
>> -i.e. commits that would be excluded by gitlink:git-log[1]'s
>> +i.e. commits that would be excluded by linkgit:git-log[1]'s
>>  `--ancestry-path` option will keep their original ancestry by default. If
>
> Heh, I stumbled on this a few days ago, and have this exact patch in my
> w-i-p series. I found it interesting that both Asciidoctor and AsciiDoc
> trip on this in quite different ways.
>
> The patch is correct and tested by me, FWIW.

Yup, thanks, both.
