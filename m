Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409721F45F
	for <e@80x24.org>; Thu,  9 May 2019 12:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEIMZE (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 08:25:04 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:35220 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIMZE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 08:25:04 -0400
Received: by mail-qt1-f181.google.com with SMTP id a39so1387765qtk.2
        for <git@vger.kernel.org>; Thu, 09 May 2019 05:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g1Ao74qfLstq//GU9AtV9Oyuzl2hA5CgrvXXc00VESw=;
        b=Z1cGwLLVoqpeeeeXN06GJb+ShlnJakzhcf7f/n7+XO8cML8twz/aXH/0K5b4EzImFz
         tBQqxScEjpFbwxCgJWTvtE0vx8k9LXP/VHYYN7Ci7esDl349r44cPytwO2Jbmvwv+jce
         3sv95O3+liB2JygVpmgPD885tMwNLXi6AOcCzAGCY+P3rT3ThwolU60K4E+xeTeQG+Cy
         CYKplP3DOjtLNLgl5Z5k/IOJ9neGZmLFUoINu32v0h33exIc+lpHqAjpPpFrNCH3YtfP
         G2cEzQcyN5aZc5LHhwmVNhP0Vpj9S70fYmKMh8jhERS1h/zuPpywcJP7a/EBhwgunpCS
         YkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g1Ao74qfLstq//GU9AtV9Oyuzl2hA5CgrvXXc00VESw=;
        b=GRIZABHxR80yXhGIPDEmTW7IZJ6xghhWLbuQRtdGEjHM0IRwdjVzqAmEVtC8Gl1N3a
         DoQ9gLd6T3JHBJq9CbgAa6ULN6w/awugEqk3UX7NoACOeXRkHQwiTNixs17JehlT6waN
         qz6TZvdy98AKn8HT1QU3Fu2rAFiKPAfqG0LxAZc8u5bR3cdMOwXvLGP6zjbgHGdar2k8
         okYYBkVYByMUdq/at5ytO/SSbkNaMCGENhL0iba+BpBz5WpcPq+6dkL7gWG/S5tv4Sx6
         ifaZcgVMLxtfQHg3mkxzrkLYJdHRDIBcbXrtLxcNYuxrRtCZ+2wsos9wRakb7kl9G/0z
         5s/g==
X-Gm-Message-State: APjAAAXuArlbZXzzQ95NTuIEiHnaqCLiL6Pe1paZw3jBucc8oak7FAVE
        dhCAUkf6ZjbZOTs+c2oWCFc=
X-Google-Smtp-Source: APXvYqyJlXxmAnDyH/iqLXpmoRnOsjvPdb8/+URWJFDmdh123VbwxNQinYs6FJqRLI1fuMAFYXDVhw==
X-Received: by 2002:ac8:298d:: with SMTP id 13mr3314198qts.174.1557404703165;
        Thu, 09 May 2019 05:25:03 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d14c:17a3:d28e:9336? ([2001:4898:8010:2:ba80:17a3:d28e:9336])
        by smtp.gmail.com with ESMTPSA id w184sm941773qkc.48.2019.05.09.05.25.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 05:25:02 -0700 (PDT)
Subject: Re: [PATCH 12/17] Documentation: describe split commit-graphs
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.git.gitgitgadget@gmail.com>
 <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com>
 <20190508172029.GP14763@szeder.dev>
 <d5ef1bcb-a910-295f-fc95-e461d34f3883@gmail.com>
 <87pnoshfkq.fsf@evledraar.gmail.com>
 <xmqq8svgfczw.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8195f9a4-1808-e23e-f633-7e6809cc3656@gmail.com>
Date:   Thu, 9 May 2019 08:25:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqq8svgfczw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2019 12:49 AM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> With commit-graph-<HASH> all these unlink() race conditions go away,
>> partial reads due to concurrent graph writing becomes a non-issue (we'd
>> just leave the old files, "gc" deals with them later..), no need to
>> carefully fsync() files/dirs etc as we need to carefully juggle N and
>> N+1 files.
> 
> The above would give a nice course correction to be in line with the
> rest of the system, like how split index knows about and chains to
> its base.  Thanks for a dose of sanity.

I'm working on a detailed response to Ævar's ideas, to be sure we are
talking about the same thing, because the original motivation for the
commit-graph format v2 was to allow the 'commit-graph' file to point
to a chain of base files by a list of hashes (like the split index
does). The current proposal was created in response to an unwillingness
to break the file format for the 'commit-graph' file.

-Stolee
