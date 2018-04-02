Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 906D71F404
	for <e@80x24.org>; Mon,  2 Apr 2018 17:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeDBRnL (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 13:43:11 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:32814 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeDBRnL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 13:43:11 -0400
Received: by mail-ot0-f180.google.com with SMTP id 23-v6so16462528otj.0
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bie4s5/42SzezOz9uGvQNSbHiwmHt/4bGpI2+HfEZvc=;
        b=K4mOnVGY0z6q7khbMThRSUY73TFCmoQo6cPMrtdkjXNbYspR2EZNSoiyhT/07+hm9r
         JX3qU5XbX1fxhKMbYHcMdhlMWBK/B3cHcyXserXsYrvQ52BQN39zD1IkYlZYMDYztYAR
         zO4HLDDBwoKsqS2VxTlTQTHYjvItOXKewVxqr9CLO+hGLV6eqdFZL9c7QH+1mNnNbOz6
         rfJYX5qfJYaoMidMSH1qQdG4E0z0LZrV2ZY62cWLCEShb4p7x9ttApsjdfWtA+j+glH/
         8Brji+mYVlV3LrImSpAWhEGR7T4d694aw4HGKhol+jbiwqQbgI3jaVZ96+4RCzkMT3pE
         KQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bie4s5/42SzezOz9uGvQNSbHiwmHt/4bGpI2+HfEZvc=;
        b=javfzx8yxvPKf2F9OyxJbaMxtVEDt0A53YuyM3aLwVE/xjcxiwFA33YshKARmwf6bv
         JcB1nMIFgthpDyK2SEbsbvlbdMQ1IwfuuC+dDAIHvDaz39XzYgFIbqMLE9U4wM4NEvZb
         gY1v5GSRwAMml8e53KjrBHs/ZMq0Tmc1X1klz4qEPUKvxt/LPaDJiGoSSVr8VIyTdbTe
         9fMoLZShEMLEtmJlgXXmqXsgaVDmN1aTiuMLZq3CrLiWDOX2jBm8mGd+GgZJTpGCPDdM
         5EIhvQgb1VnpLl4ty13ZSH54Na4JgWbdCvudssAQrl4bkgzB+wIGyM4nCwXZxktSTGyG
         NVcQ==
X-Gm-Message-State: ALQs6tDDevCRd1NZUxJ8xzBplq4+LWuQv/1t1ODcTY4fiVAaCaiKWJEY
        nZhdQCszaaSoqgDVuh7a1iQREYeS9ft/9LlKIMg=
X-Google-Smtp-Source: AIpwx49WFmgoLDwqXVlqwsVXtA4ksNo0bgVN48ZBpcBQzH0xDuehHTassx8A5l7xAfwRkycTo8MpGeHrATFNVxbDCeY=
X-Received: by 2002:a9d:3323:: with SMTP id f32-v6mr6532085otc.221.1522690990413;
 Mon, 02 Apr 2018 10:43:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Mon, 2 Apr 2018 10:42:29 -0700 (PDT)
In-Reply-To: <87zi2lv7io.fsf@evledraar.gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <87605aw1ue.fsf@evledraar.gmail.com> <CAHwyqnV1BwsaHVsh0xSx3MroNoJRT7UYrqF_WFKhkZMf-X9Evg@mail.gmail.com>
 <87zi2lv7io.fsf@evledraar.gmail.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Mon, 2 Apr 2018 19:42:29 +0200
Message-ID: <CAHwyqnU_5RVJBRLm4SBPo-xQKFQQTat33RdJBN2OOBSt1ZBNPQ@mail.gmail.com>
Subject: Re: [PATCH] ls-remote: create option to sort by versions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both points make sense and it sounds like a very pragmatic approach.
I'll look into it!

On Mon, Apr 2, 2018 at 7:32 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Apr 02 2018, Harald Nordgren wrote:
>
>> In regards the the print statement, it was only moved down according
>> to the diff because I added more logic above. Basically there is 1)
>> the unrolling of the linked list to an array and 2) the printing
>> logic. I could move it and make the diff smaller, but that probably
>> makes the code a tiny bit more complicated.
>
> I was just wondering since it wasn't explained in the commit message,
> makes sense to copy this explanation into v2, or lead with a purely code
> re-arrangement patch.
>
>> It would be nice to have a uniform option like
>> '--sort=3Dversion:refname'. But spending a few hours to look over the
>> code, it seems that ls-remote.c would require a lot of rewrites if we
>> wanted to start using `ref_array` and `ref_array_item` for storing the
>> refs.
>>
>> Which seems necessary in order to hook in to the sorting flow used in
>> other subcommands. That, or reimplement `cmp_ref_sorting`. But maybe
>> I'm missing something?
>
> I'm thinking just in terms of UI. If it's the case that porting this to
> whatever guts git-tag uses for sorting would be hard, then we could
> still use the same command-line option convention (and perhaps just die
> if anything except --sort=3Dversion:refname is supplied). Changing the
> underlying implementation is easier than cleaning up UI-differences that
> (seemingly) only arose due to underlying implementation details at the
> time.
>
>> On Mon, Apr 2, 2018 at 8:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>> On Mon, Apr 02 2018, Harald Nordgren wrote:
>>>
>>>> Create the options '-V ' and '--version-sort' to sort
>>>> 'git ls-remote' output by version semantics. This is useful e.g. for
>>>> the Go repository after the release of version 1.10, where otherwise
>>>> v1.10 is sorted before v1.2. See:
>>>>
>>>>       $ git ls-remote -t https://go.googlesource.com/go
>>>>       ...
>>>>       205f850ceacfc39d1e9d76a9569416284594ce8c        refs/tags/go1.1
>>>>       d260448f6b6ac10efe4ae7f6dfe944e72bc2a676        refs/tags/go1.1.=
1
>>>>       1d6d8fca241bb611af51e265c1b5a2e9ae904702        refs/tags/go1.1.=
2
>>>>       bf86aec25972f3a100c3aa58a6abcbcc35bdea49        refs/tags/go1.10
>>>>       ac7c0ee26dda18076d5f6c151d8f920b43340ae3        refs/tags/go1.10=
.1
>>>>       9ce6b5c2ed5d3d5251b9a6a0c548d5fb2c8567e8        refs/tags/go1.10=
beta1
>>>>       594668a5a96267a46282ce3007a584ec07adf705        refs/tags/go1.10=
beta2
>>>>       5348aed83e39bd1d450d92d7f627e994c2db6ebf        refs/tags/go1.10=
rc1
>>>>       20e228f2fdb44350c858de941dff4aea9f3127b8        refs/tags/go1.10=
rc2
>>>>       1c5438aae896edcd1e9f9618f4776517f08053b3        refs/tags/go1.1r=
c2
>>>>       46a6097aa7943a490e9bd2e04274845d0e5e200f        refs/tags/go1.1r=
c3
>>>>       402d3590b54e4a0df9fb51ed14b2999e85ce0b76        refs/tags/go1.2
>>>>       9c9802fad57c1bcb72ea98c5c55ea2652efc5772        refs/tags/go1.2.=
1
>>>>       ...
>>>
>>> This is a sensible thing to want, but why not follow the UI we have for
>>> this with git-tag? I.e. --sort=3D<key> & -i (or --ignore-case)? Of cour=
se
>>> ls-remote doesn't just show tags, so maybe we'd want --tag-sort=3D<key>
>>> and --ignore-tag-case or something, but the rest should be equivalent,
>>> no?
>>>
>>>> [...]
>>>> @@ -101,13 +115,22 @@ int cmd_ls_remote(int argc, const char **argv, c=
onst char *prefix)
>>>>       if (transport_disconnect(transport))
>>>>               return 1;
>>>>
>>>> -     if (!dest && !quiet)
>>>> -             fprintf(stderr, "From %s\n", *remote->url);
>>>>       for ( ; ref; ref =3D ref->next) {
>>>>               if (!check_ref_type(ref, flags))
>>>>                       continue;
>>>>               if (!tail_match(pattern, ref->name))
>>>>                       continue;
>>>> +             REALLOC_ARRAY(refs, nr + 1);
>>>> +             refs[nr++] =3D ref;
>>>> +     }
>>>> +
>>>> +     if (version_sort)
>>>> +             QSORT(refs, nr, cmp_ref_versions);
>>>> +
>>>> +     if (!dest && !quiet)
>>>> +             fprintf(stderr, "From %s\n", *remote->url);
>>>
>>> Is there some subtlety here I'm missing which means that when sorting
>>> we'd now need to print this "From" line later (i.e. after sorting?
