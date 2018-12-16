Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66BC61F405
	for <e@80x24.org>; Sun, 16 Dec 2018 21:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeLPVsi (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 16:48:38 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:44710 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeLPVsi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 16:48:38 -0500
Received: by mail-wr1-f45.google.com with SMTP id z5so10355016wrt.11
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 13:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0s1NvTD5bMYDmLef7++JikLwxJwInUutHQ29YsWzGKI=;
        b=nu4ZTKuzfxzFah+B8qyBXr5r1P++R5Is9gdban2kzDHu4u6YUx99KgTASyh3Kh/4Jz
         cIlgokDPv54tQ+0weU4889Cuh6dhXvEP9wWwTY6gZmyOwc2afmIfcS45uz25/IUiJ1B5
         eeQx0IGkUvK61PtK/MGXCK6bnH1e29W8FEniXbfifSwFgMTjGMxFny+vyu83nDLoEIdQ
         0upMgULHC6nfxPqkT2hbmZ7ETqZvZ5FFPT6tFQfq/I9pKDSKxHrzB0RxeaLp3UR6BYCp
         gyxgCIuBuNCG3v/Tmy+5NbH1gph2F5easNMYa7cs+JS6VDQkv18DmBD6NJ13f2pyuV3e
         fbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0s1NvTD5bMYDmLef7++JikLwxJwInUutHQ29YsWzGKI=;
        b=RvhpHOtVsrWXuNz9xemQGVuopwWqzkYLPaHYHTLTx+mmm3MCpnM4Ls0xLHGW9IGCXC
         gXIQkrambYfp1hsET98GJFzo2DBi+ofk0UJzZH8G2ce4VD3rIo9pEjQ+X+3psq+j+dUO
         wkeHU4rgeWO4juL+4Tn2I2C7c6cLoVfOq3jzHXoX8PHWgsAiS+lAwwbEcN6sAqQsKf2W
         tLdrbZS1uBk5DGOxCWYFarylFflTDxPOWtVLm1A2cSzngeHov3fuDxHp9cEZ861TLFtd
         JlHg4EFp011efN48cQMa3nU5CgTStdHNJ4dILY4AHwCizLW/dQYsW5YS0DpoaJxUgMht
         PuQA==
X-Gm-Message-State: AA+aEWbjtactr7RiWx+LCAC2FAl/M4rylO//du13Suny44ICt2OI0IyD
        E1rgGHJuo3K/Csn5Uq/xrNBHBLem
X-Google-Smtp-Source: AFSGD/UtFqTqubR6mS6kOoBo4p2UPIN5VThReUVH3/wJyyso3P1ReCcML4Z5UEtIilokRVKcrbVB9g==
X-Received: by 2002:a5d:620f:: with SMTP id y15mr8324302wru.314.1544996915675;
        Sun, 16 Dec 2018 13:48:35 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-111-151.w86-199.abo.wanadoo.fr. [86.199.34.151])
        by smtp.gmail.com with ESMTPSA id w125sm9523647wmb.45.2018.12.16.13.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 13:48:35 -0800 (PST)
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fcc4ad0b-5566-165c-f20d-8a09ce659112@gmail.com>
Date:   Sun, 16 Dec 2018 22:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 09/12/2018 à 09:42, Junio C Hamano a écrit :> -%<-
> * ag/sequencer-reduce-rewriting-todo (2018-11-12) 16 commits
>  . rebase--interactive: move transform_todo_file() to
rebase--interactive.c
>  . sequencer: fix a call to error() in transform_todo_file()
>  . sequencer: use edit_todo_list() in complete_action()
>  . rebase-interactive: rewrite edit_todo_list() to handle the initial edit
>  . rebase-interactive: append_todo_help() changes
>  . rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
>  . sequencer: refactor skip_unnecessary_picks() to work on a todo_list
>  . sequencer: change complete_action() to use the refactored functions
>  . sequencer: make sequencer_make_script() write its script to a strbuf
>  . sequencer: refactor rearrange_squash() to work on a todo_list
>  . sequencer: refactor sequencer_add_exec_commands() to work on a
todo_list
>  . sequencer: refactor check_todo_list() to work on a todo_list
>  . sequencer: introduce todo_list_write_to_file()
>  . sequencer: refactor transform_todos() to work on a todo_list
>  . sequencer: make the todo_list structure public
>  . sequencer: changes in parse_insn_buffer()
>
>  The scripted version of "git rebase -i" wrote and rewrote the todo
>  list many times during a single step of its operation, and the
>  recent C-rewrite made a faithful conversion of the logic to C.  The
>  implementation has been updated to carry necessary information
>  around in-core to avoid rewriting the same file over and over
>  unnecessarily.
>
>  With too many topics in-flight that touch sequencer and rebaser,
>  this need to wait giving precedence to other topics that fix bugs.
>

If I’m not mistaken, there is currently 3 others series touching rebase,
rebase-interactive and/or the sequencer: en/rebase-merge-on-sequencer,
nd/the-index, and the new js/rebase-i-redo-exec.  Among these, I believe
only nd/the-index actually touches the same places as
ag/sequencer-reduce-rewriting-todo, and is not a behaviour change.

Is this safe to reroll this in the next few days?

--
Alban

