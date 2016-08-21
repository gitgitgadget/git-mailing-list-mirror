Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7532E1FD99
	for <e@80x24.org>; Sun, 21 Aug 2016 04:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbcHUEgH (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 00:36:07 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:34777 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbcHUEgH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 00:36:07 -0400
Received: by mail-yb0-f169.google.com with SMTP id d10so27715311ybi.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2016 21:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bv+o6rZN/ty4s3Qj5vavD5P6ztkKCTSHF/dJSxIUse0=;
        b=PuAjpQS7RwcYJnBZ0/BwloNs2QkfMoLT68GEuOZTMkWAqf10OryQgjnBYMTve77Nlm
         JEfGcUefCAcWRPYM/HorNoeNZ/va1s85Pp3U4l2PrwHgvRzuJ2ksXRM6csnOtE5A5NpR
         mfJjCjz9Lq4j18q+WN0PtBcIB+ebt1qlxYdehJvmfFofrcsZmy+PExoWSZaEUMfaT4KA
         177Y2bhCexG1w+ZDPCOFX8/hyNS9t3QQS9TT9Rua8Qa/4XZQb4ibSt2urzXhv+9iZhCf
         g33/0oXk9//YxRVfq61o79JUX4//WSs71b9HIuqtoVTRwJ+wVRn6YJBA62QYVp++i57O
         i5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bv+o6rZN/ty4s3Qj5vavD5P6ztkKCTSHF/dJSxIUse0=;
        b=W3TkOcGq3nLfV1bMYg8/BecmiAayANRlsrCETVhzNDFfuju2TF/EWBvGT4KQNfKced
         kdZILQxN10mbFLtq8p4vRAH244v2R8ZZmd/ZN/jMgQzaKGuxGNvoJnISE+T9QIhKrEj5
         0iNWGqo/Xfzf2ond7yfD2H4S1w3srWs8EI4T2cnHg52p9lUh+8E/Q2HVE361aZXBeais
         Zhe2+Rn3t82OjheOQWE9M1jSWJU4dI8QdJu4kmI0/gJ7VoQD2T3QgOAm4cpZA9kHOdG/
         MNCZSZWEJivTY9es1LN7ntEIq3BVWSg2QIfd8pjlS9K9cUWK2g3B867OzL95xsRNP71b
         +0+Q==
X-Gm-Message-State: AEkoouupLAVrcAM2ET3H5HhdSGL+TgMcOV2xnQreXB+FiPIyFcXvKAKfpFnbVy7nd4yWubl4+YVQnckQN2IB8Q==
X-Received: by 10.37.60.67 with SMTP id j64mr11645964yba.111.1471754166331;
 Sat, 20 Aug 2016 21:36:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Sat, 20 Aug 2016 21:35:45 -0700 (PDT)
In-Reply-To: <CAPc5daWAvn6-Gv88WaWhnus35Bn_Twj2LH0cznwraQx11wX1yg@mail.gmail.com>
References: <xmqq4m6h69wz.fsf@gitster.mtv.corp.google.com> <CAGZ79ka3QEMUV6YYa74UZPZXQA1hnbCCZOCG9jZt1BPjJ0Kb8Q@mail.gmail.com>
 <CAPc5daWAvn6-Gv88WaWhnus35Bn_Twj2LH0cznwraQx11wX1yg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 20 Aug 2016 21:35:45 -0700
Message-ID: <CA+P7+xpE=GoFWfdzmT+k=Zku8+YjEH-aOMsFUtJJJwFHa1hKDQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #07; Thu, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Fri, Aug 19, 2016 at 4:46 PM, Stefan Beller <sbeller@google.com> wrote:
>>>
>>> * sb/submodule-clone-rr (2016-08-17) 8 commits
>>>
>>>  I spotted a last-minute bug in v5, which is not a very good sign
>>>  (it shows that nobody is reviewing).  Any more comments?
>>
>> nobody except you ;)
>
> OK, it shows that nobody competent enough to find easy bugs is reviewing ;-)
> IOW, I do not trust a review in this area done by myself alone.
> --

I can spend some time to review this soon. I hadn't had time to look.
I'm not sure how much my review can help, but it can't hurt.

Thanks,
Jake
