Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F821F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJDCYI (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:24:08 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:44758 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJDCYH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:24:07 -0400
Received: by mail-pl1-f169.google.com with SMTP id p25-v6so3952069pli.11
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iLQBF/7aDS8Q7S68Wd0r+sYWd6n2V4uuVNvFJO3EVFA=;
        b=qwLhR1gxpXhyyybxQNTzJKJL37Xha8KNW94H+bbXt4+pa+549ww43WbCyqoOC0XwSw
         S0SNlfrvr4DvB9yaUlti2F99qxIXLi2cBxBwBVJTGcoW5IS1SfuDlKm1lBA69pJqRKDg
         R71luQauoe9hpJ98VKJXg59aeUHp9x/0qLeAXFkBMq7/OiW6Tr46yhp3s3ZBgxJC8zaA
         6h1Zlrddqpxi2INcc1gWjdd9eKGyDJS2VmpG1wqhmVQfFwwOsV8RKKjdZnCy4TvV3qE+
         x6uBVs461DBlNW48IwupJksLhxVpIRaf0XIw5IX0xp9tNQ6RYWPc4cPtm9HPt7vo5fEA
         SIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iLQBF/7aDS8Q7S68Wd0r+sYWd6n2V4uuVNvFJO3EVFA=;
        b=TkH9MW8qKoHp+Ve4ulHe7WiRrUPD01f42taXmPboKOWeXRna7oiuQwqSNMOtOeD82J
         9hBVAVHGf2nMVWRZBrjIaOmXeYHRSv9hfp07XA9I9CHxJKzuYHZHfGRfThxZZWNjoUlj
         UZlPnkf9LelrG0P0OAGTHM/QsQMBTVDzdR1PRr9srMj7K6e4+P/ecY/uLXhWXg1f9TwO
         P/w3N/toMYUDvqE6S9+p8GZdhitQhXHHmgBgem3zMGMFZLg64PqhAyDLDuxzFOmBj8d3
         ugS1GyJeyRTltJEghN1z5KuF7LXY1ZMGlXD1laaxZrYgJFi2glPr1eDxTl1zFRzHB52q
         zHlA==
X-Gm-Message-State: ABuFfoi0fYeq1J7v8bl8BInBnmsH/nKxrNZnr3DZP6rAuGt1wtkPHQRx
        Ee3tofJBzpNM5s8hNI4ieax/+fKx
X-Google-Smtp-Source: ACcGV63MI3gVIOp5ER2mRuLFiZrK8EG91cBHb2ktrvqwvyhBXsDj/zy/BiF1YbHOVHh7CQ/LpW8mGw==
X-Received: by 2002:a17:902:d90e:: with SMTP id c14-v6mr3143118plz.61.1538595261892;
        Wed, 03 Oct 2018 12:34:21 -0700 (PDT)
Received: from [192.168.2.4] ([171.233.129.129])
        by smtp.gmail.com with ESMTPSA id a1-v6sm5311594pfc.28.2018.10.03.12.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:34:21 -0700 (PDT)
Subject: Re: Fwd: Git credentials not working
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
 <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
 <20181003171104.GA12200@sigill.intra.peff.net>
 <89f60502-c67d-83b6-593b-a0e6d8567183@gmail.com>
 <20181003182409.GA14848@sigill.intra.peff.net>
From:   Dimitri Kopriwa <d.kopriwa@gmail.com>
Message-ID: <84e704e0-fbf9-230f-459c-2927dea19a03@gmail.com>
Date:   Thu, 4 Oct 2018 02:34:17 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181003182409.GA14848@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have replaced the way I fill the git credentials store, I have verify 
~/.git-credentials and information are there, the ~/.gitconfig look fine 
too.

I still have 401 error when reading from that file.

This is the paste log : https://paste.gnome.org/pmntlkdw0

Now that I use git approve, I dont think that I need a custom helper.

Any idea why I still can't log in using git-credential?

Thanks in advance,

On 10/4/18 1:24 AM, Jeff King wrote:
> On Thu, Oct 04, 2018 at 01:12:11AM +0700, Dimitri Kopriwa wrote:
>
>> Thanks for your reply. I have activated GIT_TRACE_CURL=1 and I can see that
>> the request is failing 401.
>>
>> I can't see which token is used and using what header ?
>>
>> The log say:
>>
>> 17:50:26.414654 http.c:657              => Send header: Authorization: Basic <redacted>
> Yeah, we redact the auth information so people don't accidentally share
> it publicly. If you use the older GIT_CURL_VERBOSE=1, it will include
> the credential (I think it may be base64 encoded, though, so you'll have
> to decipher it).
>
>> I have retested the token locally and it work when used in the url or using
>> `Private-Token: <token>` as stated in the Gitlab documentation
>> https://docs.gitlab.com/ee/api/README.html#personal-access-tokens
> I don't think Git will ever send your token in either of those ways. It
> will always some as an Authorization header.
>
>> Peff, what would be the appropriate way to input my git credential in a 100%
>> success way in a CI?
> I don't know the details of what GitLab would want, but...
>
>> Is this good:
>>
>> git credential approve <<EOF
>> protocol=https
>> host=example.com
>> username=bob
>> password=secr3t
>> OEF
> Yes, that would work to preload a token into any configured helpers.
>
> -Peff
