Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152E01F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeA3XBt (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:01:49 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33086 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753642AbeA3XBt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 18:01:49 -0500
Received: by mail-yw0-f195.google.com with SMTP id x24so6081057ywj.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 15:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9qo25kwxESkTocir1h4LOGaNTZ+hp0cuosfWr5Hc/B8=;
        b=huboj5BKJDhCYcWdFHTTbHpPUUjuQ6nDORAJfza+9SBpgyWzl44mng88zTFgqXA0ia
         J/yeVEvWBoiHu2gffuoSJrhofVRfsvixsvrSRzHfqB7duFir800pAmsi4cLFhInIpLWe
         EorDpuvQrrdZ4WlaqswO8NftYmKONXjZbOHWOHgMWHS7qQcfpIPb08T2188IPCpK0bl8
         w1e9T3NVKWflyT/IAWythLg806AYTsxB/5+DCPqcj6Hos+roInsVN3nk8TX+reb9bOfG
         w9fbM+Tz2UGPf7hBEJKKKYqbSWAbYGb6zBaEkXC03LMnwaqkj47T8lcsjn2YqE+Nw+7k
         BWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9qo25kwxESkTocir1h4LOGaNTZ+hp0cuosfWr5Hc/B8=;
        b=fL4gWgdaK1BRh9ydxziiBteiji+naWu7Z3cVW4MQbMzJCsarFEYOCZknieJ02W19Tq
         C422x2nGTR4bbjUSd+JgXexbKyx0Qp6tpeVgtSctOljYSPKjDZxocro4iGt1F5LhoT1S
         VmWfae1WOquIBBOTnCrdZzMy/JOlCtN8j/lzxE4vjoFNvVgVM8biSNmsfl2IZ5dwWIZl
         g3LL3BAq03ChmFkJ2jcWGTJHVU9fj9eNVjva+kkUdX4Th3L5IWj4iPKNJNQdKsX1qN8q
         hlwFPrwKoorlcDWitR+i1VeF7NgFm1KlPB3nuBLoMhI2hh36qK7u8DsNloYbpI07f58Z
         02pQ==
X-Gm-Message-State: AKwxytdhUh10Ukr5fbqM8s23XlAwT6mFXcQrizhWU8Ek8pktz3BkhuQw
        LLxKOHpdJ0uOnPAGA5JpEVG416vTETo11fvmELii0A==
X-Google-Smtp-Source: AH8x227ExPIh56gVg3pHnKxdj4WSIaLQkfWExj/0Awn8UulgWcRyCIn7RlpyIkN2gF8RxbpI77vsgN9pNBg4RuqBcxM=
X-Received: by 10.37.59.75 with SMTP id i72mr3305221yba.420.1517353307596;
 Tue, 30 Jan 2018 15:01:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 15:01:46 -0800 (PST)
In-Reply-To: <xmqq7erzrn3f.fsf@gitster-ct.c.googlers.com>
References: <20180129223728.30569-1-bmwill@google.com> <CACsJy8Cm8HsopKisiJkwtPyfv-O6Ei3waew6CsKLXzKv7=TriQ@mail.gmail.com>
 <xmqq7erzrn3f.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 15:01:46 -0800
Message-ID: <CAGZ79kZ-hZzKtv05d5_7O2ndNZvGkU7qYnrn52zwpqSTqCiygQ@mail.gmail.com>
Subject: Re: [PATCH 00/37] removal of some c++ keywords
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Is it simpler (though hacky) to just  do
>>
>> #ifdef __cplusplus
>> #define new not_new
>> #define try really_try
>> ...
>>
>> somewhere in git-compat-util.h?
>
> Very tempting, especially given that your approach automatically
> would cover topics in flight without any merge conflict ;-)
>
> I agree that it is hacky and somewhat ugly, but the hackiness
> somehow does not bother me too much in this case; perhaps because
> attempting to use a C++ compiler may already be hacky in the first
> place?
>
> It probably depends on the reason why we are doing this topic.  If a
> report about our source code coming from the C++ oriented tool cite
> the symbol names seen by machines, then the "hacky" approach will
> give us "not_new" where Brandon's patch may give us "new_oid", or
> whatever symbol that is more appropriate for the context it appears
> than such an automated cute name.
>
>> Do we use any C features that are incompatible with C++? (or do we not
>> need to care?)
>
> Good question.

implicit casts from void?
e.g. xmalloc returns a void pointer, not the type requested.
https://embeddedartistry.com/blog/2017/2/28/c-casting-or-oh-no-we-broke-malloc
