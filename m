Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2E6C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 12:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiFNMVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFNMVC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 08:21:02 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E03442EE2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 05:21:01 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a184so6192576qkg.5
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L6oO1tcmM/JTmVLsvT0TX7Qn+VNhWM0QIu2VYGEMs74=;
        b=jPW76MfCGOl59t5IU73I6MSF48PV7YYGc4aye3bw6aQFVKonqs17eeBI82MZbuHMa2
         Wi74VVQ06dQOorhR0HsrTTDwByxekjBCJvMvlC+l2N15GovBScFizS9LMjSPjoKVJVe3
         NBeufgbmc6sLwpIgQCRNHhEkCtyRjXI4faa1Prsksys5ggtuyyE8eYylV9EZaLjd6Vff
         0dM4TEBya5lMjvBeFyQS0mwbL3XSHTbAlaAbLECof89I0cHyZjp9XXbIBaNl4SiWYnZ8
         RYRhOlQN//7eaXLORJU8zspB/jmApDMgZwuTm+OW4DBbYkyi4qJM0/kEknYU8/Fo3DbI
         9s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L6oO1tcmM/JTmVLsvT0TX7Qn+VNhWM0QIu2VYGEMs74=;
        b=TdQsoUlSVbP7aJ1Od1GAg9Nt2WR/sFgZgl6l5Dyrt7Yi3RZv4j1bD8TXPEC53U/KNK
         +jzUz3pYIVH5YgXpf7WZcQy5xVf8E413r9IfRN7MEKJyOjrHLsfkTr5LgipghbudrlFh
         5vBvBs4uEkr9mqpI9Y/KWxoUWXCx3jdd4aSCyGx8M454bVpExyDHo7frmgt/0udiD/dZ
         IsK9+ln01STFwg602bUqPIWmO5X4QrYTEjigN3+v5cok7G+/1x5RlP98vuvNOCTWDyVh
         /KZrNu0Ixdn+ReBN6d4vi2LKI+5Df0+TAUy2enMxhBN6JIwGCnbpfbh6HM/PJXJQx5xU
         okiw==
X-Gm-Message-State: AOAM530cM59CJsMqvt+6zlFS1SA7F9f4ILkNoRdAUc9WfqL4uHaI+98B
        vV834khz0U3HHlaghiaQ2vTMHDQXPhw=
X-Google-Smtp-Source: ABdhPJwncOtFjtENL4Rcsfyq8LQEkW8SW2o/jtR0NAFfBHFfDsORCRQjxofYhugmcphy9YelcldqvQ==
X-Received: by 2002:a05:620a:294f:b0:6a7:4413:9416 with SMTP id n15-20020a05620a294f00b006a744139416mr3429675qkp.181.1655209260197;
        Tue, 14 Jun 2022 05:21:00 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id p6-20020a05622a048600b00304de7561a8sm7602237qtx.27.2022.06.14.05.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 05:20:59 -0700 (PDT)
Subject: Re: [PATCH 1/3] diff-format.txt: fix ancient copy-paste error
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
 <6eaf9b3829fa8f7300bc0123c916d5ffa7c7d80b.1655123383.git.gitgitgadget@gmail.com>
 <xmqq35g8772x.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <f6e86c07-0c70-3837-abb2-874d599359b8@gmail.com>
Date:   Tue, 14 Jun 2022 08:20:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq35g8772x.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-06-13 à 14:26, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Fix what is probably a copy-paste error dating back all the way to
>> b6d8f309d9 ([PATCH] diff-raw format update take #2., 2005-05-23).
> 
> I'll retitle and rewrite the message like so:
> 
>     diff-format.txt: dst can be 0* SHA-1 when path is deleted, too
>     
>     "dst" can legitimately be "0\{40\}" for a creation patch, e.g. when
>     the stat information is stale, but it falls into "look at work tree"
>     case.  The original description in b6d8f309 ([PATCH] diff-raw format
>     update take #2., 2005-05-23) forgot that deletion also makes the
>     "dst" 0* SHA-1.
>     
>     Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Thanks.
> 

OK, that makes sense. I hadn't thought of the case you are mentioning here
(new file added to the index and then modified).

Thanks,

Philippe.
