Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A99E1FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbdAMAwX (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:52:23 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34901 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdAMAwW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:52:22 -0500
Received: by mail-lf0-f67.google.com with SMTP id v186so3843402lfa.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qxGMp2fMpL+mVatoB2SQ6TLiGRBD6TjQdinGq3ZwISQ=;
        b=J1NpkwbthaRMKKYPIKcMF7kckLmybqvwLmVegCuEAi/YnL67Zpwailc8EfkuuzwcDH
         54//zB5+lLq5bgvwlq+Ux4Fv85zEN3aC8zyB/+RgJmv1EcKW44PgRfjiFMIJt3E9RMYM
         wlPhoL6dDt7NUd7Neo+AT4D6PKHoqP5lqfFl1iPd5HbDb53ajJP36VvszhBXoAWa3IdN
         GPtts2EB0oSnORPGOQyMJxxYnb4ACyg2B//CB/8Oy/nGlJ/88R9ZbTwReQUagXk5DDa/
         yRGQGG6Paq7LWXiG0DTCbucA64CEeFvR5TLozG/V224h7V8zSkOj+nW4dFceBEE9S+x+
         sOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qxGMp2fMpL+mVatoB2SQ6TLiGRBD6TjQdinGq3ZwISQ=;
        b=OnxLKk5hmfJ3Vm2cqfPSE++ytxK3JXuVGQhnY0d4UKxOuyN8vuWnV3/tZbwgBBstMY
         jTEa3KnHtIceQ0Qc/okrEwq7Gx7VxcjyT5SXKY+/ZgPBC11JhGXM2CVbuRnA94ACkaFx
         veBoBDTZekVF4oc2MISdWrG/0d0HsO3b2+vmCEnkPiFCMXkV+1OKo9wi+YVKXQggA6df
         1lbbWAn+kzoOygsat4Noxf5ometyjp7GnvqAeKZwPiYf67+TjqCXksqh9r+lPoSVAhEG
         q5VICShLYpdnvmfsDXPQB2HidWSkaVPHBLtwuRDqMmKy+iV5FlFrQHXF/1xO7cJ1frq9
         jwoQ==
X-Gm-Message-State: AIkVDXItSbX0rKEXeEIdJygkLYr201hd1y8i0YUYUQ1Ei4ighxigqr7wFdPAZ3n+PUV8aplVAzh6/mqwGsbEiw==
X-Received: by 10.25.10.6 with SMTP id 6mr4962042lfk.88.1484268740545; Thu, 12
 Jan 2017 16:52:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 12 Jan 2017 16:51:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701121044120.3469@virtualbox>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
 <20170112001721.2534-2-jacob.e.keller@intel.com> <alpine.DEB.2.20.1701121044120.3469@virtualbox>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 12 Jan 2017 16:51:59 -0800
Message-ID: <CA+P7+xoJfiqHy28z8ynonYR3ujoCUB4_diGJHP3XSp=iWpTB5A@mail.gmail.com>
Subject: Re: [PATCH 1/5] doc: add documentation for OPT_STRING_LIST
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2017 at 1:47 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake,
>
> On Wed, 11 Jan 2017, Jacob Keller wrote:
>
>> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
>> index 27bd701c0d68..15e876e4c804 100644
>> --- a/Documentation/technical/api-parse-options.txt
>> +++ b/Documentation/technical/api-parse-options.txt
>> @@ -168,6 +168,11 @@ There are some macros to easily define options:
>>       Introduce an option with string argument.
>>       The string argument is put into `str_var`.
>>
>> +`OPT_STRING_LIST(short, long, &list, arg_str, description)`::
>> +     Introduce an option with a string argument. Repeated invocations
>> +     accumulate into a list of strings. Reset and clear the list with
>> +     `--no-option`.
>
> One suggestions: as the list parameter is not type-safe (apart from
> checking that it can be cast to a `void *`), it would be good to mention
> in the documentation that `list` must be of type `struct string_list`.
>

Ok.

> I was about to suggest that `--no-option` may be misleading, as the
> command-line option is not really called `--option` in almost all cases,
> but I see that the rest of that document uses that convention to refer to
> the negated option already...

Also, I am merely documenting what already existed, since the original
commit failed to add documentation. I don't know if we could make a
better implementation, but it certainly would be a behavior change for
the current users.

Thanks,
Jake

>
> Ciao,
> Dscho
