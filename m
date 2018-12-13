Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6BB20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 16:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeLMQWa (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 11:22:30 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45106 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 11:22:29 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so1025135ywd.12
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 08:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SXYyW5YlSe9Ikr/Hz6ZFSx4wVVElko8BJ7Fgew3AqMY=;
        b=qVWk92VWcVIi4CzG4cSnsLtYB49WM6jHXtVIbioG+bntQZ9fA6J+K97BiHGJFd7Q/m
         ZOf7z+0RAmIniIWgPkqj2GEaLE5z/NsjF+7RdIj/m9iPxrIjF5GwdSKFT/p6YunXMPkV
         Jz4tUB8wVsFUcUvZUQY6lkugbyy877/UwCFUUZC/za6WiYuy523OZ2vcBHWrEyCnK/Gi
         gqoVZjZnN+h2XewUXwIpr/9maCp97IjjBguroFsTqvn+3FmIpxs7ELfrwdx5xzfFSGuY
         rIRZrz6j8UIfQDyf8pgt9GAGuJl1YlmGSfdaZC9nKTxOByVP4aFufZ8LGCOWsWiiNW0p
         gmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SXYyW5YlSe9Ikr/Hz6ZFSx4wVVElko8BJ7Fgew3AqMY=;
        b=eOzEBvbvuf6Oh7rwH2vhlMr6psfU202x3cHvUPn6Tib5lovGVNbmQMTy++/zLwa787
         YuQ9r4s4qBcTcb5ogiDpQwpohkcFhXqYEso61odJ5sWcKsaKE/qkuNJC1OP21GPc3O6j
         2I3BI0jqW7znT4qL2iFKUbHc3CSBn8H2PN5iqmjGzKOEiR05leZ8+IIn+HXDb0aYE0pg
         akS5R8kiOSJWqSJZMnp3nCfsem3NezLCw6CaFaXuH7r7NMMIk35R08UCwFLiTiUnT9Pg
         UhK0ZVicjkPaANbC5puAqGh/CBeWbGk4N4+v5isowf2I9brDdBWqYucUDOx4wJwpWfbR
         mk6g==
X-Gm-Message-State: AA+aEWZmcaJPTYZlEFSla9WMU4O/kMadBgIPspSEjypMot+mP6m+gcr1
        q8n0KAMyC5HEWupu3g8lZnk=
X-Google-Smtp-Source: AFSGD/WBDuC6vE8WLi9OpaFZqQyK/qI4J6c3pUVJqNFOYb2ZytsFE/vLNXXvpF8lDPuml+erKElG2A==
X-Received: by 2002:a81:2b04:: with SMTP id r4mr26059787ywr.511.1544718148721;
        Thu, 13 Dec 2018 08:22:28 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id i2sm985605ywc.59.2018.12.13.08.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 08:22:27 -0800 (PST)
Subject: Re: [PATCH v2 1/2] .gitattributes: ensure t/oid-info/* has eol=lf
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.98.git.gitgitgadget@gmail.com>
 <pull.98.v2.git.gitgitgadget@gmail.com>
 <4a22502a318a65f144b3b6542cc5e711a1811c78.1544638490.git.gitgitgadget@gmail.com>
 <xmqqva3ygnh3.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d6ca9a2-9245-e5e9-6d7a-e6d3004054bb@gmail.com>
Date:   Thu, 13 Dec 2018 11:22:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <xmqqva3ygnh3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12/2018 9:38 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The new test_oid machinery in the test library requires reading
>> some information from t/oid-info/hash-info and t/oid-info/oid.
>> The shell logic that reads from these files is sensitive to CRLF
>> line endings, causing a problem when the test suite is run on a
>> Windows machine that converts LF to CRLF.
>>
>> Exclude the files in this folder from this conversion.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
> It seems that this step is identical to v1, to which SZEDER Gábor
> had trouble with (cf. <20181212133945.GV30222@szeder.dev>).  I am
> guessing that the review and v2 e-mails have crossed.
>
> FWIW, I personally do not think "is sensitive to CRLF" is too bad,
> as my attempt to clarify it does not make it much better, e.g.
>
> 	The logic to read from these files in shell uses built-in
> 	"read" command, which leaves CR at the end of these text
> 	files when they are checked out with CRLF line endings, at
> 	least when run with bash shipped with Git for Windows.  This
> 	results in an unexpected value in the variable these lines
> 	are read into, leading the tests to fail.
>
> So, I'll keep what I queued when I received v1 for now.

Sorry for missing the edit to the message. You are correct that v2 just 
added one commit.

I like your rewording, if you feel like editing it.

Thanks,

-Stolee

