Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E78320D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbdFAVGB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:06:01 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35912 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAVGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:06:00 -0400
Received: by mail-pf0-f181.google.com with SMTP id m17so37507809pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Im98JK8G1l5gI/nNEp6MNt8e9vtAeTeF54ETJ4Zx3xQ=;
        b=I8//jF7VKNsCdieVT55C8fomHqHRO2/yS0IPNALVgtlU0HxN0k7VZd1vspRi9X+ple
         kr/dDyxfDK8TREfxGlamEaYxvm9STWie3anW/G7nSr0XtcV2aeeO0uVLtLyCnM64v5dn
         95a1+7hLijDZUGu0VZXeBIW641pnnj0f4phNy7qnxVnP6VjQytpXelgH8WuDyRPcfrcL
         wuZq+Tv0MdLRjZMVFkJkvej9DwjbQNSS0b/gZ0ooo1jlq3T1TccDmhSBYMKr7nLekLH0
         moPwBpGgSmKD/icQMtn5HNEzeI2I8PhdbEM5NUfFSJo4L/11fEM5sh2VYLHqrCt9RTNj
         T8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Im98JK8G1l5gI/nNEp6MNt8e9vtAeTeF54ETJ4Zx3xQ=;
        b=KNqNo6oDsCSRUoqqKfVOofsaEp1URwpP1nNW3qdzVHhk7BoLYeQwG/4raZj+TY6y0A
         By8GmcCeSs4VFFvb6bYlH7P6qaPZMBkQlUG/QXDdBL8i7SWM0egLHx7ZzrazZ3tiquq2
         r4YtdgoRSN5MubEiZnp1cAYwcclNOXSvbVDtj9cH7aIBbwbTXmxuPykMlX+pQfmq1TMv
         ebtuvJIh3zL7h7SfIg+FjDoU6IZOYgJJUu27S5e+eYavLIeRhGaKMcsonL6UfiffJUE2
         Bu1lU/1opKMQwpzmFRKqCiyFYDm1g3BBx0xvkWdlngShq9LLMQGeKEJadfmkXGTLq9yY
         HSjw==
X-Gm-Message-State: AODbwcDfJ+qI41/5LzG8NAC1jX91ijR6Ietg5zpYpsA9mdP7G1JAGRe1
        UBtp1mpCdfK42Ilwond8OSmHPvnDLfJp
X-Received: by 10.99.163.25 with SMTP id s25mr3071003pge.191.1496351159730;
 Thu, 01 Jun 2017 14:05:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.78 with HTTP; Thu, 1 Jun 2017 14:05:58 -0700 (PDT)
In-Reply-To: <CACBZZX5j=g=Lnv-X9F5Uaf0wW922R3N=LgrzRKPw853ECmoqYQ@mail.gmail.com>
References: <CA+dzEBn4EKzDqS0pCHHsPtGGJc1orf5weKKh0GN-GkE+fVYGcg@mail.gmail.com>
 <CACBZZX7OhdRM+Mhx4FVX-Upvq169ZLvArL5ZxcTgz8u=WRh3aw@mail.gmail.com>
 <20170531214019.bbhjdaejvgje3v6g@sigill.intra.peff.net> <CACBZZX5j=g=Lnv-X9F5Uaf0wW922R3N=LgrzRKPw853ECmoqYQ@mail.gmail.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Thu, 1 Jun 2017 14:05:58 -0700
Message-ID: <CA+dzEBkUgzz4Jrsm=VZOE=YNezPEPEMoUDW9iL1vDLxDJstz8w@mail.gmail.com>
Subject: Re: bug: `git log --grep ... --invert-grep --author=...` negates /
 ignores --author
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I actually only expected the --grep to be inverted -- I think I'm on
the same page with what's documented.

I'd be happy to dig into the code and investigate this some more but I
am not familiar with the git codebase, any code hints on where to get
bootstrapped?

Anthony

On Thu, Jun 1, 2017 at 12:45 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, May 31, 2017 at 11:40 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, May 31, 2017 at 08:08:54PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>>> $ git log --grep=3Dbar --author=3D=C3=86var --pretty=3Dformat:%an -100 =
origin/pu
>>> |sort|uniq -c|sort -nr
>>> 5 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>>
>>> $ git log --author=3D=C3=86var --pretty=3Dformat:%an -100 origin/pu |so=
rt|uniq
>>> -c|sort -nr
>>> 100 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>>
>>> $ git log --grep=3Dbar --invert-grep --author=3D=C3=86var --pretty=3Dfo=
rmat:%an
>>> -100 origin/pu |sort|uniq -c|sort -nr
>>>      78 Junio C Hamano
>>>      14 Jeff King
>>>       2 Andreas Heiduk
>>>       1 Sahil Dua
>>>       1 Rikard Falkeborn
>>>       1 Johannes Sixt
>>>       1 Johannes Schindelin
>>>       1 Ben Peart
>>>       1 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>>
>>> That last command should only find my commits, but instead --author is
>>> discarded.
>>
>> I would have thought that the last command wouldn't find _any_ of your
>> commits. Don't we consider --author a greppable pattern and invert it?
>
> There's two unrelated things going on here AFAICT:
>
> * Anthony expected --author to be inverted by --invert-grep, but this
> is not how it's documented, it's *only* for inverting the --grep
> pattern: "Limit the commits output to ones with log message that do
> not match the pattern specified with --grep=3D<pattern>."
>
> * The --author filter should be applied un-inverted, but isn't, it's
> seemingly just ignored in the presence of --grep, actually mostly
> ignored, this is bizarre:
>
> $ diff -ru <(git log --grep=3Dbar --invert-grep --pretty=3Dformat:%an -10=
0
> origin/pu |sort|uniq -c|sort -nr) <(git log --grep=3Dbar --invert-grep
> --pretty=3Dformat:%an -100 --author=3DWeMostlyIgnoreThisButNotReally
> origin/pu |sort|uniq -c|sort -nr)
> --- /dev/fd/63  2017-06-01 21:44:08.952583804 +0200
> +++ /dev/fd/62  2017-06-01 21:44:08.952583804 +0200
> @@ -1,6 +1,6 @@
> -     66 Junio C Hamano
> +     65 Junio C Hamano
>       10 Jeff King
> -      8 Stefan Beller
> +      9 Stefan Beller
>        5 Lars Schneider
>        2 SZEDER G=C3=A1bor
>        1 Tyler Brazier
>
>
>> By itself:
>>
>>   $ git log --author=3D=C3=86var --invert-grep --format=3D%an -100 origi=
n/pu |
>>     sort | uniq -c | sort -rn
>>        79 Junio C Hamano
>>         8 Stefan Beller
>>         8 Jeff King
>>         1 Sahil Dua
>>         1 Rikard Falkeborn
>>         1 Johannes Sixt
>>         1 Johannes Schindelin
>>         1 Andreas Heiduk
>>
>> So that makes sense from the "--author is invertable" world-view.
>>
>> But I'm puzzled that you show up at all when --grep=3Dbar is added (and
>> moreover, that we get _one_ commit from you, not the 5 found in your
>> initial command). That seems like a bug.
>
> I think that's the only thing that's not a bug, i.e. we just find 1
> match in the first 100 (note -100), sorry for the confusing example.
>
> Anyway, much of the above may be incorrect, I haven't dug deeply
> beyond just finding that something's funny going on and we definitely
> have *some* bugs here.
