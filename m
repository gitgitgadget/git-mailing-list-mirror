Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B641F404
	for <e@80x24.org>; Mon, 10 Sep 2018 22:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeIKC4f (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 22:56:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50699 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeIKC4f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 22:56:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so23066800wmc.0
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zEpKhNvTzrjz5ZyszOvrR6cCK9cUNCnGiHv1WcqmHcE=;
        b=WhloISY1Y3RM8x2ld6dFwYifsGS8bncTa1NPUSqRdFVyGDmrck8ig7OkEiIFEz52A2
         pqnGt+OJ0OFYWDmBVD0WQrvDzRxSFRpL2IRNw3BQL0UfV5YGo17qioaAn7+V0H14yGAC
         TP+MVE+s8moz1w+8InBjQyXcbUZCQw+6upwRslgcdcZJhOSWOhqeZ3TXtq7O7CKrB1Gk
         TPTC1PPSJ+cepO/EBtg6vqjBgeEyiXbXqOwj8YdGnP7JfvdB/8BFqirNcVpJS+sN3J7j
         tPyjgct8Q6/IOq6Cnzw7g49lEuDEtIRBM8UjlZvOXtpxflZLrmvjFU62L8Qiezc3qmKi
         Y9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zEpKhNvTzrjz5ZyszOvrR6cCK9cUNCnGiHv1WcqmHcE=;
        b=H7QX9aRGuGP6KHJfogNeTJW3UKvVMM3eP1z4evVD+OHo65cIXvp94UMmrpQ189ZYVY
         C6fIaPmeVTOJyET33+aIRaeyI2dyJYX3kAqkIG7zyxtgjiFTFznSyMltA2V03EFjuqnU
         pvYZrvUO97GB3SNzHNSzhLMvUzDRqkfSpTyjKEmWyGfAqiN7vEfeBDh7idm5zTvIMMjq
         hhV9+6kIHinbSGb4HZQRo2OndEpUQDLhAGQT5GW5n2WA1Ejt6uujRRD8XVouALCEkLOI
         pq4DkXM9Ue6SgGPylPCVSvHvY+JB4GzBjvhEvN6cKkkv8R8jm61+YWbVcyThotyn3eco
         jIZQ==
X-Gm-Message-State: APzg51CBgqDMqWUVWIRqmuhMdB3V6Q5FLf+m9yOmUTjPbAvRPku78C6k
        2RJo4d9pdVcjx+VhhvL+1xk=
X-Google-Smtp-Source: ANB0VdZ4keaUIW4f3kTDrrMxd0La/mzMyqSu8VpycCkhRbyWiaHXH6Vpj4b3ZmUEyXs7K/0xw8m/gA==
X-Received: by 2002:a1c:91cd:: with SMTP id t196-v6mr2061922wmd.100.1536616826913;
        Mon, 10 Sep 2018 15:00:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 69-v6sm15392529wmb.27.2018.09.10.15.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 15:00:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] config: document value 2 for protocol.version
References: <20180522223208.GQ10623@aiede.svl.corp.google.com>
        <20180910212157.134291-1-steadmon@google.com>
        <20180910213006.GH26356@aiede.svl.corp.google.com>
Date:   Mon, 10 Sep 2018 15:00:25 -0700
In-Reply-To: <20180910213006.GH26356@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 10 Sep 2018 14:30:06 -0700")
Message-ID: <xmqq7ejtrp1i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Josh Steadmon wrote:
>
>> From: Brandon Williams <bmwill@google.com>
>>
>> Update the config documentation to note the value `2` as an acceptable
>> value for the protocol.version config.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> Signed-off-by: Josh Steadmon <steadmon@google.com>
>> ---
>>  Documentation/config.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks.

Thanks.
