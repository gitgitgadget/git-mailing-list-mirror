Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C09DC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjAWRlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjAWRlS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 12:41:18 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A1AEFB9
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:41:17 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d3so12139665plr.10
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xeNCN0G/bNxGrKpvwk4/sYlmX/lDPjGGDuuaZtyCJE4=;
        b=Fqe2y5g4mFi9ITnjSjiRQjRSrA3ZftBTWCPaAi6yKQClWgbJi3EQkfaJkPRzpZQQcl
         0O1fXtS5pEs1KVGo2PzHfUyu7d3X+z9IKPW/WT5MrexZ9TfarAWPnuEKhOl4R8bhbpgP
         iUvfyl7sfv52Ced6YRiwEFsnhftOkw9rU8cwJJKykE92yn1CzyGhLkc/P6xbuKTc5aqU
         F9i9wT/mNpQZghO1ac7TU7g1JTZ98HDXc7jL1LrjG1X4yIrUV1TQ+A1gPxccT2SAX9cS
         8mGpM3fT0dsm+JHDXxCD2BB3iWCmNWemP1i6Yl3du+pcVcVi13vdfHo1TpKCV/1FhFbx
         Rxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeNCN0G/bNxGrKpvwk4/sYlmX/lDPjGGDuuaZtyCJE4=;
        b=mZu5CT2Bi5IGXJpwNe9b8Z4T82lqn3633iHeiRyvmzTLHpSN2+AgHHdm1DTQLKZL5d
         W/syjgbg24lp2v3QgyZUOGHYIZ2rPCXin42u8RJLNy9d7KrnkzBIuy8wsrP42hY2Z7Qk
         0vgiGqusjXqGVl46W5kGKDeIr8bTdO102aEHiAeuvR0VHJWCXsjXxiZ07B3jIXKZv14t
         AuUg0G4rAAOUJ+zzKTKdCcv8dlBgYANs7s1nNY6+E/cV80IcFSpB73I8XnTUrMh1L7hU
         Qex7P9Lt9aryPL9HZOnK5vtHgR1P5ATaT9rGlkJDJ+vr+NxBeRXl8WnQSjHjBH0BvGlo
         nM6w==
X-Gm-Message-State: AO0yUKWZtDhx49LolRJ1oXowEpTDbgAaHkpmIB21q8xmQs08QeBkKdoY
        GecoAliaM7zIjC7ekiwhFt2e6c0l6og=
X-Google-Smtp-Source: AK7set8k3rKPGVeRj/2PUOF5gee+QM9/x1njbDku20WcurCP98ZcVnxES/5O7xJ0cWXUunUEbBQpPA==
X-Received: by 2002:a17:903:454:b0:196:10b3:4364 with SMTP id iw20-20020a170903045400b0019610b34364mr9412plb.51.1674495677402;
        Mon, 23 Jan 2023 09:41:17 -0800 (PST)
Received: from [192.168.208.87] ([49.204.120.129])
        by smtp.gmail.com with ESMTPSA id g22-20020a170902869600b0018bde2250fcsm3100689plo.203.2023.01.23.09.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 09:41:16 -0800 (PST)
Message-ID: <d8ce0159-c9dc-25c2-4180-70518bb31bfc@gmail.com>
Date:   Mon, 23 Jan 2023 23:11:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: GSoC 2023
Content-Language: en-US
To:     Christian Couder <christian.couder@gmail.com>
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
Cc:     git <git@vger.kernel.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On 17/01/23 15:04, Christian Couder wrote:
> 
> GSoC Org Applications open next week on Monday, January 23rd at 1800
> UTC and close on Tuesday, February 7th at 1800 UTC.
> 
> I am interested in mentoring and being an org admin for Git again this
> year, so I plan to apply for Git soon.
>

I would be glad to help as an Org admin this year. I don't suppose I 
have the capacity to mentor / co-mentor this year, though. I could very 
well help as much as I can passively where needed.

One thing to note about the Org application. As per Google's claim we 
should be able to complete this year's application quickly since the new 
webapp allows us to reuse last year's application details. To quote Google,

   If your org applied to GSoC in 2022 your Org Admin will have a very
   quick and easy 2023 application. : ) As mentioned last year, the
   webapp is now evergreen so if your org applied in 2022 all of the
   information for the org application is still in the system so the Org
   Admin will have a couple of quick steps to follow during the
   application window.

Do feel free to let me know if it works otherwise, Christian. I'll be 
glad to look into it.

> The GSoC contributor application deadline is April 4 - 18:00 UTC, so
> (co-)mentors and org admins are already welcome to volunteer. We also
> need project ideas to refresh our idea page from last year
> (https://git.github.io/SoC-2022-Ideas/).
>

We certainly are in need of ideas and mentors for this year. Do chime in 
with your thoughts. :-)

-- 
Sivaraam
