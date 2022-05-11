Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C0CC433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 21:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbiEKVtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 17:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiEKVtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 17:49:50 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F479AFAED
        for <git@vger.kernel.org>; Wed, 11 May 2022 14:49:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z126so3347221qkb.2
        for <git@vger.kernel.org>; Wed, 11 May 2022 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xBYkbMu2MOl46kqNIJ2UPCmnkB3loFa+fAz1VOTpG4I=;
        b=F+7JzXFWMphUPkm19SlJgJi62p8PCIpdE8xb5eS8W0WpYGLQeLsvktSdYZ37yc/h26
         hEepIpogJS5Q6z8eaK4ruRmtMdauPERJuqWGqY8BcyzakoBoIVjyZ77ZLPP6w1AC7K3N
         2FLWddwklp3D69f5ArIDDyxjLm8p3yyQCurxcHkBmREVpsvldyz89CamH+UMbGYctRAv
         ALmxarqYa4u8OqMEOFyqpTsgUz6IeEy5lI8/XbOFIlvVyUFhPjJoYE5kWX/8eD0WTj2x
         Qz1p10RoePplGgmqP9aFKrnNvv+YrKVZ66+cXDEOc96LROK6dXCDwPssAcADOGP7GFOW
         ivLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xBYkbMu2MOl46kqNIJ2UPCmnkB3loFa+fAz1VOTpG4I=;
        b=ZkKnGcyz9XZaQnQWZzxhBc7hcP0uWf02S2LRoBCz5aqpdd0Z9O5zX0O0WMr+vjzTIL
         miRCrEPHgK0E/EcPRGK8QJTMtJY8rOXt6X2tb7KUBxePd+TSiSBbPsrlGZWCb485fd3R
         cvK17+y/oNOyt51IP86auzXs6PUq1UrM8cPbzqfp2IVnHTq4OQpzUrPl/Cgtvq9wGLFF
         ah0JD4daJ2FHoOoGzIDtpobSp9ThNgqUedL5YTbmq4SN1z8hjCl4r02ko4lyRLEfz2tp
         DkypP6CtzOq9HZ9z5udHnEb6Yl6cQQ3WKeSmHTQtjQq5A52bBDIOMHyXBdwMkInlx6Dk
         O2+g==
X-Gm-Message-State: AOAM532sHtGVV+oP16bPa2azjRchsyVLCuNTH+Q+avdzJP6UZPOe2Lv5
        aql6c11ffm6qBCm7vTtSwDA=
X-Google-Smtp-Source: ABdhPJyEVFWTTcuZdSxbPKGREJX4Z9WvnZvoBb6bXnf4s4WikgzUmnCwg+EXJV57n9W220zoyu2NVA==
X-Received: by 2002:ae9:eb89:0:b0:69f:b960:5dc3 with SMTP id b131-20020ae9eb89000000b0069fb9605dc3mr20229305qkg.305.1652305788603;
        Wed, 11 May 2022 14:49:48 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id k4-20020ae9f104000000b0069fc13ce205sm1835883qkg.54.2022.05.11.14.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 14:49:48 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] MyFirstContribution: add standalone section on
 cover letter
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
 <9552d80a80d9574c8f256696fad06f48b39b51c9.1652233654.git.gitgitgadget@gmail.com>
 <xmqqa6boo0az.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a955b9f1-3e11-70c5-b390-a35b420d6835@gmail.com>
Date:   Wed, 11 May 2022 17:49:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6boo0az.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-05-11 à 06:01, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +The body of the cover letter is used to give additional context to reviewers.
>> +Be sure to explain anything your patches don't make clear on their own, but
>> +remember that since the cover letter is not recorded in the commit history,
>> +anything that might be useful to future readers of the repository's history
>> +should be in your commit messages, not in your cover letter.
> 
> I agree with only a half of the last sentence.
> 
> Things that are useful for "git log" readers should be in the commit
> message (but that goes without saying---by definition "git log"
> readers are reading commit messages).  If that material helps to
> understand the overall topic structure by the reviewers, it is not
> wrong to have that _also_ in your cover letter.  IOW, I sense that
> "not in your cover letter" is a bit too strong.

OK, I'll tweak that in a v3.

> 
> Other than that, I found that 1/5 and 2/5 are very nicely written.

Thanks !:)
