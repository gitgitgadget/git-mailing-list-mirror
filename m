Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3719D1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 19:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbeGXVF4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 17:05:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40165 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388597AbeGXVF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 17:05:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id t6-v6so5260909wrn.7
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/J7v3o2fX78iT6aBi3NZUoLgsHKs8Qp9rCunVkZCvZE=;
        b=tTZgpxBComYvxMBPYfM5h0SIoeoWnSXWWmCSxAg7LpEJd//ZHuA/p27a11MIdtaNNt
         b1kJehlIESrgzdaW+x/wRHI9rafqtBHdU97ymC8utxzo0Iotg2BXdsqCkWZvbLbQmz3q
         77r04D79hH1dpPJug7epHgM5N1kqEB3W+y1L68pnBVeNL5A/d7FqvZa92PNPHwqgZtbg
         ijIgqJdARdBBDFeW6pNqOZp2fcLfhXcLK+Sly/KeqFVP810tgXWALKUkjMTG7834WgOB
         BGc3ukUV0ECLIBgGGnKylGBmLk8LYDzw6u+7XluYxlwNtL1QQH13V4MY7oFt7dsk3K7b
         xeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/J7v3o2fX78iT6aBi3NZUoLgsHKs8Qp9rCunVkZCvZE=;
        b=JVLul3fpxVCsJnnqi4pZqb1kCjyr22k28FpdJ+FtLNIPKURXXea3OMqAi2POf60Vvo
         JDKR0uH7S/czcihwH5i2IgYEdEq4y9SdrMRz1SOIapJK2t1X9qEEMPT4GPKU4pM054+Y
         jREfATNaGTkI9OXIm9Zn4nM1PY3MV+znGjwCDZYks0njMxYJYZEmbhnX1RPcp5yHBCLe
         3OIfGK7+0NXjES5cidBOu+PYZyf9n18uP7zQtQYqH6jsKMZM1zvq5yTwrxkom3DKREYS
         XKzcQBa9bm5RxmvOz03tuoRFRjflffRIh/8o1H2VV7LpTq7LfZZvbEIET+6ra3EAYJgS
         ECeA==
X-Gm-Message-State: AOUpUlGd5VGHSCNsmVl4GBeDkXVO7qspz6r4ielS2ZmflAbFPJZ6VpsD
        Tn3DwuvD9J0n6FpCvBu1HL0=
X-Google-Smtp-Source: AAOMgpeAUOoMz3ytjItal5I1Por5vPZNBTI0yHTIeq39zWTIKLmu1yHXvuTYpZ8AXs7OttOzGmwUEA==
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr13616446wrb.155.1532462271752;
        Tue, 24 Jul 2018 12:57:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i14-v6sm9039684wro.11.2018.07.24.12.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:57:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] pack-protocol: mention and point to docs for protocol v2
References: <20180723174807.28903-1-bmwill@google.com>
        <20180724045233.GB208393@aiede.svl.corp.google.com>
        <20180724181913.GA225275@google.com>
Date:   Tue, 24 Jul 2018 12:57:50 -0700
In-Reply-To: <20180724181913.GA225275@google.com> (Brandon Williams's message
        of "Tue, 24 Jul 2018 11:19:13 -0700")
Message-ID: <xmqq8t60xv7l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> Not about this patch, but I wonder if an organization along the
>> following lines would make sense?
>> 
>>  1. Rename pack-protocol.txt to protocol-v1.txt.  Rename
>>     protocol-v2.txt to pack-protocol.txt.
>> 
>>  2. Make pack-protocol.txt self-contained, and remove any redundant
>>     sections from protocol-v1.txt.
>> 
>>  3. Add a new protocol-v2.txt that briefly describes the benefits and
>>     highlights of protocol v2, referring to pack-protocol.txt for
>>     details.
>> 
>> That way, newcomers of the future could read pack-protocol.txt and
>> quickly glean the main protocol in (then) current use.
>> 
>> What do you think?
>
> I dislike the idea of renaming protocol-v2.txt to pack-protocol.txt.  I
> agree that we should probably have protocol-v1 broken out into its own
> file, taking the parts from pack-protocol.txt, but what really should
> happen is that pack-protocol.txt could describe the basics of the wire
> protocol (pkt-lines, the format of the various transports, etc) and then
> refer to the protocol-v{1,2}.txt documents themselves.

WRT the naming, are we happy with the idea of (1) pretending that
when we say 'protocol', there is nothing but the on-the-wire
pkt-line protocol (i.e. that is why we call "protocol-v2" without
giving any other adjective---are we sure we won't have need for any
other kind of protocol?) and (2) tying the "pack" ness to the name of
on-the-wire pkt-line protocol (i.e. that is where the name of the
original pack-protocol.txt came from, as it started only for the
packfile transfer---are we happy to keep newer protocols tied to
"pack" the same way)?
