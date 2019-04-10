Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9196020248
	for <e@80x24.org>; Wed, 10 Apr 2019 10:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfDJKMo (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 06:12:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51156 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfDJKMn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 06:12:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so1990488wmi.0
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 03:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w2qijmR5mqEfI2RkxrKpDI++a/6PiHg8+5H/311nxT8=;
        b=ihE8tVPbVUq/f/QoedY6Halk4diLbPfIrtk3Zy2GI3U3OELqnd+WreoKpcVlB6skv1
         ke/ThtqezoFw3VE0t/DFzBypjhhBVN7/j5+twnv/D1VzU9NL7JXToZwuIfzUz60T7IOD
         rCcmoHAcOXq5MYlKkiFZ1TqPDeyZVZibjZCs3xmIK5w10ct07eT1AgbqpTczGMAOX/jp
         NSfUQbRTV64w2LQHFWJoeBG/QKURrO6Vey4qqO1hKEAAxeQ49cHkLQMp3892kZ6ufswz
         Mbn6tfc+4WRWhwdFXv2oo/kLKAHJ9LofXuIu4oP9e8eHzQupD4Al5c+LSseAOfbUtYaC
         7fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:cc
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w2qijmR5mqEfI2RkxrKpDI++a/6PiHg8+5H/311nxT8=;
        b=ktyuDcTu/yyA2bQuJNR/BpujvbwzI+zEgw4zTaWbijUZN/ZC7uOxYYhcCfX3Pdg4wR
         gUrNN1plwqn0UNEp8SfE3+yER9HdHNdt+KbtCARKe/7OvfBisYt0xKTSVi5LpEVFoIyK
         U6DhBORRbsscjmgu2zX+Ewl28+Hxz3dLv/w2t5cAnAkNKLHnq6Miej34p1q5IwP7mrTs
         rj0qSeReMkFYwe+CZL2NRKIZJkVYVgxebRck+Jyyg5VJ3Jf6l2lmr7TtghvCgSPG0jWy
         d3szXPdOjuGhknzTRjGkI/VWqyvc8E7FRAn45++RY59yj+bLx+M5AObnEMRJf1Xrle47
         Uf5g==
X-Gm-Message-State: APjAAAWfxuuUmgHNLtdqP3Q3tsVCiDTrc7uZSdgtU2zfH6aegglyItck
        VNJXpEjORdesI6bSmUQ+WUw=
X-Google-Smtp-Source: APXvYqzvCB5Q64bq9pO0Ki4GAA3wbLCLEmMqOLG5LKVtOm4S8FJwbjgjVJ0TFt4ljwekRFbX2fMLGw==
X-Received: by 2002:a1c:cf0b:: with SMTP id f11mr2176515wmg.26.1554891162089;
        Wed, 10 Apr 2019 03:12:42 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-29-81.as13285.net. [92.22.29.81])
        by smtp.gmail.com with ESMTPSA id y127sm2172718wmg.29.2019.04.10.03.12.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 03:12:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <2a91a971-24fa-9cc7-5159-14c0771838f6@gmail.com>
Date:   Wed, 10 Apr 2019 11:12:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/04/2019 19:08, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> * pw/rebase-i-internal-rfc (2019-03-21) 12 commits
>   - rebase -i: run without forking rebase--interactive
>   - rebase: use a common action enum
>   - rebase -i: use struct rebase_options in do_interactive_rebase()
>   - rebase -i: use struct rebase_options to parse args
>   - rebase -i: use struct object_id for squash_onto
>   - rebase -i: use struct commit when parsing options
>   - rebase -i: remove duplication
>   - rebase -i: combine rebase--interactive.c with rebase.c
>   - rebase: use OPT_RERERE_AUTOUPDATE()
>   - rebase: rename write_basic_state()
>   - sequencer: always discard index after checkout
>   - Merge branch 'ag/sequencer-reduce-rewriting-todo' into pw/rebase-i-internal-rfc
>   (this branch uses ag/sequencer-reduce-rewriting-todo.)
> 
>   The internal implementation of "git rebase -i" has been updated to
>   avoid forking a separate "rebase--interactive" process.
> 
>   Comments?  Is this ready?

It is more or less ready, there weren't many comments. I'm planning to 
send a re-roll but am waiting to see what happens with 
dl/merge-cleanup-scissors-fix and [1] (which you don't seem to have 
picked up yet) as we discussed rebasing this series on top of a merge of 
the current base with dl/merge-cleanup-scissors-fix which currently 
conflicts with [1].

Also now ab/drop-scripted-rebase is going to be in master I could add a 
patch to this series that drops a bunch of unneeded options from 
rebase--interactive as it will only be called by 
git-rebase--preserve-merges.sh which only uses a subset of the current 
options but that could always come separately later.

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/20190329110842.30604-1-phillip.wood123@gmail.com/
