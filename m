Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371991F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 19:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeKTFZ1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 00:25:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45148 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeKTFZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 00:25:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id d135so50410300qkc.12
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 11:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ucDv9xfMyBjQpdKA30nWb18923fePufvkPJHIhwvxkw=;
        b=BSVM0bKNC4d4355t9jQMADKcIpwOGQvDfdm36/ZFC0mcUOpEJ12JAfeP/Wt4LeGm/L
         Bok1YphRZJDUYV6UXSwjShYKVQsQPVbA9SM+LCU8m68xHIX02+Zxm1HwrlGnIsRCDaWZ
         s3cWq0lwIGYaPP/wXHOYkREuN4ppbD5Z8JBLWr8K/cU153V+i2JpmgZIPj1g2lqmOQNM
         ofUT3mKXD9txsyRCA5eQjthNewLdrXQBS/xPzoBi3YdQAtdbDnaKDctp6A9RCHTXfgmD
         DZENtuHa29rTc1m6JioNMAGJ/RAowuhYUO4HlTUzD+IA6vbjf9zzrdsKl0Hjj+px8Yix
         VF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ucDv9xfMyBjQpdKA30nWb18923fePufvkPJHIhwvxkw=;
        b=Yxp75rZq7Kb78+3MdPJPWheaUhHQvrcpQRbR9NbV6ldOuFYvFK+Al+J1EjS0kRQeS3
         rkWeJZ68rGUSa3X/LIUmCa4ZNshhVTSbVuMGKaPXUim5DITN6mBvahZlBcaiJVTl01O6
         XVl835COK+0V2+XfMlR9tqsoAoYAsDxN6X8K4PeqoeSf8VTuOiDfVNkT/MLSGSFOywEB
         QqhuAErVGmrND1gunonD6W6clDkKCEwh65XpqNxVJXMAfhqMezsW+zgS/3YI0crM6B1S
         ZagVTYeKVW8EV9TRzbnvawxOOSesrDZPjdvFjrjxXtoPsspKZhk1Mds36lm9pEWbdftv
         GKkg==
X-Gm-Message-State: AGRZ1gJxODBMLEnSCRUASgHim8NG7CfX/KrhK/M53RUz3wNR/4CfIE4T
        rHx22AMbTqi8xL7YF4PN8bw=
X-Google-Smtp-Source: AJdET5diBKyRhybuRJDZdQ+TFq7LTwg1YVSPM0FMtKbneeY0ELMPNX8LmT1Cu3vhozTcQdpPOME5jg==
X-Received: by 2002:ac8:3181:: with SMTP id h1mr22875761qte.14.1542654030879;
        Mon, 19 Nov 2018 11:00:30 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id r16sm27882486qkh.71.2018.11.19.11.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 11:00:30 -0800 (PST)
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
To:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <d39320e2-0614-569b-4e82-7f7541589aea@gmail.com>
Date:   Mon, 19 Nov 2018 14:00:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/19/2018 10:40 AM, Derrick Stolee wrote:
> The test coverage reports started mid-way through this release cycle, so 
> I thought it would be good to do a full review of the new uncovered code 
> since the last release.
> 
> I eliminated most of the uncovered code due to the following cases:
> 
> 1. Code was only moved or refactored.
> 2. Code was related to unusual error conditions (e.g. open_pack_index() 
> fails)
> 
> The comments below are intended only to point out potential directions 
> to improve test coverage. Some of it is for me to do!
> 
> Thanks,
> -Stolee
> 
> On 11/18/2018 9:54 PM, Derrick Stolee wrote:
> 
> There are a lot of lines introduced by the IEOT extension in these commits:
> 
>  > Ben Peart      3255089ad: ieot: add Index Entry Offset Table (IEOT) 
> extension
>  > Ben Peart      3b1d9e045: eoie: add End of Index Entry (EOIE) extension
>  > Ben Peart      77ff1127a: read-cache: load cache entries on worker 
> threads
>  > Ben Peart      abb4bb838: read-cache: load cache extensions on a 
> worker thread
>  > Ben Peart      c780b9cfe: config: add new index.threads config setting
>  > Ben Peart      d1664e73a: add: speed up cmd_add() by utilizing 
> read_cache_preload()
>  > Ben Peart      fa655d841: checkout: optimize "git checkout -b 
> <new_branch>"
> 

These should be hit if you run the test suite with 
GIT_TEST_INDEX_THREADS=2.  Without that, the indexes for the various 
tests are too small to trigger multi-threaded index reads/writes.

 From t/README:

GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
of the index for the whole test suite by bypassing the default number of
cache entries and thread minimums. Setting this to 1 will make the
index loading single threaded.


