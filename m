Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3251FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 18:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbdBISbh (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 13:31:37 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34858 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdBISbe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 13:31:34 -0500
Received: by mail-qt0-f194.google.com with SMTP id s58so1654231qtc.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RbgKRW+96HIbig00bifIK9Wlb1osVJKQL2DyrulojF8=;
        b=jN/XxmUmia/yNcjxeIBwBnOOhy7lXEu/Xvrv2Z5x1As77k21b/c9mPExC8by04VvJP
         KCCbGMaHdyp8twYZAgwuLggIxxUyoeHFYPNBF2NCmbvtKhvt8NOdYaG2FjXSJcMNwah+
         6O2Not+c4OVMzFIdpo79XweSqyUFO6ia9Qd/e6bjb19jY31PUIep7rdx9DQWA3ybMd7X
         0Qtr5afN1oxVLJB6hqnmD8LG3ETgrTaEFkkVQDA9zQHmYHgyIndsfOBm7VFFnAjudWQI
         GsetHrMYsNGGybXm/N1zKXKo9e2tBECiFgxlfmBDp0pQDka7SHHSJBpO/GfEZVSY7IzB
         dHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RbgKRW+96HIbig00bifIK9Wlb1osVJKQL2DyrulojF8=;
        b=LePH95+GyosyCbeinQCsk6IYfUQ7ouPiXQRfs/K4cOIdFDnBrseW97eMkT4p5a/ZdQ
         YyA7wy5WNMwHkd4OmkecvIcc/GBkdp7XyLqR8V6RopW8XWAMSG7jJ0ppJZBi+pHNxNDy
         l2OHDTnxx3/eJ4CZglRn4n+RIgvTMtIiUplIfNwgnuldJCfchIzds13tzXA6vKk2WbDA
         doNOyaydy+WNAmXlPWWy3OdjMNUShZkmBYCReoytig6L93u5Ff/F5zVZq9zOM9iXI952
         Ebqm3MKYbGyTBSZ9GBIgpzKPCMz+ix16eNFmlKJFU/hjzzeBEqojJfTA7pp2498xVJtW
         O6cg==
X-Gm-Message-State: AMke39mCLPZIwdUXaRMNKnirrBFPLEAAiVSVVcB4uOEt5inxOgR0BfIQGxySLbK6UuKPlPR0qKigeT1qzj97Hw==
X-Received: by 10.237.36.24 with SMTP id r24mr4090102qtc.229.1486664537409;
 Thu, 09 Feb 2017 10:22:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.106.138 with HTTP; Thu, 9 Feb 2017 10:21:37 -0800 (PST)
In-Reply-To: <vpqwpczlfe5.fsf@anie.imag.fr>
References: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
 <xmqqtw882n08.fsf@gitster.mtv.corp.google.com> <20170206181026.GA4010@ubuntu-512mb-blr1-01.localdomain>
 <xmqqtw86zzk4.fsf@gitster.mtv.corp.google.com> <20170207191450.GA5569@ubuntu-512mb-blr1-01.localdomain>
 <vpqh944eof7.fsf@anie.imag.fr> <CAN-3QhoZN_wYvqbVdU_c1h4vUOaT5FOBFL7k+FemNpqkxjWDDA@mail.gmail.com>
 <vpqwpczlfe5.fsf@anie.imag.fr>
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
Date:   Thu, 9 Feb 2017 23:51:37 +0530
Message-ID: <CAN-3QhpWQ8qt7Bza=c1v4FkTigW127sqFc7qj_m3_tQ0vfbbxA@mail.gmail.com>
Subject: Re: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous branch"
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Jeff King <peff@peff.net>, pclouds@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 February 2017 at 17:55, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> [...]
>> As you might notice, in this list, most commands are not of the `rm` variety,
>> i.e. something that would delete stuff.
>
> OK, I think I'm convinced.

I am glad! :)

>
> Keep the arguments in mind when polishing the commit message.

I will definitely do that. I am working on a good commit message for
this by looking at some past changes to sha1_name.c which have
affected multiple commands.

>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

-- 

Best Regards,

- Siddharth.
