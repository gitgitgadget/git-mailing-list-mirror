Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380BCC433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 04:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJIEhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 00:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJIEhu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 00:37:50 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17F32E9DF
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 21:37:48 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g11so310971qts.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hD9cm9pmj4jjRreOR9pM/QYxz7yUPeWv2nnZfUfHpjw=;
        b=DnVv9D5IXP4ExBVgYL7WaZzCX8P4XMTH7ubW4traV2RySBLm/vSPLFcDie01bxrvb/
         T9YQdsfp7j+u6ttzVGV/XX4qkA++KWdRdH5LYtyy+zYgr5/w/95Mi3dDTx9wWPE45Id6
         bixqrb3MbDEqmu/V+bor8kzJKL9WxxwmwtEVx3L0Aoq/Vca8CkYiwW/k3lIwPGhlKlC3
         WqfuRl5M/IBbsvsboAZ+f4DaAPplhU86XwnIlxzFTB1H289dSelXc5xEDXTDjxVo0A1q
         kzRhelKU8xehPbr7dELHPL4ooGjoOJXwj/B9BgOJngH3cmdstAxiX/Bat5/MpmzVt6Gn
         3Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hD9cm9pmj4jjRreOR9pM/QYxz7yUPeWv2nnZfUfHpjw=;
        b=SAral0uG/U2I+Ig4w61Co784+QY/5nL3+tpmLqynKd2Eh4y50umF/lPkQBYFoiPddI
         dZAzBcqV6zYJLOXEpaEusBHNzt7O+SjL2wqelT1sVFFiL5ziDzYG4wZsb4Qu2dIWICtq
         yvjA4U8ZQ1sm8RvhvVYJEnDqtEEP+s0mWyjeKQkMa0KEgqTbl65XuaQRb2egiqb6b2yf
         cUv2LhAgMaKgG8Mv/GpFZpodeA1RdA2q/z159/3decGYQT6ZWEeXA6YSgVncjH8d6uwi
         mXQexJ5ZQQM9q/04gUhisO+yK+YCStDjXDS4dcsvcPX0nn0jrkPuQKegROToEZsIbxxV
         fCpQ==
X-Gm-Message-State: ACrzQf2JS5joeyJ18skHE7bGJ7lm+VnNC8mVyKERFQdB8TLHhNOEDtAY
        69a0u8VkGs3yEHYHcAU13eO3o0fID47a0c3M93+xHmAi0UEavmLqJeCSUg==
X-Google-Smtp-Source: AMsMyM5xNdy9skVdhe4ryko6KcMZjQMhSQ6R2UH24l9Ruu0x/glqCZU0xsFwABGf6Raa9kSjsl8IH6gg8i36y5dY4X0=
X-Received: by 2002:a05:622a:5a0b:b0:35b:b8fc:874f with SMTP id
 fy11-20020a05622a5a0b00b0035bb8fc874fmr10356772qtb.267.1665290267868; Sat, 08
 Oct 2022 21:37:47 -0700 (PDT)
MIME-Version: 1.0
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Sun, 9 Oct 2022 07:37:35 +0300
Message-ID: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
Subject: [Outreachy] internship contribution
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I am Nsengiyumva Wilberforce From Uganda. I am happy that my first
application for outreachy internship was accepted.

When I read about Git in the project list, I got interested and I will
be glad to be hooked into this community and get my hands dirty in
contributions. I am eager to learn new things from my mentor and the
entire community.

I will be glad to hear from the community on some tips on how to get
started with contribution.

And more so would like to get in touch with the my mentor

Best Regards,
Wilberforce
