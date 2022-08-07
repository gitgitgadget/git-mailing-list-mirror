Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0300C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 03:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiHGDC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 23:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGDCY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 23:02:24 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC9CEE2F
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 20:02:23 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id y127so9114329yby.8
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 20:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n+Oo6kZC7ROGMRY0+sbYcmANGxc5+24mx1GCgjrGYBU=;
        b=RSTM0I7vPIQiTWiFBn0x9tD2yaGqT1os7GhmEr81uaHbDsU4VBHNKQp4lXVIqYcSXQ
         V5oi77AVg4jJOwirZe1tcJpB2uDLGers/Xh4ibpGVJzakUXRRDcTNydpqr2KfUr16M7R
         LUL8kSYnsLluStR3NO3Ov5gbHpizzF9LN2N7t2d+tfY4UWnCca0OipQ3OgtFTIs+fLcM
         gIgMHnadQD9GUtbQZXGbmpQaq3GRinIlraVLRINdDhqxIy56lRmRp/0ewCKM87CjM6BZ
         c981brjY7YFSUcayGNDKnZrPCXAmQd6jBFG8rEhSRcgnQlWv/3C47BorR0eSk/A4kH4H
         t9+A==
X-Gm-Message-State: ACgBeo2OGXA+kycl7QFt5HKQY2ofJ5jZZVmSZ2BZhLEaxuCLAoEojkNS
        ipDRtErWKKaY+3JoCfR511+dUUANP/T5HCYIzgg=
X-Google-Smtp-Source: AA6agR6CNZeVgR6yZW4akJ+dszsVtcf1uVufP+vCuJYe+nd2IO9V3cMI7F1qbcD5rsVO1Kp62obS3xVV1jPz/QFYjMU=
X-Received: by 2002:a05:6902:100d:b0:67a:7141:a2bf with SMTP id
 w13-20020a056902100d00b0067a7141a2bfmr11147541ybt.54.1659841342469; Sat, 06
 Aug 2022 20:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa68ixcrf.fsf@gitster.g>
In-Reply-To: <xmqqa68ixcrf.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Aug 2022 23:02:11 -0400
Message-ID: <CAPig+cSz9RKj43_kwQFDQpN2Ggrimrw_DcOFnxGS+nBCPqDK5Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2022, #02; Fri, 5)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 5, 2022 at 11:44 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/doc-creation-factor-fix (2022-07-28) 2 commits
>  - range-diff: clarify --creation-factor=<factor>
>  - format-patch: clarify --creation-factor=<factor>
>
>  Expecting a reroll.
>  source: <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>

Per [1] and [2], I think the intention was to drop these patches
rather than moving forward with them.

[1]: https://lore.kernel.org/git/CAPig+cQ94oC-6wftkP_=RSEsOVPKeuBWuMshDkwV+Xu_FjrKeg@mail.gmail.com/
[2]: https://lore.kernel.org/git/xmqqa68nlfiz.fsf@gitster.g/
