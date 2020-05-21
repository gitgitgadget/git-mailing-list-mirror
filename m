Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588CEC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D23F20814
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgEUSbh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 May 2020 14:31:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42467 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgEUSbh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:31:37 -0400
Received: by mail-io1-f65.google.com with SMTP id e18so8520015iog.9
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XMdZ+0mfebjUXtOKUUgKI9dubQ4B118qAUH4BASjZUc=;
        b=hX4D/JsJ16+G0aDmMilHgZv3yfVwyxX7lKqauGYagRPNKrZWa48XNEG4SwwYwc4NJK
         TEwOdlMNf8Hk65X6HzZLEnc6yvd1vQ7ny5qIqmNh2afsbjXM/w7egk/5BA5LXVnTDJ0F
         knd4HomJA1WjS7tPM0PAaqD0/EjsRDH2mcy9o/BoFQuL6w/5wG0zc2Q0tPUsKreBNMyx
         tv2ySlt0IoZskZfkTMnVdAEC1B+T7b1nfHB04+zm53RE29PDme1t2CtPyzM+1c2rnhxL
         P7GdopRfJc/fuuJcviRBcT/tpyv2M70vZYjm0+jqFCHbj4yOo2TmuZULA/InV2Zj/Kx5
         jH/w==
X-Gm-Message-State: AOAM532c2xz3s39fAtukzt3FxeWU8j/c8Y03GuiDME/JHkMMmYdQKvr+
        fDE+Jf1ijve0m20QM0Ns36GetGJFGmmR9dC6XZY=
X-Google-Smtp-Source: ABdhPJyMs8R4K7djrYz0TjwhgcFGg8uBKn5BdllOfxRXeq+WksHu+7GrOVRwtJQpQVOSdyc1m0Cpx0U64MsXNDZO1eg=
X-Received: by 2002:a5d:8041:: with SMTP id b1mr2498542ior.146.1590085896363;
 Thu, 21 May 2020 11:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142156.4717-1-ville.skytta@iki.fi> <xmqqo8qhrvrz.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8qhrvrz.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Date:   Thu, 21 May 2020 21:31:24 +0300
Message-ID: <CABr9L5BzpA1fnVP7+wk62-MMrfb05LSu7egvn-enZb6cmMNt2Q@mail.gmail.com>
Subject: Re: [PATCH] completion: fix completing stashes with "show -p"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 May 2020 at 21:24, Junio C Hamano <gitster@pobox.com> wrote:
>
> Ville Skyttä <ville.skytta@iki.fi> writes:
>
> > Regression in df70b190bdd2add42a906819f9d41dbf91cf0809
>
> That's not very helpful to readers.
>
> Something like this?  I am merely guessing why you thought this
> change is a good one, but that is what the proposed log message
> is supposed to do.

Excellent guess and wording. Will copy verbatim and re-submit.
