Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958751F454
	for <e@80x24.org>; Fri,  8 Nov 2019 15:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfKHPmG (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 10:42:06 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:39709 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfKHPmG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 10:42:06 -0500
Received: by mail-wm1-f51.google.com with SMTP id t26so6672156wmi.4
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 07:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=niemier-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GvOI4HJEedNOd8Rj6/g8BaOoaVaQAIC1ZcW2VtFYiE0=;
        b=n7G/Y0JPClDW4JZEIUTLM5awNxQmsGZfJ2fBE0ngr5QnAsSAcwzy2TkmA0QGd9YnJt
         sQWl6z80I0QOwjJV2F4bixC6VdBaGyM0isgIq2L1+rk2lIP6ADrk+uR1PvSZVu6YQqL1
         ELMs2o+o0eHrldkV5FjLsZnF7wsB/4rMtWMDM4pMYvGmzLG8PciSlbsGRwMekex/TjBv
         eSLw3grPeGmV6vshtCg3vssRRu3xXsZLYRW2Uri7gXtITxc6MhXKpZEFu5xU8N+HqSs6
         fPceNss2l4dbm9V5uvC9nqQaWHkEp4JsuQgoWbPcFUfdLAuKPX2WQR4BDdyiGInAkqLw
         AazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GvOI4HJEedNOd8Rj6/g8BaOoaVaQAIC1ZcW2VtFYiE0=;
        b=D5ahbzo/qP//bQlihLe6RMd0TPSqtBjGpXcMiF4F2krodjlzDUkdJ7vV1Yz3FWMCuf
         Oy0l8JY8B9LaNge/UIZQI4sJn/VCd1Nk1CpSxRuwTZR7HHRbBzUE4RyIJeoJPBt1lk6v
         vYeHqiYhruCTN3XBeRV5xKpuzonvmAKPpTOwrkqke5pVfl8zT9mMeiIIyL3zr3L2X2Q+
         K8CFR7IdxhCth+HzhzOX3aSIj3BWd4M1rUN26+7NVXqBX7HpjT1CEeIMg/EDcpNvB4BM
         8/aQvxXp3nBd/aoMvIhMAvY5pRcC/aYvjQDjGHuilQc9ySDNybeSQMankDRZ+KLN0xJj
         QyNA==
X-Gm-Message-State: APjAAAX5RqVcHxcn8tC200P68NCBUeTUMpDkMO5El0uZhPeZ4yKk6vpA
        RijHi8/3udA/1BNe3SWmslaWQo+AQOfJVg==
X-Google-Smtp-Source: APXvYqxWsn5QGNKKq7hPSJstH9AmVInRWoKjaSXy5iNNU3rDp0E4LohgRbWSS6/r7qh9s8g6DItnwA==
X-Received: by 2002:a1c:a556:: with SMTP id o83mr8521731wme.165.1573227722567;
        Fri, 08 Nov 2019 07:42:02 -0800 (PST)
Received: from [192.168.188.32] (83.25.107.61.ipv4.supernova.orange.pl. [83.25.107.61])
        by smtp.gmail.com with ESMTPSA id x9sm6015997wru.32.2019.11.08.07.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 07:42:01 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] userdiff: add Elixir to supported userdiff languages
From:   =?utf-8?Q?=C5=81ukasz_Niemier?= <lukasz@niemier.pl>
In-Reply-To: <f85a5c31-52ff-85be-b1e0-f3982fd2a7f2@kdbg.org>
Date:   Fri, 8 Nov 2019 16:42:00 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <86417D50-2C28-477A-BC49-9097A24A3BF3@niemier.pl>
References: <20191106234941.48926-1-lukasz@niemier.pl>
 <f85a5c31-52ff-85be-b1e0-f3982fd2a7f2@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Please keep the Cc list when you send new patch versions. Also, it is
> customary to send them as replies to the earlier iterations, so that
> they all end up in the same thread.

Sorry, I am still learning how to use git send-email and I thought it =
would be handled automatically.
I need to find how to operate it properly and how to configure it to =
reply in thread instead of
creating new one.

> There are no single- and double-quote anymore. An oversight? Or an =
error
> in the earlier iteration?

No, I intentionally left them out, as :=E2=80=99foo bar=E2=80=99 is =
allowed atom, and I didn=E2=80=99t want to complicate
everything word regex. Instead I assumed that these are so rare, that it =
should not be a problem.

> The leading optional sign may be problematic. When a patch changes =
"i+1"
> to "i+2", it would be highlighted as "i{-+1-}{++2+}" instead of as
> "i+{-1-}{+2+}". You could remove the leading optional sign and let it =
be
> processed as an operator. But we also have an optional sign in the cpp
> pattern as well, and haven't noticed it until now, so=E2=80=A6

I copied this pattern from other languages, so I assumed that this is =
what is expected.
It could be fixed, but I think it should be handled in separate patch.

--

=C5=81ukasz Niemier
lukasz@niemier.pl





