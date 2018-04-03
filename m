Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18C221F424
	for <e@80x24.org>; Tue,  3 Apr 2018 08:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755139AbeDCIhe (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 04:37:34 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:46954 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754985AbeDCIhd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 04:37:33 -0400
Received: by mail-pl0-f54.google.com with SMTP id 59-v6so5192825plc.13
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qAtg7HNgPpfTcZXAQ87Ov9pIKwgOkFapyxEuJsqMMhg=;
        b=gQwdFEA8R66JGt899dSjmT5PPrfKfudNfyhm/8KlRao4DyBsrzsusl6koLgnXIZK+P
         t1dFaKo/1XNMgy/unuhgWklTkTkuUVDoCv6LAhiPkcBNInj29oY7MvQQGHFCiqRE4a4y
         5YGEpc+W4cGoecLhrrl7jPozjjOKZZl+a9U7sTR96qMDVo6JgcaRP2ZC9PjqF3Jcdmbf
         i7wYyTQNkCFHn9f2MOqSx7F5IGgGpDS3BZfdEZE4xYCA6uHhrxMKzmFvGDLP96dNiXBS
         Ko0Oop6yQAZ73lmLHMU0958Bq9Le1nxRc3+7mz53krZwh34cSG+DJoEaSSINZK7XSuKx
         opdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qAtg7HNgPpfTcZXAQ87Ov9pIKwgOkFapyxEuJsqMMhg=;
        b=uCzwi9KxqijQYFwx73xNw/LNjYOhsUW3OAGbK+73AbVz5z/bGsCEHt+tqThR4ouDtB
         7ZbuSNma8RcFtydphP3Cw+7q8yNqQEfNMbHeGDQ78+YvEg1UWXxzXvAvKcxpOdnaj7gE
         8ew6nfKiPJlhKflgY3BkB4SviMVwDZV49me6o9LgQ0erUvpTTigcwRNUvDES3p7F3KAs
         KF4PXQRarjQFo60mkSAvBXJ9aaOmJMec9E4aaJxXa6izv3ANZT7Nl2Qys5RWX779mREW
         F4tnkp4ZlhcTfeKrAq4k5tUsp7qpiNhFCvHMYXtnwCP7Ml6/sP/26HgppLvyhneF2TbC
         z3DQ==
X-Gm-Message-State: AElRT7GwGrEk9fBhe48iBpWPpG5uzneqz5RFozapdvefc62o9uTyFFAs
        AfxMa5ocP/gAOSh2FhSbVmnVCPDj
X-Google-Smtp-Source: AIpwx4+U+HlQf2tE8PsTjjtELOYiFfwd9whMS/JMa6/Fy3umrPxcZN4WAP2Iwt+MTSbisWQfe4ijsA==
X-Received: by 2002:a17:902:8f8c:: with SMTP id z12-v6mr13370576plo.400.1522744652792;
        Tue, 03 Apr 2018 01:37:32 -0700 (PDT)
Received: from remr90p0m4e.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id a67sm3692425pgc.6.2018.04.03.01.37.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Apr 2018 01:37:32 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v12 00/10] convert: add support for different encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <3DC6237B-002F-4CAE-AD57-E10A5B5D3D3C@gmail.com>
Date:   Tue, 3 Apr 2018 10:37:21 +0200
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <7DE7FA3C-C2C9-491D-B51B-5E0C102C8261@gmail.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com> <xmqqwoxu684c.fsf@gitster-ct.c.googlers.com> <3DC6237B-002F-4CAE-AD57-E10A5B5D3D3C@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 Apr 2018, at 20:31, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
> 
>> On 29 Mar 2018, at 20:37, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> lars.schneider@autodesk.com writes:
>> 
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> Patches 1-6,9 are preparation and helper functions. Patch 4 is new.
>>> Patch 7,8,10 are the actual change.
>>> 
>>> This series depends on Torsten's 8462ff43e4 (convert_to_git():
>>> safe_crlf/checksafe becomes int conv_flags, 2018-01-13) which is
>>> already in master.
>> 
>> I didn't see any further review comments on this round, and as far
>> as I can tell from my reading, these patches looked more-or-less
>> ready.  
>> 
>> Except for 04/10 that had a few messages around "who should be
>> responsible for handling the 'NULL is for the default UTF-8'?", that
>> is.
>> 
>> So, what's the doneness of this thing?
> 
> Almost. I'll send a new round tomorrow. I hope to make this the final
> round.

@Junio: Can you remind me of your preference? Should I rebase my
series to 2.17.0 or keep the base to make it easier for you to 
check the interdiff?

Thanks,
Lars
