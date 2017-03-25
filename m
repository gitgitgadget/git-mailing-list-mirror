Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73CC2095E
	for <e@80x24.org>; Sat, 25 Mar 2017 19:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdCYTwC (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 15:52:02 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:34866 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdCYTwB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 15:52:01 -0400
Received: by mail-it0-f42.google.com with SMTP id y18so38875338itc.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L+/DrAIyslB5aP4Al8OV1T0NwJo6dmYPkhpfrbDC2Ec=;
        b=J8Ou3bkMF1NEZK1mc9wc7vTM1POVwbpEhLzKh/cZ07t4IKw6M39NgLqEcvwb4wFluL
         +pHVUGFUc0QEqzIUObsaK1Sm7/y1KDoK7ulr5rpdUteN66Fhb0cq1fADp9W+4Dh9aW4f
         52DDtQKhELqSYLA8zEdXeH+U/NJvUIF+B8ivPiD7eebcMkkbzHYSfTwgmxjcIDkVmbBX
         QGA4qsc0hEl8hpFVCMt0+iZLtXUPaAUtS3iCIXXpekhcSYeGCBpM6pNV5QjvP2gUS7IW
         vUyDqa1JyoF0jChJsPe3ZHTBu0q+FjxUtJAR9x6mNWKQI36P0m2byE3msWA0E1s1cQh1
         R0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L+/DrAIyslB5aP4Al8OV1T0NwJo6dmYPkhpfrbDC2Ec=;
        b=Lh8IIQW0mixLVFNWQmjX9MX0Vj2zKCVzYaSGO3trQ/PBsam8wwUIyA3XBSpSE90b1x
         3aCh5PbhQEtNUq2QNChGsshqfDpbeW8O0J8y/SpZycvT7PhPSHKCZl/yoEwgwTgugNxi
         0acxQgLERTeprrzbqjWZvDHeAqWdr1ddaM6S544a93x8GLaoZ5NyE10CFqV4XiNqDT2W
         ppAZCJwYoYQ2M2A53NHkEClw+kBiAhXhdRqSnbwY0hiVEXnsHzEHwPVBIhSS/H42TEcc
         nnL/d2GfqPx9my7LszAZZ+0QiHz1Mzu8hZ624rO8WlikbiAItIZenIgSNhRhZ7PZVpIB
         bILg==
X-Gm-Message-State: AFeK/H0ydYRZ5pNBQ5S3GzG/tkrn5aVn3sbtBSkOM6hFz3tUWIFMypzzhjFwSBYm1LmhfKVwn0wJBjgCwYXzsQ==
X-Received: by 10.36.116.71 with SMTP id o68mr3339420itc.60.1490471519996;
 Sat, 25 Mar 2017 12:51:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 25 Mar 2017 12:51:39 -0700 (PDT)
In-Reply-To: <7a2444f08dea1b2fe497ae7498eba44626414d29.1490397869.git.johannes.schindelin@gmx.de>
References: <cover.1490397869.git.johannes.schindelin@gmx.de> <7a2444f08dea1b2fe497ae7498eba44626414d29.1490397869.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 25 Mar 2017 20:51:39 +0100
Message-ID: <CACBZZX64wCFFG9WFEmAiB7vtAfP1uwcgMx8HwA4Hx8jtF5pKOQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] Makefile: optionally compile with both SHA1DC and SHA1_OPENSSL
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 12:24 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The collision detection is not for free, though: when using the SHA1DC
> code, calculating the SHA-1 takes substantially longer than using
> OpenSSL's (in some case hardware-accelerated) SHA1-routines, and this
> happens even when switching off the collision detection in SHA1DC's code.

[...]in some case*s*[...]
