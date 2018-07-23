Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A41C1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 14:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbeGWPf6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 11:35:58 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43201 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388048AbeGWPf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 11:35:57 -0400
Received: by mail-qt0-f194.google.com with SMTP id f18-v6so803019qtp.10
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=inBt+hrCiZukEUPeSi7RwfWqJI2F5nfzNaX7gti63VY=;
        b=Gbuz0RxNsCsjt/btXyeYWgn6EKi5lgvd9bGUxBdZ4KRxUCguuq5r5mAxMpttb/mmZ8
         PcW9HpueSFLY0NKbhqzFx5w9yA10FCn3ZocDOwhuWYC+mJt3us16xmVM8qgY5ZvD5bHm
         CALafCSkhUCwGf7hdIqfft5PcaSlzfuXFYlNsE35NBXclPLV4fjdWw0KZUj2kEgyVROm
         20lDCkyjpvVZwY92HoOYrmLlrauas/gFpPyakVT/1UAb+VbfXowLfx6rh+lmzA1rRvlj
         YbnJmxUvuq5p2mkF8xWJ91kDSCUYufkjfKMu9Sb63mAqWUWrw+cWsnnbxlsZkWXCgMfs
         ODpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=inBt+hrCiZukEUPeSi7RwfWqJI2F5nfzNaX7gti63VY=;
        b=BAUjpGh5fygfS2LY+0W8o4yYa+eT5ImLiI3MKoeovjOblmbv0A0kF87WC2M65a327C
         P/NeiWargoQPyOIxGHHdGoaqpASpuTPJRzP/Lk/7356tXJr+8jkCZAXR3RDsnQlzNzZE
         I+dvwYJ9+tJXjn+Br2009IoBCmfrjmFu4/07tNxIHYHR5t9+Xbo8qy82KCLIt2A9AZSa
         eNJMAZmILLQJKodYmHH18Mim1pBlY2D490O6gbplpcls5G6SVy+3592yCYmHQIqRsAdx
         REintPYswzJKSMFc6NNF4aUBS0O1bjJtdYa1njjXGo3PkZ1/G4zxjJAuKpZjx5RqZ0OQ
         Js5Q==
X-Gm-Message-State: AOUpUlGP3TaqClup3yCR7kFzWpCiz6xM1BZ3TLIFmzL369pKGTXi/ww0
        +CIpt7StxGCQ4GIbZGoIggU=
X-Google-Smtp-Source: AAOMgpf+FqMkkO8VlGk5d28qORUvf9pHTiDTwTx9VWcnx/jkZVCTaY9Cb0vWtSpBsuzcpGoPseAhXg==
X-Received: by 2002:ac8:34f3:: with SMTP id x48-v6mr12263672qtb.53.1532356464813;
        Mon, 23 Jul 2018 07:34:24 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:79ea:539c:969d:bb3c? ([2001:4898:8010:0:6320:539c:969d:bb3c])
        by smtp.gmail.com with ESMTPSA id u27-v6sm6895163qkl.66.2018.07.23.07.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:34:24 -0700 (PDT)
Subject: Re: [PATCH 4/5] coccinelle: put sane filenames into output patches
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
 <20180723135100.24288-5-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9f560db6-b50a-e2f3-7215-d046c60e255a@gmail.com>
Date:   Mon, 23 Jul 2018 10:34:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180723135100.24288-5-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2018 9:50 AM, SZEDER Gábor wrote:
> Coccinelle outputs its suggested transformations as patches, whose
> header looks something like this:
>
>    --- commit.c
>    +++ /tmp/cocci-output-19250-7ae78a-commit.c
>
> Note the lack of 'diff --opts <old> <new>' line, the differing number
> of path components on the --- and +++ lines, and the nonsensical
> filename on the +++ line.  'patch -p0' can still apply these patches,
> as it takes the filename to be modified from the --- line.  Alas, 'git
> apply' can't, because it takes the filename from the +++ line, and
> then complains about the nonexisting file.
>
> Pass the '--patch .' options to Coccinelle via the SPATCH_FLAGS 'make'
> variable, as it seems to make it generate proper context diff patches,
> with the header starting with a 'diff ...' line and containing sane
> filenames.  The resulting 'contrib/coccinelle/*.cocci.patch' files
> then can be applied both with 'git apply' and 'patch' (even without
> '-p0').
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 73e2d16926..72ea29df4e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -564,7 +564,7 @@ SPATCH = spatch
>   export TCL_PATH TCLTK_PATH
>   
>   SPARSE_FLAGS =
> -SPATCH_FLAGS = --all-includes
> +SPATCH_FLAGS = --all-includes --patch .

Thank you for this! These garbage filenames cause significant pain when 
trying to apply the suggested patch.

