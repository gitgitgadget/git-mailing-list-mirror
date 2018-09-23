Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A391F453
	for <e@80x24.org>; Sun, 23 Sep 2018 21:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeIXDiU (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 23:38:20 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33657 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIXDiT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 23:38:19 -0400
Received: by mail-ed1-f54.google.com with SMTP id g26-v6so1577411edp.0
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=E/5m5SNTnreK0sv3K0soQ7Op7wDHEnl9nxzT8MluweQ=;
        b=j7rK09mZMMRn4r+5a+u+r5+I1qfNDQFcKSj4Q6OiuVnC0/5I//JyDLm5u0ZjuGv896
         nzq/GoBatOhaqv2fQd+RfNWzhV1bxKRqeI4OP1ZE8ov2J6Kvw/tGTsiLvQrZ0dFxD/f+
         nNwEnbbWQDxgpax4ACB2Zfr0eS5C3WIB7lXEEq77NmgznaV0MeEh87pHDimVhqmGvaEB
         ttNKQqmwOZhYXzuDiEc1P9MDzKRyxYRmJrjsBa0ySwgOr4k2Vn1zuF/ZWDzJS277x4w1
         7adbWC09nZFmlOkXUro6xCwDnd3pimiW3XH6HrJpOzP9ZLz8S8AjShCvV/9fco1g+s6b
         9EOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E/5m5SNTnreK0sv3K0soQ7Op7wDHEnl9nxzT8MluweQ=;
        b=USvNaU9GCwvKkj24SZVwwiyIwDhtpbTzcVy3MXopXJ0ucQ+K0Ye1y03rGB0HDZstg5
         22qmX9Zjh/E9gyobDN+eA+nYm0+7rUiWkGNEfYSoGAMCKHILjo62D2AVW1Ov+8gStHNY
         NngdyT21wiJIW6ZxYhYMtWx04Kf8o/U5u03FUtPc8GzsJKqeQMZEuaEQLusDkth4Fg9r
         pOrWiGKbYPrVW2X8T5mKzZcRKc+6EPN2NCf85hnoH61ea3pHivG31ttJQLCbCTqNQfxB
         11Sy2VmTlhs4wCY65uBWPIBLva6USR0ibvliWyZXYkbZpRWpCfJbwm12wztDbFWpCPoL
         HSDg==
X-Gm-Message-State: ABuFfohUt1gXPGUWjBoD2WXA4edkjHx/rtUcbg79exYwSQNpnUfDin1j
        0Bz/rXAOLx3yRET0utpbupn/9T8x
X-Google-Smtp-Source: ACcGV63dNvDOYzFj3nQikomYTSYpcoKGPa+iiEamDVFh/czaSORVnpJ2fP3ly+T8slbTU1Vn+BVTEw==
X-Received: by 2002:aa7:c5d9:: with SMTP id h25-v6mr5246207eds.27.1537738758165;
        Sun, 23 Sep 2018 14:39:18 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id x22-v6sm4754056edb.8.2018.09.23.14.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 14:39:17 -0700 (PDT)
Subject: Re: What's cooking in git.git (Sep 2018, #04; Thu, 20)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <38cb30cd-603d-540b-075c-c6378fe13a84@gmail.com>
Date:   Mon, 24 Sep 2018 00:39:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 21.09.2018 08:22, Junio C Hamano wrote:
> The tip of 'next' hasn't been rewound yet.  The three GSoC "rewrite
> in C" topics are still unclassified in this "What's cooking" report,
> but I am hoping that we can have them in 'next' sooner rather than
> later.  I got an impression that Dscho wanted a chance for the final
> clean-up on some of them, so I am not doing anything hasty yet at
> this moment, though.
Sorry for this late response. I was unexpectedly busy for this period of 
time. I will send a new iteration of `stash` tomorrow or Tuesday at the 
latest.

Best regards,
Paul

