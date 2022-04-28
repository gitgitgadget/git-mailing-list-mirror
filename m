Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B94C433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbiD1SU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349499AbiD1SUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:20 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90351592
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:16:58 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 1so3791938qvs.8
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LBjwx52xlSk8+Ex5WHjVEVyoW/X7Lnt2uogWBr0fz8c=;
        b=OjRv5JABticSUxsHQl2fhqcdOde063PgbAx4iwmdGJLw90ZxKRH+fbSKxnzSxG0fl9
         dXvzXIxr7OrAvmEEey4jDlCebyjKjqcxdc3LSv/efM1Y7nFte8PU6V9GXCAs3cnmJgIN
         pXAl8WCjf7k160kpDSyIGqwVFmihoIMijRmto96seHJqGwrgiokHbmLdjPA1K2kiYDWi
         nx1iJZTyjU/ijTpT447iiZ3CAxdbgjAdITI4dUMsU7eSJ/h177C0PYM+p4l5V1KCeQOL
         8dKH9HBuRGSxQdfpcKRObGRtwLv4NIOoWHNmyfdMGXHFCPEhgt/V57GDTddK27jD0nFO
         gXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LBjwx52xlSk8+Ex5WHjVEVyoW/X7Lnt2uogWBr0fz8c=;
        b=WMPDiJha9kXmnSRIpDDnQQc5054SbyJxemwXSVTGb7etqCx85VfBHJ0f8RrxxkoDTm
         MI2I9fhe2XcvunkGXvpzMFAt2GAZo7caVMQfxugRgpXXfCK3kCVEEDq+F5MIk9zMxMLL
         +hwrWypkeTUrEhS+p7hPcj1uCd3uO94ZEe+22KPaGPZgAgdhpe1q75mIo7PTmL9kmNic
         Dc9WXJrwcVJk/9o0aOgmvt2Eb0JFMVWMszNEgqpxt4usP/U1Fm6Ko8l3DLApeUnKtxGU
         JyhfDRs4f9FEfpSgXrxrdRRX3XbbNBikDqNmG04r14ZTaoSIwFjHwS+vgfYxInsd+rmE
         j+tg==
X-Gm-Message-State: AOAM5330s94aIEDSyRw7CJVRrSBxUwFVa8RhgnZ9PZsls99/ivqPd3V5
        31ErhIcl2bzLKY8Wokuo+Js=
X-Google-Smtp-Source: ABdhPJwGsAMt3bwr9vmPrPwLYeRjCjfVg6cbPfTHh1kvuYuPt3N960KOrqK7XhkRgcgpu91iVlKFIQ==
X-Received: by 2002:a05:6214:f07:b0:456:4bf3:bb00 with SMTP id gw7-20020a0562140f0700b004564bf3bb00mr9913203qvb.39.1651169817678;
        Thu, 28 Apr 2022 11:16:57 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id o14-20020a05622a044e00b002f3656df6f6sm372146qtx.78.2022.04.28.11.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 11:16:57 -0700 (PDT)
Subject: Re: [PATCH 1/3] MyFirstContribution: move cover letter description to
 a separate file
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <7e84d5b286de9dddf28ef1c8f38c7d7c28e266f0.1651086288.git.gitgitgadget@gmail.com>
 <xmqqr15ijiyt.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <706e34fb-fb0c-e86d-5d0f-0bd052566b3a@gmail.com>
Date:   Thu, 28 Apr 2022 14:16:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqr15ijiyt.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-04-27 à 17:48, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> In a subsequent commit we want to reuse the explanation of the purpose of
>> The cover letter form the "Sending Patches with git send-email" section
>> in the "Sending Patches via GitGitGadget" section.
>>
>> To avoid text duplication, move this explanation to a separate file and
>> include it in MyFirstContribution.txt.
>>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>  .../MyFirstContribution-coverletter.txt       | 18 ++++++++++++++++
>>  Documentation/MyFirstContribution.txt         | 21 ++-----------------
>>  2 files changed, 20 insertions(+), 19 deletions(-)
>>  create mode 100644 Documentation/MyFirstContribution-coverletter.txt
> 
> If the end-product is a single document, "MyFirstContribution", I am
> skeptical if it is a good change to duplicate the same text in two
> sections.
> 
> Should we instead reorganize the document so these concepts like
> cover letters, log message for each commit, etc., which are
> applicable regardless of how you send them out, are explained,
> before we start talking about "now, we understand the components out
> of which a patch series is made of, here is how you give it a final
> polish and send it out, with send-email and/or with GGG"?
> 
> Short of that, perhaps whichever appears later in the document that
> uses "cover letter" can just say "see above"?
> 

Yeah, I guess you are right. I choosed to factor out the cover letter
part like this mostly because it was a smaller change. I'll think of doing
it like you suggest.

Thanks,
Philippe.
