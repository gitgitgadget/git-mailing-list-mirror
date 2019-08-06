Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24641F731
	for <e@80x24.org>; Tue,  6 Aug 2019 07:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbfHFHQP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 03:16:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37797 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731807AbfHFHQP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 03:16:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so81417375eds.4
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 00:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDfrzGKXzj1k0yhHrnWIV6jALE52vuibZnkGyfwrM+k=;
        b=YD6ZaGu+qrVhANO/YHPl//E8Bv6Z52XpAFkjGrgn/Ziow1vTfAM0xzD1XNCG+1S3g3
         mPmKGiS3Nu2UlKCIiLDfwMlcJi+ikDhTH7Rr3pkZ/S8mkJycooGT01oSlQF9HxAoFKiC
         1JAdyu5FGvMRLsizGwx+NURRqy6t+a8lSz2NI6SESMhIhInjbFHXIq4mJPDPzyuKxybU
         fpPFsAEcfyNWsiOX/ZmcbtfUsdAEq5IXUx7R/zB9t596hJ0TfMLP5KkLN6BCD2Z72Brz
         /bNeyKi1dBCNIbW0Wr0fyPpKcuyUYTHS0N8Z0ei9U5mtpcea4B5JKtzllDRQUQFBQS4U
         +JwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDfrzGKXzj1k0yhHrnWIV6jALE52vuibZnkGyfwrM+k=;
        b=p8nuYXjaeqNSZBF6JqIIDiPfU4uSpsU1jyPpOwPUe3tDdIh/acmHEMq1pD3+d1HtmH
         0gtogDFUjb/pCzCHHKSGfLyYaBi7uAyvZQ1SbNziIoZHcMxL4MY0fJwX/NM0wrjJLJbc
         u9+sveSMgFoNttjUXGLz/8Q6FEvc9xmDlZdQHoJjhRoJGj8qbhtzeHzE0EvBKPo2S9vv
         uSv0aHsN57mMKjRAFmfPThxFfQvheJXP4fG53jXa/XVmjyDewKf/2c3d5j3RYsaswmd+
         vwYloXXMqiKMtQh/BsEz4veM5cJGWDJMt2b86t8FqQs2FEBIlVG0maM8e0uFKHVoZed8
         g9dQ==
X-Gm-Message-State: APjAAAXyQOudbdsAdmNL3eaqMT8B09ZUYnOpaeM68ln0KO29uVhdcjPx
        KUmhgsyZC/01RRZz3b6ka8VqEMUW8ZRPNI5/sPQ=
X-Google-Smtp-Source: APXvYqwLEYQbVTnwfp0t96KrvK/uOwSNTeG/plWrcY9voZ21g+R1EJcGDK+CKURcdlCbxvwjsajOn8VnPiLpArSMsBQ=
X-Received: by 2002:a17:906:e91:: with SMTP id p17mr1763691ejf.217.1565075773457;
 Tue, 06 Aug 2019 00:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
 <CAHd-oW7pT=RhsCnkhRzGDy1gXWN7a4AnwdYCNa6q6uri1O51FQ@mail.gmail.com>
In-Reply-To: <CAHd-oW7pT=RhsCnkhRzGDy1gXWN7a4AnwdYCNa6q6uri1O51FQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 6 Aug 2019 09:16:02 +0200
Message-ID: <CAP8UFD1HgjcQDS2ypJVe_r3-Jpy1ENNGR+kCfa72Kmht28ZNJw@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Tue, Aug 6, 2019 at 4:54 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> Here's my report from last week:
> https://matheustavares.gitlab.io/posts/week-11-wip-grep-protecting-textconv-and-submodules

Thank you for another great report!

> I'm working to protect the operations I left behind on the first
> version of the patchset[1]. And for that, I used a lot of the code Duy
> provided[2] me as an example in the early days of this project. The
> race conditions are now majorly gone, but the patches still need some
> refactoring and there are still some problems to overcome.

This looks good to me! I think you are now way past the point where
you know much more about this than me, but anyway the following might
give you some ideas or perhaps in some other ways help you:

  - About "Try to remove the obj_read_lock", which is the last point
on your TODO list, it doesn't look necessary before you submit a patch
series, unless there is no performance improvement without it. You
could, as far as I can tell, do it in a later patch series.

  - I guess " --recurse-submodules" is not used very often with git
grep. For example I never use it on the Git repo even when I perhaps
should. So if it would simplify things to just disable the
improvements you made when " --recurse-submodules" is used, then you
might consider doing that. You could later send another patch series
that would enable your improvements when " --recurse-submodules" is
used.

Thanks,
Christian.
