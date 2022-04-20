Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD72C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 19:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381824AbiDTTnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351468AbiDTTnx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 15:43:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE2114026
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 12:41:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s14so2729629plk.8
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6DmswfrNHwNyQSxVsGa7bsGlTq5hf4d267ZlnARFSLg=;
        b=D8+5CHtAPJJtJcR2TY8FvnAuu3KHD0HoGUK0ITQVzQ0VQzX/mNXelkSFpOtSJ/PvKM
         Wbl5/TBQuncGjgGo3bYPo8hhRkM4XBZ/8wdTqezCg+dtG/Af8SJXkrGOroX5FDuNWT+b
         0zLZiRro6CPR5hehJ/V1Nerj4MliK8LqBG4cVE3EpzRwew+VY6n4m/EMCRxfClZS7jsu
         8TazDgqtcyC335PDZuOJCjDHJZZd8xWaNi2INkECP3PkkrJMG7C+/ypWMXzgjZI+ME1T
         Ca+6nxT+8wDZVypLY91Vv3CnYMEwGmjjTR9UUyJdfLAI0AzGYfj6adOR2nh2TopXOaQN
         4JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6DmswfrNHwNyQSxVsGa7bsGlTq5hf4d267ZlnARFSLg=;
        b=cn6OsrfiET45B5AYGFE8svOrpxH/x0jdkrKC0OKRWl2RmOSMckCyVRVDeTDBIQF0Jv
         /DspENT3Ntnu3jug93MoSDHQeF/EoWJxPAgN9dmXJDOvRMGTJwqpORcGiP64C7qfOar3
         AoDZUbmxEbYJkcsVEQ4flze7mF85juUz/Fo/0EXq6lt/tCTtUMHRIWXLwlDPkGeeSnRF
         bEyDcZU8ajlAwPB2xdPjF6GpcypZKOsnI4zMT+Cvahle5NFNw6xLxRx9GUnn4P/j3xa+
         t7mFVgAUjl9IpBTevkBXdcSxNFqbA9o2w99gYeHve9uTCaHOAxyNotGBsPShI7ht/1VM
         d8Aw==
X-Gm-Message-State: AOAM533e77TzQjvGYpc1soxCmGMZLnXgpb7vEzZgFsvDfX48eIG6D1sj
        5HoeLGSGCOwqma3kytZKCdc=
X-Google-Smtp-Source: ABdhPJxFycxZIvCx6yhqESngRjZjSlJpZKGxpYfdj167rY1Kf76QwUkbMafGknmCjoDP2oYShekKkg==
X-Received: by 2002:a17:90b:17c6:b0:1d2:fa2d:bb7c with SMTP id me6-20020a17090b17c600b001d2fa2dbb7cmr6307567pjb.22.1650483666047;
        Wed, 20 Apr 2022 12:41:06 -0700 (PDT)
Received: from [192.168.208.37] ([49.204.135.129])
        by smtp.gmail.com with ESMTPSA id nm5-20020a17090b19c500b001cb9ba78d39sm187354pjb.9.2022.04.20.12.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 12:41:05 -0700 (PDT)
Message-ID: <d29613d0-c022-6338-a8cc-5a2c8b83e638@gmail.com>
Date:   Thu, 21 Apr 2022 01:10:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GSoC] Contributor candidate introduction
Content-Language: en-US
To:     Labnan Khalid Masum <khalid.masum.92@gmail.com>
Cc:     Jayati Shrivastava <gaurijove@gmail.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jack McGuinness <jmcguinness2@ucmerced.edu>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
 <E6525E16-10E8-4C08-A596-6C16AD31F62A@gmail.com>
 <CANsrJQcq-nWPaCyM3qR1d_u4U8wERdKbxFKMVK6Db9uWtyoFfQ@mail.gmail.com>
 <6ab769f8-92da-774f-9d33-4ab5c1eaab6b@gmail.com>
 <CAABMjtFw3dXd8kp82Hqz_NDMxV-U4mDD5y_MrxPj2bvinR3OXQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAABMjtFw3dXd8kp82Hqz_NDMxV-U4mDD5y_MrxPj2bvinR3OXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Khalid Masum,

On 20-04-2022 18:46, Labnan Khalid Masum wrote:
> 
> I shall not be able to participate in GSoC this year. I'll try to contribute
> and understand the codebase more instead and try to participate next
> year hopefully.
>

That's understandable. Thanks for letting us know. Hoping to hear from
you on the mailing list :)

--
Sivaraam
