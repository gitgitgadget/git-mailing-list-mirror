Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A66C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 06:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CA660FE7
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 06:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhJVGuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 02:50:32 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:46866 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhJVGua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 02:50:30 -0400
Received: by mail-ed1-f51.google.com with SMTP id z20so1307890edc.13
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 23:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5OQNg3CO3eq+uwZIXiWhOIiY+KDcPTFTaWK0vn8jos=;
        b=ap/YCQN12a4Z0k5eXdu3SfWSA8Fv1CMC07qh00HQ1ZlcpitF5ZWRyBzNwOMeTw1Ic8
         +liZ/Bbs/DI2LAAy7ej+L8sNnbN9dO7w6o72+d4XLJS32qtCLUVu+hPnVNWCreLIXB4W
         EoLYxOk57XoBH/WaOcYYGenRYuT1G0rbrQkKVV59jWG3fsXan213veEtLEw4nxIiA9es
         uT8FFk24r2D4hms31nfljMmUcED7nw+UB/EDLlyC24/YTfR7vwEvLGAVoz+t0eiBT7hI
         EokVeTgpv0jaAwxqVlOmJr66ypKRY4vPIPlaGyza7Ih1byEtVPSXCVjM1TfYlQt8Uvrz
         akmQ==
X-Gm-Message-State: AOAM531hX3SacoxAiIspufsbILozEzy6jtC42WrTqPjNRQ+mby0GmZ2L
        X9Jgl1BLUAgBuSNLnL/pTL3Bl9awmazhiQ2PmnPHskXcNHvDSA==
X-Google-Smtp-Source: ABdhPJzw+rUvcHRNqltpyHKeIUqBLcMURqkohi1Tf/xfOW9F6xaA4qDnUVlsJSR+j3MVRB0x+Ax/oWkCvK2jwn8RBfY=
X-Received: by 2002:a50:ec0f:: with SMTP id g15mr14186291edr.47.1634885292943;
 Thu, 21 Oct 2021 23:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211022064044.28761-1-bagasdotme@gmail.com>
In-Reply-To: <20211022064044.28761-1-bagasdotme@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Oct 2021 02:48:02 -0400
Message-ID: <CAPig+cSgEvxVBUhrVf9ceG5L1DU5qTbfOgo=wOsOja1X8y+pfg@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: teach to use "format-patch --base=auto"
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 2:43 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> From: Junio C Hamano <gitster@pobox.com>
>
> Let's encourage first-time contributors to tell us what commit they
> based their work with the format-patch invocation. As the example
> already forks from origin/master and branch.autosetupmerge by
> default records the upstream when the psuh branch was created, we
> can use --base=auto for this.  Also, mention to the readers that the
> range of commits can simply be given with `@{u}` if they are on the
> `psuh` branch already.
>
> As we are getting one more option on the command line, and spending
> one paragraph each to explain them, let's reformat that part of the
> description as a bulletted list.

s/bulletted/bulleted/

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> [Bagas Sanjaya: fix grammar in commit message and explain `auto` value]
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
