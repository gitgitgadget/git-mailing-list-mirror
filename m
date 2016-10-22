Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85DB61F4F8
	for <e@80x24.org>; Sat, 22 Oct 2016 09:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936529AbcJVJ3O (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 05:29:14 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36510 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935727AbcJVJ3N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 05:29:13 -0400
Received: by mail-lf0-f46.google.com with SMTP id b75so161670908lfg.3
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QvgSX1Q3BjV5pFY6/AP+MamXtBjO6b8RocMY90jybek=;
        b=AX90kpuJ+gWsfCDIIyJDpk1KTDfMA/cOaVRlaeAvCOEmfLvXYhAHGP/bObuiWDuMZb
         CVTmIVxFtaRHwg3G4bLMomW6WbNnkIRIAMUfBTQnzojdu8OHzV3apV5EWZlmhSlpouWz
         vWSzEuMRSzRZr2CdHahtqfp9OF+/NhYtCmLdsM3bP4u6qirGEiiRrZt+jnRfANAV2lK5
         +UxK9ZWe+V1CKsQzuo+8NMV2ZdKJafmMDzu6Wlpmwmq2YQMm8mnKKFGi0G1YOSwtKyMJ
         PUxTRnkINQlzUGkSyAoO3weJRGISotwYI0S0taopEScRimdDMxdEf5az7m0aWdjovoAV
         BPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QvgSX1Q3BjV5pFY6/AP+MamXtBjO6b8RocMY90jybek=;
        b=eciQipZ18mtMQb5ygNQzzl0crQTKMMt9WumqQS9mGorBPnqzFVapXNyfSkSrdSaLUY
         lliCG5PBGFDZrJxXIHs6E6KE/rvjbAie/cEZIrOiaPDHWU/Uq8fFhETJ0TXtWavsyLfI
         ue7/WRk7nmYSElwJcXufgf/p4UazlUhFbk8N7MLuhu0kqRYhUQk4hKBLs3NYJntnrKcb
         YJESlyexpEk0R45VQBhcxbUd5cJ9rHnPp+fod9iGhIqW/Pl23wjqPeDydrWT2t5XKEtK
         pJSdBVfEIAtFercmtvrKEVZUnuajJ3N1E4NIxwbeD+cyA+cnAA9XDIXAxunOvmB5CfdW
         QrBQ==
X-Gm-Message-State: ABUngveTWxI9BVKibvyLUbVk+XUmKgUtWi3KGxlx7DhesBLtfUEkITbQugV0ii8Cl2lztsBlzSjvR8T8S5myVA==
X-Received: by 10.25.24.39 with SMTP id o39mr2227399lfi.151.1477128551196;
 Sat, 22 Oct 2016 02:29:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 22 Oct 2016 02:29:10 -0700 (PDT)
In-Reply-To: <xmqqr37aej26.fsf@gitster.mtv.corp.google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476998988.git.jonathantanmy@google.com> <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
 <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
 <xmqqvawmekhk.fsf@gitster.mtv.corp.google.com> <22e4b88b-5273-99c9-bcb3-0748c17a7229@google.com>
 <xmqqr37aej26.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 22 Oct 2016 11:29:10 +0200
Message-ID: <CAP8UFD1eVgWvMsYvb-aBaM9Soox3PsuzC7_-fS3K4+mbNe6=vA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 12:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> If we do that, there is also the necessity of creating a string that
>> combines the separators and '=' (I guess '\n' is not necessary now,
>> since all the lines are null terminated). I'm OK either way.
>>
>> (We could cache that string, although I would think that if we did
>> that, we might as well write the loop manually, like in this patch.)
>
> I wonder if there is a legit reason to look for '=' in the first
> place.  "Signed-off-by= Jonathan Tan <jt@my.home>" does not look
> like a valid trailer line to me.
>
> Isn't that a remnant of lazy coding in the original that tried to
> share a single parser for contents and command line options or
> something?

I think the relevant discussion was this one:

https://public-inbox.org/git/20140915.080429.1739849931027469667.chriscool@tuxfamily.org/
