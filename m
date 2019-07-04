Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C470D1F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfGDJxm (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:53:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37044 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfGDJxm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:53:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so5930837wrr.4
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZhsZ+HlhV1sprvK47M+6DTZrJv9PcsYDZQbaI7C3LZA=;
        b=gzk22tE/jC92Wfa0wV0Sg+LFStdElwoU+wG+Y03K75v27VOCVChnjmOs1zkZGlJpen
         jsi/eQUi6Fx50+fretxwf7IKg7cqXxgbpaVb1lNwImVBrnWd0Ex5kVLdfneVmAIp1mz7
         r6Y8OUBR7qxb92/T//2Ci5qpn3QZn+THwFmC1YTCfGwEdfhloeVCVVVvtJ11QdGqNzC8
         QeJse/8HC5vuRz4Z9Mi+Tbjkr92m0+d19xpXWDwa7ZFHhdyItSr9VvdRPtSp+yKK5J5z
         3xDwBx0B8iomZtUQ5USb7o9z8zUHyMI+Gljk3SlyrRQK3FJbPJcwjQ0X5YBL3z/7pF8E
         ZH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZhsZ+HlhV1sprvK47M+6DTZrJv9PcsYDZQbaI7C3LZA=;
        b=dOY7VlHM9GKL+WEzkou9T3btYiLPxmwpxG9yEN7zyBR9nV54gSHSYCcTvaEEU9vzQZ
         OP10vZiI3Cos74ecOHvDDvIGfwzCAJtLb5H616J4oDPqo6H3RDLmX3lymiCcgT5BeGDN
         OuUSgzbxH68DfZfTG68bhsfkr8H/zN5G6xUVmVG35w20hxskKCSGveCr60gHlmkxXR3c
         ImiclFm9/8w7W+ui8SBCwW37VPdwHgP4AYODzdk9ERQOYXCmWoNecNtxX2BGyuvp5U7U
         BnlblsgQOunU0fvNeTm0EpDN1fiHkcYOT2/WFv56AymgbKc+/PfCeQiRLe/gQNNat0GE
         fGkQ==
X-Gm-Message-State: APjAAAVVteKaOqAOnsRtskN1TkEHXESQNhfyjr1+a5zZX6nWn3D97eIo
        GHWXV3bQUBup5b7NegdOWVk=
X-Google-Smtp-Source: APXvYqxyVVd72sBcQhq/RmhZYwYav2rO+uMqgng22yVge3/CZOcpmXuPnt58r69mOz+xsLQtUan0SA==
X-Received: by 2002:adf:eecf:: with SMTP id a15mr9613859wrp.264.1562234019838;
        Thu, 04 Jul 2019 02:53:39 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id r2sm6104690wme.30.2019.07.04.02.53.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:53:39 -0700 (PDT)
Subject: Re: [PATCH 1/1] t3420: remove progress lines before comparing output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.276.git.gitgitgadget@gmail.com>
 <52501623f6b47447ce5da283ec11e378413899b7.1561986710.git.gitgitgadget@gmail.com>
 <xmqqimsl5v1u.fsf@gitster-ct.c.googlers.com>
 <2a0a968e-6929-71eb-77cf-ec3ee28fd734@gmail.com>
 <xmqqmuhw4afu.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b7cdf6af-061f-6578-384f-e378b712eea6@gmail.com>
Date:   Thu, 4 Jul 2019 10:53:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqqmuhw4afu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2019 18:23, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> As long as sed implementation used here does not do anything funny
>>> to CR, I think the approach to strip everything before the last CR
>>> on the line is sensible.  As I am not familiar with how Windows port
>>> of sed wants to treat a CR byte in the pattern, I am not sure about
>>> the precondition of the above statement, though.
>>
>> I wondered about that too, but it passes the CI tests under windows.
> 
> Hopefully Git for Windows, MinGW, and CygWin would all behave
> similarly.
> 
>>> I also have to wonder if we can/want to do this without an extra
>>> printf process every time we sanitize the output, though I do not
>>> think I care too deeply about it.
>>
>> I could add 're="$(printf ...)"' to the setup at the top of the file
>> if you want
> 
> As I do not care too deeply about it, we recently saw a lot about
> reducing number of processes in the tests, so apparently some folks
> care and I presume they want to see something like that to happen.
> I do not think $re is a good name for such a variable, though ;-)

Yes, $re was just a place holder - naming is hard ...

Best Wishes

Phillip

