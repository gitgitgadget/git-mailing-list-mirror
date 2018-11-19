Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5D091F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 21:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbeKTH5a (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 02:57:30 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:33788 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKTH5a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 02:57:30 -0500
Received: by mail-qk1-f181.google.com with SMTP id o89so51230268qko.0
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 13:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qOmWRApv0RJOR/bzLuZLBTyw10vQhH8NkpEuZCc306k=;
        b=Qbuiu/4xVyaGB3Ddbfa+2gZp8KqiLDH/U69b/HAxBRWSf5n1v7VXgQdkHNqLbIaEoA
         GwIx/SPb0zxU3iO6GZ4bQFWGl7wwXJNjEMgMckzbPX18knn0MPRcascFXPc7pyJHFa46
         7rsGpqI5HQD1CherIGcS1VLnKdmMgBLXJYpnIfq4vHJ3/xkA2JYgVhKuMA618Gs6X/+9
         1P1xD8nZgEODLCTSQeVNXw49Bk7Sg9rWBrVQHXJCITU71eVPGpXrElg7rDgC8AFGHKqw
         bpI61JdOK8WmjpnWHzEU50mtUtOdmHzqA2qmyXbSRwQAI8e9YrUMFoVexpvRtOVzz1qh
         DmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qOmWRApv0RJOR/bzLuZLBTyw10vQhH8NkpEuZCc306k=;
        b=nQ4vt/+gl+moEoMikPXWXtqdQ1WPKC8Jd/w4CP1gtU5wzUIIAy8ymlXroQbweOFP5T
         kvXXNl/B7ZS38XsvMpLNBvmwyuyxkv8iH4w1pF8xpkPnRD9BS7zPIw0/uC9MzAM8qhjQ
         pA27ehdNfWJoZk3AWXuBb8axAKVDDfAheDfluz4QOfMXX7KOq0E39rXA1YRVBspilOZq
         5qYPbxIgM+yZObNmTevvIA7N+TrYqL5f//DCH9sHg9TM+Z3We+r0rycvkFxuPUgq/Kee
         Yx/jWrorlLKSf98SpwHRwbtylWKwSi202EO5KlwJx5rJsrdumBnhBrQ+IUfv4F6vNgaS
         NGJA==
X-Gm-Message-State: AGRZ1gJ4BcmSONnTNpaG+AQAdBl4M9IBwgU7f/zO+YteBL8iDVJpnv92
        8Ky501SdrvkIb01JQRW7Egk=
X-Google-Smtp-Source: AJdET5dN142NC70cvw7lZUvydSHcfKU1tGNaAzjvuu8mta066HEA4+YPExx5WgTEhVLh1s6b2s5Img==
X-Received: by 2002:a37:ae87:: with SMTP id x129mr22800565qke.15.1542663114847;
        Mon, 19 Nov 2018 13:31:54 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9842:9c91:9414:a691? ([2001:4898:8010:0:8178:9c91:9414:a691])
        by smtp.gmail.com with ESMTPSA id g52sm1521117qte.58.2018.11.19.13.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 13:31:54 -0800 (PST)
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <871s7g29zy.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6f0ff2e3-4019-1dcc-f61a-cd0919b9a247@gmail.com>
Date:   Mon, 19 Nov 2018 16:31:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <871s7g29zy.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2018 1:33 PM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Nov 19 2018, Derrick Stolee wrote:
>
>> [...]
>> builtin/rebase.c
>> 62c23938fa 55) return env;
>> [...]
>> Ævar Arnfjörð Bjarmason 62c23938f: tests: add a special setup
>> where rebase.useBuiltin is off
> This one would be covered with
> GIT_TEST_REBASE_USE_BUILTIN=false. Obviously trivial, but I wonder if
> the rest of the coverage would look different when passed through the various GIT_TEST_* options.
>

Thanks for pointing out this GIT_TEST_* variable to me. I had been 
running builds with some of them enabled, but didn't know about this one.

Unfortunately, t3406-rebase-message.sh fails with 
GIT_TEST_REBASE_USE_BUILTIN=false and it bisects to 4520c2337: Merge 
branch 'ab/rebase-in-c-escape-hatch'.

The issue is that the commit 04519d72 "rebase: validate -C<n> and 
--whitespace=<mode> parameters early" introduced the following test that 
cares about error messages:

+test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
+       test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
+       test_i18ngrep "numerical value" err &&
+       test_must_fail git rebase --whitespace=bad HEAD 2>err &&
+       test_i18ngrep "Invalid whitespace option" err
+'

The merge commit then was the first place where this test could run with 
that variable.

What's the correct fix here? Force the builtin rebase in this test? 
Unify the error message in the non-builtin case?

Thanks,
-Stolee
