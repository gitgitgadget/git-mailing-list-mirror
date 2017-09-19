Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786B920A29
	for <e@80x24.org>; Tue, 19 Sep 2017 09:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdISJ1M (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 05:27:12 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:46955 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbdISJ1L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 05:27:11 -0400
Received: by mail-it0-f42.google.com with SMTP id 6so1266565itl.1
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=TbSoW53x75+mtcn8vN4NlTOSvVTarEVfZ5VuZbQ8J3c=;
        b=oiFn5FLvGyhfbcnOYl/i6C6OgrxzHoh2h7zVnQKfy/CuRKRsj8vjXMeJnnVYl4AX9L
         49sZN8nS8JxWHO4Pv1g6Kr9O0Sns/ZydQUK5R+GZUsTYyvN8fAj8mgFnVG+8q6UeMVC5
         a9MI3vdFnmQcjtaCYP9pV2XayF39RTEZ/BRNnkXIjgxcRx7ekeG/QceW2zgWq4Xv1/w5
         U1EjiJoWo8DRk2xvrHQwh23HkvSZQKi6nvn13TTxo1XLe4uzPVKIV9dMPWxdHuAqboLS
         w0PRMVmx8+vTU2857p+aTdYKTtqaihLdxJFrZwR0MNUW0GPMXY18blZ0N3dP7gSpvRuk
         +1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TbSoW53x75+mtcn8vN4NlTOSvVTarEVfZ5VuZbQ8J3c=;
        b=Q+40aST5BWS0vIikq39MU2DDjuDbyepQnARjHJMhkQ2Ls6hP70BUIBqblQCp4DBhVN
         A73ufaWH+IT2xuIbJQl5vhKxPKCynmfnPEx1kxZ6glOAl6SIAu1iTP32hw2DIpT3sBDr
         2SLZ6ZMpPZ2LYKOS6MuXOiPmIOycoMfIsl7pRiwYZhstR6grnivcJWf02Mch6OHVqOFJ
         +xbjDhdE2eg7lGglXmepxvGcc9CSZyFA27sc0AxlrdhLJ+zuikKCDljL2JnajGKPMvjn
         7HKbPUD25LoFQmoxJeS4gWuSZ3tcmQmfLIIjFYfRpx9Fma8kY3LIrTtJdhffe9yS4cNw
         6jyA==
X-Gm-Message-State: AHPjjUhduzAdf3rHbBb+6pO46CzAyTQ6mD2vJC8IComQ5WoX0YW6R7nu
        ePkJboirV9Zz0/wrl6V2ugQjd1oJ
X-Google-Smtp-Source: AOwi7QD0nMO0su3LLKQQgE4Ux0I7irjeeXfJWHfHKZPq7T5uUFneBP3e40+bqC2jyL1zGS/dfhS9dQ==
X-Received: by 10.36.50.150 with SMTP id j144mr617596ita.52.1505813230368;
        Tue, 19 Sep 2017 02:27:10 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id q26sm4848666ioi.58.2017.09.19.02.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 02:27:09 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [PATCH] doc: update information about windows build
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <0102015e8e4f7e75-dfec22a3-bb1a-4208-a069-450275d52b6d-000000@eu-west-1.amazonses.com>
 <80afe093-aceb-9478-f0d2-d69f7f75eaab@talktalk.net>
 <1505655777.14232.3.camel@gmail.com>
 <b1add5b2-7ebe-38b9-de85-742e64cd1ee3@talktalk.net>
Message-ID: <ca0d3d6c-68a1-f689-6051-9ba1fc2b3a42@gmail.com>
Date:   Tue, 19 Sep 2017 14:57:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b1add5b2-7ebe-38b9-de85-742e64cd1ee3@talktalk.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 18 September 2017 12:32 AM, Phillip Wood wrote:
>> May be the Windows build exit with failure on other repos rather than
>> saying it passes?
>
> I'm not quite sure what you're asking. If the tests aren't run it 
> needs to look like a pass or everyone's branches would be marked as 
> failing on github and more importantly it wouldn't be clear when there 
> was a real failure on linux/macos. If the tests are run then it will 
> pass/fail depending on the test result.
I thought failing wasn't a big issue because the macOS build failed most
of the time due to time-outs, at least for me. Most of the failed builds in
my build history were just the macOS builds timing out. That was some
time ago. They seem to be passing quite often recently.

---
Kaartic
