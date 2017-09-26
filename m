Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C40E20281
	for <e@80x24.org>; Tue, 26 Sep 2017 19:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030413AbdIZTdU (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 15:33:20 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:43294 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030327AbdIZTdS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 15:33:18 -0400
Received: by mail-lf0-f46.google.com with SMTP id c80so5584482lfh.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=91zi8nSJfScLqGpeX5mI6FBNnZwpizi7nOqFsyhTcSU=;
        b=fpuMFU1nPNRUnE0jJI2O1wnkjW9Vg7aMWwzumh52vk397oR0ubwCgL3BY5GU7sOwwF
         +TxyyZcNdvJbTyDdYpGKBST/xiTI8xzYenMo/M1pRlu/hTzvDE72pKbK9rr/yye7aBxf
         cEyq2nAlK7IBdNdAQDjAGDav8dXMmpm6txWlAvknFeonoFc2rdon7ALSmOMnr813+mpt
         2jCQqZvU+ogIDgwqC4oDuFfcllFnxW/caKw68TTdh9VtNwkaRNzhuI1D3BvpcCkfWbi4
         x0nnhzfsC5SFO3qEBfbhVQAlSQjH9j40Lqiq+MgRfUBOIbEhh4FDQ/MWYSEuTd6+QVZE
         QvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=91zi8nSJfScLqGpeX5mI6FBNnZwpizi7nOqFsyhTcSU=;
        b=cw+NdzvH8KlCR0haucBiiqNoHuaZvogTxvopydSWsEzs8OD1Vu6+JbWFdI4UMgsx6I
         UYgo8MtA6qsPNZ6/IM+6vWz6hMW9Rew9dk2twuJqtGopk+1CKitzhFt1qkp+BIhMNivl
         irjK3zaIRX4fdk8cTG6RNDEijP2/D+eiwQ9wuO9KTOnVGNlLmeG42Y1t149M4udBmVWD
         Oz63YDukx3NUmyNWOA4EJesr81Ns2mOeCLBnyJdWTmCIxxdGT5cA3sdV4nKgFDH7Pldv
         qMMUWns0Y5aiPssfTOsBLt/BJlCGEw4x53HFwfRkeBopsIypQd0tBo9Hl/9dCh/GZnFw
         PNxg==
X-Gm-Message-State: AHPjjUg2SIz80z60mtfGwdwNRYEeiHNwG4uSvSklydsSsxJhE4AlpvgQ
        /3+rEYTZESlhBGV4GJE4upQ6m55kleA/dgAFHD2xHlvlgYo=
X-Google-Smtp-Source: AOwi7QC+ZeCBkDg4q310WNjnAphp7IPSxtakBM1V8mPPApkBoWc1xJR6pP0gHaNYHtrPX/7wEIsclIu/quuzswzEAbQ=
X-Received: by 10.25.59.138 with SMTP id d10mr3744556lfl.202.1506454397070;
 Tue, 26 Sep 2017 12:33:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.179.0.2 with HTTP; Tue, 26 Sep 2017 12:33:16 -0700 (PDT)
In-Reply-To: <CAP8UFD1C80cHnMtdZ-iTYQpNNErUEJ9TmQ9baG1J2w+pv1ceSw@mail.gmail.com>
References: <CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com>
 <xmqqbmm0h6h1.fsf@gitster.mtv.corp.google.com> <CAP8UFD1C80cHnMtdZ-iTYQpNNErUEJ9TmQ9baG1J2w+pv1ceSw@mail.gmail.com>
From:   Roberto Tyley <roberto.tyley@gmail.com>
Date:   Tue, 26 Sep 2017 20:33:16 +0100
Message-ID: <CAFY1edZ6FX6s+H_XWa-=nKqr4NA9BNVxR6fcOo+5gn-Z1XKdUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Teach 'run' perf script to read config files
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Roberto Tyley <robertotyley@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26 September 2017 at 16:40, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Sep 24, 2017 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> (It looks like smtp.gmail.com isn't working anymore for me, so I am
>>> trying to send this using Gmail for the cover letter and Submitgit for
>>> the patches.)
>>
>> SubmitGit may want to learn the "change the timestamps of the
>> individual patches by 1 second" trick from "git send-email" to help
>> threading (you can view inbox/comp.version-control.git/ group over
>> nntp and tell your newsreader to sort-by-date).
>
> Roberto is now in CC. I will let him answer about that.

I had a quick look at git-send-email.perl, I see the trick is the `time++` one
introduced with https://github.com/git/git/commit/a5370b16 - seems reasonable!

SubmitGit makes all emails in-reply-to the initial email, which I
think is correct behaviour,
but I can see that offsetting the times would probably give a more
reliable sorting in
a newsreader. Unfortunately the documentation for AWS Simple Email Service (SES)
says:

  "Note: Amazon SES overrides any Date header you provide with the
time that Amazon
  SES accepts the message."

http://docs.aws.amazon.com/ses/latest/DeveloperGuide/header-fields.html

...so the only way SubmitGit can offset the times is to literally
delay the sending of the emails,
which is a bit unfortunate for patchbombs more than a few dozen commits long!

I'll take a further look at this when I get a bit more free time.

Roberto
