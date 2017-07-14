Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706DF20365
	for <e@80x24.org>; Fri, 14 Jul 2017 09:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbdGNJr1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 05:47:27 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34298 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdGNJr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 05:47:26 -0400
Received: by mail-yb0-f194.google.com with SMTP id n205so4817700yba.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 02:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=17LomnoIr8VHZY0OCQ3f7JreBpm09unBblVHo2fbQHs=;
        b=TYsfuRwfjWcqAknKIwVjQlKLAcpCPQxqZeRN9bYnXoA8QSVO0YEI+1RJjHzF6YD/OA
         qmeJWe1k1b7wo+jTujdHnROlJN4wR7fGVZNAAbKH57PTtvLLPWDENEuk4jMQJNP9IQWO
         vca20IxjhyXIHTCr6TTceplDBYqS58qYaQourTB/pJo4A+93qU5EZHO7Hnx7d2U9WukS
         XAfhiAnnzXQvOQgOthyyfoGeKA9mQDo2RajUeR6j3S21LSaJUCo+/gLAJcE1CuyfUvqj
         /jfROPBFOjEqx6SEYzqcGWtVx2FLyxNkXdsysFElRtaUafuqEkEFZemlTVUF6e6QPnPR
         PxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=17LomnoIr8VHZY0OCQ3f7JreBpm09unBblVHo2fbQHs=;
        b=Mnz1J8XADRKF7M6/C47OKLZNOGC4uH6Uu4ahKmZltBL/AemAJJXdgQQ3/jqIjlv9hD
         1SQ0AQP+/sM8OOUEc5ItCIYiAsiFpGoR0r6vZvNOCqqoVvT+ajMwhPDu+FJ3Kj6xr00/
         5wxg9ono0EOTUpVyshx+bkMibee2s4P1K1X9c1/5lKY+53MfaBYwVZw+ffyLr163LXYd
         qqa4jJ35AwUg+Xn6L+lHS4pq3m3/EDRgQVxqmIj3IGA/EndEzLTv/lnEY3NyG1AMJKFT
         IOZlIw/6HBlwEUBty9bhx9lJNrMOfSCVp4Nf4pluQ46wafLA6S6Gil9PQZZoO3HDUMMu
         ZbnA==
X-Gm-Message-State: AIVw110xPalQl/sSfFb+5+Kh0RYtWNNAaUJ7SmJSZ4vtZL6S8SZ4XMOS
        clCPbIBzq0aNWe14yuDwCsKuJkx5pVea57c=
X-Received: by 10.37.171.97 with SMTP id u88mr6655661ybi.36.1500025645488;
 Fri, 14 Jul 2017 02:47:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.130 with HTTP; Fri, 14 Jul 2017 02:46:55 -0700 (PDT)
In-Reply-To: <914898a3-24da-403a-8e1c-e90b53df46a9@web.de>
References: <CANmutwCSGgLxESPmTJZXkid6P1N6HwwOTaz=7QHOsSPrrHQ4EQ@mail.gmail.com>
 <914898a3-24da-403a-8e1c-e90b53df46a9@web.de>
From:   Elliot Chandler <worldpeacehaven@gmail.com>
Date:   Fri, 14 Jul 2017 05:46:55 -0400
Message-ID: <CAHVrscBhH8U8=f44qCJEk4zQS_1B3iHiV+RnbY47f27WEqezaA@mail.gmail.com>
Subject: Re: Git on macOS shows committed files as untracked
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For what it's worth, the file looks normal in Gentoo GNU/Linux (name
appears "=E1=B8=8B=E1=BC=B2=E2=95=93=CE=B5=EF=AE=AF=F0=92=91=8F=E2=97=8B=E2=
=95=93=D3=B2" and it seems to work like any other directory).


On Fri, Jul 14, 2017 at 4:41 AM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>
>
> On 14/07/17 06:49, Lutz Roeder wrote:
>>
>> Using precomposeunicode still reproduces the issue:
>>
>> Repro steps:
>>
>> 1. Download
>> https://www.dropbox.com/s/0q5pbpqpckwzj7b/gitstatusrepro.zip?dl=3D0
>> 2. unzip gitstatusrepro.zip && cd gitstatusrepro
>> 3. git reset --hard
>> 4. git -c core.precomposeunicode=3Dtrue status
>>
>> On branch master
>> Untracked files:
>>    (use "git add <file>..." to include in what will be committed)
>
>
> A (short) investigation shows that this seems to be invalid unicode,
> at least from a MacOSX point of view ?
>
> Unzipping your repo shows this:
>  git status -u
>   deleted:
> "\341\270\213\341\274\262\342\225\223\316\265\357\256\257\360\222\221\217=
\342\227\213\342\225\223\323\262/test.txt"
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> If I run this:
>  xx=3D$(printf
> "d\314\207\316\271\314\223\314\200\342\225\223\316\265\357\256\257\360\22=
2\221\217\342\227\213\342\225\223\320\243\314\213/")
>
> echo   $xx | iconv -f UTF-8-MAC -t UTF-16 | xxd
>
> iconv: (stdin):1:5: cannot convert
> 0000000: feff 1e0b 1f32 2553 03b5 fbaf            .....2%S....
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> So I don't know if we can do something in Git to improve your repo.
> How did  you end up with such a directory name ?
> And would it be possible to rename it ?
>
>
