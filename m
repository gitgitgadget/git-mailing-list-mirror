Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E096F20281
	for <e@80x24.org>; Tue, 23 May 2017 19:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967652AbdEWTvA (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:51:00 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:32931 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967149AbdEWTu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:50:59 -0400
Received: by mail-io0-f175.google.com with SMTP id p24so104751211ioi.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7wq+AIGI1C18Kjw78pxGhjc7xsRmd6zR3SrN+BO+ue4=;
        b=sRJDIv6/uPjYvTfo8V3wfU1WQNhPJvXWvC6jAWV2+j9LNKlVrTNnbH9UFwA0QIorWQ
         aTdPhJ9zaxC+JUzG3cOs4aAkDNGHl37VX/RtWsmz/60HEZpuQ3p1/QclxkQG5sRGx+4f
         P08lPrhxt7XpmTrTZB1p/OmUL8q+EkjLO9nnUmsgyOHfBRNWS4EHt+/rR80mryIheF3j
         NwODZfPFeEHJc1vDfSR6JSxlL80gqyNwkpH0W6nCFAJsdeFnLq4cbw+i9f2F9q7r5anl
         aP5TFb8an98m05mZxnd9VXOfUG0HTH8ASgo/p/P0i84TbMWsWKmUBnoRncFRbkMCNs8r
         9ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7wq+AIGI1C18Kjw78pxGhjc7xsRmd6zR3SrN+BO+ue4=;
        b=GTKgneOXcQUH2IWC/HkGBsb8RkzKr5zsgzP9suKkRTTQGw8K6+aToMFp8t4PNXmJ19
         DRDP8USx42A4X4RfaCY5hlTQgBF1ZEPz7brbN5bZ87qCzbKYTSzSkpqnq1Gpltv6XiFn
         1MZI72nWJmAhbd6vtoeBkhZt0NkmREml9vRn50zAKOkPxcVgKF4tSiAtCAKK51JeCxk8
         4sFiKh2PIXUI5nXzXcXwXEM2Sht2DVELSanMPzA6WhcxO7j8y8sek06n/tWHkCDPzk+m
         APAuZgdsqmmhQL3lYPOWAjSOjYZo2vdoDOlBDYtqG1GLXaIgbpPaLtMg4sGJ54DEm9zr
         DB6g==
X-Gm-Message-State: AODbwcDO3JLrdtYv7tekam1UefxOA3Mh7Vg01ZDCx6msNFZ2GDXeNBgK
        3P5/dxLKk0NIMp/5F6PyGrMl8OTT/A==
X-Received: by 10.107.178.12 with SMTP id b12mr27358806iof.50.1495569058134;
 Tue, 23 May 2017 12:50:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 23 May 2017 12:50:37 -0700 (PDT)
In-Reply-To: <CAGZ79kYoHYz6hi5kDjQBcN-35c0kXE6mf6NNV_Z_F6-UqZ=3cw@mail.gmail.com>
References: <xmqqwp98j8q2.fsf@gitster.mtv.corp.google.com> <CAGZ79kZMJP7K5MU0UujuEatZ2MOrSnFpfD707aSGa64mKyCZbw@mail.gmail.com>
 <CAGZ79kYoHYz6hi5kDjQBcN-35c0kXE6mf6NNV_Z_F6-UqZ=3cw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 23 May 2017 21:50:37 +0200
Message-ID: <CACBZZX4adLy6Xumicu3Qke=g39EEe3iBa5ShsGvTBAYFqXENPg@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #07; Tue, 23)
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 9:38 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, May 23, 2017 at 12:08 PM, Stefan Beller <sbeller@google.com> wrot=
e:
>> On Tue, May 23, 2017 at 1:08 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>
>>> * sb/submodule-blanket-recursive (2017-05-23) 6 commits
>>>  . builtin/push.c: respect 'submodule.recurse' option
>>>  . builtin/grep.c: respect 'submodule.recurse' option
>>>  . builtin/fetch.c: respect 'submodule.recurse' option
>>>  . Introduce submodule.recurse option for worktree manipulators
>>>  . submodule test invocation: only pass additional arguments
>>>  . submodule.c: add has_submodules to check if we have any submodules
>>>  (this branch uses sb/reset-recurse-submodules.)
>>>
>>>  A new configuration variable "submodule.recurse" can be set to true
>>>  to force various commands run at the top-level superproject to
>>>  behave as if they were invoked with the "--recurse-submodules"
>>>  option.
>>>
>>>  Seems to break t7814 when merged to 'pu'.
>>
>> I will investigate! (It passes on its own, so I guess it is some
>> interference with a recent grep series)
>
> And the winner is 5d52a30eda (grep: amend submodule recursion
> test for regex engine testing, 2017-05-20, by =C3=86var)
>
> The tests added by grep rely on the old content of
> test 2 'grep correctly finds patterns in a submodule'.

Sorry about the fallout.

> The (whitespace broken) diff below fixes it.
> I think the best way forward is that my series relies on
> that series as a foundation then, and writes correct tests based
> on the file contents at that version.
>
> ---8<---
> diff --git a/t/t7814-grep-recurse-submodules.sh
> b/t/t7814-grep-recurse-submodules.sh
> index 14eeb54b4b..ce9fbbc1f6 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -36,18 +36,18 @@ test_expect_success 'grep correctly finds patterns
> in a submodule' '
>  test_expect_success 'grep finds patterns in a submodule via config' '
>         test_config submodule.recurse true &&
>         # expect from previous test
> -       git grep -e "bar" >actual &&
> +       git grep -e3 >actual &&
>         test_cmp expect actual
>  '
>
>  test_expect_success 'grep --no-recurse-submodules overrides config' '
>         test_config submodule.recurse true &&
>         cat >expect <<-\EOF &&
> -       a:foobar
> -       b/b:bar
> +       a:(1|2)d(3|4)
> +       b/b:(3|4)
>         EOF
>
> -       git grep -e "bar" --no-recurse-submodules >actual &&
> +       git grep -e4 --no-recurse-submodules >actual &&

The rest of my changed just did:

        foobar -> (1|2)d(3|4)
        foo    -> (1|2)
        bar    -> (3|4)

While this works might want to do e.g. `-e "(3|4)"` here like the
rest. This works, but probably confusing going forward when it's the
only exception.

>         test_cmp expect actual
>  '
> ---8<---
>
> Thanks,
> Stefan
