Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C9020279
	for <e@80x24.org>; Sat, 25 Feb 2017 02:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdBYCfe (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 21:35:34 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33645 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdBYCfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 21:35:33 -0500
Received: by mail-lf0-f54.google.com with SMTP id l12so15637187lfe.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 18:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1XbNn8qyqA9ls38/p0Jc8Ed4AJICmQo/S5lsynmobZE=;
        b=ufzhSLP37iwQ4DW2edbmtj+OKhDiSj8esnhQSzBEGLPujJ/Ji2l8rXl8D+M3NLd/Pi
         jRFviVjG8thbzmE9Hr6tZ+dSfF74hLTMKEpDsMftoUFqtH8d10VfrkV/LgJpOzCv3jZT
         USq2DUTyH+5aYEAbB4nxQ373LJd30AuH2UMRlkjjezGrS0MmVtBdNzQq4xWO/K8swscx
         pfQW56vQr5NXwuwKspOcO27SqPRrevy+yVr6jDVLL2EIN4AQbDuy5HLcmqkXhi0jHyxN
         D+/OwPPSLtkSUhVEDFWxB+bTDDLu9wjyb48bpqg1EW6ru3R2xBnpuNjZvN558+nhxYXp
         kTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1XbNn8qyqA9ls38/p0Jc8Ed4AJICmQo/S5lsynmobZE=;
        b=g545ywse4H8k8f+DCenvNpGO+GQ+6znxITuVGm1DJ6rcO2FDFcqymc5g1NdU1we/hR
         C84tfP+GWSQZ5UEfLjI3kQrZjfmIvCbA3oqSOXwhDrCJkIy5jWFiU4nLA4RIyXXceJw9
         ayka8ljs/Cd3DFdXdcDIina4kGFq5z04rqFdugKHHWaQtLxQ1Q9c9a3CT+BByxGM9G0C
         gXqdLU4sBema9E3SYqDnoKL7Od8lDzZ+kYaAMqMGeY8P5KamsE/3o2BDWnQ3BcalzRdT
         sTvhDTP9pQW335LBlDs9IeO9hhmEanTtn5E5JoTDUB25klWlV5FamCBmPD0d5cCNVYAY
         jH5A==
X-Gm-Message-State: AMke39mUNju4rPvIt5SbABzM/yK6+4Xpy3yJTDuxSPALxugtpC50oWVYgpzMA6nSMcOYNFu968BN6Iqb09v2+A==
X-Received: by 10.25.79.69 with SMTP id a5mr1701894lfk.58.1487989754665; Fri,
 24 Feb 2017 18:29:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Fri, 24 Feb 2017 18:28:53 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.75.62.1702241733250.6590@qynat-yncgbc>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc> <20170225012100.ivfdlwspsqd7bkhf@sigill.intra.peff.net>
 <nycvar.QRO.7.75.62.1702241733250.6590@qynat-yncgbc>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 24 Feb 2017 18:28:53 -0800
Message-ID: <CA+P7+xqem_7L3Hyf+vEpkav-JJSvpcyytbendeyLcpwkusE+Zw@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     David Lang <david@lang.hm>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 5:39 PM, David Lang <david@lang.hm> wrote:
> On Fri, 24 Feb 2017, Jeff King wrote:
>
>>> what if they are forks of each other? (LEDE and OpenWRT, or just
>>> linux-kernel and linux-kernel-stable)
>>
>>
>> Once one flips, the other one needs to flip to, or can't interact with
>> them. I know that's harsh, and is likely to create headaches. But in the
>> long run, I think once everything has converged the resulting system is
>> less insane.
>>
>> For that reason I _wouldn't_ recommend projects like the kernel flip the
>> flag immediately. Ideally we write the code and the new versions
>> permeate the community. Then somebody (per-project) decides that it's
>> time for the community to start switching.
>
>
> can you 'un-flip' the flag? or if you have someone who is a developer flip
> their repo (because they heard that sha1 is unsafe, and they want to be
> safe), they can't contribute to the kernel. We don't want to have them loose
> all their work, so how can they convert their local repo back to somthing
> that's compatible?

I'd think one of the first things we want is a way to flip *and*
unflip by re-writing history ala git-filter-branch style. (So if you
wanted, you could also flip all your old history).

One unrelated thought I had. When an old client sees the new stuff, it
will probably fail in a lot of weird ways. I wonder what we can do so
that if we in the future have to switch to an even newer hash, how can
we make it so that the old versions give a more clean error
experience? Ideally so that it lessens the pain of transition somewhat
in the future if/when it has to happen again?

Thanks,
Jake
