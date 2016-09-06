Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B471F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 17:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938823AbcIFR55 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 13:57:57 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34937 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938515AbcIFR54 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 13:57:56 -0400
Received: by mail-oi0-f46.google.com with SMTP id s131so47495136oie.2
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HinFy2EkhtKohnBwk2opyDGtc8ReWcaXrRb0qaRBsF0=;
        b=MSLk2KcBx1GLFzfFOPfZ/bNaVCDBxyZCGtBkm8/8DfWUFEbAyWalD4qUushNC526SP
         dQey5zyH/g5UML37tBbdf5qiL4cVWTRiDVcKntdtk49fdxuAO4lQjPhM3oN7GWhoQ8Pm
         RnfO5ml/VNns8aCKvEfFJO4YOVUSAMoAEaoUuq712JhawkymyERCzor72S+9yA5dFEeK
         4a3EdPp/6B4mZLYivAHnD2zbzC9FhBoMsMq3KyZ6iwpLJu4vXd3V9gRXVOpdPEdZ7MyA
         ohr17Sf7qxEzj01sHRLYu5tR0sld1n7lAdx6f6iZ4ZPlRK9h8eTkHFVW9GSwFVlTAQiY
         fwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HinFy2EkhtKohnBwk2opyDGtc8ReWcaXrRb0qaRBsF0=;
        b=JAwx+ippipOmaYGtaKLxglOQqbPAoJrvocQngn2Wul//PmklIfHFSfgbW9mSA2i82m
         JWCptfOBfsb9oBzhYrDyIN9v8KWXH4R+MxaBDLxyGzRrUNILpEzMUa5o+UnDWl8O1K8G
         7zxTE/7VudKvcGNLutiPSwhq/NL+i+gnZDXQjODEiROUFddDK2BXb1RGKewWhJp8nRz8
         rP0m2WPrzxc9Kk7nmdr0jp0sU9uLHTx3k/ebJpMKdte/gyVhgFsHvWvTuh6J04+9vgbf
         JYbPeiQwjfi3GGToWj/wXWAhZ311A7BVkvcUo2+L+kUKDRjPdrDYhcc49G30gRG8qYWW
         n+7A==
X-Gm-Message-State: AE9vXwNOKafBdVZU0oIwUScfwJldfLUTinbzNNcv0BVNU13osBBGomStILYsCdmbAEZFxtV+LQ2nUzVVXiyN4Qpc
X-Received: by 10.36.217.131 with SMTP id p125mr32041954itg.46.1473184675068;
 Tue, 06 Sep 2016 10:57:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 6 Sep 2016 10:57:54 -0700 (PDT)
In-Reply-To: <20160903031648.14465-1-sbeller@google.com>
References: <20160903031648.14465-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Sep 2016 10:57:54 -0700
Message-ID: <CAGZ79kZt5M60xC6w1_12U1M168uJ3MGE2-ikoDx96kzYpfHVug@mail.gmail.com>
Subject: Re: [PATCH] xdiff: remove unneeded declarations
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 8:16 PM, Stefan Beller <sbeller@google.com> wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  xdiff/xemit.c | 9 ---------
>  1 file changed, 9 deletions(-)

Despite the moved coloring patch moving into a different direction, I
think this is still
an improvement to the code.

Thanks,
Stefan

>
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 49aa16f..b52b4b9 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -22,15 +22,6 @@
>
>  #include "xinclude.h"
>
> -
> -
> -
> -static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec);
> -static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb);
> -
> -
> -
> -
>  static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
>
>         *rec = xdf->recs[ri]->ptr;
> --
> 2.10.0.rc2.22.g25cb54d.dirty
>
