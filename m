Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94B8201A7
	for <e@80x24.org>; Mon, 15 May 2017 15:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965496AbdEOPB3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 11:01:29 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33806 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934147AbdEOPB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 11:01:28 -0400
Received: by mail-it0-f67.google.com with SMTP id d68so1710240ita.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dR4rZZvWupbUED3IiJkBl4TUz98sR/2SJxHPC2fXIkU=;
        b=HZu7B3b+TuSr1pz2ID7iWzcA/9utZbQDepWf8ZDGETx4evxCnnxseSi3S+YCuPOdIj
         60zLq+nRDt4M8UuJyXFwz+elinAo46Sde94O+AIjMSzIpHkfmnIbL7Zn/HJRPtJlvogd
         0vUKUP15+dmUwcnamEmmNMisZiAA0CtjdlHdIlkX5Q5h6ER52kX+Wyn7wMYUhJLMf2ll
         Tb4GuP5x28g7aQBBzgRBkCuYoOayyK+b105gTesiAZYIUU/4B+ugcFm89TV60w47q7ga
         DiU6/e5wF2L1mQb5CdV3RWUp6RIv/hHMnbfHxVlgUncg1gOxtD6Ht9KWXDZVapw+MbYE
         +Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dR4rZZvWupbUED3IiJkBl4TUz98sR/2SJxHPC2fXIkU=;
        b=pzB6Su5Unl3Pm77nXoFs/azsTfGpoCpoGHNvTApJtQyA1bHpjdMMsZPCuvB5CxsF7Q
         x56CPw+YAeul8x2SefDDKuz7LmrqRc/uhQrJz6kvtEoBhK8fzLkWzounYdEi3gFBNxiq
         mK51WyaKW+vGpTMiuckyTgwRG2XExxHNfdqetx5Naa5wkx0xdYBSGFgucYoEWmp9Gy1F
         oJYVAG+JzY0zTcWMTrO2Im4wOZYy5pcEmryUw1w9TqwgOZIpL7VWDPDxz4EkiYigD3Vo
         q21QDy+nFlpuaE+H0g7Klx7GX50lmvjrIIgSNmbp3LJgAAP5kROCXSrIwoh6uF7n/c7T
         T0Kg==
X-Gm-Message-State: AODbwcAWaAU5DX7R3HWh178r7hXqu/7/rG5nNnqclsW+H1aCE2x6NUra
        rG0sV+Cxicyw3kb3Yv4qOe/vHmPCAg==
X-Received: by 10.36.89.207 with SMTP id p198mr5712375itb.71.1494860487848;
 Mon, 15 May 2017 08:01:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 08:01:07 -0700 (PDT)
In-Reply-To: <28535adf-5f8f-a43d-82e9-2ada398637e2@xiplink.com>
References: <20170515122331.17348-1-avarab@gmail.com> <28535adf-5f8f-a43d-82e9-2ada398637e2@xiplink.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 17:01:07 +0200
Message-ID: <CACBZZX4VDphESS1bt8w4A2GGCnXgj3DRwQLtC+o2ngTQz9=CZA@mail.gmail.com>
Subject: Re: [PATCH] tag: duplicate mention of --contains should mention --no-contains
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 4:20 PM, Marc Branchaud <marcnarc@xiplink.com> wrot=
e:
> On 2017-05-15 08:23 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> Fix a duplicate mention of --contains in the SYNOPSIS to mention
>> --no-contains.
>>
>> This fixes an error introduced in my commit ac3f5a3468 ("ref-filter:
>> add --no-contains option to tag/branch/for-each-ref", 2017-03-24).
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/git-tag.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index f8a0b787f4..1eb15afa1c 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -12,7 +12,7 @@ SYNOPSIS
>>  'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
>>         <tagname> [<commit> | <object>]
>>  'git tag' -d <tagname>...
>> -'git tag' [-n[<num>]] -l [--contains <commit>] [--contains <commit>]
>> +'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
>
>
> I think
>
>         [--[no-]contains <commit>]
>
> is the usual pattern...
>
>>         [--points-at <object>] [--column[=3D<options>] | --no-column]
>>         [--create-reflog] [--sort=3D<key>] [--format=3D<format>]
>>         [--[no-]merged [<commit>]] [<pattern>...]
>
>
> ... like with --[no-]merged, there.
>
>                 M.

Thanks for the feedback, this was discussed earlier in the series and
we decided on the current format I'm submitting here.

Saying --[no-]merged is the convention we use for options where the
two are mutually exclusive, as is the case with the --[no-]merged
options:

    $ git tag --merged v2.12.0 --no-merged v2.13.0
    error: option `no-merged' is incompatible with --merged
    [...]

But in the case of --contains and --no-contains you can provide both:

    $ git tag --contains v2.12.0 --no-contains v2.13.0 'v*'
    v2.12.0
    v2.12.1
    v2.12.2
    v2.12.3
    v2.13.0-rc0
    v2.13.0-rc1
    v2.13.0-rc2

So they don't use that convention, since it would imply that they're
mutually exclusive, rather than both being optional.
