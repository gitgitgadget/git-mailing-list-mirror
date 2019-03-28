Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38EC920248
	for <e@80x24.org>; Thu, 28 Mar 2019 13:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfC1NiZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 09:38:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43391 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfC1NiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 09:38:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id d26so17213102ede.10
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EiV9dff7Trz/otgJ9rmqmp3DBNNzZ5dB//TFxjbU33A=;
        b=vKWv00xNPJQ3ALmgQ3qRd3OPd2Nu0pOtJOtI+78pL++Ix2BwMfYCHYQF0C9J2R6yKI
         zuRrbORsoVZ3Jyt5oombd7tlAlr4Dqb8U+Zo9+k77ZzppkGEIbjGoJJcelD5yuCzURXV
         cq2iPIt85bmv3RAfHnB7rjPHFkLp1kBVS/K+JJ6fGhdIixGHXq3Kt2tEsN8QDMhMbfbd
         zdAo5hR+hC6Kkl5Nnex9Qtbi8KDE0Gmdx2UB7OplmHow4BZ47sTDjRrC790TF0ETUfHw
         oSlBJgP9bgWD9BWnxxDzZbIymkL/UXfXG9adct3l2wO7vMZi/6ZTKxEBOrP1G1dxrakR
         yYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EiV9dff7Trz/otgJ9rmqmp3DBNNzZ5dB//TFxjbU33A=;
        b=jErjmURSQACApVMs7h41VhChMYkT7+tFk9R3l8THmmaQynYr1YLLF5K5RuSwYwTB80
         ZFxVMulRKHxnkhAspo85nz7EIO4ha9FqVCh1qMsjXt27CHvcKkCUTn9/05uyj4l+OPQM
         jHOPe415wOn7s+77W/kxhgwl+4L0scbSNIKiU+UhL9xHU2LnU0cqMmZstFKn/HmKOz3w
         eMMa2LZ+p4MXTijgPIAK27NWZcNUmzzfqGiBxvT8njsPFQAx80SgrbU/u9T1Et50Kzdv
         boJb+Ia0LKeanrK/Pxu8wKrkX4s7N/9Ug69RFJ5fVx9EbmjFkkCaPgI0M+8gORwJuP2M
         Obdg==
X-Gm-Message-State: APjAAAWlocRxhT2OJzf9d6XaXdXt0CvIuipgdg8kjypbyCv5lGEQNBR7
        fBhMxp5N+KnDm2X1QQVyl1E=
X-Google-Smtp-Source: APXvYqwlvSwqSPD4+vd1Hk5MQrwfN/jcIwcWjxSN83ozgdY9aTA1y2YgRYbqkgvOKMDE3Pbwcy4zdQ==
X-Received: by 2002:a50:eac9:: with SMTP id u9mr17972918edp.159.1553780302802;
        Thu, 28 Mar 2019 06:38:22 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id bs21sm5158564ejb.11.2019.03.28.06.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:38:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victor <__vic@ngs.ru>
Cc:     git@vger.kernel.org
Subject: Re: Strange behaviour of git log --follow
References: <web-54136765@mx30.intranet.ru> <87zhpf9m10.fsf@evledraar.gmail.com> <web-54137705@mx30.intranet.ru>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <web-54137705@mx30.intranet.ru>
Date:   Thu, 28 Mar 2019 14:38:20 +0100
Message-ID: <87y34z9l0z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 28 2019, Victor wrote:

> Any plans to fix this?

No. I just thought I'd peek at it for a sec, sorry. Maybe someone else
is interested it poking it some more.

> On Thu, 28 Mar 2019 14:16:43 +0100
>  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>>
>> On Thu, Mar 28 2019, Victor wrote:
>>
>>> Hello.
>>>
>>> $ git log include/__vic/mutex.h
>>> commit 9429293f8f8fb0819c77cf1f723567f6edc8fb6a
>>> Merge: 96dd9a2 f484f4e
>>> Author: __vic <__vic@ngs.ru>
>>> Date: 2017-12-13 10:41:32 +0300
>>>
>>>     Merge branch 'generic' into posix
>>>
>>> commit f484f4e8aae32041ba56bdce12d1efd8491e94d5
>>> Merge: 86b848a b9bbbe6
>>> Author: __vic <__vic@ngs.ru>
>>> Date: 2017-12-12 17:35:10 +0300
>>>
>>>     waitable_event, thread, mutex
>>> $ git log --follow include/__vic/mutex.h
>>> $
>>>
>>> Why --follow makes git produce truncated history for file that
>>> wasn't
>>> renamed?
>>>
>>> My repository is available here
>>> https://github.com/2underscores-vic/__vic
>>
>> I just briefly looked at this. It's because all changes to the
>> relevant
>> file are in merge commits. If you run the "log" with "--stat" you'll
>> see
>> no output.
>>
>> Something in the --follow machinery takes the same shortcut on
>> merges
>> and doesn't consider them.
