Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70FB01F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 17:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKSR6y (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 12:58:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55753 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKSR6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 12:58:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so4182858wmb.5
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4lVV2eBGO9oiYMfKy8b27MxnsvH4AYboS9XZtKoe5AU=;
        b=hfpZHjsbJi9CXe+8p9qalVnn/Tz5I9o1DWMXi9MSClqdJ5RPeRK85fu01fvi6mXuqm
         oEdUxgrzIa/LSCNqcRzR0EZa2vdPorz+uozd5FL2KCZ4JfE47VVsPbv5ycA5XZQUTOyl
         RLFccRo8rTpcbOsgoQuTCtpWeftHrwTXm4HyJtP16nVGtSDnVsZl0EsD4T0w48JGlQme
         svwgpNNo4pQ2Xo5C0c14R1RsrVyQEth9kOa1m4rCSHLZRG5a187/Iq55cWiKtDP5RNEx
         xh1fYSZ2RBqB17qovt4lq+7URR6e3K7OoARNMKGrTa+T5JrXzGoJBzv+RJQf1F0c1458
         XvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4lVV2eBGO9oiYMfKy8b27MxnsvH4AYboS9XZtKoe5AU=;
        b=i6g8W379pWLIPNCS4d+8CKZY0lQmh7l8DMYDutUCzqKtP1e4Jf9NJz0i5c/GSorqG8
         +Z+oon/xD/voggb0x/+ZRyA14Cw8EwDYcwioa09puD6e65rh6UjA+dCcDMyasXNM97Ij
         Jp76DUEInkaMESWCmwSyqB7BJJ29bJ8HxvbtVMi9Ij5pC/m2+Fev2nRqgJMUpiAzgEgw
         rZ0cz4EEe4WX9lAsOjkgvt8xuPth26zG4ZLDcgaDujOScZSqeUCsJjGz0y97Mud4lbyg
         6HggyomEK9iMRF3Dy7r9X7ziQN6jqqCu49uEDleNIWRqU4S8k2GX0LrT3WZXneOKTHD8
         pl6w==
X-Gm-Message-State: APjAAAUGWdTp0cHycxHfx9r9fVGlwsrfneGAejp0HxFW0pEG3XdZvog3
        EcmArCU6WOLWjqMXzdEXeAc=
X-Google-Smtp-Source: APXvYqz9sGNfpK/nKlmdk1j7Tz+2PzUT32EnaqkilyCbUE+HRJSo0alUl02FCCpmx46aZiFAqG28gQ==
X-Received: by 2002:a1c:560b:: with SMTP id k11mr7841714wmb.153.1574186332769;
        Tue, 19 Nov 2019 09:58:52 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id d11sm28050182wrn.28.2019.11.19.09.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 09:58:51 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:58:50 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2019, #03; Tue, 19)
Message-ID: <20191119175850.GL23183@szeder.dev>
References: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 04:05:48PM +0900, Junio C Hamano wrote:
> * ds/commit-graph-delay-gen-progress (2019-11-07) 1 commit
>   (merged to 'next' on 2019-11-19 at afa7c921be)
>  + commit-graph: use start_delayed_progress()

This commit is incomplete:

  https://public-inbox.org/git/20191111142739.GL4348@szeder.dev/

>  One kind of progress messages were always given during commit-graph
>  generation, instead of following the "if it takes more than two
>  seconds, show progress" pattern, which has been corrected.
> 
>  Will merge to 'master'.


> * ds/sparse-cone (2019-10-23) 17 commits
>   (merged to 'next' on 2019-11-19 at 1eb4b3a012)
>  + sparse-checkout: cone mode should not interact with .gitignore
>  + sparse-checkout: write using lockfile
>  + sparse-checkout: update working directory in-process
>  + sparse-checkout: sanitize for nested folders
>  + read-tree: show progress by default

This commit changed the default behaviour of a plumbing command, and
the resulting discussion concluded that such a change is not
desirable:

  https://public-inbox.org/git/6c6b9838-af7b-7212-199f-a0a3f3f2ac77@gmail.com/

>  + unpack-trees: add progress to clear_ce_flags()
>  + unpack-trees: hash less in cone mode
>  + sparse-checkout: init and set in cone mode
>  + sparse-checkout: use hashmaps for cone patterns
>  + sparse-checkout: add 'cone' mode
>  + trace2: add region in clear_ce_flags
>  + sparse-checkout: create 'disable' subcommand
>  + sparse-checkout: add '--stdin' option to set subcommand
>  + sparse-checkout: 'set' subcommand
>  + clone: add --sparse mode
>  + sparse-checkout: create 'init' subcommand
>  + sparse-checkout: create builtin with 'list' subcommand
> 
>  Management of sparsely checked-out working tree has gained a
>  dedicated "sparse-checkout" command.
> 
>  Will merge to 'master'.
