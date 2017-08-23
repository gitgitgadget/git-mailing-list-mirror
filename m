Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069321F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 22:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbdHWWj1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 18:39:27 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35957 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdHWWj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 18:39:26 -0400
Received: by mail-yw0-f171.google.com with SMTP id y64so8953888ywf.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kjVjH6lEQ45XCIJS7v6sEAmpJFogPezofhb1sCUJfDQ=;
        b=eoy5or0XCGqc0uJecHLl3tjs6lJBhWItGCzWCICT4baXhgybpWIgNl8CvvqSQLBvaj
         W5DOGHBWI5Hqe4bx5eUMgd7ojxTEpu2Bfh9qzmxR4sWHy+jhnKeIRuHU1lgScR9QXN7X
         VD/4S8zfMLLrndtVAfmB6B/p5BAcs3B4uyX8ugPNFEgyVOBmA8tUU1uYmrCud0sZ5So3
         k6y3obgmXl2RhpZ8ImREN1FMSFcEVZl3fcMofJz1WL/vdqd8PzIRFROsVqt7ZxtacfTT
         +ErNU3KdsAT5devuNefunrV4LTBDEBQ9QxtcXc4YgI/GCDDZczUEDfKsPeC+BUv2uhB8
         yJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kjVjH6lEQ45XCIJS7v6sEAmpJFogPezofhb1sCUJfDQ=;
        b=kK0EDGehjg1Ar+YXwAnHEmbQ/vkj1DstKUE9qNZOGJdzWnvTVpOaxL01IdBLsf/EDK
         M2aZN+bGgswFune/CLg9qhfdNrThCYURXrjheT3QptGPpY+1lMvgxoBsLM7DXdfHXV2I
         wCtwb32GJIxkThs5kvxkRtY56D+el9COft/KdJaQQdwGgYgXzu83W6ipWB5rV2dsGuzu
         Y+h/yUpIRdE+njSTZg09nvvfw0q1TYaVBy1/K9KW3tkkFoU1UKNQ1FZ00NSnSil3b5VZ
         Oc+64465VUnEJnEKJWDIMnBgq6YuEWdquFZQQ2Lk5yfgQCSqxvzN8tEeRCCXPENkVfMv
         EyTg==
X-Gm-Message-State: AHYfb5jHZxkhi4EyrrjA3Pr0UnTYVFiPxLoIXA79GARbVxKKU5oMF528
        W9AWv1Ou8os2vpGq732BflfwVTGjRQ==
X-Received: by 10.37.188.13 with SMTP id i13mr3632982ybh.103.1503527966039;
 Wed, 23 Aug 2017 15:39:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.153.133 with HTTP; Wed, 23 Aug 2017 15:39:25 -0700 (PDT)
In-Reply-To: <xmqq378hylbd.fsf@gitster.mtv.corp.google.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
 <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
 <CA+sFfMdXv+nqpXmwfLTHtkRLuGkAEAwWXZCvOryVZ=aLb_UmbA@mail.gmail.com>
 <xmqqh8wyxag1.fsf@gitster.mtv.corp.google.com> <CA+sFfMe56itAMDXOJybf0yHj+BqU1Ai1aU7inoTG3FJtdtZxyw@mail.gmail.com>
 <xmqq378hylbd.fsf@gitster.mtv.corp.google.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 23 Aug 2017 15:39:25 -0700
Message-ID: <CA+sFfMdvOcXd_ePyqyiCXL9O6xpYxxn+iKw6NRJCYsiCFK_ADA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 3:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> On Wed, Aug 23, 2017 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Brandon Casey <drafnel@gmail.com> writes:
>>>
>>>> So is there any reason why didn't do something like the following in
>>>> the first place?
>>>
>>> My guess is that we didn't bother; if we cared, we would have used a
>>> single instance of const char in a read-only segment, instead of
>>> such a macro.
>>
>> I think you mean something like this:
>>
>>    const char * const strbuf_slopbuf = "";
>
> Rather, more like "const char slopbuf[1];"

You'd think that would be sufficient right?  Apparently gcc and clang
will only place a variable marked as const in the read-only section if
you initialize it with a constant too.  (gcc 4.9.2, clang 3.8.1 on
linux, clang 8.1.0 on osx)

I might have to adjust my stance on initializing global variables
moving forward :-)

-Brandon
