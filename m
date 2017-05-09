Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4662018D
	for <e@80x24.org>; Tue,  9 May 2017 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbdEIVEU (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 17:04:20 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34242 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdEIVET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 17:04:19 -0400
Received: by mail-pf0-f174.google.com with SMTP id e64so5690181pfd.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wXJvQPe0tFwbVDNGooW2tQrJZJzAohdDefxsygTps/0=;
        b=vLe/8MmqcgXB5OZrliYQd54yBmx1FAFYK7WtXi1z0KWjcr53wRdvY1b9pTkOBvY3W9
         N12SS3oEzPLeyO6mxJfTbIt7j7YMAHh+ObMX0hpR8raMCgSWVpVhYG3MRDYSKZ1WX+zq
         NR/0VOsATmRMHw9fiY0lwbFgWzYsX1wrTP1Jr/Z7M39DSqknu769b8X4hbE27YrVpxki
         E2VmtmjKIlgWaKlTCc5Q+FRmu8IezEgSUM4C4sDIf38BEFts91cj0yLauqBg8jdT7iwM
         tuO3FoSOia8s9WxjZdBEBGjPCjBQZEIjOoiofFhG2/gm6bpnEhhM5GYu/9qvwClN7k4K
         DU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wXJvQPe0tFwbVDNGooW2tQrJZJzAohdDefxsygTps/0=;
        b=BXH1Ru+372H3ZjzqFIEMH/SStgYgAiqsQ5lFGtwtlqBXynRnaj3vng7x12Z8+N4prA
         H8V2I3qTADJgpQolEBeF1B+/QFN1N1UO2h0oX+mBjUB0Sm4wU2VxdVlfBLO150s8UFWU
         oZH+gcsOHEr74rwELk3XThLsq2zA53Y+0Q/2vttOYo3JZe5j87L21WY7YEuf9dop9m7V
         XPQADHPhL0CG1KW1hMB3Wvm+PoT4Q8ylIk32DlXVVmPNbuEuuqTPUjxP23IIQWJtGsm5
         TG8WJgzHJDHbhuop04+9Tyi7W0b0nAeTIZeJWeoC8PU+cDC/06P7jvi6v/Ve9mgY92PL
         +hwQ==
X-Gm-Message-State: AODbwcDkVWzgFDOT3ZE6YRCJHullsn95rT8M8ycADPyoTblVBA5pqL9n
        KfnVh/wsOCYkpttL
X-Received: by 10.84.217.218 with SMTP id d26mr2996461plj.47.1494363858544;
        Tue, 09 May 2017 14:04:18 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:2d56:76d3:6883:f04c])
        by smtp.gmail.com with ESMTPSA id r21sm1443185pfg.95.2017.05.09.14.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 May 2017 14:04:17 -0700 (PDT)
Subject: Re: [PATCH] fixup! use perl instead of sed
To:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <xmqqfuge4sak.fsf@gitster.mtv.corp.google.com>
 <20170509164515.31942-1-jonathantanmy@google.com>
 <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com>
 <4cb1d101-3efa-6376-64fd-2b9090d0b0c4@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <9353580b-d792-f3c5-a099-74eb49b867b0@google.com>
Date:   Tue, 9 May 2017 14:04:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <4cb1d101-3efa-6376-64fd-2b9090d0b0c4@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/09/2017 01:43 PM, Johannes Sixt wrote:
> Am 09.05.2017 um 19:00 schrieb Ævar Arnfjörð Bjarmason:
>> Finally, you can just use -i like you did with sed, no need for the
>> tempfile:
>
> Nope. Some implementations of perl attempt to remove the file that it
> has just opened. That doesn't work on Windows. You have to supply a
> backup file name as in `perl -i.bak ...` :-(
>
>>
>>      $ echo hibar >push
>>      $ perl -pi -e 's/([^ ])bar/$1baz/' push
>>      $ cat push
>>      hibaz
>
> -- Hannes

Thanks - sent a fixup [1] in reply to my PATCH v3 cover letter (but 
forgot to CC you).

[1] <20170509210158.17898-1-jonathantanmy@google.com>
