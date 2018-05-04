Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CDF1200B9
	for <e@80x24.org>; Fri,  4 May 2018 03:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeEDD2A (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 23:28:00 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38679 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEDD17 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 23:27:59 -0400
Received: by mail-qk0-f196.google.com with SMTP id b39so15637811qkb.5
        for <git@vger.kernel.org>; Thu, 03 May 2018 20:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iNJGGR9R+4MTl/Tl7V2j4Fs+wLgH4ufZLp+XLEfxB0w=;
        b=R8i32ZNne+qFmRLqBhNIOYMFUPPDCmj0bzsXEqanIlmjZr6sF1Roq7qi7hO9fSpCTE
         e0oZrjKf9N9vAvysPmqtMaHiWzt0g3cqZhT//t8x8kYUPMXDBg0kGordbE52ljdflGuR
         uWF/LyxhddJLZWhktfreMb4spcVxM7cw+8msITuBjjPobmLJXSthGiMHjCDZKgxncbwJ
         fJwkVDNDtaGT31Jl4nErqI0W56GL5iJ+5okABoe5M8qalZsctTboRhLb+il/3zlH5+5y
         gy1xDLn4gLrqMniC+9Ov1jyfONjCIUyCTuJe13D1jWrkVUpzYsMmySg97jeZq0QwpVn3
         9xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iNJGGR9R+4MTl/Tl7V2j4Fs+wLgH4ufZLp+XLEfxB0w=;
        b=Z2Af3ewx2UFWY5D5Vh8nWwyA4SUmHL96vn3z9cZmKx54C+yBNqlzjVBUI1CXpIdk2r
         DihuuRHF1EtBfXsMq8E39pYe9pbiX+f7fXxUERC7/6V5C3AhsoQezWyG5ul8Hl8lfC5w
         mzbvwFOJqPFXHd8GS54pTK2UQ6nTiHyvuFV6ovaUnbT67oWu7FUx2Gz/fS0pax2oD1nZ
         qjTH6r7zi95SM0GSwLeTA/ZP6jSVbLb8Ym0PnAshm/mOM7qkWyLgqsajNi/nO6QNxK/l
         gJx8guSzCHGuXwBjk7biGjITf4SwpHWZmghMt8fYKMtShGRHfyxwnLUfwixQKZSUN32C
         iqrw==
X-Gm-Message-State: ALQs6tDVNSwJirZHR9N35PHj0QeolbZL7qWSxW4wkTIhsuRgrL9EoaUd
        MNvwvqm6+m2n9aowM0+A80XDsXurxGD3YQEAHuE=
X-Google-Smtp-Source: AB8JxZqTBbdeyHXyFlAg3ZC4Bw/6eGD2OJ+guGWSsVF9s5wxvo3kLcUXFbTYaMn/7kmpSq5BrwHkpmvP8baft4+CQpc=
X-Received: by 10.55.108.198 with SMTP id h189mr11145384qkc.2.1525404478419;
 Thu, 03 May 2018 20:27:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Thu, 3 May 2018 20:27:58 -0700 (PDT)
In-Reply-To: <edb34bd4f8da7437efb20e442780f17e9f84fc73.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <edb34bd4f8da7437efb20e442780f17e9f84fc73.1525361419.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 May 2018 23:27:58 -0400
X-Google-Sender-Auth: w9C2emf9rIezh865nVyb-G9ua4M
Message-ID: <CAPig+cR0V-UgKg0iDfAXLPiSANLv2b3CbwGNKk=VBvrZjX5FdA@mail.gmail.com>
Subject: Re: [PATCH 17/18] branch-diff: add a man page
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 11:31 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This is a heavily butchered version of the README written by Thomas
> Rast and Thomas Gummerer, lifted from https://github.com/trast/tbdiff.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Documentation/git-branch-diff.txt b/Documentation/git-branch-diff.txt
> @@ -0,0 +1,239 @@
> +Algorithm
> +---------
> +
> +The general idea is this: we generate a cost matrix between the commits
> +in both commit ranges, then solve the least-cost assignment.
> +
> +To avoid false positives (e.g. when a patch has been removed, and an
> +unrelated patch has been added between two iterations of the same patch
> +series), the cost matrix is extended to allow for that, by adding
> +fixed-cost entries for wholesale deletes/adds.
> +
> +Example: let commits `1--2` be the first iteration of a patch series and

s/let/Let/

> +`A--C` the second iteration. Let's assume that `A` is a cherry-pick of
> +`2,` and `C` is a cherry-pick of `1` but with a small modification (say,
> +a fixed typo). Visualize the commits as a bipartite graph:
