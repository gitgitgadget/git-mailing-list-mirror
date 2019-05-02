Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19391F453
	for <e@80x24.org>; Thu,  2 May 2019 10:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEBKN1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 06:13:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38275 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfEBKN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 06:13:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id k16so2520987wrn.5
        for <git@vger.kernel.org>; Thu, 02 May 2019 03:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ceQQNIjs1ktUvA7BhHproKs9wUvV1/UuxjXXAIA6HcE=;
        b=IvaJVfDfiIDgenfYmTCmZnfwuhwLG5uFqU71hQrYOtxVLySLZ/4cuzGURJ5uFweLtB
         86FrEQExacYUwyg3llCLKPi/0x1JIL4ntevKJIYSCAmi0BV4c3jcR+0Lk6qO+D0kLUO8
         pUbLxr5c9Nbm01Mu6MP72DBI6wjrIP1DJcslMCR4I/VdOrMVWYsoRkMMBHAYTzvxcFxl
         cUyKzg3CUztpjCQyaE42h1UHHQ83PEStr0/kJwmPS4Z/KaJnhMmN/prj31ehC+dIiWXy
         Ru4BN45pRCHJSK9JiQ3QKpziqtlo9NiNtQVmQpCM1+svNa9pETdejGuzhLc4aNf4301O
         JfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ceQQNIjs1ktUvA7BhHproKs9wUvV1/UuxjXXAIA6HcE=;
        b=UWvf9GqGMc4XudZ6GhCM/C4sqT1+EYrOiFbrs/tNsqIpawFWahYA0kbYkAK/B1CPYD
         aJRJ9C8ZOHPmmrzb9XbtEXnCd2kYY2LQ1REwL8pAl2A1xpYhXWVj2d/U2nerfd6ZiA3K
         TDcVuF2RcDGSLC5mZnAVBqKCC+neVC0MKzneWLYrqWg7+qLf8e3Vf/q3VwRDzgl9mG3+
         dUhZHpGKY4K5zwTPKeK3LpIlW1SSJUd59vYtbX2akoTiSGpZhqFYEdINdBrSDksMZQz/
         /yY42I4nv1x50Cwjz+nTz9hW//oiXWh2kmseeBy6fAGXRSMEza7ZHiUfcWJZfZjHd5/3
         Ahqw==
X-Gm-Message-State: APjAAAUiNoSxGpzOhRrkQwQlNLAf79wvDQNMplsJa8GpNeFFMDiM3oN2
        /2CcOg5DIKNynbWagB/y3TInw08z
X-Google-Smtp-Source: APXvYqyehIYGls0a2CeNq6HqRRNgfG5gzS5oCkz5OQptpxU4ktnb0AcqFWPCu+LyHUcRMWqF2R97/w==
X-Received: by 2002:adf:f588:: with SMTP id f8mr1669281wro.282.1556792005773;
        Thu, 02 May 2019 03:13:25 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id j3sm10744417wrg.72.2019.05.02.03.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 03:13:25 -0700 (PDT)
Subject: Re: [PATCH 0/2] Add "git merge --quit"
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20190501131152.314-1-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5c62bf2a-5bf1-6aff-6343-cd8471e662c2@gmail.com>
Date:   Thu, 2 May 2019 11:13:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501131152.314-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy

On 01/05/2019 14:11, Nguyễn Thái Ngọc Duy wrote:
> nd/switch-and-restore suggests 'git merge --quit' to get out of a merge
> even though this option is not implemented [1]. It's a soft dependency, no
> actual functionality is broken by the lack of --quit, so I'm sending
> it separately.

Both patches look good to me

Best Wishes

Phillip

> 
> [1] https://public-inbox.org/git/78c7c281-82ec-2ba9-a607-dd2ecba54945@gmail.com/
> 
> Nguyễn Thái Ngọc Duy (2):
>   merge: remove drop_save() in favor of remove_merge_branch_state()
>   merge: add --quit
> 
>  Documentation/git-merge.txt |  4 ++++
>  branch.c                    | 11 ++++++++---
>  branch.h                    |  6 ++++++
>  builtin/merge.c             | 30 ++++++++++++++++++------------
>  t/t7600-merge.sh            | 14 ++++++++++++++
>  5 files changed, 50 insertions(+), 15 deletions(-)
> 

