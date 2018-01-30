Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A3661F576
	for <e@80x24.org>; Tue, 30 Jan 2018 11:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeA3LdR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 06:33:17 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44811 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeA3LdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 06:33:16 -0500
Received: by mail-oi0-f67.google.com with SMTP id b3so4603066oib.11
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 03:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bnDhtA3V8pIiBCSGbgcopGQO5RdRflmhR2xehWfcwLU=;
        b=JiSqcD3ZckDsYaKpCCuT3tHxW7sAOOxutYZSSRx1G4SWImkDeNsW+cLzKsOXFsfREU
         WY2LLq/uZHmMwkelMZu7GOEV6Sk74e7CdCtJpL2Y/u6/dMJTYY/Xugy4U6IKNvzOA9J2
         X9lhABSoGtaib71oylwal1hcD4p1Ta8tzpH3zVveuomGUrc1mW0OCMrWOVhli1o02S3C
         LBBioDKDKgg8hBRhNqG5Qo9Fe6AB1SLK7VfDV5oDQSU7Wc1XPkzzofamVXlMgiRxa18b
         h3+xWJ06gLOY2d4Hk+33VAc4KL3H4lwBu6xTl9tRG6n3zopmpHIlkoLgqd0CZ2Xo8dCH
         vXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bnDhtA3V8pIiBCSGbgcopGQO5RdRflmhR2xehWfcwLU=;
        b=qSpmvSImO8vUF3iIXmUdVj79ZUAfTFT1U6bAv669585dTfBZTSucWZlMwhks6O0MM2
         4Pdni45WvgzD8U7HAuLfR5N0oPrXLk3iL6SZunspWFGDOOh43BjQu+gZiHDH5/bQWve7
         9A1bjuVgggjEizBBInWgetD1LNnJ4tdRNLFrxdbJ02gq0kE4PcOk24LN4KSLgL42Rhh4
         HOkN9ZPLouRrzTpVUNXaKCqYr85c6LcLK398rc6wr00HccZSdk2vg1q/F0L6Y29QctUM
         zb0OBcgnO1eMKwlGL5ogHWB90oZOhFMEDeBAHq05rVpiXPb0vHwiq3QH6NV+CjOe1uTQ
         64xQ==
X-Gm-Message-State: AKwxytcIZ576AcIFtZ5OBpgFzrFL4GIuUH4pfOgh6OlYqerZR4mDd7M0
        W0oKN3V2rHwJyOCEb7h3FB+zZjyfDbiVmPaveZk=
X-Google-Smtp-Source: AH8x225Rxuk90peTvX+0FdYApUOnAEofJKSrJa8S+Q9VvpISowlf+Yg0Xpu9YzICCSudUQa47g8mrCk7270uVknn9UQ=
X-Received: by 10.202.171.207 with SMTP id u198mr8904635oie.253.1517311995657;
 Tue, 30 Jan 2018 03:33:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 30 Jan 2018 03:32:45 -0800 (PST)
In-Reply-To: <871si7ob9z.fsf@evledraar.gmail.com>
References: <903a193c-0360-59bc-4d86-6470ac8dc1a8@bytes.nz>
 <000f01d39918$70009eb0$5001dc10$@nexbridge.com> <20180130101351.GA761@ash> <871si7ob9z.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 30 Jan 2018 18:32:45 +0700
Message-ID: <CACsJy8BOnRrP4qXvsFcLBGukL=JzDbrA3kju87_ND3u36g=RsQ@mail.gmail.com>
Subject: Re: Missing ? wildcard character in gitignore documentation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Jack F <jack@bytes.nz>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 6:07 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Jan 30 2018, Duy Nguyen jotted:
>
>> On Mon, Jan 29, 2018 at 10:47:10AM -0500, Randall S. Becker wrote:
>>> The implication of support for ? is there through the following paragra=
ph from the gitignore documentation:
>>>
>>>     "Otherwise, Git treats the pattern as a shell glob suitable for
>>>     consumption by fnmatch(3) with the FNM_PATHNAME flag: wildcards
>>>     in the pattern will not match a / in the pathname. For example,
>>>     "Documentation/*.html" matches "Documentation/git.html" but not
>>>     "Documentation/ppc/ppc.html" or
>>>     "tools/perf/Documentation/perf.html"."
>>>
>>> Of course you have to go read fnmatch(3), so it might be good for
>>> expand on this here :).
>>
>> I agree. How about something like this?
>>
>> -- 8< --
>> Subject: [PATCH] gitignore.txt: elaborate shell glob syntax
>>
>> `fnmatch(3)` is a great mention if the intended audience is
>> programmers. For normal users it's probably better to spell out what
>> a shell glob is.
>>
>> This paragraph is updated to roughly tell (or remind) what the main
>> wildcards are supposed to do. All the details are still hidden away
>> behind the `fnmatch(3)` wall because bringing the whole specification
>> here may be too much.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  Documentation/gitignore.txt | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
>> index 63260f0056..0f4b1360bd 100644
>> --- a/Documentation/gitignore.txt
>> +++ b/Documentation/gitignore.txt
>> @@ -102,12 +102,11 @@ PATTERN FORMAT
>>     (relative to the toplevel of the work tree if not from a
>>     `.gitignore` file).
>>
>> - - Otherwise, Git treats the pattern as a shell glob suitable
>> -   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
>> -   wildcards in the pattern will not match a / in the pathname.
>> -   For example, "Documentation/{asterisk}.html" matches
>> -   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
>> -   or "tools/perf/Documentation/perf.html".
>> + - Otherwise, Git treats the pattern as a shell glob: '{asterisk}'
>> +   matches anything except '/', '?' matches any one character except
>> +   '/' and '[]' matches one character in a selected range. See
>> +   fnmatch(3) and the FNM_PATHNAME flag for a more accurate
>> +   description.
>>
>>   - A leading slash matches the beginning of the pathname.
>>     For example, "/{asterisk}.c" matches "cat-file.c" but not
>
> When reading the docs the other day I was thinking that we should
> entirely git rid of these references to fnmatch(3) and write a
> gitwildmatch man page.

That's even better :) I forgot that we don't use fnmatch anymore.

> One of the reasons for why fnmatch() was removed as a supported backend
> was because it couldn't be relied on as a backend, so it doesn't make
> sense to be referring to that OS-level documentation, wildmatch also has
> other features.



--=20
Duy
