Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207E61F461
	for <e@80x24.org>; Sat, 11 May 2019 13:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfEKNIM (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 09:08:12 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:37129 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfEKNIM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 09:08:12 -0400
Received: by mail-pf1-f174.google.com with SMTP id g3so4700332pfi.4
        for <git@vger.kernel.org>; Sat, 11 May 2019 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ybeSLghUeZDSHL7bmTOyYYwqAN3xNlzY33NlZURj+zc=;
        b=JlM2MKKk8FlwnUNH2KCbCo7pxEJ8M/I8qMT+vxjVkKmrlHBBi+w9vrlgVXbthITHin
         V6rDhKoNOsaMi00MYIPPmQR45OT7vZgkP3MveIH7RzsCztSUOGdC+3X25vrB6mck4hE1
         weD7IKO1BIZ5JmM1qxr/1NMN8U1pjCVtVHZkPNyX1FC/Ixhsj21u50enKt7V4fBzmZD4
         RUs6cYWgt6reznpLCQuVyiqBMOLBNM+NXk/nSZuHF9Uw7Lcle++QyPh1IV6rAgGT5SYK
         GkVlevU+VPP/lwVcagGhLqcppM4I2pdgT65xo846thq6Aa2liAvET60LNRKumnKX1/+F
         H8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ybeSLghUeZDSHL7bmTOyYYwqAN3xNlzY33NlZURj+zc=;
        b=qYZ2VNWcritcjzj2ET0xYEt53wcEirg37NaSLq/BOxuNABlj7mYbesflYrs8XZwt20
         HK7JEkQyr3SIyAfYWFcXdC4GxmOBHenmm0cRWnIPCKmsPATdIossLaiYixWpmtvmAfDL
         F2DpgF/IFmKC08cMy4ddR0bZFaQA8Z6upOZajMqZtrsYkvr8rDuWofUujj6df7BzF/Fz
         Na8m6ILZQk9XMtWuw+j2nApEcUxgiircTfldxe/ZffJGHgodU4EgQZolJQ7aNK9kQZaL
         zzI7ji8h1IDYWAQH3FUYMPHZiyYM2K+3pFDyMk+O7NLPEeombPVGgBdVSxhxl1dOnWj6
         mc+w==
X-Gm-Message-State: APjAAAV7i/zrB4UH6anQ68uyXwfzgw+TT6SVJyN2pf9c7BPb9YspqFpr
        F490/fwrz3W9V/FFKRlzpGE=
X-Google-Smtp-Source: APXvYqw/VwQcZq5UKfHViYTVH2lBf5z3WiZ2EfncZ5e2buNEQkz2CaSAHwGCZspzhmXRMmN2r06cFQ==
X-Received: by 2002:a63:360e:: with SMTP id d14mr15873623pga.188.1557580091407;
        Sat, 11 May 2019 06:08:11 -0700 (PDT)
Received: from ?IPv6:2406:7400:bb:59c2:f0e0:62b8:91d2:79fa? ([2406:7400:bb:59c2:f0e0:62b8:91d2:79fa])
        by smtp.gmail.com with ESMTPSA id r11sm15377158pgb.31.2019.05.11.06.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 06:08:10 -0700 (PDT)
Subject: Re: GSoC students and mentors 2019
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
References: <20190508171941.GC2068@hank.intra.tgummerer.com>
From:   "Kaartic.Sivaraam" <kaartic.sivaraam@gmail.com>
Message-ID: <fd9b5a9d-9f29-b18e-4c68-e37120df45f1@gmail.com>
Date:   Sat, 11 May 2019 18:38:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508171941.GC2068@hank.intra.tgummerer.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit and Matheus,

Congrats both for getting selected to contribute to the Git project. 
Hope to see your contributions improve usability of Git in the upcoming 
version :-)

Wishing you the best on completing your projects!


-- 
Sivaraam

QUOTE:

"The reasonable man adapts himself to the conditions that surround him...
  The unreasonable man adapts surrounding conditions to himself...
  All progress depends on the unreasonable man."

	- George Bernard Shaw

