Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FAFC433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 08:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiBFIMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 03:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiBFIMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 03:12:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43368C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 00:12:13 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id t9so6641925plg.13
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 00:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OVlZpE4G9X+QOlbpixfFvTWLLdSflHnLLRC/z1ODPtc=;
        b=Nv8lgIbLHR3ayKR2N/doQ9xH1lYGJT0uzaIIhRKliY2ExdNpPBLGIZmsrMgpx2gQyc
         x2gJGSPIG2S1NjFFCNU1s81WNIzhLb/utYd3dmOa+yZdtODixx1bUx5f43r7uhHrMGa7
         rlIB6NcNKIrDTNPYXrcpw1BRgBZ3mqGcF60qcZEoTcKtMqqSMhhLAk3sMjvdkrNnbwUC
         /jNkSmBun3DlXzoc/g15jv0+bd7HMeSfMzjTT9PaJ+swP6qaQQK3UHO/quX5O6Yhiy5A
         zP8xHihx+CXD/NTPfa8nZ1HTE6aTkFKXMaTYVHtDHSIYIUNRrlBm0lqAIQ3v9Am06ChO
         sC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OVlZpE4G9X+QOlbpixfFvTWLLdSflHnLLRC/z1ODPtc=;
        b=Ce7qtJwgbR6uDRn/JR7EBwW5np9Zh0Wbh0eQJB3i43CP91ZiJDmuglVYXlYuVhGQeo
         U5QjbR9uoItPxcZpKQECb8laU9pKNlXTvzMcHNfrDHRxDt7BDbChPzO8hpi9pADo56UJ
         wACyDlp8yS8ao/r/FTXP/wBU1tQm0ksa+W8+iraqVikI6261yDHt606Uei9xkKTF8XzB
         QYFS695P0kyArchLlfBNvXG7269HjlhnBK/rap73u4UlvdiaGLS80pK4F5Ro1H8YaVsf
         GA9FBAIsF5vr4A2e6YeJnHTt2kfsDQ5yAjwTsB4GILZDAL/HvZgQDVeP+ghCT61/Aw77
         XPmg==
X-Gm-Message-State: AOAM530swbX31ZbNYkZDVAiMw1pWoLZnnnj/aDHBt4ygG7Xn/nTW+4WI
        WwWPe9jEdoYZPLHVCOIdOfg=
X-Google-Smtp-Source: ABdhPJyFB7HKkB19RpbR7VS7S13EYbvamHsJqG/tmvIJdXNc8Q9mcNJK4bmiIzlgbaR3JKSMRhuBig==
X-Received: by 2002:a17:90b:4d82:: with SMTP id oj2mr7909187pjb.202.1644135132611;
        Sun, 06 Feb 2022 00:12:12 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id pc4sm7347978pjb.3.2022.02.06.00.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 00:12:12 -0800 (PST)
Message-ID: <032852b5-0cb3-4515-592c-9433930946f3@gmail.com>
Date:   Sun, 6 Feb 2022 15:12:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: ja/i18n-common-messages
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqr18jnr2t.fsf@gitster.g>
 <220204.86iltu3jbm.gmgdl@evledraar.gmail.com> <xmqq5ypuo9it.fsf@gitster.g>
 <7408402.9NgVXbFLuH@cayenne>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <7408402.9NgVXbFLuH@cayenne>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/02/22 19.18, Jean-Noël AVILA wrote:
> Bad news: this implementation is already crippled. For instance, calling `git
> commit --fixup -m -c` would first bring up:
> "options '-c' and '--fixup' cannot be used together"
> Then remove --fixup and you get
> "options '-m' and '-c' cannot be used together"
> 
> This is because (according to the code, I don't know if it's really what's
> wanted) the real logic is
> Exclusive ("-C", "-c", "-F", Or("--fixup", "-m"))

I read that your intended logic as 'options "-c", "-m", and '--fixup' cannot
be used together', right?

-- 
An old man doll... just what I always wanted! - Clara
