Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E580C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiDFVUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiDFVUL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:20:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C360D5
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 13:12:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so3961882pjm.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+MQLgI3Nb4RG/KEJavhtbaU+d2wY792X8A7G8tE9A+o=;
        b=BYjX7VXhgvvZx4KnjOci7XSWy6VYgynNi1YFD0O+twzxn4O1gAIqHvLq7ngaA41lOa
         jCcFVVEtuPXDVHydlkG+aoWAk3/i9SF/VlwL9qFnDODwRa9LolD7CuBrWRLjfAi5sboA
         XHRhGIKlRvBuTNeRDUcV1QbokuwM33eydvkEwWNL6rn0mbXciXF/TUL6p8lQY0RL9jfG
         30V+0qO4g+ivP1MBHCOj4WzWm37c1zzoJoX/cyDEPz+tflrHXfOjt1YBRj3MjHuY6HEW
         ut6ZLTB+V3nWw+DNQKx/57vyo1yeyG10odpCh4OX4gllJgtSTIzqZB/v18G8zx17ZV/k
         MLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+MQLgI3Nb4RG/KEJavhtbaU+d2wY792X8A7G8tE9A+o=;
        b=YBFaljevqnJw7Em7Xk+PjtgiiiSljo8uYZCkngoxa8C8jn/GJt8FX0nVeGiJZ+SJAO
         zfQLVBOxp8dKHlC9qn5kvXWAd8NwooRaA7AFNc7eCfSeivNoJhpWiNilcBKRdZVrgzRz
         Kk393TibDhJL0xrgSHWPYt/Cd6yoUjDyHgUIiWbRfTm1mbmCvYxaVpcMsUONb8UKF8jg
         GBXT6mOW1zZsNvJRWe13uSmVAYxiBnSJ0Dbaj/HIvHnhai8L3EvXwCbC7wIDQtBqgoXz
         9yAJYl0jVmo1LApTiNVQy/YE+tnbtOKZ+BCKHJ2JiQkhhj+hWAG9LvEhmHBaDyTVsDC0
         /qSA==
X-Gm-Message-State: AOAM532KcTGLf14JbDQCf28aSx+iohMdJ0rIGBr5LM0ZhaDo8z6gCBvZ
        Wp5mvvn/b/sLmT/SookipuQ=
X-Google-Smtp-Source: ABdhPJzSM6ztKyNX0wDO1B3DnOJmxwOkCxlJy6Oir5x7UswAXg1AVsQJMyfyx8uLTOf8icUSg3FqtQ==
X-Received: by 2002:a17:90b:1b0f:b0:1c6:ed78:67ad with SMTP id nu15-20020a17090b1b0f00b001c6ed7867admr11855662pjb.41.1649275921173;
        Wed, 06 Apr 2022 13:12:01 -0700 (PDT)
Received: from [192.168.208.36] ([49.204.132.177])
        by smtp.gmail.com with ESMTPSA id bv8-20020a056a00414800b004fafb37f293sm18327462pfb.209.2022.04.06.13.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 13:12:00 -0700 (PDT)
Message-ID: <e312b18b-f0d6-8980-9cad-74602043a1db@gmail.com>
Date:   Thu, 7 Apr 2022 01:41:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GSoC] Contributor candidate introduction
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Plato Kiorpelidis <kioplato@gmail.com>, git <git@vger.kernel.org>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <Yky7xb7nQRR8Vqtj@nand.local>
 <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
 <Yk21JvirO6FyQ3Va@nand.local>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <Yk21JvirO6FyQ3Va@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/22 21:13, Taylor Blau wrote:
> Thanks for this information, it's exactly the sort of thing that I was
> hoping for from your response ;-).
> 
> Like I said in my other message, let's play it by ear whether or not we
> need to split the project. If we get closer to the next deadline and we
> have >1 potential GSoC students interested, then I'm happy to split it
> up.
> 
> One thing that I worry about a little bit is that I think a new on-disk
> .bitmap format will be necessary for both of the projects that Plato and
> Shubham are interested in (though I could be wrong). Since GSoC forbids
> students from working together, it may be difficult to feasibly split
> the bitmaps project into multiple, smaller ones.
> 
> That said, if we do end up splitting the bitmaps GSoC project in two,
> when would we need to do it by?
> 

To the best of my knowledge, Google does not require the proposal ideas to
be laid out by organization before the proposal deadline (which is April 19).
This gives the flexibility for mentors and GSoC contributors to collaborate
and come up with a project ideas that are not present in the initial ideas
list and write proposals for them.

The only significant requirement is that once a proposal has been selected,
the corresponding GSoC contributor should not be made to work on drastically
different project.

I hope Chrisitan will correct me in case I missed something.

-- 
Sivaraam
