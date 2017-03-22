Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2F820323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbdCVVdI (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:33:08 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35216 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdCVVdF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:33:05 -0400
Received: by mail-pf0-f177.google.com with SMTP id 20so48837524pfk.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eV6wstDmCUm6JAMz2O4GyAy85xVhB1XFJ7z9pnbC2Yc=;
        b=VkyB68f2q88U4hwqM7ajvX9VquXdoj+GnnWi6x4QPGreWJKaRkzuC8cwx+VaBXsJpf
         ax1rEW3Ips6GLi6dWEkSzGgCqrgtuneCl4uBq7pBH+4pUsnVuK2j10dDxeown53rxTXk
         zDPsihc9txViKtB2hy3IoYkG2kIXRoQxoN9pHy3LDRGKj135eBby2++sYLSp4kgomy+u
         pf0TS7BR1Keme47UVzXZJNWKTT2piQ4grL2WHntDX7/o9JmwwsJd55qLSnVptVlBFHr3
         gAXkbyTpOMc2bxFVqXWa92c8px/+9MoZAWu0o9d0XX18whHxAojevjUt/w0LJq8S9i7/
         Fqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eV6wstDmCUm6JAMz2O4GyAy85xVhB1XFJ7z9pnbC2Yc=;
        b=L8ol3FhTF2IwwY4FECXWptrCbRGU0C7lqAvI4rSMCo2uOVidZGhUPkeRx7yMW/nGCb
         EgnG46ZG5Xh16KERx1EtXSPJhDAzMZ0CIb0twIwknu04qe+Bo+BM+oP8scgtA4oIbHXt
         wogCG2I+nJ2vZHFNYaoQ/IR1A96efFncT+Q8KALAhogdx1tsRBjZACT45wsLbIWL5r7j
         YaJis62TFBRl/M+Hw0X/ABpR5RhhWN1QpbEM60IC8EzcqF+LowvGjBWsqcPvE72cjQtX
         dlSUeNyln6hQY7ZZ47R4RPy4jnMzWLni1nNlp7sB3g+0CGoX1fFm9wSCZ9iF1QOGNHA+
         B7XQ==
X-Gm-Message-State: AFeK/H3tGtLsgLuQytoFOqHWcJhOzMwh1ACoLtOS7Zk2H5uak/+Epn039EyiXHpvKEWK+S9S/Oz299KxtHATscco
X-Received: by 10.84.136.34 with SMTP id 31mr57347485plk.52.1490218342546;
 Wed, 22 Mar 2017 14:32:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Wed, 22 Mar 2017 14:32:22 -0700 (PDT)
In-Reply-To: <20170322210733.ohb7duy7bmmon6ny@sigill.intra.peff.net>
References: <20170322173528.ho43ulndlozq35tu@kalarepa> <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-3-gitster@pobox.com> <20170322210733.ohb7duy7bmmon6ny@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Mar 2017 14:32:22 -0700
Message-ID: <CAGZ79kafNKwfLhE1nXyt5mc5-D-kdxRxDP9pV7gc3btvjiHV7Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] t7406: fix here-doc syntax errors
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jan Palus <jan.palus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 2:07 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 22, 2017 at 01:08:04PM -0700, Junio C Hamano wrote:
>
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index 347857fa7c..a20df9420a 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -442,9 +442,9 @@ test_expect_success 'submodule update - command in .git/config catches failure -
>>  '
>>
>>  test_expect_success 'submodule update - command run for initial population of submodule' '
>> -     cat <<-\ EOF >expect
>> +     cat >expect <<-\EOF &&
>>       Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
>> -     EOF &&
>> +     EOF
>
> After applying this, I get a failure:
>
>   --- expect    2017-03-22 21:01:53.350721155 +0000
>   +++ actual    2017-03-22 21:01:53.346721155 +0000
>   @@ -1 +1 @@
>   -Execution of 'false $submodulesha1' failed in submodule path 'submodule'
>   +Execution of 'false 4301fd3e4110d3b6212c19aed3094150392545b9' failed in submodule path '../submodule'
>
> At the very least, we need to drop the "\" from EOF to expand
> $submodulesha1.

yes.

> But the submodule path seems wrong, too. I'm not sure if
> the expectation is wrong, or if there's a bug. +cc Stefan

Yes the actual output is wrong, too.
But that is not because Git is wrong, but the test suite is.

    test_must_fail git -C super submodule update >../actual &&

contains 2 errors:

* we are interested in stderr, so make it 2>
* the -C switch doesn't apply to redirection. (obviously!)
  So if you have run the test suite in a normal setup, you may have
  a file "t/actual" which is empty. This is scary as it managed to break
  out of the test suite and overwrote a potential file in your git.git.

I'll send a patch on top of the one under discussion momentarily.

Thanks,
Stefan
