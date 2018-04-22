Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12ABE1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 15:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755883AbeDVPXb (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 11:23:31 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39930 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeDVPX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 11:23:27 -0400
Received: by mail-ot0-f196.google.com with SMTP id a14-v6so14576251otf.6
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k1p5EQTFPwPWqCFxSzUibyj4qalv15Ofqwq4G+S1JW0=;
        b=vgEm5XjYQIN6I8Hast7pnATynRUncZQ9s7bWXfavvSWuwi/ScHZGdEcGL6VkUimLem
         Hls5sPbKniLbmVzdGjynkdsgqD11R4VZRM54orpeYFLViwfksn9ga4QTYLZjHjQ2UdmH
         nR6EhkkTDkgaUYL4+2EnoUGiIYae3/XEYydjMulC4Hpn1LXaf5fHg1vm/Z8dDa2SmMBI
         P5rUEuGwVT6krJihIeFMRlgaOUkwe9ZMXopR/97AzHuX/I3TSBBBg1xRgohceXCwixaZ
         OJMeQN5zIsjtR/ptnICNFfDXBU9+Lds17xBbEpHsgATu8Qa5TJzI7BTLjIAm8oJR5gZf
         mrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k1p5EQTFPwPWqCFxSzUibyj4qalv15Ofqwq4G+S1JW0=;
        b=pgczNG7mUACNz2fMWIR8lX+rE+BCvLB7LlOezNk9ML5i6OxTrz8k0g2zBlBdg55Mrm
         2rjxN2IWKjtGkhYRKgCkg86W3lLpSCU0Q8xJGcJKxhe8XT0+zAYllwXqimGByNYW4ZaH
         oFgBoUI7kwYzzVprRkvcCKeQnLz6TbBj+UZyv8W7f9FSIhNIFypXp2DMJjzZEohF61OJ
         XWeTauCeBxcPtZEBhiyOa9H7cTECVZkhQ7z5ZYRyQ8pbjHwVVUFAYbJgkPtmdlU0/I1k
         f7mhzURpykfM3CwtPwbPTa1e6JjoFRwYDeT4VX8uccV0cij5vaj6C7kFEhnB8G9W1yrP
         wzCg==
X-Gm-Message-State: ALQs6tDe5ghGPPTOjI6r8aX3n2cB+IIhzh0ZLlgMdgCVTx3zD/5/Nd87
        1+FQkOXJq5XxJGq23DnuukOyPLRpTNnVrcsVWb8=
X-Google-Smtp-Source: AIpwx48H73YbEfnRAcYlhREgd8wnQKMaTrQTCq9NzravNM1vhtM0uge+Rcw70er9KZNHi/cAKqUFzT1uLxn9InfK+Kg=
X-Received: by 2002:a9d:2623:: with SMTP id a32-v6mr12420135otb.65.1524410606571;
 Sun, 22 Apr 2018 08:23:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sun, 22 Apr 2018 08:22:55 -0700 (PDT)
In-Reply-To: <a5dc36f7-fc79-46ba-7e73-e9473cf1aec9@ramsayjones.plus.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165618.GA30287@duynguyen.home> <a5dc36f7-fc79-46ba-7e73-e9473cf1aec9@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Apr 2018 17:22:55 +0200
Message-ID: <CACsJy8Cj57=p5nKH1T2UZmFbDv2d_JRO+GcAo29SAZcSxgKCkw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Keep all info in command-list.txt in git binary
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 4:45 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 21/04/18 17:56, Duy Nguyen wrote:
>> On Sat, Apr 21, 2018 at 06:54:08PM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>>> Changes:
>>>
>>> - remove the deprecated column in command-list.txt. My change break it
>>>   anyway if anyone uses it.
>>> - fix up failed tests that I marked in the RFC and kinda forgot about i=
t.
>>> - fix bashisms in generate-cmdlist.sh
>>> - fix segfaul in "git help"
>>
>> Sorry I forgot the interdiff
>>
> [snip]
>
>> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
>> index fd2a7f27dc..53208ab20e 100755
>> --- a/t/t0012-help.sh
>> +++ b/t/t0012-help.sh
>> @@ -25,6 +25,15 @@ test_expect_success "setup" '
>>       EOF
>>  '
>>
>> +# make sure to exercise these code paths, the output is a bit tricky
>> +# to verify
>> +test_expect_success 'basic help commands' '
>> +     git help >/dev/null &&
>> +     git help -a >/dev/null &&
>> +     git help -g >/dev/null &&
>> +     git help -av >/dev/null
>> +'
>> +
> I think you need to try a little harder than this! ;-)

Yeah. I did think about grepping the output but decided not to because
of gettext poison stuff and column output in "git help". If we do want
to test this, how about I extend --list-cmds=3D option to take a few
more parameters? --list-cmds=3Dcommon would output all common commands,
--list-cmds=3D<category> does the same for other command category. This
way we can verify without worrying about text formatting, paging or
translation.
--=20
Duy
