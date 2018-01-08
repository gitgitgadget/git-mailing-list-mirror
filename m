Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A8D1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 14:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933588AbeAHOmw (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 09:42:52 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:46477 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932494AbeAHOmv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 09:42:51 -0500
Received: by mail-ot0-f173.google.com with SMTP id f6so1536118oti.13
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 06:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IPwHhNHJ1k1tSc6Au9kTJz9SVEdnv/hAEk7PkS93vzE=;
        b=mLwsQHjsADnZ8DjVc6sV3IWnRE/o4x/g4aYZrmRVmlBsOzmPUSDadH0eidOhjBZ1lF
         m7YEmy6MC0DFzSK2qrLaU+vYNECsDWGuUgfhLeiYrZki3xP8tOEZwZQ2LY1+kUHMtHah
         i0tjQWKXFH5SsC1Nj/FoTmYVF0HuIOog0ur1scRMTNn3yA/1lsuk7wj/ZEZJbFm1EkR8
         pBPDUPP8T7HWA/qzZXoO3CLxc8EM9KZN57NviDXXPPX4siOSKotMOucHkyKJNkb71N6k
         NFMXLWvSQHbdgOn+kdlIXctUgKpabDYVt4qtWWrgCoRZ3wrGwIpgWeXEY1lg9djPWdU6
         jXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IPwHhNHJ1k1tSc6Au9kTJz9SVEdnv/hAEk7PkS93vzE=;
        b=RE5ZGtDFIgIkVfDKP3E1PWTF3ABXamtBb4Vyj0GUBnAxDS0YvnoGfCadAzN8PbWRpm
         Jsk0DJryDK9uZawTRQ5qltswTchuobeMR4sh+CsFDtPwJcW5qiaMbPqW8ZbKXM3vv1GO
         VRVxXDSkojZMh0Qdcd3CpSSKgrgDbbyhI4cfgA6vVWgPXJoEKdgc4mp7cp/iwhRlGbun
         IlKbU+Ib6NQeotYqEwY9zq1jGmrJK+GozQ4R0x7nVi/6X0ScY+u2YhsrULzydQk6Aq2d
         DOkPv2TyvRUuLMdrYhLHy9VSv8XrAzNstcq3zOKW+7RXGIAsYFuNFiGZxtYXGh462eEN
         Gryg==
X-Gm-Message-State: AKwxytcsUmnVo8NUely+VUQzXOsQ/b0n1fr+7KK3BXAYTe2ipOr8icrJ
        mPb7aIXTt6gabpDfeKSWbwuDasWOfBRExfEkU54=
X-Google-Smtp-Source: ACJfBosrfmfgNUvJYLVw5CrftDGdYDML1IvE7N3rlehvt2RpTN7To3Szbc5L91qmD6OK1214JXAxwtMIsrNpyxpjZv4=
X-Received: by 10.157.4.98 with SMTP id 89mr7176862otc.313.1515422570179; Mon,
 08 Jan 2018 06:42:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.73.21 with HTTP; Mon, 8 Jan 2018 06:42:29 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801081452290.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAJs94Eas59UxZ+490AUSOuB37i+JBEvbCnGBMVpKi1G469OTbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801081452290.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Mon, 8 Jan 2018 17:42:29 +0300
Message-ID: <CAJs94Ea52CcNvBxXVeZLvgsaS4YPiXaeDvRm2zUopoLVowgm+Q@mail.gmail.com>
Subject: Re: rebase preserve-merges: incorrect merge commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-08 16:56 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi Matwey,
>
> On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
>
>> I think that rebase preserve-merges algorithm needs further
>> improvements. Probably, you already know it.
>
> Yes. preserve-merges is a fundamentally flawed design.
>
> Please have a look here:
>
>         https://github.com/git/git/pull/447
>
> Since we are in a feature freeze in preparation for v2.16.0, I will
> submit these patch series shortly after v2.16.0 is released.
>
>> As far as I understand the root cause of this that when new merge
>> commit is created by rebase it is done simply by git merge
>> $new_parents without taking into account any actual state of the
>> initial merge commit.
>
> Indeed. preserve-merges does not allow commits to be reordered. (Actually,
> it *does* allow it, but then fails to handle it correctly.) We even have
> test cases that mark this as "known breakage".
>
> But really, I do not think it is worth trying to fix the broken design.
> Better to go with the new recreate-merges. (I am biased, of course,
> because I invented recreate-merges. But then, I also invented
> preserve-merges, so ...)

Well. I just checked --recreate-merges=no-rebase-cousins from the PR
and found that it produces the same wrong result in my test example.
The topology is reproduced correctly, but merge-commit content is
broken.
I did git rebase --recreate-merges=no-rebase-cousins --onto abc-0.1 v0.1 abc-0.2

>
> Ciao,
> Johannes
>



-- 
With best regards,
Matwey V. Kornilov
