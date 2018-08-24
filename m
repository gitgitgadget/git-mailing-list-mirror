Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3201F404
	for <e@80x24.org>; Fri, 24 Aug 2018 15:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeHXTFw (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 15:05:52 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44762 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHXTFw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 15:05:52 -0400
Received: by mail-wr1-f41.google.com with SMTP id v16-v6so7808377wro.11
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/myhGoBYJXof+HHQz1QZgQ4xgsnAlp48oMli5dlat70=;
        b=E26H5shHUXXJ/UH5pDOlFBOCgKFBDJjheiB+4tUMe2o09q9VXd1mjhaxVmOu1RsVLi
         gJJuwiUxrJ1wBCpY2Jy7B+DgkRhc4ppbBRJasHTMgDi7TEAIFeSn2MZ6vtBYTwGxRCcb
         pbHZ+mHjKrYWFTkIb2qfcjbGMkaHib+wQQ8nPn6Ki8fzRk/khVwlrorCrErPt9AerMD7
         xEzqMnRIsRFiUCmjGd4hkoaPs5VSkJRbGQSbWI4oIOkV4MUphIn40qHnIeFoAKgFTC7x
         jGEvgp7evNi9k9i4LAQXpHolceAf7nGbuns6w1s0m77k/+Oz8JM5FxW2V/+4QcDIPpBM
         m2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/myhGoBYJXof+HHQz1QZgQ4xgsnAlp48oMli5dlat70=;
        b=b0ZZAGfYGIsnk/GN2joZUhLUdxgQMsvJXZs4gLwyJxORcsvFqLD/VJV25OLljxq0Bf
         2ci8Kc13UAeV8T1VEKW2/Qn0YsHRqGV9yerL+TKV6PdBaXyMkE2L1rms2t/mANHytfPt
         Mt3NUPxXnvqvCBk/uaxWRuRFimRq15suzPbHGFf3M2VriBXc4z0aefs/W8Mfo0Ccj/8r
         w/ImEP1otFDRlYAuB/w3LzIKBE4+DdybgPZJGi1xjRKx/qVR10W5pkka7IjcJ0QDhNb/
         G+HLrGfilfGQONt/e0Zz/aYr1V4zFuMxNEX2EylzfxuiTq4GldtC1tMsBW1SMA/h7G++
         Z/qw==
X-Gm-Message-State: APzg51DHYmkQQTnU3Trqoub8SjAPLOACsmaf/f3AE19GBNB1Xy5hvRy5
        sN5DqC3DI33P+ujxdQVW9NBfX30j
X-Google-Smtp-Source: ANB0VdZZyJp9Sm5DBY7tBROnW7qLt/pWa1YBIuCzfrw7Sbpa4ZLjxzNjVRaluiGsqRRHLZk8Vqc2iQ==
X-Received: by 2002:a5d:4d52:: with SMTP id a18-v6mr1546560wru.40.1535124641816;
        Fri, 24 Aug 2018 08:30:41 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.gmail.com with ESMTPSA id x65-v6sm2274100wmg.39.2018.08.24.08.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:30:41 -0700 (PDT)
Subject: ag/rebase-i-in-c, was Re: What's cooking in git.git (Aug 2018, #05;
 Mon, 20)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsh38admf.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7d10d662-2de5-56fb-31a3-d48221e5d505@gmail.com>
Date:   Fri, 24 Aug 2018 17:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqsh38admf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 21/08/2018 à 00:15, Junio C Hamano a écrit :
> * ag/rebase-i-in-c (2018-08-10) 20 commits
>  - rebase -i: move rebase--helper modes to rebase--interactive
>  - rebase -i: remove git-rebase--interactive.sh
>  - rebase--interactive2: rewrite the submodes of interactive rebase in C
>  - rebase -i: implement the main part of interactive rebase as a builtin
>  - rebase -i: rewrite init_basic_state() in C
>  - rebase -i: rewrite write_basic_state() in C
>  - rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in C
>  - rebase -i: implement the logic to initialize $revisions in C
>  - rebase -i: remove unused modes and functions
>  - rebase -i: rewrite complete_action() in C
>  - t3404: todo list with commented-out commands only aborts
>  - sequencer: change the way skip_unnecessary_picks() returns its result
>  - sequencer: refactor append_todo_help() to write its message to a buffer
>  - rebase -i: rewrite checkout_onto() in C
>  - rebase -i: rewrite setup_reflog_action() in C
>  - sequencer: add a new function to silence a command, except if it fails
>  - rebase -i: rewrite the edit-todo functionality in C
>  - editor: add a function to launch the sequence editor
>  - rebase -i: rewrite append_todo_help() in C
>  - sequencer: make three functions and an enum from sequencer.c public
> 
>  Rewrite of the remaining "rebase -i" machinery in C.
> 
>  With "rebase -i" machinery being rewritten to C, with a different
>  interface between "rebase" proper and its backends, this and the
>  other topics need a bit more work to play with each other better.

I am preparing to send a new version of this patch series, but it
conflicts a bit with js/range-diff in the Makefile and in git.c.  They
are not really hard to solve, though, a 3-way merge can handle this
fine.  Should I rebase my work onto origin/master, or should I let you
handle this?

Cheers,
Alban

