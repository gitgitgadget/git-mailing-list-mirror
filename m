Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E27F20286
	for <e@80x24.org>; Wed, 13 Sep 2017 12:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbdIMM3R (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 08:29:17 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:47005 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdIMM3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 08:29:16 -0400
Received: by mail-pg0-f49.google.com with SMTP id i130so110639pgc.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=27Im8srJuaW0VUTsykheRaJxu2MzA0elV8Q7uAdOTYU=;
        b=E4NeyM4nU3r8+6MI6ktpsxatqmsr1msZ3qIou6v86QTBbYNF9JcfOs/eaubODlWYVU
         TcGxLvRP9ql6/EGn8hTc99fNiKazXnkmtRMDWxB5KCBF6lWgxP7LZJ7Qxkq4gXiXvaom
         6JmGwX78Lxle/2HPVJawNZpanBDuuOaOGyT3dkmw8xJ5vlkyZpPFpZlmXv91hM3H0WZm
         PucjXZl/HWHUOlbg25U9HjsXC3gJHZQXrJP74txjmRMgzFEWAnhQJ8Gu+iH+pnUR+jPq
         KFG685rPMcVDkjJxKV5kzzWlB1CRg90EPzbABnmBfoJ0GO+yldNBErZODGFhcNG8MkYD
         9DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=27Im8srJuaW0VUTsykheRaJxu2MzA0elV8Q7uAdOTYU=;
        b=qOgmgIfNxjog1glVp8hC8uQYHasgn/lnXRkaCOfYshyz9IlDEVKTfNvQrh3hW5gmw8
         dHdm+qdmfabfmyF3IIzysFFEWF+8z2otW4X+/lU43OSAGV0rJh9/EAuKo8PEKObfTl8Q
         yHJG6yzo9Yz+cnVg+eBqTHp20Uj3OzXly45M0/CUIIczdB2b7vj3PRUYzn4mVx6nxkjF
         9ghOnE24sWFTb7nitFHegBW2Xb7ulxTQrI3AU0UHfAC5MDPHapp00W0+TQjeZMHSj5lW
         aDp34Dachxl3WSRcrQyuT6qU9xP18lJk+V5yGmGFDVsut2j17NNaD/M6AGQc6Vn9FEoK
         FNlw==
X-Gm-Message-State: AHPjjUgZIKgUp8x/97ptnbCsYMvNMrL1EnRMuDe03rOo6os1m2++YSSx
        iF5RBALwseK1xA==
X-Google-Smtp-Source: ADKCNb7DBlS69Bt4lDVxKZ929+rOidovx/d9ybqT8V+973b8HL6MwhT1qPo7n1kmIzfd2eSQ6mI4fQ==
X-Received: by 10.98.192.18 with SMTP id x18mr18000343pff.2.1505305756415;
        Wed, 13 Sep 2017 05:29:16 -0700 (PDT)
Received: from [10.4.2.238] ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id r12sm25335245pfd.187.2017.09.13.05.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 05:29:15 -0700 (PDT)
Subject: Re: [PATCH] commit-template: change a message to be more intuitive
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20170912105536.6094-1-kaarticsivaraam91196@gmail.com>
 <20170913102915.GA21499@alpha.vpn.ikke.info>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <1d400615-be2c-7ed7-9687-d78ab163eaea@gmail.com>
Date:   Wed, 13 Sep 2017 17:59:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170913102915.GA21499@alpha.vpn.ikke.info>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 13 September 2017 03:59 PM, Kevin Daudt wrote:
> Touching something can also mean to disturb or change something, which
> is the meaning being used here, so it is not an incorrect use of the
> word.

I do get your point but I should have been clearer in my commit message 
about the
fact that it's a word that could be misinterpreted.

>> So, make the sentence more intuitive.
> I can understand however that it might be not so clear for people with
> less fluency in English.

Not just that, it could also make the translations a little unclear. 
i.e., the when the words that convey
clear meaning in a particular context in english speaker get translated 
"as such" to another language,
they might turn out to become unclear or might even convey a totally 
different meaning. I'm not sure
if is currently happening as I am not familiar with any languages for 
which translations are currently
available but I'm pretty sure that the sentence "Do not touch the line 
above." would not give a clear
meaning when it gets translated "as such" to my native language (Tamil). 
Of course, it's only a problem
if the sentences get translated "as such" but I'm not sure if 
translators (human/non-human) try do
meaningful translations or try to preserve a one-to-one relationship 
with the words in the source
language, either.

---
Kaartic
