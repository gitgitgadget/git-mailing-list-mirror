Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C378D1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 15:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeGMQJX (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 12:09:23 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:51754 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbeGMQJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 12:09:23 -0400
Received: by mail-wm0-f54.google.com with SMTP id s12-v6so9315690wmc.1
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xZSD2eyLdskiRbp6deSSoifoygI+Ls/y/fnTAV+vIAU=;
        b=owPES5fyYkkq+z/MfDQg/925p8hmDVt4VVZqqEXqBPotp+zDXiex98mOZZjP77orpd
         wPx+2cHwEflI5wytOyP0lUUoNI7oS4S9UQmNPWc5Ys2t0OLkRcxNRatPWmyLdjGFlJqQ
         qP06TPn8WikoeYHdtZOklZAzzDvItXSyZwK8f7LaIpCFiKOrfComzkKc1azJGGZQjFOS
         yVOHDSiyBZlqAI/pgfZvmek7aNtbLuap7pU7QakrmF1UHe7RZWiqCTjmz4M6u4QKdJGJ
         Zubhsl0TeMcrbYG1njfZ11Daq4GzrBOBuwnS6djxwinDf2aIrib9U95vCclsyNLicnxt
         r/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xZSD2eyLdskiRbp6deSSoifoygI+Ls/y/fnTAV+vIAU=;
        b=Kl/StifPNvV/QHw2Fpbmnsg6jU2yeEJCbAL5lNYoTX+GsC12kQbTDlkFgq5cB2a/6C
         h4V/P83Z3AeNxuykyKD6DsZPVrHMBGImNPnuFQHcxhQ6bLsJkyqRcCigtdRyW/VwCmdD
         bl6HY2nZpdUb7fQBrt4DoYCakr0EUokBI/5DVISKmZuQhLEelpFlxL7z3cGaGrtHWNpS
         s30uhdPwO9J0zXT400fmMniLK6F1rG9p1sZIMMZ9wPpWCbGk7heB0dJM0NjH8lgy2bFV
         pQmOdLQ83vid46MewKTXVCsirbV/FTjp4izB74FARMUGwzIFIBxznLyiX/fDerEaV7TF
         R6Zg==
X-Gm-Message-State: AOUpUlHY6QUC5UIm9VvnoNOGr86wKzm1m8l4mC87BO8lB+I1tii28z5Z
        FB+gFQbj86UWcihT5TyM7bw=
X-Google-Smtp-Source: AAOMgpcKMOoIIKlZXVroR83/OBkI//vcm4pqIsEr9DKgIqP0yHCncwCj4DS29IwraPhPlQTDTtq6QA==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr4113371wmx.38.1531497249844;
        Fri, 13 Jul 2018 08:54:09 -0700 (PDT)
Received: from [192.168.0.137] (5-13-238-53.residential.rdsnet.ro. [5.13.238.53])
        by smtp.gmail.com with ESMTPSA id 63-v6sm4888087wmo.22.2018.07.13.08.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 08:54:09 -0700 (PDT)
Subject: Re: [GSoC] GSoC with git, week 10
To:     Pratik Karki <predatoramigo@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <d6b9e84b-4d9e-ff1d-e726-56aa58a6b358@gmail.com>
 <CAOZc8M-CVgSqCByngV3DjQ0wNhDFOoWZuHVyRmoHiHZ9kuB-OQ@mail.gmail.com>
 <f2fcb7ef-8d24-b11d-42cc-33f0d3bc6367@gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <171c2d7c-7031-ac1f-2c48-5dd1ce4cd2c4@gmail.com>
Date:   Fri, 13 Jul 2018 18:54:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f2fcb7ef-8d24-b11d-42cc-33f0d3bc6367@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am back with a new (and updated) blog entry, in which I talked more 
about the bugs I mentioned in the previous post.

https://ungps.github.io/

Best regards,
Paul
