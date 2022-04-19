Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E25C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 17:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbiDSRnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiDSRnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 13:43:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D45E1D313
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 10:40:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b7so6810821plh.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aZRdZt8/xRpIVElEA3wGfoESzfpK/BvoQB2sAZ5iBw4=;
        b=ehhV77TT82+gRmJXsh+E3UY7hKVcKqRpR7AD1KgRIFTOYQwRtMXFGn8jua/XcG3AtL
         rYmiOxHrvS6KQGQlWWO9Pl8iE4eiQSd1cjT3GwRh5vANYL7xPExE7TktkrpkBIoNepHL
         2tBEM83vXvaHHcA2t3Dm0Hw/1jtqWcjWIcrCgVH0tHFwqjuFL/YE0bQ3Yf69ujrFJPtJ
         uztPrOSqKx2XmJXtjipH5zIIWak4P1D8r0PKnTmjbADVsisf8G6j35paZwJ16LpJwNa7
         WjRJtSvsYGK23qCNMx84pAyEMzUgqUSL437uaW7LX+OjT3B4rtzM0MRwt4HtoolQaIhi
         VgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aZRdZt8/xRpIVElEA3wGfoESzfpK/BvoQB2sAZ5iBw4=;
        b=itecY9qQ2NsulFW7EZnJk/xPOLuM4BkwR5Zp2fsR5qw2gCu+5UdWNaDXrR+xCL70V0
         9LifxpzVV8yjfSP+9NmU+AxyfZrIc7aHivG75cFgez4Gbt5FBcRjpSHJJrpJOtCygQlj
         /afHuW/HAsJmfQG1DSLn/LISNb4AAEpMnLsi++UdTZZaa5siG/1/BfyWRtCS2NAACT5t
         iRzFY02DjfcEk/iKEWI9AemAdRa7kl86ndeTOlAdU+PAMVWa8Gd9qRE6yL4iQfJQ/emk
         UK8STcDpxCSmrTC1uEKNdbDTMKR8PDUvDFAzB+oMkMZN1rIyNZ1nfs3DuNnbCP1Adc70
         YZdw==
X-Gm-Message-State: AOAM5303uFk45jT6Xrr1Qkh5OXpRTyQXYoZlrlCVr6ZEQ3TuziZrD4QJ
        TxozEc4hAUZX+B1p2zLyfCc=
X-Google-Smtp-Source: ABdhPJxkLSFKv0S2eFe9KuMHhBwy4Yg+0bzWvA7M1COs2r3WG8M3i7YX5N6rEgSomHAn4aypL0rrXg==
X-Received: by 2002:a17:90b:1d0c:b0:1d2:a91e:24dc with SMTP id on12-20020a17090b1d0c00b001d2a91e24dcmr10628445pjb.165.1650390025079;
        Tue, 19 Apr 2022 10:40:25 -0700 (PDT)
Received: from [192.168.208.37] ([49.204.130.177])
        by smtp.gmail.com with ESMTPSA id 5-20020a631045000000b0039d942d18f0sm17045101pgq.48.2022.04.19.10.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 10:40:24 -0700 (PDT)
Message-ID: <6ab769f8-92da-774f-9d33-4ab5c1eaab6b@gmail.com>
Date:   Tue, 19 Apr 2022 23:10:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GSoC] Contributor candidate introduction
Content-Language: en-US
To:     Jayati Shrivastava <gaurijove@gmail.com>
Cc:     Plato Kiorpelidis <kioplato@gmail.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Labnan Khalid Masum <khalid.masum.92@gmail.com>,
        Jack McGuinness <jmcguinness2@ucmerced.edu>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
 <E6525E16-10E8-4C08-A596-6C16AD31F62A@gmail.com>
 <CANsrJQcq-nWPaCyM3qR1d_u4U8wERdKbxFKMVK6Db9uWtyoFfQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CANsrJQcq-nWPaCyM3qR1d_u4U8wERdKbxFKMVK6Db9uWtyoFfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jayati,

On 19-04-2022 18:46, Jayati Shrivastava wrote:
> Due to time constraints I shall be unable to participate in GSOC this
> year, but I'll continue
> to contribute to Git and invest time in understanding its codebase and
> hopefully apply
> next year as a GSOC applicant.
> 

That's understandable. Thanks for letting us know. Hoping to hear from
you on the mailing list :)


Others,

Thanks for submitting the proposals on time.

--
Sivaraam
