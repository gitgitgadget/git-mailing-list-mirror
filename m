Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A3C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 18:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiAZS3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 13:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiAZS3e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 13:29:34 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA7BC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 10:29:34 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id j10so172291pgc.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 10:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Fhw5Wbez0mH/Q5Hm2fPmiivO4AL5tOmMkE2U2USk038=;
        b=eQe0grn7m0IBzqxkZDPd8EXN9wAumr8TnShw8YJq2ME2iBX2xUulgZvu4GC4Kdf46G
         8zJMiOBlRDVP8VZCkg7mzdRtqMx3U3vkns21I3kRQgXuxwwnf37bytahdccmU3Zv+iyG
         hPB7hgbCggeiMGuWmTkfONLLvhww3jdDXs1TEAgKQPkFsPKdVuBfj2ZBTwPDXP3jbxas
         bjRr15p4HbQ7Z1RwUnWCTpX2kTAKOWXavsIheBy+pp/5uTEPfbWe5vwL+Zz/Z2pqHK2p
         oTTqYfEjIn1yd7+yfO1hjcEHbdFmuGY+olLC4poAz5FQMz6zGfGCUtDg4JRIeBt/TpN5
         AQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Fhw5Wbez0mH/Q5Hm2fPmiivO4AL5tOmMkE2U2USk038=;
        b=LjJR07YR3iTyxmfRcPDLxgUjbpLzdSmEjSSaJE/odEI3XmVQ4K55dzSQ/WiTxYtBvS
         3TCu4oJoIjrYhMg/TQEQcIutzaOze1VtbHtO6W6QLfDBRldh5+3omfYAMefiC4l0QZX1
         M8Mx0NAS4AMin1pf4T+EIKjGE+9LSSXZf57SV0T4S67162pR2dVb0tzSb6PfUlaKbo1f
         5gukN1ygoRui0fOI7DmY0AY5oV8785YKgOC3e4AQ6y6Zu1ERbsGK0dC5j+q1KgRenNEm
         n47hQ5gneHsmtNV2chC9x800y5fW3J1KRDsqduLVzebfJcsTofIaSWJ0yBrIcSqb/Udc
         2GQg==
X-Gm-Message-State: AOAM5321OPCaPsrURBoVKSAVP/nsau+wkZgp6sdPxpVE20aGi/SXUQET
        xVKnMsDKY+Nzuyd6O8t7BY0=
X-Google-Smtp-Source: ABdhPJxK6YlaAQPwoZYakpi4FE5zZyqtJgHOrFi/sgWlpYEvL3S9QNI/ojvQ3ClNSSHsTJbYPDQL/g==
X-Received: by 2002:aa7:888c:0:b0:4ca:75a3:aa1c with SMTP id z12-20020aa7888c000000b004ca75a3aa1cmr10601997pfe.65.1643221773487;
        Wed, 26 Jan 2022 10:29:33 -0800 (PST)
Received: from [192.168.208.38] ([49.205.87.95])
        by smtp.gmail.com with ESMTPSA id g11sm757326pfj.21.2022.01.26.10.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 10:29:32 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Git in GSoC 2022?
To:     Git Community <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Message-ID: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
Date:   Wed, 26 Jan 2022 23:59:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

GSoC 2022 is approaching. The timeline has been released [1].
Mentoring organizations should submit applications between
February 7 and 21 at 1800 UTC. So, I thought I'll kick off
the discussion about our plans for GSoC 2022.

First, are we interested in participating in the 2022 round of
GSoC?

If we are interested in participating we need:

   - Volunteers who are wiling to act as mentors. I would be
     willing to be volunteer myself as a mentor for one student.
  
   - Microprojects: I believe we could repurpose the Outreachy
     microproject ideas[2] for GSoC too. If others have suggestions
     for microproject ideas, please share them.

   - Project ideas: There are two mentioned in SoC-2021-Ideas[3]
     but both were picked by GSoC students the previous year. So,
     we would need new ones this year.

     Taylor showed interest in a bitmap-related project during
     the Outreachy application period [4]. Taylor, are you still
     interested in mentoring a bitmap-related project? Would it
     be possible for you to do so for the upcoming GSoC?


Also, wanted to note that GSoC has some changes in store for
this year [5]. Concisely they are:

   - Expanding eligibility: the program is now open to non-students.

   - Multiple Sizes of Projects: In 2021, project size was reduced
     (~175 hours). This year, both medium sized projects (~175 hours)
     and large projects (~350 hours) are supported.

     GSoC organizers recommend communities to have both medium _and_
     large size projects.

   - Increased timing flexibility: rather than a mandatory 12-week
     program, projects can be extended for up to 22 weeks by the
     mentor and the contributors.

See the blog [5] for more details.


[ References ]

[1]: https://developers.google.com/open-source/gsoc/timeline

[2]: https://git.github.io/Outreachy-23-Microprojects/

[3]: https://git.github.io/SoC-2021-Ideas/

[4]: https://public-inbox.org/git/YVTM+WQH%2FUyhVeTz@nand.local/

[5]: https://opensource.googleblog.com/2021/11/expanding-google-summer-of-code-in-2022.html

-- 
Sivaraam
