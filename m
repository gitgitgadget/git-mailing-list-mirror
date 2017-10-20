Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08191FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 20:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbdJTUo7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 16:44:59 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:49412 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdJTUo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 16:44:58 -0400
Received: by mail-wm0-f53.google.com with SMTP id b189so86845wmd.4
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yF5KR2D5u08E0xbK0WqloODQdSu2HAf7SHQrUaDfZug=;
        b=Gu4HZ+a6ORsfVDfudabgLTh4vC9/NBMgvI2kkrq5Nt0UZ4zF0lm6jjueCYGnthasdL
         ZDJga0eek7vcqd0giNQszoYPzaAWmAPinbQVGbytigNlUzWeRB0WkLLsYUYJnnJvkd7l
         qeo3KL2y66puTsWaWrt6Pi7GjkNUKWTLrLVVvpUs3dEpai3pXavQNLPyqdlMynYXWVa8
         myYoR2nu/CGiRBESh9nQ//LLkv6XNAf6Z+6EAezRoubH91QlOw/GVEIHfwfu4Mq5XgJA
         92h23Bm3xa9OuEQVdvtMzmmeRC614FrVBmaTt1O2cjEz+JFM83VmK8HqCgY0fICHwt1V
         fDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yF5KR2D5u08E0xbK0WqloODQdSu2HAf7SHQrUaDfZug=;
        b=Rx2r40IAXcGVL6nOuPpIWJT9B9uDY661EaGbwXpTWqO2uu4kq/wWabsabS/O4Bk8/o
         Wg4ZDPs6i0LWI1nZ8m9gpDseqq+KRtHsb//0UeTB4PYE929k6QjBFTtn96FKyUCXDS15
         TjlAAGltJ8W+u61BAA5k6hDcGxZIqdkGwUgneXQmgqTyS76698xc4w35uDFW13R9eJKn
         1AbtVV8F39xVuTK2VeVcEomk397hOlHuXmRv/EBuZcreFnXeJT33faBsuLDNpFnr5ce1
         WNIlq/HHm67Sr0ttlYreTCDDEvgtNeSnKuu2DfTaFGYkSlLplqkUp4mTc6eRTgIz/BNW
         rV7w==
X-Gm-Message-State: AMCzsaW5HxVxIYplm5xCPVeTPCWvitTvyUOLD7uHKPwD9yvTfkUn8cK0
        EmUaRrMvk+/14Y5eb38XOoK/pb+1giAkMROlmJtJ0w==
X-Google-Smtp-Source: ABhQp+S+RYoHzgfZof/zKJPX1OlWbBVsWG6uGa3/yHE3PB8ail+N5mzSXXjOLAXIGgv9RHkTxuo++RS7osu4T3su/Sg=
X-Received: by 10.80.208.222 with SMTP id g30mr7623840edf.246.1508532297419;
 Fri, 20 Oct 2017 13:44:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Fri, 20 Oct 2017 13:44:36 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1710201105351.5973@qynat-yncgbc>
References: <nycvar.QRO.7.76.6.1710201105351.5973@qynat-yncgbc>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 20 Oct 2017 13:44:36 -0700
Message-ID: <CA+P7+xpdWJbxtxAggRpYR3eE8qjH6TfbYQS_=20aZM7d2RbC0Q@mail.gmail.com>
Subject: Re: hot to get file sizes in git log output
To:     David Lang <david@lang.hm>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 11:12 AM, David Lang <david@lang.hm> wrote:
> I'm needing to scan through git history looking for the file sizes (looking
> for when a particular file shrunk drastically)
>
> I'm not seeing an option in git log or git whatchanged that gives me the
> file size, am I overlooking something?
>
> David Lang

I'm not exactly sure what you mean by size, but if you want to show
how many lines were added and removed by a given commit for each file,
you can use the "--stat" option to produce a diffstat. The "size" of
the files in each commit isn't very meaningful to the commit itself,
but a stat of how much was removed might be more accurate to what
you're looking for.

Thanks,
Jake
