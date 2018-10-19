Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E321F453
	for <e@80x24.org>; Fri, 19 Oct 2018 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJTCMX (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 22:12:23 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33686 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeJTCMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 22:12:23 -0400
Received: by mail-wr1-f48.google.com with SMTP id u1-v6so2537263wrn.0
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vf3cb7Y2dWrEw7DXMzYJ5CktykngoeUo4AukpVwqOFk=;
        b=bSPpwJGUaENVz3q012Gf142qgKh20oeuVvLjSrLOSqOP24x5zHeEBC0inyHlBbfXSx
         TA3ccAFeLyQhx+5qKTT0lmMfcoledD3lbugH0ViwylM48eEvEYf5vJ4FN5GB+VNy6CoV
         Lj5bWn0B4FoQXGXxtDv4/5L7E9ovsQdXH1ioHATrXLQ436t1ByjAl8Lt4RFT+2YVHmiz
         Ms4u5g5cLWmPSyAEuWAgOhsHtA1kh+tX/nYl1TDYGxIN8rQUtLONBVDlf/vGFp7Wxkpk
         62VaZjmJNpbfjiDdQWBjRe71KRUyELnHN3x63dtUYBA5M5MqT14TyOgChQ6fRu9OlCrY
         LegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vf3cb7Y2dWrEw7DXMzYJ5CktykngoeUo4AukpVwqOFk=;
        b=iXjEc6n4zIRU4AJSc/0Th8QeJv+DxN6VLOiuPzUEJ0BYT3Yp0Jy0sKusF+hGNx/WcF
         07aByDx4tJRgtdZJ4Q4Nrh3kJvH2CRj0rKHaOIy0CdFeU/TKrAYoKPS/Jtf82um69OiW
         2uIgxS6k3FSWBQ8A/tb+zUMK0t21xnLV7Tj9Dl3a0P7QzGPwNyuapGVyAWN8xl4Zedwa
         XnwQMIBhI+VCLspsVy/3u36yQOw8G0EGiM74R9+GekQnYHHtHBFBM+gJuRnJGVOqrpjd
         Muij+UGAG2cMkJidYhfgJUQ8D8Z/Nn0ferOLh4hPZbiOHWJOrML4in+z4bEvM67071IF
         ztUw==
X-Gm-Message-State: ABuFfojc5g9oWoYgiWueGyZoSRNW8EhysY1e+B1fJcQi0BL4SO265BYN
        4EfEH3hisAb2/WQNr4zazY1QFAN9
X-Google-Smtp-Source: ACcGV63ZMES0QwLRlIqQ0FZ9PTND7hJ8r2LFqQvChhf7qfnUajegqXkxLGnTALrrV1kRJoO2JxqT8g==
X-Received: by 2002:adf:e9c7:: with SMTP id l7-v6mr33228003wrn.238.1539972312115;
        Fri, 19 Oct 2018 11:05:12 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-59-23.w92-136.abo.wanadoo.fr. [92.136.154.23])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3758276wma.8.2018.10.19.11.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 11:05:11 -0700 (PDT)
Subject: Re: What's cooking in git.git (Oct 2018, #04; Fri, 19)
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
References: <xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com>
 <20181019124625.GB30222@szeder.dev>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6e4fdcdd-6c50-a07e-74b7-1fcd15c33444@gmail.com>
Date:   Fri, 19 Oct 2018 20:05:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019124625.GB30222@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 19/10/2018 à 14:46, SZEDER Gábor a écrit :
> On Fri, Oct 19, 2018 at 03:02:22PM +0900, Junio C Hamano wrote:
>> Two large set of topics on "rebase in C" and "rebase -i in C" are
>> now in 'next'.
> 
> I see occasional failures in 't5520-pull.sh':
> 
> […]
>
> When running t5520 in a loop, it tends to fail between 10-40
> iterations, even when the machine is not under heavy load.
> 
> It appears that these failures started with commit 5541bd5b8f (rebase:
> default to using the builtin rebase, 2018-08-08), i.e. tip of
> 'pk/rebase-in-c-6-final', but it's a "flip the big switch" commit, so
> not very useful...
> 

I can reproduce this.

I also tried to run this specific test under valgrind, and found out
that some cases I did not targeted with --valgrind-only failed.  The
same thing happens with t3404, which did not crash with valgrind before.

Here is a log:

> expecting success: 
>         HEAD=$(git rev-parse HEAD) &&
>         set_fake_editor &&
>         git rebase -i -p HEAD^ &&
>         git update-index --refresh &&
>         git diff-files --quiet &&
>         git diff-index --quiet --cached HEAD -- &&
>         test $HEAD = $(git rev-parse HEAD)
> 
> +++ git rev-parse HEAD
> ++ HEAD=d2d5ba71c6d0266f26238e804f77f026984ae0d9
> ++ set_fake_editor
> ++ write_script fake-editor.sh
> ++ echo '#!/bin/sh'
> ++ cat
> ++ chmod +x fake-editor.sh
> +++ pwd
> ++ test_set_editor '/tmp/git-alban/trash directory.t3404-rebase-interactive/fake-editor.sh'
> ++ FAKE_EDITOR='/tmp/git-alban/trash directory.t3404-rebase-interactive/fake-editor.sh'
> ++ export FAKE_EDITOR
> ++ EDITOR='"$FAKE_EDITOR"'
> ++ export EDITOR
> ++ git rebase -i -p 'HEAD^'
> GIT_DIR='/tmp/git-alban/trash directory.t3404-rebase-interactive/.git'; state_dir='.git/rebase-merge'; upstream_name='HEAD^'; upstream='8f99a4f1fbbd214b25a070ad34ec5a8f833522cc'; head_name='refs/heads/branch1'; orig_head='d2d5ba71c6d0266f26238e804f77f026984ae0d9'; onto='8f99a4f1fbbd214b25a070ad34ec5a8f833522cc'; onto_name='HEAD^'; unset revisions; unset restrict_revision; GIT_QUIET=''; git_am_opt=''; verbose=''; diffstat=''; force_rebase=''; action=''; signoff=''; allow_rerere_autoupdate=''; keep_empty=''; autosquash=''; unset gpg_sign_opt; unset cmd; allow_empty_message='--allow-empty-message'; rebase_merges=''; rebase_cousins=''; unset strategy; unset strategy_opts; rebase_root=''; squash_onto=''; git_format_patch_opt=''; . git-sh-setup && . git-rebase--common && . git-rebase--preserve-merges && git_rebase__preserve_merges: line 0: .: git-rebase--common: file not found
> error: last command exited with $?=1
> not ok 25 - -p handles "no changes" gracefully
> #
> #               HEAD=$(git rev-parse HEAD) &&
> #               set_fake_editor &&
> #               git rebase -i -p HEAD^ &&
> #               git update-index --refresh &&
> #               git diff-files --quiet &&
> #               git diff-index --quiet --cached HEAD -- &&
> #               test $HEAD = $(git rev-parse HEAD)
> #

This comes from 't3404-rebase-interactive.sh', with --valgrind-only set
to '63'.

Cheers,
Alban

