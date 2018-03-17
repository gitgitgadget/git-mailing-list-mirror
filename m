Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3BD31FAE2
	for <e@80x24.org>; Sat, 17 Mar 2018 20:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeCQUvI (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 16:51:08 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:54551 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeCQUvH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 16:51:07 -0400
Received: by mail-it0-f47.google.com with SMTP id w3-v6so5972781itc.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c3HWBzJKK1p8ebT/IJQh7KB27bolWr8dIl6vdVX7NLc=;
        b=NsjiHMkAMbLLEX4MGcDr2hqeRX53cJbmHVWeJJ9/wVL0u8Oj4S9uaL3NgXkRkXwSpS
         edoLGbg7WL3Z/LS0MiLymh8JzpPiPmoMoiypiO9E8Ha+5GO/8sK/E0+C3wuEa2j/9uhe
         gqtennmjq+Itg0bjk4Jnu7dcibLNMonLZeIfGQh5DHN6FbGK8Z2jnnS9cPTyYPbMtGm9
         k14aqSovZZuDh/UdvCjJlyDiBiu776ol+nGhoEpA3dDLtkFaY/A3ASiZ75ptMG0s3RJN
         jLvfck3KjaWI3dB9DFQ4zblvFQJwPYqDEiePOavdg8RnrfdyJ/m3h3qE5vD5SD9pExlF
         hGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c3HWBzJKK1p8ebT/IJQh7KB27bolWr8dIl6vdVX7NLc=;
        b=Z7BysKrUYZDM3mCHTL/ggkgAZt8h3NLcCZsUWS3tR6ZCupPvAjjp4FuuTUhWBxbNkE
         dPDq0c8Vw5D/gvwu/5dAz+jJLFF1YTKPD+KtqFcKNMhZ+KojqXvHJFRpgN8o0MYnVq0o
         WYl9gwKyU+G/rcnXkGw9KHUIgVbear3WQPjXmAltpZ3mtU6ZM5CM4jC8AnyOLc37k5Wr
         b+0W/pEFyReh/oG6/whC9n2+auJSDGONs6wkJeXQKbvmInv2q1CLmht89W6cC3sKz36E
         sobw7xqD3Xqr/18SHtp5oX2SfrmQ+WCQFSF9fY8cv6WdHwp6i8yr7gQGaFTKuuBOIdql
         U4jw==
X-Gm-Message-State: AElRT7GnpqFddtkILTKzIbv2xlNQFgo8SiZB+FOKoJkjs+j58zNQgxzX
        723D0edyEFq9H0xX7vuElf7kTl2IN5AIb9PHnoc=
X-Google-Smtp-Source: AG47ELsP4tPK3hqswFZbMhL6mXAQiStncfUWKiChk0EkhkRJUKcuhhlc/Jq0B+eTU1Nn7o+O/lc+qUEjmKimPG16Tuk=
X-Received: by 2002:a24:9794:: with SMTP id k142-v6mr3559020ite.40.1521319866636;
 Sat, 17 Mar 2018 13:51:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Sat, 17 Mar 2018 13:51:06 -0700 (PDT)
In-Reply-To: <87r2oid0df.fsf@evledraar.gmail.com>
References: <67e865ac-3303-eda6-e14b-f56607d64908@gmail.com> <87r2oid0df.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 17 Mar 2018 21:51:06 +0100
Message-ID: <CAP8UFD0QMqUDmBSYT1_-BcUcfCFfxTef8PAddHzcDv+a0W+44Q@mail.gmail.com>
Subject: Re: [GSoC] Scripts to be conversted into builtins
To:     Yash Yadav <yashdimpu@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 7:26 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Mar 17 2018, Yash Yadav jotted:
>
>> Hello,
>>
>> I am a student going through the GSoC process.
>>
>> In the project ideas listed there is one idea talking of conversion of
>> scripts to builtins. This interests me but no pointer forward is given
>> and I'd like to dive more into that idea and go through the script(s).
>>
>> So, where should I look further from here?
>
> One good place to start is to start reading at:
>
>     git log -p --stat --full-diff --reverse 74703a1e4d.. -- 'builtin/*--h=
elper.c'
>
> And then search for git-.*\.sh in your pager. These are a bunch of
> commits where the bisect, rebase and submodule helpers have had their
> shellscript code incrementally replaced by C.

Yeah, and we have been proposing this kind of GSoC projects for a
number of years now, so we have had a number of GSoC students doing
this kind of projects, and therefore a lot of information about their
projects is available in the mailing list archive.
