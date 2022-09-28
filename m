Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D355C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 23:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiI1Xfp convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 28 Sep 2022 19:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiI1Xfo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 19:35:44 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F2075FE3
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:35:43 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-352ffac3941so39463167b3.6
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XUmARWGBgUbwMVW8njeCny8ULxaj77BhP0SRWWJCztY=;
        b=2uBz+f+3zvcO0FmXRHLbdQVpukUxFIjOqU213gTHYi33WTZFmPLiAUFHulh17IfEaG
         PnZAYQelV7aqQyLytirDfZZhQVwpWX/SLRlCnLVY7RrK1yOCy//4hAbzfB9hqvdAQ2fj
         EltoSaoLXPbwFmtHaqQHM/cfF2DB7S0AnzWVIe4qKpW+Dlyz0PENYF+ZJtDX4zZyHTwW
         2qVzj/LnxxNdpUw6p4T7V4UpkfZdN27th1dZ+s9O168q9XX9i7AQExRuU+oKNFNlY4H3
         4tYnq7rBrxQmmK9FNPUoPytMqhMZMWw7NjiBxNm3DZj+8jDly16T1Vvg3ZoL0q7T/AqB
         61Hg==
X-Gm-Message-State: ACrzQf1dP7nUm0TmXThrBJAiAQzTS4vF5Ca+jEapL1MnPDisxAe311fd
        VlYdPp6mk5Iu4OCHvUfQAcdl/26wk5i1r5uEuvY=
X-Google-Smtp-Source: AMsMyM7JC5QviPld8EzwjLqjCXtol2lQcYWjMS1FFngCeR+wiLsQrkgiWxl2skAMeZWXI5YcDZ5qRp0sHsMHAEh/I8c=
X-Received: by 2002:a0d:e244:0:b0:351:ce09:1b13 with SMTP id
 l65-20020a0de244000000b00351ce091b13mr434833ywe.332.1664408142170; Wed, 28
 Sep 2022 16:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <patch-v2-02.35-63145b58504-20220928T082458Z-avarab@gmail.com>
In-Reply-To: <patch-v2-02.35-63145b58504-20220928T082458Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Sep 2022 19:35:31 -0400
Message-ID: <CAPig+cT+-bT0FUVYaGnMqwbAYasJPp2Ci+gC8=qRPf7vpxj=gQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/35] builtin/bundle.c: use \t, not fix indentation
 2-SP indentation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2022 at 4:41 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> builtin/bundle.c: use \t, not fix indentation 2-SP indentation

Not worth a reroll, but doesn't this have one to many instances of
"indentation"? Also: s/fix/fixed/ ?

I'd probably have written it simply as:

    builtin/bundle.c: indent with tabs

> Fix indentation issues introduced with 73c3253d75e (bundle: framework
> for options before bundle file, 2019-11-10), and carried forward in
> some subsequent commits.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The patch itself makes sense.
