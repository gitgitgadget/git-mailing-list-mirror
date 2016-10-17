Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 114C61F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 18:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934765AbcJQS6z (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 14:58:55 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33291 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932712AbcJQS6y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 14:58:54 -0400
Received: by mail-qk0-f176.google.com with SMTP id n189so252124987qke.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wja3OZo7r3BnAkjqz6j1r8wS0X4ZfotQyXuaNlq6cQ0=;
        b=gK5G7tPnaVajFfhvwWMofXn9iRrbm8R8XA0Tjh8dlOjeHV5Badlrc9NwTRhFjSR79m
         L2007Bp9I0c3Hwqp5IoNoEMnrKNIG6XdwuBJIcdOlUyX0mYEjdJ7E5N4YWqc60ylQ2DJ
         vNMHfTMNmPUIbhJ++aIXHhXXSJKSFCxHP+VZH337NrIhGop0PXB9B345mDwWVvXUqhzC
         4ReYYDUxHr2K9H+fnL2S1OkM19zQwZLU/9u06VmFb/mFoP90b0eDIFnjJ9vBPZy2Qmnk
         P2nNZ/kNMJgBk+KhrJjLvM2z6PGkgy1kvrLuXwJfyoDFwxpwpuAfTyLn4AERKAmWyEtv
         +U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wja3OZo7r3BnAkjqz6j1r8wS0X4ZfotQyXuaNlq6cQ0=;
        b=TlvFKt+fouPb8uz5YN4SvY+li2sMpAYETO2y+qKttLigcUMjmHDU5PSAFYuI/9R/9M
         AvzuFXMbISPGZFN9nXQ2eXpGEPWB3Dk13n1Il8wG5O0Zkj8Iq00ZjgW6rx/36v4K+1YV
         Ueu+gUUxTIM9+SMGX4DrOl7od2DY1BXErp05dUepUhhyINm0g2+wOh04sckG8GMvBSN+
         dvfvyto/IeRR5QFkziANoGHlyOUl4eSbvkciQkCLxHsF7JYzLYi3Hmmw7BTn01GlqM9k
         anatOne0sSEB/XQL0721sR8VoIgC/MlGIdIoPDu0R0tdeUVNx8NxnbmYIU3uppS/qsDF
         qtvA==
X-Gm-Message-State: AA6/9RmgScAYIDFmC4QRRRn6Sdp4h5mPKl9SrBBQUFb2qkhQH5kLjK92E/KUinEpjHo4bXmNT7vWb8nA8zDhW5mY
X-Received: by 10.55.45.193 with SMTP id t184mr23648694qkh.58.1476730733111;
 Mon, 17 Oct 2016 11:58:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 17 Oct 2016 11:58:52 -0700 (PDT)
In-Reply-To: <xmqqh98avnhh.fsf@gitster.mtv.corp.google.com>
References: <20161010175611.1058-1-sbeller@google.com> <alpine.DEB.2.20.1610121501390.3492@virtualbox>
 <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
 <alpine.DEB.2.20.1610131255001.197091@virtualbox> <xmqqfunvxxgu.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYW2qK1GKxoKy_mkVkjjqEUzkh5aPSzDEfRd6U=PYDdzw@mail.gmail.com> <xmqqh98avnhh.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Oct 2016 11:58:52 -0700
Message-ID: <CAGZ79kZvRf0gHA7tBh1veS9YzAWZ0j0SMGL3c9QQOrERMjmuyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2016 at 11:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> In any case, I find it more disturbing that we somehow ended up with
>>> a system where these three things are expected to behave differently:
>>>
>>>         A - path/to/dir
>>>         B - path/to/dir/
>>>         C - path/to/dir/.
>>>
>>> Is that something we can fix?
>>
>> Well A, B are the same.
>> C is "obviously" different, when it comes to counting slashes for relative
>> path/url purposes, in the way that there are characters after the last slash
>> and just by coincidence '.' refers to the directory itself, C behaving like
>> 'path/to/dir/sub' seems right to me.
>
> It doesn't look right to me at all.  If you were contrasting
>
>         cd path/to/dir/sub && cd ..
>         cd path/to/dir/bus && cd ..
>
> then I would understand, but why should these two
>
>         cd path/to/dir/. && cd ..
>         cd path/to/dir/sub && cd ..
>
> behave the same?
>
>> So how do you imagine this fix going forward?
>> * Breaking existing users with /. at the end? by treating it the same as A,B
>> * Do some check based on time/version of Git and cover the old data?
>> * Forbid /. at the end from now on?
>
> Where at the end-user facing level does this trailing "/." surface
> and how does the difference appear to them?  I think that is the
> crucial question.
>
> Unless there is some convincing argument why "." is not special
> (i.e. counter-argument to the above "bus vs sub" and ". vs sub"
> example), I would think "existing users with /." does not matter.
> If they are "relying" on the behaviour, I would think it is not
> because they find that behaviour intuitive, but only because they
> learned to live with it.  IOW, treating all of A/B/C the same way
> would appear to them a strict bugfix, I would think.

I see, so we should adapt the windows style and chop off '/.'
to make A,B,C all the same, because internally we never produced
C AFAICT.

These came in via hand edited .gitmodules files.

>
> It is totally a different matter if OUR code that consumes the
> output from the submodule-helper --resolve-relative" internally is
> confused and relies on "../. relative to path/to/dir/. is the same
> as ../. relative to path/to/dir/sub" for whatever reason.  Without
> fixing that, I would not surprised if fixing things to treat A/B/C
> the same way would surface differences in the end-user observable
> behaviour in a negative way.
>
