Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79CC11F404
	for <e@80x24.org>; Mon,  2 Apr 2018 16:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeDBQ1b (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 12:27:31 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:39521 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbeDBQ1a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 12:27:30 -0400
Received: by mail-oi0-f45.google.com with SMTP id q71-v6so13335493oic.6
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uh5ksUPa/KvSDnUK6YTC+EXOjC8lpxA5TA4K60ehOlI=;
        b=M+S6wKAJvGQk4ZuOgzZi3jZTj+deFlnrSW2KvBc2OGphn0zWuXxpA86P9gD3St3kOz
         myo5WFghsEYqx7txUEMDtzwGQx1C5a9h9VNaQ2eGmKsoGlImZTmRB3f46tiUNYcdwKoC
         miw82volmwfMPaPOPzSqe1HrFGIk2H+YzPFR2scqgcrOEF//APP3E34AzAsGb5ak6Yhq
         NvUZwu2nEytztwG7ZKfzMBPZeYb3gR2XVFT3x78Bh/14eVT4G7C2V+bxcSaAgXG7XIaG
         xXdlMQa+kreFjhNrONlp57F17cfMnp8DL/txj/neapoCiScyUgwJHjYxgZCgDy/heEJm
         dvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uh5ksUPa/KvSDnUK6YTC+EXOjC8lpxA5TA4K60ehOlI=;
        b=BNas0NECdtze/TAJ6/2zWXb9AZbG/mI3HsvrjwfdUwLKOSNtfm7nfm/dCvzP5hjWVK
         CnOTBj2EsoDXQElGjY6z7sr2BQpvm8YDx8zr1/nSGlOl2Z3rw6IvZ01+ejr0MHi6u0ZQ
         FvE7EgK1fAR9ETXNZvJBI2BMY38pC9THFGI53LoCip5nwraOQCn3wgg9c86Y08QzB0Ab
         0Cbn9d9PEh/3Rqr0zWRoCDGuB4F31vF1CTsA79eP9X3XVWW7vi8QedzXU6tuytMiPGRl
         K+/7unfRtbtUrQcQT1PNaHzlpEJyciJNqn2K7380keDiKwhxK1m3zxS5WVdwCE7bsAuk
         KX5g==
X-Gm-Message-State: ALQs6tBP3EIJRClcqc2lveP+VJB0c48Zpv06rcUmhaIT3wuzjwtIEIe9
        4iTWCkpW+WfyDsGPtGI24eIMkJ4g9xt8SPoAlf4X2A==
X-Google-Smtp-Source: AIpwx4+/pfP05UexNpukeC4sHvAipwvrGLP3HM/lryAqDkWn19ktgKKQmwPB9kD9Lab0Mqyv96Ln23eUcAqhucSbqVE=
X-Received: by 2002:aca:e302:: with SMTP id a2-v6mr5873856oih.156.1522686449610;
 Mon, 02 Apr 2018 09:27:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Mon, 2 Apr 2018 09:26:49 -0700 (PDT)
In-Reply-To: <87605aw1ue.fsf@evledraar.gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com> <87605aw1ue.fsf@evledraar.gmail.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Mon, 2 Apr 2018 18:26:49 +0200
Message-ID: <CAHwyqnV1BwsaHVsh0xSx3MroNoJRT7UYrqF_WFKhkZMf-X9Evg@mail.gmail.com>
Subject: Re: [PATCH] ls-remote: create option to sort by versions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your comment =C3=86var!

In regards the the print statement, it was only moved down according
to the diff because I added more logic above. Basically there is 1)
the unrolling of the linked list to an array and 2) the printing
logic. I could move it and make the diff smaller, but that probably
makes the code a tiny bit more complicated.

It would be nice to have a uniform option like
'--sort=3Dversion:refname'. But spending a few hours to look over the
code, it seems that ls-remote.c would require a lot of rewrites if we
wanted to start using `ref_array` and `ref_array_item` for storing the
refs.

Which seems necessary in order to hook in to the sorting flow used in
other subcommands. That, or reimplement `cmp_ref_sorting`. But maybe
I'm missing something?

On Mon, Apr 2, 2018 at 8:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Apr 02 2018, Harald Nordgren wrote:
>
>> Create the options '-V ' and '--version-sort' to sort
>> 'git ls-remote' output by version semantics. This is useful e.g. for
>> the Go repository after the release of version 1.10, where otherwise
>> v1.10 is sorted before v1.2. See:
>>
>>       $ git ls-remote -t https://go.googlesource.com/go
>>       ...
>>       205f850ceacfc39d1e9d76a9569416284594ce8c        refs/tags/go1.1
>>       d260448f6b6ac10efe4ae7f6dfe944e72bc2a676        refs/tags/go1.1.1
>>       1d6d8fca241bb611af51e265c1b5a2e9ae904702        refs/tags/go1.1.2
>>       bf86aec25972f3a100c3aa58a6abcbcc35bdea49        refs/tags/go1.10
>>       ac7c0ee26dda18076d5f6c151d8f920b43340ae3        refs/tags/go1.10.1
>>       9ce6b5c2ed5d3d5251b9a6a0c548d5fb2c8567e8        refs/tags/go1.10be=
ta1
>>       594668a5a96267a46282ce3007a584ec07adf705        refs/tags/go1.10be=
ta2
>>       5348aed83e39bd1d450d92d7f627e994c2db6ebf        refs/tags/go1.10rc=
1
>>       20e228f2fdb44350c858de941dff4aea9f3127b8        refs/tags/go1.10rc=
2
>>       1c5438aae896edcd1e9f9618f4776517f08053b3        refs/tags/go1.1rc2
>>       46a6097aa7943a490e9bd2e04274845d0e5e200f        refs/tags/go1.1rc3
>>       402d3590b54e4a0df9fb51ed14b2999e85ce0b76        refs/tags/go1.2
>>       9c9802fad57c1bcb72ea98c5c55ea2652efc5772        refs/tags/go1.2.1
>>       ...
>
> This is a sensible thing to want, but why not follow the UI we have for
> this with git-tag? I.e. --sort=3D<key> & -i (or --ignore-case)? Of course
> ls-remote doesn't just show tags, so maybe we'd want --tag-sort=3D<key>
> and --ignore-tag-case or something, but the rest should be equivalent,
> no?
>
>> [...]
>> @@ -101,13 +115,22 @@ int cmd_ls_remote(int argc, const char **argv, con=
st char *prefix)
>>       if (transport_disconnect(transport))
>>               return 1;
>>
>> -     if (!dest && !quiet)
>> -             fprintf(stderr, "From %s\n", *remote->url);
>>       for ( ; ref; ref =3D ref->next) {
>>               if (!check_ref_type(ref, flags))
>>                       continue;
>>               if (!tail_match(pattern, ref->name))
>>                       continue;
>> +             REALLOC_ARRAY(refs, nr + 1);
>> +             refs[nr++] =3D ref;
>> +     }
>> +
>> +     if (version_sort)
>> +             QSORT(refs, nr, cmp_ref_versions);
>> +
>> +     if (!dest && !quiet)
>> +             fprintf(stderr, "From %s\n", *remote->url);
>
> Is there some subtlety here I'm missing which means that when sorting
> we'd now need to print this "From" line later (i.e. after sorting?
