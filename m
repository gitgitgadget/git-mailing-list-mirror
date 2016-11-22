Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6722E1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 18:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933909AbcKVSJ0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:09:26 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37575 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754975AbcKVSJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:09:25 -0500
Received: by mail-wm0-f47.google.com with SMTP id t79so38698101wmt.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3JzLBM3Xo7qusCaSwCNW/j+07OeUoHBKedjJLG2ZTg8=;
        b=YrbXxocLLPxNrTA9KJkp14/pT7zoLdqsYz2enVupDyCm3oD18bcofuNzD/UboxOUTx
         Qjcg1z0imyhEiNNgrNErIgCo2OmKO11PLg6oZeYt4oYhLkH10mrHXDLnVNiIBgJet0b+
         Q+y3B/mFsqFtNy6Lsah1QgshtYvBhOTKyznzzC0itjeewSgV8FKDiREmxKVs+SpB6DAb
         jr8dljVJaD5b7HHqNf7EHQxG3Hw2Y4NivVhyk808W4ZNvQCjnBc3gtqB1DxYGKdP15ae
         IcE/hsMBVY4UZQHwaFDM5iRWCw/m6lV+p2hgBgn3lSt48sgcf+bMw00nPSUC6zgzjtGR
         Zvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3JzLBM3Xo7qusCaSwCNW/j+07OeUoHBKedjJLG2ZTg8=;
        b=BYugbCEe2+dXox2/P5V6pK2N68+jsep8YNZgME3BgzLGVxtim+9JjpZg6sK2L+L2Uw
         CJyfdB43TfOpV0c+uCpBzW/iLBqU4K0S878LkJcK0hiSjhSM3MIo+9nXVVnv8uQMSdJ5
         /Ie76qVslion8xvjsrdR+i5AvMtjuuINYHdpaXRPFABJ/wX2GJgZjzC58edB6GdinNYw
         tWmU/9qKpiZadczdQtUvGquVwSLs/NmODVMqCuuIyFX4Vq0qZ1g3tlt5/iNo9p2ZPTM+
         5CT/d2GXxynKcWjAT4TZ88f4A7fEeCiiRfPM3nqjI2TjTc44WMDCKxcAKSB1wKLMr4ah
         q+rg==
X-Gm-Message-State: AKaTC0116Tagh8Tzh9VEqBLqToU/IMw/VddyWw+4L0lptr4jT8PtfiinGmyn9oCAnXmIEnHCyVvuq4kfuSsmXA==
X-Received: by 10.25.5.7 with SMTP id 7mr4870533lff.125.1479838114527; Tue, 22
 Nov 2016 10:08:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.21.75 with HTTP; Tue, 22 Nov 2016 10:08:33 -0800 (PST)
In-Reply-To: <20161120201744.7ym4gsmjoijw6oow@sigill.intra.peff.net>
References: <CAEYvigJ14xYDmRG2N0yTgM4spaaB7s9923w0+e9+QQEeFz0NTQ@mail.gmail.com>
 <CAEYvigLz3muWD-QFjMZUn=H3RQoxhTYX9EwB6=aiMjWOEN3CBA@mail.gmail.com> <20161120201744.7ym4gsmjoijw6oow@sigill.intra.peff.net>
From:   Matthieu S <matthieu.stigler@gmail.com>
Date:   Tue, 22 Nov 2016 10:08:33 -0800
Message-ID: <CAEYvigLLQq2SK60UsiTPCxpptpjz85_rGtDVugjfu-sCT1juGQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IEZ3ZDogZ2l0IGRpZmYgd2l0aCDigJwtLXdvcmQtZGlmZi1yZWdleOKAnSBleHRyZQ==?=
        =?UTF-8?B?bWVseSBzbG93IGNvbXBhcmVkIHRvIOKAnC0td29yZC1kaWZm4oCdPw==?=
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jeff for the answer!

You are right, I should have compared with the same regex, and indeed,
--word-diff-regex=[^[:space:]] is also much slower than just
--word-diff, although they do the same job. Maybe this is a hint that
the --word-diff-regex code could be made faster?

I have a small understanding of git, but is git diff computing the
diff value for the whole file, and then showing in the terminal the 10
first values? In some cases, it seems to be a lot of unnecessary
computation! Is there any possibility to ask git-diff to only compare
say the first 100 lines? Or compute only when necessary, i.e.
when"enter" is prompted in the console?

Thanks!

Matthieu

2016-11-20 12:17 GMT-08:00 Jeff King <peff@peff.net>:
> On Fri, Nov 18, 2016 at 03:40:22PM -0800, Matthieu S wrote:
>
>> Why is the speed so different if one uses --word-diff instead of
>> --word-diff-regex= ? Is it just because my expression is (slightly)
>> more complex than the default one (split on period instead of only
>> whitespace) ? Or is it that the default word-diff is implemented
>> differently/more efficiently? How can I overcome this speed slowdown?
>
> I think it's probably both.
>
> See diff.c:find_word_boundaries(). If there's no regex, we use a simple
> loop over isspace() to find the boundaries. I don't recall anybody
> measuring the performance before, but I'm not surprised to hear that
> matching a regex is slower.
>
> If I look at the output of "perf", though, it looks like we also spend a
> lot more time in xdl_clean_mmatch(). Which isn't surprising. Your regex
> treats commas as boundaries, which is going to generate a lot more
> matches for this particular data set (though the output is the same, I
> think, because of the nature of the change).
>
> I would have expected "--word-diff-regex=[^[:space:]]" to be faster than
> your regex, though, and it does not seem to be.
>
> -Peff
