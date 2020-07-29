Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BA3C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F0B2076E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgG2C53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:57:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54243 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2C53 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 22:57:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id g8so1338999wmk.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 19:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tM/GwesOrkeFTcAtSmYTn57s25SCDrMpxTjFs8x5LjY=;
        b=mYdvoeRRTI+IsS32m+OCUBHBqS7bk4Hgx/Wq1s5smbEaEosKeaMQrjduYhSaGxMyg6
         ebdnXSL7qnlWkCxrsnS+k4BTCcqS9ScVxW4Cs+MOK3rUGrcCL430g8wLJ2C+2EE6CObm
         geV14/Rbq6nR9QCFblBnQkG+t5AkMyifagXyQ/5QsdtjOIEwow1Uog3GhCmH5eJmrnKw
         PYjoorBwADWYaehxZf7gp5HVWW56SgUtEuLPxUSuhHAZiLFzYTj5787CKBCCEjZJeOa6
         ZoIDRdFvBMRRIjqrvE1t82OtATFKZEQzqcWp4mMrtlG6CfNe5CjL5R/4iuSopvRR1ZXu
         JYDA==
X-Gm-Message-State: AOAM533gtwagmIdJ9iM4bwmuaT0dVg0A32g+RS9UW9+gxIWP7FqThwkp
        XLCcfOap2d/b1NKTBh2Ir/GiR/s8LFcUQeuAx/jSx3RmdR4=
X-Google-Smtp-Source: ABdhPJxG02MjgQia+rfSJ9kTj6cmPLftdcFuuJYdSwt/lkhnlryTLXCUsvCc27xfg/RriYRRgJ5AH9k04kYMICXRRE4=
X-Received: by 2002:a1c:e304:: with SMTP id a4mr6438507wmh.11.1595991447763;
 Tue, 28 Jul 2020 19:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net> <20200728233446.3066485-34-sandals@crustytoothpaste.net>
In-Reply-To: <20200728233446.3066485-34-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Jul 2020 22:57:17 -0400
Message-ID: <CAPig+cSErEWAaDtpOBbWDuQd+6yN4UKmUvMjKpT6AAd+SwkyTw@mail.gmail.com>
Subject: Re: [PATCH v5 33/39] Enable SHA-256 support by default
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 7:36 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Subject: Enable SHA-256 support by default

If you happen to re-roll, perhaps: s/Enable/enable/

> Now that the we have a complete SHA-256 implementation in Git, let's

Still wonky grammar here (mentioned previously): "Now that the we have..."

> enable it so people can use it.  Remove the ENABLE_SHA256 define
> constant everywhere it's used.  Add tests for initializing a repository
> with SHA-256.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
