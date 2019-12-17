Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7376AC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401722176D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfLQTgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:36:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38732 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfLQTgc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 14:36:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so4498708wmc.3
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 11:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7d7v7blGXnnZSt1gVxlQKtmfMMU+VkSHQFD1Epzvb0w=;
        b=AKgzhC306PDyL6qdFnWWMI/mgEodRlGA12AGbq28nQZ+nTO71rpeYtQQ+HB+h5JCVk
         KRbW170TIni3LX83SFzEKuMZ5CDGqNH2HxEgwamvFXXtY7OE96dnnjHKGfy1zZSuVrUw
         b2MhQRgWKTsrYokZdQWtzkrhIOnjQ87kitC+3oxOZC91v+XybvazOHvj4V9qdoLG+CGq
         e0fSyQE1d+JzeHEE6eiGQidgHLMl+j2vV/hWfqgYV0U1y5zK11mX7/7kyYi8NL60dz0C
         zdh1g0pFyxvUSGIULZu4lVyhk/S8lb0CuJvaIMAXjHFWG4YvSY2CnWuxXwowqCxSrhC1
         9IAw==
X-Gm-Message-State: APjAAAVxpfdNtkS84w4tvhhEulqw7Y8G788EPJ68Kw/9+09468mcp9AN
        CPzPuZwtnh5yraTs7JhY1wzVFItW2UPMwfYqlhw=
X-Google-Smtp-Source: APXvYqxtH4sRklahu07pSaRB+pwalzir0HX1f5eJF3sRA1prKnn0ND6FCBHRZ2WuvNLTfi8UtJmCncZ+J4HTJRPb0mI=
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr7203473wma.84.1576611390368;
 Tue, 17 Dec 2019 11:36:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576583819.git.liu.denton@gmail.com> <8adc5cd5aaeef76ddeef459c79ecec7a05a1fd7b.1576583819.git.liu.denton@gmail.com>
In-Reply-To: <8adc5cd5aaeef76ddeef459c79ecec7a05a1fd7b.1576583819.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Dec 2019 14:36:19 -0500
Message-ID: <CAPig+cRupjwrfoccta1JyjuB1hNhVGOP=as+dDQ8BhUVcYX3nA@mail.gmail.com>
Subject: Re: [PATCH 08/15] t0020: s/test_must_fail has_cr/! has_cr/
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 7:02 AM Denton Liu <liu.denton@gmail.com> wrote:
> t0020: s/test_must_fail has_cr/! has_cr/

Cryptic patch subject. How about being consistent with other patch
subjects in this series?

    t0020: don't use `test_must_fail has_cr`

> The test_must_fail function should only be used for git commands since
> we should assume that external commands work sanely. Since has_cr() just
> wraps a tr and grep pipeline, replace `test_must_fail has_cr` with
> `! has_cr`.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
