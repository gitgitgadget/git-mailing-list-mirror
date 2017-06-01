Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85AA20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdFAVix (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:38:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34763 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdFAViv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:38:51 -0400
Received: by mail-it0-f68.google.com with SMTP id d68so7675426ita.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NTtE5yV5YtqIG3LBVUWsLRAvVP+tVoPet2kQ61wDUBg=;
        b=tIVfeGU+MneSP1tH9FDfIhSkAIdqB5SHTki4/tCmS/xl6V929iwRz0WGFbU7SN5deF
         cQQvSpp088GozmHl50goS3cBxYisKuQ/BryXsDyCJLfYjnqrBLuvEa8QvxQr0sHnaFd5
         m6f45Q9JiXXXLdIa58DNkXfqPnWIKaGGSU/Fw8mO5d2nz/cRj31rHclUDA/SmwhobRHh
         abWLrCSL4JDfEk0c7u0+A+zBhJvL0M9RRKjKeeKi4BFa0EEd7JNcY1orKP8LQFre3x1O
         62JJZMpQR8r/Z4SjQ0L4FVCmM0l9UUicTW06aEfXcmjTSHuPTMOQjED5TTGKFOy2Dwpl
         OlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NTtE5yV5YtqIG3LBVUWsLRAvVP+tVoPet2kQ61wDUBg=;
        b=MD4xwGXPebsuSXepXNHsDXNnCy/JhOEOLuzzb1XnX4T1rGsnjsPF9HA7s97PB9OZb/
         JQrv5QC4Tgncv4c/bf1jgtHpoelh2EyH/EOlI72chCiRQupd2Pv9h16a5/vq+LYl7aDk
         iO5TCvsOU9PL5Zfh516or1Ll/1PDn4gmK1LxAzNiOlgaIaF4xOfDdAINk0PfYLV4emBa
         bcJCvYpNsbYnQUaXT1GpK5Or4iSPBkoYIuIllcsErRpes4ZVCmpfN8yFer0UEgy6pcjB
         6A9sTuF6N4vZq6FKc1po3Zj+j9DcfM5o3ME1iug9YFylyGQzyaxJcjYrzbH3A3a8yRao
         RWLg==
X-Gm-Message-State: AODbwcCnqig+SuiQvsdG4JOPIco1XCrFodDEftiLVOVPf/9H9GhH4V0A
        03MgwdIdLoD77TYBqq4Jz12gbCvc0Q==
X-Received: by 10.36.138.131 with SMTP id v125mr1531372itd.66.1496353130878;
 Thu, 01 Jun 2017 14:38:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 14:38:30 -0700 (PDT)
In-Reply-To: <CACBZZX7hffa3iGndzyJMKYAwDqjjYO6XacWLrHnSo29xYSKAsQ@mail.gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com> <20170601182056.31142-3-avarab@gmail.com>
 <CAGZ79kb6O7hraY4caY8tdFn1d0Fi+LRr9cHk2UuXf79LbnPdhw@mail.gmail.com> <CACBZZX7hffa3iGndzyJMKYAwDqjjYO6XacWLrHnSo29xYSKAsQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 23:38:30 +0200
Message-ID: <CACBZZX580g_fKMnCf0XGD4sGY6DjgH7t9cBtcXZf6muemKWXLA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] grep: skip pthreads overhead when using one thread
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 11:36 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Jun 1, 2017 at 11:20 PM, Stefan Beller <sbeller@google.com> wrote=
:
>> On Thu, Jun 1, 2017 at 11:20 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>
>>> +       if (num_threads =3D=3D 1)
>>> +               num_threads =3D 0;
>>
>> I would think that it is easier to maintain the code when keep the 1
>> hard coded, and apply the following diff instead. If we encounter
>> a 0 later on, it is not clear what the original user input was.
>> (Did the user ask for 0 as a proxy for GREP_NUM_THREADS_DEFAULT ?
>> do they care about the number of threads?)
>> It is less complexity in the decision logic here.
>>
>> --8<-- (white space broken)
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index c6c26e9b9e..6ad9b3da20 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -1231,7 +1231,7 @@ int cmd_grep(int argc, const char **argv, const
>> char *prefix)
>>  #endif
>>
>>  #ifndef NO_PTHREADS
>> -       if (num_threads) {
>> +       if (num_threads > 1) {
>>                 if (!(opt.name_only || opt.unmatch_name_only || opt.coun=
t)
>>                     && (opt.pre_context || opt.post_context ||
>>                         opt.file_break || opt.funcbody))
>> @@ -1295,7 +1295,7 @@ int cmd_grep(int argc, const char **argv, const
>> char *prefix)
>>                 hit =3D grep_objects(&opt, &pathspec, &list);
>>         }
>>
>> -       if (num_threads)
>> +       if (num_threads > 1)
>>                 hit |=3D wait_all();
>>         if (hit && show_in_pager)
>>                 run_pager(&opt, prefix);
>> --8<--
>
> If I've understood you correctly (what I applied on top of this based
> on the above at the end of the mail) this segfaults because now we
> won't compile the pattern.
>
> I agree that this logic is a bit tricky, but it must be considered
> with the "!num_threads" logic in preceding "grep: don't redundantly
> compile throwaway patterns under threading" patch.
>
> I.e. we already have num_threads being assigned to 0 under
> NO_PTHREADS, doing the same for the PTHREADS codepath seemed like the
> simplest solution to me.
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index a0a3922f92..6d16df2526 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1238,25 +1238,23 @@ int cmd_grep(int argc, const char **argv,
> const char *prefix)
>                 num_threads =3D GREP_NUM_THREADS_DEFAULT;
>         else if (num_threads < 0)
>                 die(_("invalid number of threads specified (%d)"), num_th=
reads);
> -       if (num_threads =3D=3D 1)
> -               num_threads =3D 0;
>  #else
>         if (num_threads)
>                 warning(_("no threads support, ignoring --threads"));
> -       num_threads =3D 0;
> +       num_threads =3D 0; /* If we have no threads... */
>  #endif
>
> -       if (!num_threads)
> +       if (num_threads) /* Or if we've decided not to use them... */

I didn't mean to change this bit, it should remain "if
(!num_threads)". I was in the middle of monkeypatching and didn't
review the diff carefully enough. But it any case, without this change
the rest of this diff is your proposed (but segfaulting) change as I
understand it.

>                 /*
>                  * The compiled patterns on the main path are only
>                  * used when not using threading. Otherwise
>                  * start_threads() below calls compile_grep_patterns()
>                  * for each thread.
>                  */
> -               compile_grep_patterns(&opt);
> +               compile_grep_patterns(&opt); /* We'll compile the
> pattern here */
>  #ifndef NO_PTHREADS
> -       if (num_threads) {
> +       if (num_threads > 1) {
>                 if (!(opt.name_only || opt.unmatch_name_only || opt.count=
)
>                     && (opt.pre_context || opt.post_context ||
>                         opt.file_break || opt.funcbody))
> @@ -1320,7 +1318,7 @@ int cmd_grep(int argc, const char **argv, const
> char *prefix)
>                 hit =3D grep_objects(&opt, &pathspec, &list);
>         }
>
> -       if (num_threads)
> +       if (num_threads > 1)
>                 hit |=3D wait_all();
>         if (hit && show_in_pager)
>                 run_pager(&opt, prefix);
