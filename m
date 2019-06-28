Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9EB1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 21:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfF1VIX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 17:08:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42416 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1VIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 17:08:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so7894568qtk.9
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uSyRkrI35t9fDJBaYDwrUL7ua1bcsI+Vj7z86KNxW7M=;
        b=s5cU8WEDXSMQHMzQutUkoS9Dvvo2hz/RPEXQwc1xQmU+X2oTdkcCv/E5/Avr2iaq/C
         oI9big3YKvE/wVoG+dFEOqVxT8LSDGdt8ooQoG89kZUNsDkgTo1G5bAxqTyqmmku81Wa
         34htg/5oq6P4XYZKT8xwwabjN3wkpDG8z+84oyrzPvd8fqfOzfLL0r43gPLMbA1a7uxZ
         fIXo3neV+TwRBjNUF4cukcJml+qUwMrsztRpccPMjBVAyOO3iVRspVyW5Icq4H0XZsZj
         ZSIqg4mrLFMwQLCZIfeLjDg7vjmf5lWx2ZPBoH2ZccM2BMtj05Dj3OLapW3YMfrj5/kl
         9Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uSyRkrI35t9fDJBaYDwrUL7ua1bcsI+Vj7z86KNxW7M=;
        b=UT6joP2xY+xXsNPC2Oha1fL+YMAjj42vp6IrGQV3AzYQ2iLmXNX8Ekqn8XGPGUNWfT
         B55F0QjlCIVuXHjZZfVVM1ujR6kvZPGE3iLQms9KFVEKSV8cDCv0peZm9SM4QRYv2Hwz
         jgI5qd1jz+lxcP1+QhSSLr8ufUEgwibHKBUz4OSIVpk9pQOAIkAc9FXOE//IuEuOt0Dy
         0NytyDqGz6+Krf39sF99pbIGfStFqRIHHbfpA3YQt30efIQic5XilIABnaZghcGooftt
         npfSDGOXtpCOu5jrUcPacdmiUUk+buMYE3dB3RAkYG26Rxw0fnxdnZkk9HxrMc9cuNnF
         oH4w==
X-Gm-Message-State: APjAAAWnS6ag+2cZP4vSKXJD3Sma/gmNNaHo1bJBwOg+t09wpeUJxMQk
        /Y/f9XPd2zQ5Vm3kHzdXSFc=
X-Google-Smtp-Source: APXvYqwezeiWNwbde6wnlce+sHND3mooF4gLxZ1pbw3JUq6qzWaoH9A0L8uryiIrDB8jaZ3BwDslGw==
X-Received: by 2002:a0c:d0fa:: with SMTP id b55mr10051463qvh.209.1561756102335;
        Fri, 28 Jun 2019 14:08:22 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id d38sm1550253qtb.95.2019.06.28.14.08.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 14:08:21 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate
 setting
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.254.git.gitgitgadget@gmail.com>
 <pull.254.v2.git.gitgitgadget@gmail.com>
 <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
 <xmqqd0ix8me1.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <de9f547a-ac01-29c4-a330-1a7e7a7b1c20@gmail.com>
Date:   Fri, 28 Jun 2019 17:08:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0ix8me1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2019 4:50 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +core.featureAdoptionRate::
>> +	Set an integer value on a scale from 0 to 10 describing your
>> +	desire to adopt new performance features. Defaults to 0. As
>> +	the value increases, features are enabled by changing the
>> +	default values of other config settings. If a config variable
>> +	is specified explicitly, the explicit value will override these
>> +	defaults:
>> ++
>> +If the value is at least 3, then the following defaults are modified.
>> +These represent relatively new features that have existed for multiple
>> +major releases, and present significant performance benefits. They do
>> +not modify the user-facing output of porcelain commands.
>> ++
>> +* `core.commitGraph=true` enables reading commit-graph files.
>> ++
>> +* `gc.writeCommitGraph=true` eneables writing commit-graph files during
>> +`git gc`.
> 
> I was re-reading the whole series, and found that the phrase
> "present significant benefits" was somewhat overselling.  Wouldn't
> that claim largely depend on the end-user's workflow?  The same
> comment applies to the description of "at least 5" level, too.
> 
> I would not mind if we say "enabling this may present performance
> benefits", with or without "significant" before "performance
> benefits", and with or without ", depending how your repository is
> used" at the end.

Thanks for taking such a close look. Indeed, it is not appropriate
to over-sell here. I will take another stab at this documentation
next week.

-Stolee
