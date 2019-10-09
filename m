Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972561F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 19:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJITwI (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 15:52:08 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:40901 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJITwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 15:52:08 -0400
Received: by mail-pl1-f169.google.com with SMTP id d22so1557760pll.7
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e1KmAnb0Ep+OvUe7HOoQgb0yyFpaJU7Vy4DbXMbZTRk=;
        b=jIMxH3hTmZ1SpJjqvvrADThWocSN9vQKxbRI6wgRCpur9Qz26JAQguJWMqyYaGWN7L
         BUR6U1LomosRFTOplr53EMJRgaw06peswgOLMNzxwtq1htAJj5gCwkiOqZmnGNS+uctl
         GPoZdbQGXQUuAIcHpzoQoXKdHfJ+62J/dApnDUobbPgk2Zr6A71UbW5PKj5VvuUBpOfs
         I4EVg8w8WaaOh/wFWYadxiViFh5Js/k1QP9PlYd0HLvUoc661++zshqz83rnN5fOwvBS
         4ZQqEGTBULX9RSj0JRuP/Kd2cyMVBNMPlneIo7LNE9Ok/DDIBZgfDt4Ut6T/wckPE3rz
         3U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e1KmAnb0Ep+OvUe7HOoQgb0yyFpaJU7Vy4DbXMbZTRk=;
        b=d9ETWQhtnc4cwm0kwU4UcACBJKhNpZBEuRkjuWgRzKIq6ZKlZ0A9NDBQWUAvRYMuS2
         07m9HoEYQW0Guw/z63ykraPVQDYHm6vPtifCl6Ws/OQVgdN1EGL1AQ+lurnFm+Gh57BO
         DGUjaFBTAeNfMdvpyglVIfUfOLSIoRwk/3KAFElzGwsqL20GIM6fHUvXcbnR5q8W6KhY
         Mg9IJtLzQSpa8DXtD1IU8NHKZUAJvmF8GrPYj83Dbyz+9ITFmq7Safl3SGxxm451Mt3m
         G8id6lD8SfhBBim0L8Ae6nuxY+zvlActrixUtplF5Ty54h5gPQBgpPlYMFit5tz8kxtJ
         P9PQ==
X-Gm-Message-State: APjAAAWcVlqTmhATTaYyqGPXd3IOfa6KZFV0Imw1QqBEqytGQ2lSYdwd
        i9nEiXBhlRwYaI6ITYIKOXv75KjE
X-Google-Smtp-Source: APXvYqyyZFXMtFccRy5FV07RxGmw2J7V+DnrSk2BpTMQeqDuiqad3iMW2p3EWU48iTv6HM8KuPLgIg==
X-Received: by 2002:a17:902:a58b:: with SMTP id az11mr5080765plb.1.1570650727749;
        Wed, 09 Oct 2019 12:52:07 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:7:35d9:1017:4e5f:d2fc])
        by smtp.gmail.com with ESMTPSA id g202sm4259536pfb.155.2019.10.09.12.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 12:52:06 -0700 (PDT)
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru
 cracks
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <a1bc8d82-65da-316a-4e34-196a7b10b3c1@gmail.com>
Date:   Wed, 9 Oct 2019 12:52:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/19 5:14 PM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> In other words, the commit message can be augmented by this:
>>
>> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Acked-by: Derrick Stolee <stolee@gmail.com>
>> Acked-by: Garima Singh <garimasigit@gmail.com>
>> Acked-by: Jonathan Tan <jonathantanmy@google.com>
>> Acked-by: Thomas Gummerer <t.gummerer@gmail.com>
>> Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
>> Acked-by: Elijah Newren <newren@gmail.com>
>>
>> Junio, would you mind picking it up, please?
> 
> I trust you enough that I won't go back to the cited messages to
> double check that these acks are real, but I'd still wait for a few
> days for people who expressed their Acks but your scan missed, or
> those who wanted to give their Acks but forgot to do so, to raise
> their hands on this thread.
> 

This looks good to me as well:

Acked-by: William Baker <williamtbakeremail@gmail.com>

Thanks,
William
