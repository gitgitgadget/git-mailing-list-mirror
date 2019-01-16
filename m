Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FBC41F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 21:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfAPV1g (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 16:27:36 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:34568 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfAPV0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 16:26:36 -0500
Received: by mail-wm1-f54.google.com with SMTP id y185so2035166wmd.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kGOPPvoQA3upGjEnftnbZ7RjGsea3MOWOSJ2NjHIQmk=;
        b=KZgZArqPwMbUGKB0oYri5X9HHfzx+2hnyUac9FXzH+GfjUzH5Wjc9CNmQMLuU5IErW
         zmU7zBpq14jpLBIbfuNwtmDrktHvmlyQKKZ/TmLNzFLYv+Gfxemsb19rCuVUBOyxsEJW
         pc5zynaZlCVbPROEiPGhgJAPZfW4aIcxoPtR5GlIq1pI+e04KdV924Cb8duufOMoE7CF
         7Ip6f7ivSynPRPyJhmpemqBJur0mf7TzohN9aDh4tvWisfCG2Fwg9CQ35vhGVVZda8Wb
         +g4z2tl4YKv0flcbLHdHL2HC+NXpiBRHpXE0wLIR4ZVm41OGKsH36iSlmtNeu4ZVzfpQ
         WbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kGOPPvoQA3upGjEnftnbZ7RjGsea3MOWOSJ2NjHIQmk=;
        b=BUQBi3Rxpd0jNEtgsmRywHor17ZWY7Lwa26JPVFUP1RZS0hFKtsDGmCX56UaAaNDou
         ioDNRdx3/KUOXpyBCDnRtZ8NK7K1vEaS3EtfCmYHfbIsMKuuzUydAU1X4yZKU6A+C0wR
         ZUqMcvrLlaJNKIVlMXqu/Dyl1zPwPX5AlB2CquA6h/Kf5ibOaEAC7dYCtKRZqO+79oUg
         YOlfvOEgR0z32uJ0YrVkAfN94Aco4jt4lIM6GvUNuFRmV/3Nu5SruFdim6an+eIkOrz7
         ZoLmT9AaPAyBXfNalSQoovvh+m3lqretAjKG4/MRsp+Fk7tVGGHiL+sHnqSfv4nkKhcf
         7PhA==
X-Gm-Message-State: AJcUukf2R96iF3CfK6o9Vi9Qk0NKw9k/6kHbGzg3EUAahXgW+/Sdwzhp
        2zyrPV1dowTWTWxP4c9aueQ=
X-Google-Smtp-Source: ALg8bN7jSg/zOLW2unO512R2vebRUea1vwrVS85ZKQeD9A37wpWgx3ChqItzmaWekP5FsDnv1bVfaQ==
X-Received: by 2002:a1c:2e0c:: with SMTP id u12mr9214106wmu.81.1547673994291;
        Wed, 16 Jan 2019 13:26:34 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id l6sm79017187wrv.70.2019.01.16.13.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 13:26:32 -0800 (PST)
Date:   Wed, 16 Jan 2019 21:26:31 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #02; Tue, 15)
Message-ID: <20190116212631.GK25639@hank.intra.tgummerer.com>
References: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/15, Junio C Hamano wrote:
> * ps/stash-in-c (2019-01-04) 27 commits
>  - tests: add a special setup where stash.useBuiltin is off
>  - stash: optionally use the scripted version again
>  - stash: add back the original, scripted `git stash`
>  - stash: convert `stash--helper.c` into `stash.c`
>  - stash: replace all `write-tree` child processes with API calls
>  - stash: optimize `get_untracked_files()` and `check_changes()`
>  - stash: convert save to builtin
>  - stash: make push -q quiet
>  - stash: convert push to builtin
>  - stash: convert create to builtin
>  - stash: convert store to builtin
>  - stash: convert show to builtin
>  - stash: convert list to builtin
>  - stash: convert pop to builtin
>  - stash: convert branch to builtin
>  - stash: convert drop and clear to builtin
>  - stash: convert apply to builtin
>  - stash: mention options in `show` synopsis
>  - stash: add tests for `git stash show` config
>  - stash: rename test cases to be more descriptive
>  - t3903: modernize style
>  - stash: improve option parsing test coverage
>  - ident: add the ability to provide a "fallback identity"
>  - strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
>  - strbuf.c: add `strbuf_join_argv()`
>  - sha1-name.c: add `get_oidf()` which acts like `get_oid()`
>  - Merge branch 'sd/stash-wo-user-name'
> 
>  "git stash" rewritten in C.
> 
>  Comments?

I read over the series last weekend.  I had some small comments on
21/26 and 25/26.  I forgot to reply with my overall assessment on the
thread though.  I'd be happy to give my Reviewed-by for the whole
series with or without the changes I suggested.  I double-checked the
re-introduced "legacy" stash script to make sure it is actually the
same as it is on master.

So I'd be happy to get this merged into 'next', and if anything comes
up to fix that on top.
