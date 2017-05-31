Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8CE11FD09
	for <e@80x24.org>; Wed, 31 May 2017 14:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdEaO5S (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 10:57:18 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33634 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdEaO5R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 10:57:17 -0400
Received: by mail-qk0-f196.google.com with SMTP id c206so2127865qkb.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mC888tEE0r0iiB7piWtFL5vgx5bmvxDZm/Lzmdnx0NA=;
        b=R+Q3WcnQBqZqKmmrZ7cXUlm8oKLFpR5oyVmy4kvEzgOyeiB+CXfEqrvheiQDocpkYV
         f27TvcmexwBV3sKJc3CYbDP9wVnctWzITyeeuqLh3P1YGbPaSnug1J9ccStgr9HIWt40
         oRLj2YVVLudr5CeanhI4L4irv2Hjzzgv5mWZ/+S8oc8alzO7h+7nmuJmNmdmo2NzVW6s
         LENH7Cw9w+vKse4R95/8PHlL5/oBK4Z+Ipfmdo/ePMmRph4lDitLQ+ppDGpDW/u8vO+g
         13LM69YU1MnZlNfRhn7P+QbMqABVIUNpfGdt1BRvRbZIqSDBAcla9o5v50WBKZn44Pb8
         TO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mC888tEE0r0iiB7piWtFL5vgx5bmvxDZm/Lzmdnx0NA=;
        b=fCMbixc28iCVZfisnLLLsDWMH0BMYekcUXkRNseo/U9nUMyUiS34L4T+Z0xz2MW7jE
         mtptXlrdNfFLho2CLS7N/St7uI2vCdjgeJvfCSVFnrfh2BU/DpoinOLFMVNkLrhPv12X
         1tPrYlAu5Wf1YcGkC9SXkefpt5X1QrO2sMJB6hGwt91JA/0rOwZ1qUYzBBkfV6JR01rK
         Z+JITeoc7LRvKqu8CWHx6DmjlGR7abs1ALwyfQuq7yxTPVu6x7/x3WF16kZleH8iAooS
         ueFqGU9kJ4aByK4LzHpjex+nEfJ0S7JZDQEV4b4zCc2wg7YYWeHHL3wuWXQ4ICNhfjyh
         oKpA==
X-Gm-Message-State: AODbwcBlQgtsX8mxRyMj4OP4OTUsncoWpxNMBo/JAk45ytTrBB8G8/oG
        sVkQIFYRSkjH+Q==
X-Received: by 10.55.10.12 with SMTP id 12mr17803206qkk.217.1496242636289;
        Wed, 31 May 2017 07:57:16 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w12sm10820073qth.42.2017.05.31.07.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2017 07:57:15 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] fsmonitor: add test cases for fsmonitor extension
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
References: <20170525183612.3128-1-benpeart@microsoft.com>
 <20170525183612.3128-5-benpeart@microsoft.com>
 <CAP8UFD0OEUogQYL5Eo1kBy_1B=dBcdEJyc4B_qAUOU=2XnrxxA@mail.gmail.com>
 <bfab707a-7f3a-ca7d-1f67-66dcb6ab2ea6@gmail.com>
 <CAP8UFD3jkAOOpFqJg2LurBfXRzeOLNO6+Wso3OPt_40TUVZy9g@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <47d76489-3e2f-ca25-8ff3-4350ca47aa76@gmail.com>
Date:   Wed, 31 May 2017 10:57:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3jkAOOpFqJg2LurBfXRzeOLNO6+Wso3OPt_40TUVZy9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/31/2017 12:33 AM, Christian Couder wrote:
>>>> +test_expect_success 'refresh_index() invalidates fsmonitor cache' '
>>>> +       git config core.fsmonitor true &&
>>>> +       git config core.untrackedcache true &&
>>>> +       clean_repo &&
>>>> +       git status &&
>>>> +       test_path_is_missing marker &&
>>>> +       dirty_repo &&
>>>> +       write_script .git/hooks/query-fsmonitor<<-\EOF &&
>>>> +       :>marker
>>>> +       EOF
>>>> +       git add . &&
>>>> +       git commit -m "to reset" &&
>>>> +       git status &&
>>>> +       test_path_is_file marker &&
> 
> Ok so "marker" is there now.
> 
>>>> +       git reset HEAD~1 &&
>>>> +       git status >output &&
>>>> +       test_path_is_file marker &&
>>>
>>> You already checked that "marker" exists 3 lines above, and as far as
>>> I can see nothing could remove this file since the previous test, as
>>> the hook can only create it.
>>> So I wonder if something is missing or if this test is redundant.
>>
>> Testing it each time ensures it is being created when it is supposed to be
>> (ie when the test believes it is using the query-fsmonitor hook) and that it
>> isn't when it isn't supposed to be (ie when the hook should not be called).
> 
> I would agree with that if the "marker" file was removed after the
> previous "test_path_is_file marker", but I don't see any "clean_repo"
> or "rm marker" call that removes it.
> 

Got it.  I've added a call to "rm -f marker" to ensure the marker isn't 
left over from the previous status command.  I found another instance of 
where this could happen in "status doesn't detect unreported 
modifications" and fixed it as well.  Thanks!
