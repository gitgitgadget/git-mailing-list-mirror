Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E41D2023D
	for <e@80x24.org>; Thu,  3 May 2018 10:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeECKqm (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 06:46:42 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37559 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbeECKql (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 06:46:41 -0400
Received: by mail-it0-f65.google.com with SMTP id 70-v6so14798524ity.2
        for <git@vger.kernel.org>; Thu, 03 May 2018 03:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e6SUZ00DMblmHLzQHZeH2ejFXpRPfZsrDTIIAmC+kVg=;
        b=K9pW/GuuEdc126x8KrET1DxMX6KGwWqaTuB8hlITKFGk/Y4F1KE3X7m+v5n3hdPF4r
         p851E3LmuV9sMwWfaVfwlxYvhPffEdJ3MdK6GW2EilGWXuE7J0d55L+M6ep0hZCeo46C
         cHkTaZq0LD8YD9BJbkHw+iSNZCFDxDRTSuY1YNFQ2L5sZOMcE2ScyADCxbhcj1nG0hF9
         BMvVaS0OHsDPT6NzErDWJIpSVHt1UqeEdjpYeMiTUuf0OyJuCbNJuR519hMND0mWXItQ
         0L7zi2IS4M3XMrRYJ2bYb1wxQZ/7H55L7ks+VW88XXOUOzsOKJVPFO5jsSQfld1u50Nz
         pM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e6SUZ00DMblmHLzQHZeH2ejFXpRPfZsrDTIIAmC+kVg=;
        b=a244pYQ1BpqIzte+wOdCbxJHehs4LgnY4nvIAt5lFvq0JcnljevBc5Sb4Y0daMB6EV
         U1uKefGPjC6Hn7o80tb4yGKt0WHbrH3wg80w88ZSYBj2Z1CH90JHfx688GpbvWJ2+kYD
         6VC/Q9SD52dKOw/z7ObA/mj/WUm/4KwG++QVVodt6wQXv9PDh5WEQvMcLXi9rjfuRr/L
         nu1xH9Gkvz8OhSAiayjVDwkg0oPO5EJkAmIM65H3PnhJ8Ri7q5MP12mE/PLEY5P2j7SW
         gIEWVIdg0v/+bTFCuvpG6xRbUb9jVxMcq6ClGP6UhY+h8VmhotZSgekR3LSFnrwkSN1p
         0PVg==
X-Gm-Message-State: ALQs6tA6Gh5/ocfJjy4pxI3tEZ/QZOL0gcJEBCaq+uxrHETHm8A7HyfG
        RSeKg7fEAvEPFl+SIXjSyFD3ufn420dEf1lPg98=
X-Google-Smtp-Source: AB8JxZosHTlRDfqfiGUhweoJ8MThzTPME9uwdtlA7STD9lPOm9zGY9V12edGUZgz1Lf4yX0ypTkWRrBwsqpQGrRl7mI=
X-Received: by 2002:a24:36ca:: with SMTP id l193-v6mr15874784itl.103.1525344400519;
 Thu, 03 May 2018 03:46:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7c91:0:0:0:0:0 with HTTP; Thu, 3 May 2018 03:46:39 -0700 (PDT)
In-Reply-To: <xmqqy3h2vbqj.fsf@gitster-ct.c.googlers.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180502005528.19740-1-kcghost@gmail.com> <20180502005528.19740-2-kcghost@gmail.com>
 <xmqqy3h2vbqj.fsf@gitster-ct.c.googlers.com>
From:   Casey Fitzpatrick <kcghost@gmail.com>
Date:   Thu, 3 May 2018 06:46:39 -0400
Message-ID: <CAEp-SHXPKJNuc+dhkZu=Vr=ju8AMHq6Rd851vNOV3WUvOQnrLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] submodule: clean up subsititions in script
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks I will amend and re-submit (this time with  -v$N, I apologize
for creating a confusing mess in everyone's email clients :))

On Wed, May 2, 2018 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Casey Fitzpatrick <kcghost@gmail.com> writes:
>
>> 'recommend_shallow' and 'jobs' variables do not need quotes (they never contain
>> spaces) and do not require any additional prefix, therefore remove the
>> unnecessary subsitition.
>
> The resulting patch is good, but "they never contain spaces" is not
> a very good rationale.  The real reason is that (1) we use them only
> to hold a single token value (or leave them empty) in the current
> code, and (2) if the feature they represent is enhanced in the
> future to make them multi-token options (e.g. we may allow $jobs to
> contain, in addition to "--jobs=2", "--jobs 2" for whatever reason
> later), it is likely that we would want these multi-tokens split at
> $IFS (e.g. "--jobs" and "2" get passed as separate option, not a
> single "--jobs 2" string).
>
>> 'progress' is a boolean value. Treat it like the other boolean values in the
>> script by using a substitution.
>
> This is OK.
>
>>       git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
>> -             ${progress:+"$progress"} \
>> +             ${progress:+"--progress"} \
>>               ${wt_prefix:+--prefix "$wt_prefix"} \
>>               ${prefix:+--recursive-prefix "$prefix"} \
>>               ${update:+--update "$update"} \
>>               ${reference:+"$reference"} \
>>               ${depth:+--depth "$depth"} \
>> -             ${recommend_shallow:+"$recommend_shallow"} \
>> -             ${jobs:+$jobs} \
>> +             $recommend_shallow \
>> +             $jobs \
>
