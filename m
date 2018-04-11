Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185551F404
	for <e@80x24.org>; Wed, 11 Apr 2018 21:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeDKVF0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 17:05:26 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33360 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeDKVFW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 17:05:22 -0400
Received: by mail-wm0-f50.google.com with SMTP id o23so659795wmf.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YOCRh+dVA4t4C23gI+FZFckQ0ITQdypp3ACTF53hfgM=;
        b=J3WAi3GxqO79cid8KLN6DUOS9Duw286XaxJkJiseqmr2XydnLCdNJpuqM7e7E9mQOZ
         suUbZNrNeKc1XVrnw1VZsLVQgephlEiOjSltFgdulGc6mGNrmjhVQzCrUKASGgp8jJIi
         bJiNd0e+aGVv5FxViEjlDD0CjgOhquJb9R851W7dWESkOoNaQXGWqJppDTlAp/N01Sed
         Oez8g08VHwfVLoFooib7YopSpYWmbQvT9eZopwfs8WxHhqKwCb72ZW0497t3515U3+ji
         wI/dLMNUEdJa3s08ZCBS/b2lyWxiT4W7K9E390iMC2Xgax6t6gtp33Uix+hOVxZU/jX4
         WzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YOCRh+dVA4t4C23gI+FZFckQ0ITQdypp3ACTF53hfgM=;
        b=JG4aMUMlcw8ZuLhdSSO0aOxMGmn9/CSttNPRVwd7kWmMrw2a+sphXEUldhptP2r/Zf
         JhB4ZgRUFZcFB6ng5LIzdbQ25zEDWPwStj0K9OPvu97lW2kPK0B8neoxHgWOKzNVRXcz
         Xjse5x7xa7GTCiolZPb5sLKquwlZecgRtIvTGZza1EGGKcN6igEal4esfU8BsqPgnHdy
         Fu7kcMmdRwso7b0qd/yugUloV7QA3ITEKN1SwpXqkAQXCz5VSq7DvnjjToAAOPaJjBR9
         JzHUdMxggE9XCQe7S1YoltmOiTnf53PNik+cmk9pkq7UD7mm4c9GbyPwJxZUFsBkfFHu
         uniA==
X-Gm-Message-State: ALQs6tCKYFi5ILy145/ZjgL+OrNE5BG5J6R7/xcFb9PrkdxepWNFdue1
        hEEpBrTBlycAGrD4Ns1jawM/cA==
X-Google-Smtp-Source: AIpwx49TGAQpvtppKXYlVSa1NY1LdCv4Ef3b7X50xAa+vtFiQ30XcW+CfIgErCIiWfwmysGY6KsIsg==
X-Received: by 10.28.136.199 with SMTP id k190mr3843444wmd.154.1523480721087;
        Wed, 11 Apr 2018 14:05:21 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:2863:8879:6ffd:c5f2? ([2001:a62:81d:ab01:2863:8879:6ffd:c5f2])
        by smtp.googlemail.com with ESMTPSA id l41sm3687784wrl.2.2018.04.11.14.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 14:05:20 -0700 (PDT)
Subject: Re: [PATCH 1/6] doc: fix formatting inconsistency in githooks.txt
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20180410183224.10780-1-asheiduk@gmail.com>
 <20180410183224.10780-2-asheiduk@gmail.com>
 <CAN0heSquxLpMfrLQs2em1amLv77-Uywr+885Viuq4-7DiWYmAQ@mail.gmail.com>
 <f45ef7cb-dc0c-8c63-1d2f-6ece0d0091cc@gmail.com>
 <CAN0heSojXxQZz50rwCJefkMpF4bPfpzt+=r9qcVoczU1+qN0Dg@mail.gmail.com>
 <xmqq37023gdx.fsf@gitster-ct.c.googlers.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asheiduk@gmail.com; prefer-encrypt=mutual; keydata=
 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
 khKIKhAKu5lezA==
Message-ID: <b227d2b3-dfe8-09cf-2705-da70bfebd268@gmail.com>
Date:   Wed, 11 Apr 2018 23:05:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq37023gdx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So the following two fixups should cleanup that page considerably.

