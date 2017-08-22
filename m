Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5EB1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 22:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbdHVW0S (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 18:26:18 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35245 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdHVW0S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 18:26:18 -0400
Received: by mail-oi0-f45.google.com with SMTP id r200so798838oie.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 15:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bnVUjGwfd7FlOgNM31+0S/Tw+xRyp5edB/uLHqD4gbQ=;
        b=YWX5gqd04ZAxISDATM6JlPae+f3wrXzF0g8pPcqwYCK1ZyIujxfnhgiJImVshLdE1w
         lj/X23Ic5qc0rpAj//5AJR8tHKSL5/NuBNot2BKB6yB33BJvAapfQuCyJOv5V6FdQTOB
         lU55F6E0PIdzPxvpBlG5jkA23TeTWZyWH9LjZYMxoUZg1ANqrdlb2XeNNpV9nWtlSuM/
         HqJr1V2iTszupOxiV93r08AstznREn1NK7slc7T/qR87/11Zf92cjVm4yRD8/Vg6R10B
         qUfVUsPWIBDGobh3GH5gBOsfd2XDFiwfJytOeXADv218N0umZemjDzY9l2L+JW0gMrDt
         V3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=bnVUjGwfd7FlOgNM31+0S/Tw+xRyp5edB/uLHqD4gbQ=;
        b=mg0itrqBLKoZB8fDo0EReLqVliUNr1HKrrq+pzrBUj4xQDK73I2sdGzF1rBREPc8P5
         cA87LAXxDcaAnXE654KLKrxvV8WPHeXOhu2QqiRZ7+xKYev6kFFjZcUb2KpdkARWk6ef
         EpWdj4ln9qiMSLkzxJ6/r9rYB/snubD5Yh58Ct5KDpS2K5cn+Rhd85aPBDSObmUNu6b8
         uSD/ju3E7FcXH1wMKvoI+PKDKcl/xXgTEOyEqQcftcy53iKU3KIfeqHDlgNwjarIhCqa
         aMgaG7yh+3Eiif2479SH3lwyT6E4vnGowyevqcChpDbwm71Ap14W+pvwr6z23uxbIFDw
         uXng==
X-Gm-Message-State: AHYfb5j6uBFnZfun9hCUyMQGalZuM3GCuTAHNWQoV9yIxT3aQKO9PW6u
        fMspRD3o1vJTPsZYwMMxl1qzZbe2QQ==
X-Received: by 10.202.182.10 with SMTP id g10mr920070oif.173.1503440777609;
 Tue, 22 Aug 2017 15:26:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.98.28 with HTTP; Tue, 22 Aug 2017 15:26:17 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <CAH8yC8nHnbWTG4hxD+mEHKPS6eWcBb7yMsgN886=aTWaBRhE5A@mail.gmail.com>
References: <CAH8yC8=A0-geqduTNNJw0yb1BREqsB75_bKSp+06Rb5fY6oiuQ@mail.gmail.com>
 <CAGZ79kYyO4zvmTvMpxpFyBEs4f=xoy_-UeSbmi9W-OCFz0kCwQ@mail.gmail.com>
 <CAH8yC8nu7zDmkQMZ99SpePXL1WpvvcOdQDAtwdo4WXiPiR3tOQ@mail.gmail.com> <CAH8yC8nHnbWTG4hxD+mEHKPS6eWcBb7yMsgN886=aTWaBRhE5A@mail.gmail.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 22 Aug 2017 18:26:17 -0400
Message-ID: <CAH8yC8=HuAZ0tJbRGnp83-Th5OkQ0-cdSOBrMU23y6NyB0Ax3g@mail.gmail.com>
Subject: Re: How to force a push to succeed?
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>> Commit seems to be the wrong command as Git appears to be trying to do
>>>> something I don't want.
>>>>
>>>> How do I force the push to succeed?
>>>>
>>>> Thanks in advance.
>>>
>>> Checkout the --force[-with-lease] argument.
>
> Thanks again Stefan,
>
> From another testing machine, it looks like the changes have not been
> backed out. The previous operation un-did the ADX gear because it was
> an evolutionary dead-end.
>
> via$ git pull
> From https://github.com/noloader/cryptopp
>  + 66654dd...559fc3b master     -> origin/master  (forced update)
> Already up-to-date.
> via:$ cat integer.cpp | grep ADX
> #if defined(CRYPTOPP_ADX_AVAILABLE)
> # define CRYPTOPP_INTEGER_ADX 1
> #if CRYPTOPP_INTEGER_SSE2 || CRYPTOPP_INTEGER_ADX
> #if CRYPTOPP_INTEGER_ADX
> extern int CRYPTOPP_FASTCALL ADX_Add(size_t N, word *C, const word *A,
> const word *B);
> #if CRYPTOPP_INTEGER_ADX
>         if (HasADX())
>                 s_pAdd = &ADX_Add;
> #if CRYPTOPP_INTEGER_SSE2 || CRYPTOPP_INTEGER_ADX
>
> Above, there should be no references to ADX. Looking at the GitHub the
> changes have been applied.
>
> Any ideas?

You know, I look at how fucked up yet another simple workflow is, and
all I can do is wonder. It is absolutely amazing. Its like the project
goes out of its way to make simple tasks difficult.
