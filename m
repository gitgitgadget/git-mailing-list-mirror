Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1F51F453
	for <e@80x24.org>; Sat, 27 Oct 2018 19:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbeJ1E3Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 00:29:24 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:39295 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeJ1E3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 00:29:24 -0400
Received: by mail-qk1-f178.google.com with SMTP id e4so2701969qkh.6
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I4iD2oYWrvUWHzvL9dyC68h64dsSo2xpR+p+4TTYAsQ=;
        b=LWIDXQAA72IDctw+gFPxl4NF5um+mjsxwJNvmakajhRY6mlPt3NyOe4HFtuNpJEYhb
         Fkkp4RYf70uSr2xRPc0zIEzQayBm0xctwq6Jru+w5Hz1nRWeHTW2t9IopsviC+x1J4fe
         Id/z0ST6U4H7IqPCED4TuG7KWNiWpsPERjS2EkEzHbJDJVNtQM/767mIxlwVd/MbVWiQ
         JRcFUhig28wSMocDDb1LYGOqP5oCryc3l9grqf5wGYxLfBYsqAYR3bgguDiGjwAlaGPg
         ZpUbuHV5RPn3O75XnBk/LDD6O5wIig8dlypNugTUNtNaAgPvHBdjHhDz++C/+TjamqMo
         kJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I4iD2oYWrvUWHzvL9dyC68h64dsSo2xpR+p+4TTYAsQ=;
        b=uaV1ITKiSTTc4q3KTGkUHlgHkBXge3Ipj5vcVs/5VaHofyhgJeRCZssI9MB6ozNlw9
         mNKf0wu3Fmn60oZJFpYN+f7slAH+vHphXcGvBwNd8nCmpBqbDh1CUvq89+y/Tu0nd4sl
         Fy6vqwmoe2GP+gApvO1IMb84qXGPbC7Mhp9r6cODDRY/it04gunuQYA09JlssTBRiFwv
         KOZQHKJfuIE8tNyYfFr8qKOgGCd/J5ZERWRd/D7JdxvRMXLbEYoCB77R9sM5Ajw0xgIF
         CVpBThBZXNIWGEN6/uywWyKEvsZn5KETtEYMwvC5hgfyHvhBWAosQqSRgDyQ24bnKYyz
         657w==
X-Gm-Message-State: AGRZ1gLnG/wxdpWFCxSU2hiK2BKuC943k4IvBtJYSqIQdGWjkNLQ4mZk
        +WGuMNvYELbPWACgBxBFEbRKO/5G
X-Google-Smtp-Source: AJdET5exeBxjBnVak6S7iQxcaxNxfXzSeGRSpBnvPErUuKQI174xdmCystmRcWw9HanZNyLX5RtH+A==
X-Received: by 2002:a37:d2c2:: with SMTP id f185-v6mr7351470qkj.30.1540669641914;
        Sat, 27 Oct 2018 12:47:21 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id d6-v6sm8986303qkb.71.2018.10.27.12.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 12:47:21 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Saturday, Oct 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <5db6213b-b7d0-b995-de80-9671604416a5@gmail.com>
 <xmqqsh0ra3yx.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <649cac55-7fb0-d23b-eaf6-6f1dab30a0da@gmail.com>
Date:   Sat, 27 Oct 2018 15:47:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqsh0ra3yx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2018 9:55 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>
>> Uncovered in mater not in master@{1}
>> ------------------------------------
> Does this typo indicate that some part of the process to produce and
> send out this report involve manual editing?
I kick off four builds with on Azure Pipelines [1], wait for the builds 
to finish, then copy the appropriate sections out of the output 
(trimming the timestamps). If I were more familiar with the Pipelines 
features, I'm pretty sure I could make four parallel jobs inside the 
same build that ran the tests on each branch, export the logs as 
artifacts, then auto-assemble the email at the end. I plan to do that 
soon, but I'm still keeping a close eye on the results to see when and 
where failures occur.

Thanks,
-Stolee

[1] https://dev.azure.com/git/git/_build?definitionId=5
