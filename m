Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CC9211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 14:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbfAKOJ3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 09:09:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53523 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733016AbfAKOJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 09:09:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so2521943wmb.3
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 06:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=duc301AKs6DLsa+SOEK56tU2PctjFXO5DUxgjKK9nRQ=;
        b=hqOwix4lnhBG29wjXGuWECWJ0j/Bl8zwPoakcI0BDfTzwR93Z112tyv4+UNJjV8rHi
         crjqLyBdsBpffkt3bnqZVgIzR3Gl98yovBj/k5s7TkTGgnbJKltTwbmGOVPz9MvjMWKD
         +Fm8TaDveYa8C2Rd/03l+zljqtQI1SMcp9NsHFbFa9bd1dYH6Aox8qeNlgjchrNyMSkl
         RKzHCZt7sOypFos8FesRmr85SZF+ktYj+VbkR6P0QUWlxeZ7OCRG3oqcMLJnYhshAFwT
         iHIGaEMJzPqOgC/ZdC+LuxuJUhuT5/JWHnNLr2zVx+5eLQ67pK0LMSGhlwNfHye5a52I
         2ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=duc301AKs6DLsa+SOEK56tU2PctjFXO5DUxgjKK9nRQ=;
        b=uhCLN1UOiCEG2NfCTBNh0LHyov0ogh69A9IWTng6mledMxDYFxxNUxYix/pWMP3NA8
         IGkivTvoeGcL/5U5y9OyhqxSP4nzmB0m1H4qvBT6gp8FdB2LRpBsgku35FE+HdDUUjyP
         CVwvdcJqSh/EdWzX609W2vCuPFIjDwUBxsFT9BVlTPaBIC+6iS/MTnJkTT7Mo9ajELWS
         8xjDJfGMdOu++/tyGx/AJgRFu+d8I+2XiC3vVlWVIdOWd1F8L7zzFnZQeNiSXeDVkBnb
         y+wVlKXO+JtOjtkBvSpqS2Vk1SbWofa+pcj76ey4perXGDvTDM6uH0bfL/N1ojTh8x99
         +GAw==
X-Gm-Message-State: AJcUukdvSjKxNvZ77yh6L75Q2Qbu6gGvHy9Uqzcbr9U/pxK5BYJG3+KW
        psr2apDeLHAsjaNIB2Cos7LYJKt2
X-Google-Smtp-Source: ALg8bN7bqu9jw54pisgPA/V5hVGpwq12Je1hAdwF0DQEGZCRRpEnvh3vlNgoo1nLwY/iy0C0uYO5JQ==
X-Received: by 2002:a1c:8b44:: with SMTP id n65mr2570300wmd.104.1547215766730;
        Fri, 11 Jan 2019 06:09:26 -0800 (PST)
Received: from [192.168.1.8] ([31.223.156.248])
        by smtp.gmail.com with ESMTPSA id h131sm27580329wmd.17.2019.01.11.06.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 06:09:25 -0800 (PST)
Subject: Re: [PATCH 0/7] Turn git add-i into built-in
To:     Johannes Schindelin <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <pull.103.git.gitgitgadget@gmail.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <5f3c374f-9a10-1a12-e5f5-5e0a2514c120@gmail.com>
Date:   Fri, 11 Jan 2019 15:09:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <pull.103.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 20-Dec-18 1:34 PM, Johannes Schindelin wrote:
> From: "Slavica Đukić via GitGitGadget" <gitgitgadget@gmail.com>
>
> This is the first version of a patch series to start porting
> git-add--interactive from Perl to C. Daniel Ferreira's patch series used as
> a head start:
> https://public-inbox.org/git/1494907234-28903-1-git-send-email-bnmvco@gmail.com/t/#u


Ping? :)


>
> Daniel Ferreira (4):
>    diff: export diffstat interface
>    add--helper: create builtin helper for interactive add
>    add-interactive.c: implement status command
>    add--interactive.perl: use add--helper --status for status_cmd
>
> Slavica Djukic (3):
>    add-interactive.c: implement show-help command
>    Git.pm: introduce environment variable GIT_TEST_PRETEND_TTY
>    add--interactive.perl: use add--helper --show-help for help_cmd
>
>   .gitignore                 |   1 +
>   Makefile                   |   2 +
>   add-interactive.c          | 265 +++++++++++++++++++++++++++++++++++++
>   add-interactive.h          |  10 ++
>   builtin.h                  |   1 +
>   builtin/add--helper.c      |  43 ++++++
>   color.c                    |   4 +
>   diff.c                     |  36 ++---
>   diff.h                     |  18 +++
>   git-add--interactive.perl  |  15 +--
>   git.c                      |   1 +
>   perl/Git.pm                |   2 +-
>   t/t3701-add-interactive.sh |  25 ++++
>   13 files changed, 387 insertions(+), 36 deletions(-)
>   create mode 100644 add-interactive.c
>   create mode 100644 add-interactive.h
>   create mode 100644 builtin/add--helper.c
>
>
> base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-103%2FslavicaDj%2Fadd-i-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-103/slavicaDj/add-i-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/103
