Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D004B1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeADTZ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:25:26 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:44165 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeADTZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:25:25 -0500
Received: by mail-ot0-f178.google.com with SMTP id g59so2169302otg.11
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 11:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H3CROAITyoHBoNahNcRB8uiJgEP5M4Xagyd029Zokss=;
        b=QqSFbrmA9hUxuN9tWNKr/ejgIN6IYa1I4uKlMMWIt/UC09BZ2Op42dbta/VIHYu367
         PeT6Vyxa1VbeVkQLX0o44BDFkXDrbqwb3IIYTZqwLzufpZBuFv139r5gTXGIEGyAo3bi
         wuVAaDqpltRvfXe+fYu34UzpXAQMWtFISQy5E65+4mRKXBeg4/ZbDQ8LZNW4uT7LQCKu
         Ma81+HNhbUPEsBV34P+Mm0phfs2LSmy7Lmwqn5wOTq7cxv5+f34UMuJJZBbznepX1WJn
         BtOMEv+ZX09rggU7u2C70RnRUWQKI2tc21pebiJPp9dO6O8aR1/o/EmVCOUYgVOaulFV
         V2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H3CROAITyoHBoNahNcRB8uiJgEP5M4Xagyd029Zokss=;
        b=A8TAkBfL3LIvelbQHSFqCzLQmKNDuFPPW4WmC+EgPItAooiLuwapPrGUukRZNxzVl4
         spASJNx1+YKMrufKLmTtORs2xQYJUJcOevXqiFWahLmwAK9lO0fRnVTd5SwkxMA8MHyh
         +P/WWdQOLzKzoZa+2LCvUMgTDmhPPCFaFW2FfPIJ1lmd2EyXvMlRgYA+1ij25qf2NHUB
         ZogAB9TNh0cU/sezeqBpqfqCT5pvIc8AJFcjgcS1H7lwsGc5++834G/rpD9M3UUL3hYZ
         J8+mB1ParF61DkS1etWGjUTEHjf45dU/6Ab14+0BgfPms7GCqfC14NOyI+Py4nk5n4TM
         axuw==
X-Gm-Message-State: AKwxyteZGm9rprmaewfx7L/0c5bReg6VA1NI49YgtQVKne6Rqe2y2urq
        CBExyiECcQckAutO6rp/atWMcwEc66+apqpkCe/F5w==
X-Google-Smtp-Source: ACJfBovQjCgICuUeueklN0OX0/SPgsOYLb8vjoWrP5EUIxcm4Dteh6/MxGkCQJFeN/BJ9a319EMdwHbINF8Bk9JlDFk=
X-Received: by 10.157.4.98 with SMTP id 89mr408554otc.313.1515093924924; Thu,
 04 Jan 2018 11:25:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.73.21 with HTTP; Thu, 4 Jan 2018 11:25:04 -0800 (PST)
In-Reply-To: <xmqqefn5fo5d.fsf@gitster.mtv.corp.google.com>
References: <9e4ffb63-59de-a020-fee8-6cefae3b3dda@gmail.com>
 <CAJs94Eakp6kaD=+imH2cZdB-=2NCBJNu0Rt=MmRtWiM60QGBSA@mail.gmail.com>
 <p2l6s0$eot$1@blaine.gmane.org> <xmqqefn5fo5d.fsf@gitster.mtv.corp.google.com>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Thu, 4 Jan 2018 22:25:04 +0300
Message-ID: <CAJs94EbtnCcKiYO9sSqhOwtkSCsApRJoSzVEA7_N23wXGhwoww@mail.gmail.com>
Subject: Re: Fwd: Unknown option for merge-recursive: -X'diff-algorithm=patience'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-04 21:57 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> "Matwey V. Kornilov" <matwey.kornilov@gmail.com> writes:
>
>> It seems there is some issue with double escaping:
>> ...
>>> # git rebase --preserve-merges -s recursive -Xdiff-algorithm=patience
>>> --onto abc-3.8 v3.8 abc-3.9
>>>
>>> And then I see:
>>>
>>> fatal: Unknown option for merge-recursive: -X'diff-algorithm=patience'
>
> The string looks like a result of a shell script that quotes any
> end-user controlled string before incorporating into a string to be
> eval-ed, or something like that.  Is this a recent regression?  Does
> a bit older version of Git, like 2.12 or older, behave differently?
>

I've just checked, 2.12.4 has the same behaviour. By the way, can you
reproduce this at all?

-- 
With best regards,
Matwey V. Kornilov
