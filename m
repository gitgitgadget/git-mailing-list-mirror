Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637EA1FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 08:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932083AbdDRIlb (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 04:41:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35780 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbdDRIlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 04:41:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id d79so13266653wmi.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Srt0zD2IneDqapX8zqiejCRQlKgYJq4hxQrjl6Sv650=;
        b=he58yLy0opWbS2sPBF997WfA5zzKe/s2p/2KzXuxrMsn4ixxzFq28eUVL3CEr7Z2MN
         P7ZQsxvmsybeeHr9wokda86q5GErRS7g3hw2+J9e8537T6PCXwWKETA3OagmkVEmW+jQ
         BSpaQTES7Vmpk1UijSKa/eOjyrRV7XGkhKvMhbl9uBl+VIKL1O/ToOb8IJXTCrKr/bPu
         k1AdERiJq1AyBpif7IsWmD61bt3bUiGlusXmx6NuZNlIUfmtgevrIlDWUK6MaGA7gF4P
         v1qi2JY+O8qoI0YkWBY2PMMr2fa4SuqBfRiKMf+GE0Qu0u1hw+rTkhIoGshd0K4wEiPQ
         S0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Srt0zD2IneDqapX8zqiejCRQlKgYJq4hxQrjl6Sv650=;
        b=ODR3Vije6y2/sDWIHY1UUFpSgwbYpG5o4NkSYKKEVVqmf69jfKyZvT2wXeEi5FBDOt
         rtRTybs42i0rVogZL/P+jhR0xF+n8vmVdv7hy7KgTFfYxQMMXPwrrqmottj064y0u0gG
         RRZuoKvWFa1DXNT9jXz59yKep9qD+QfWHX9PFg/JYQv7a2giwHTvXB5ZMjz5s0ZPXnMY
         NRvUxRhEaHHdX0o9QcNe9tIY5Lut6zc8eHfr9hAx0U8EvcDs0SX/tsgTaoFFtnKiT0XX
         zSPwEMQHO+oARtF97nAAhNJs91sXwSs8cbtmwf5gZ9EDK6NJNIWn7rix/I/KvVDe/kig
         pd0Q==
X-Gm-Message-State: AN3rC/5z9b4yl9TqaKxhDI9pqizxEyH4baNU/KaOzedvmIcwfABBlrjV
        NnTT+eAOkO8INn4W5o833ELJ525TRw==
X-Received: by 10.28.197.135 with SMTP id v129mr12716137wmf.55.1492504872608;
 Tue, 18 Apr 2017 01:41:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.98.212 with HTTP; Tue, 18 Apr 2017 01:40:52 -0700 (PDT)
In-Reply-To: <xmqqinm2inc2.fsf@gitster.mtv.corp.google.com>
References: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
 <xmqqshl7ik21.fsf@gitster.mtv.corp.google.com> <CAOxFTczhfvzhrSiCj7SgLXbO3hrBW_QaDVZMpOqrij_hCJyCzg@mail.gmail.com>
 <xmqqinm2inc2.fsf@gitster.mtv.corp.google.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Tue, 18 Apr 2017 10:40:52 +0200
Message-ID: <CAOxFTcyv_o8Gbjj-R0g6eK-i1QDZUA9okwq=7Yb4iW3n=kF-mQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] rebase --signoff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 2:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>>>  - How does this interact with "git rebase -i" and other modes of
>>>    operation?
>>
>> A better question would maybe be how do we want this to interact?
>
> If "git rebase -i/-m --signoff" will not do anything (which I
> suspect is what we have here), we at least would want it to be
> documented, or the combination be made to error out, I would think.
>
> A better question can wait until that happens ;-)

I've been looking into adding signoff support to the rest of
git-rebase, but the thing is far less trivial to do than I initially
imagined, since the interactive part is split across a number of
sections and files, including C helpers and the sequencer itself. It
can _probably_ be done, but building tests for all corner cases is
quite the daunting task. I think that for the moment I'll resubmit
with the Documentation fix to declare it non-interactive only, and
then leave the extended for later.

-- 
Giuseppe "Oblomov" Bilotta
