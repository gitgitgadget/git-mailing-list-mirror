Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CDFB1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 19:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeKTGJw (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 01:09:52 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:46949 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeKTGJw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 01:09:52 -0500
Received: by mail-qk1-f174.google.com with SMTP id q1so50643200qkf.13
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 11:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bHGczHeWYaZanjo61xvB1EQ67g+vFRXViEW3/EaTZ0w=;
        b=ki9jP8g5WAW1f5YP1McM0DTQ0IR9ZvQHkti1hg/Pt8FAQ940/S7JaKa1y/dLTy46QI
         x7r/d99UWCetggY94VXqVfugDo5rsTiZuRC8AIAWD2Yb1Q+WGCidANgFnyccly7Ad+A3
         ee1sJ9zycmmA0/QELxvRRd0sY25pcak1CCnVgQtwfhJey7QCIsOiYF+PZHcY/Gv2o5WJ
         57TPtjSczBOOzyBWTI+IfsvfXXVN69+0s6D5nd+4O+YZzvrF3TfAkiP1zMVQbohTysdA
         MHk55Dhzsv82bYUVAEXHgdJhABXzc/HJWgiJdQ3BsYY0GbblVEPTrJ4o1gvvfYbFXZlQ
         4HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bHGczHeWYaZanjo61xvB1EQ67g+vFRXViEW3/EaTZ0w=;
        b=LDTwxQgrGol9/tKAq1tc7MHU0bPhprn34fA1hHWNDFa7LvZ9qDU9V/+6uGGga8XgLX
         hI/SeMF57RUfQdanEbKQuK2Q2KALkJnUEU6cLIK2XseIOPytFnQmTNC0uC529pmsIpQe
         uIBpqwdMJkPOokKykIAzHSVHIfgSPBsHjM7Ia+KGwTbPP+ngc5b+auGOyYqQ4gKq4E0j
         xONq+e47Mm2Be9CYHxgiDzE9ccmnCYQgO9s223q0kWUvwlLVd6aHi9C2MPx3VQ39bBpp
         AOFJpmRGhGwgPXZWNHAF8Im2ayTk0XD9lE62BPah5CeTmrXDV1xVIrBijW0pg9hHT7ea
         ygHQ==
X-Gm-Message-State: AGRZ1gKDj+yUHm0vl4D5kudpbrlKptqxiNe+e+e3qfPjrLS7NaRtnIQ3
        xJNla4P0qUPV/Agsz3gwgeCwjJ+x
X-Google-Smtp-Source: AJdET5f78Wap3psDvQKcNBkYS3FbMXrhGDjHql0586sfPjE2cKw/4il7rppnRHb0qZma8fNfRztdsQ==
X-Received: by 2002:aed:36c1:: with SMTP id f59mr22101564qtb.250.1542656683751;
        Mon, 19 Nov 2018 11:44:43 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9842:9c91:9414:a691? ([2001:4898:8010:0:8178:9c91:9414:a691])
        by smtp.gmail.com with ESMTPSA id u16sm25377011qkg.14.2018.11.19.11.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 11:44:42 -0800 (PST)
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <871s7g29zy.fsf@evledraar.gmail.com>
 <37b2c29d-43bb-9987-e91c-cb3e6b65d354@gmail.com>
 <87zhu4zwk5.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e992e36b-4b0f-060b-2224-31fad752e64d@gmail.com>
Date:   Mon, 19 Nov 2018 14:44:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <87zhu4zwk5.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2018 2:39 PM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Nov 19 2018, Derrick Stolee wrote:
>
>> The coverage report has been using the following:
>>
>> export GIT_TEST_MULTI_PACK_INDEX=1
>> export GIT_TEST_COMMIT_GRAPH=1
>> export GIT_TEST_INDEX_VERION=4
>> export GIT_TEST_SPLIT_INDEX=yes
>> export GIT_TEST_OE_SIZE=10
>> export GIT_TEST_OE_DELTA_SIZE=5
>>
>> I need to add GIT_TEST_INDEX_THREADS=2 and GIT_TEST_REBASE_USE_BUILTIN=false
> ...although note you'll need to also test without
> GIT_TEST_REBASE_USE_BUILTIN=false, otherwise a lot of the new C code
> won't have coverage.

Sorry for lack of clarity: I first run 'make coverage-test' with no 
GIT_TEST_* variables, then run the test suite again with the optional 
variables.

Thanks,
-Stolee
