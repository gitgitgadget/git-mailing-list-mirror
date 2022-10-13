Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0CDC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 21:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJMVlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMVln (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 17:41:43 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18A036418
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 14:41:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a25so3966660ljk.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L0yzLYRW8Q/cJYLjCUZQE4pEmXrCTaFykCfwRa1+cq4=;
        b=g557J8vJXdB8U/9Cksa+7Csh4w27Q35K7L3ukO2Gwtb5m7RAReyXSGk9YLGnWS/7wX
         cIQs16mzjeNr+9B7w9xNMBMuctPRKTH8gno8gKuTC9wy7Sy7oyI3uppMytRWqNTjXgdV
         hkcEbla03GxfUp5nTXGexaCfLUzmzf3tAxUOx1JmgBlrdkDhMWSSlk6aK4bSm396LUNY
         Qsy0d9lJaiB8FPSzi5lQNtXXOyxZLK63DjP9dJjzvIqFJIS5kkHC31pe1m4DP0u1jsaT
         QE2MrrdPG/05eEkdS0gJ34qz7l6+hKlg4+5b6irIwD0SvA59dJ0XIN4VTZoQoaa55avP
         ZaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0yzLYRW8Q/cJYLjCUZQE4pEmXrCTaFykCfwRa1+cq4=;
        b=vdlO0mtcvTOZpM8sAU6kL5XBCZ2F+G2gZo9Lr0mj2nBWKmFLUsHpCsGf5FtuC4a+Xw
         m8YvZcEmG1OqfupIoFN6aARSV+ho4O1fChXIR/3wNLkJEwXNBmT2kNUSlJmk/QTTIyS+
         +/QE6ElCNfmJgt3CkXbxwk92bquvUfLVDq4ACBeRcAcFwQeCUhnLMX8v1TfaloSqWPws
         80QQdu67L4kOA9AA1o04DKft3zd4JXIQTVMYD980iXRaM5AoQixI9V/Qq2LQixInJ3Ot
         6omleJN7O0FAA/BDOSquk5XppovG15J6KnQcqyNXGGbAv5NPTqZQCetrmMHc9CXqc98T
         6d1g==
X-Gm-Message-State: ACrzQf2ArcH/u0P13Srlos5FtP6KTkPtwLLICllhzsDfULSvPrWsPEXZ
        gSvoH+N4uXKgtP1/wof9TftGkU7v8Nmv12cjRbYspJKMS0RR6MEX
X-Google-Smtp-Source: AMsMyM62Jy6a+em5fO1iaZxG8B02a0gbFmmcrKwup4T0oeZ06HQ2ryRGaxfEe71D8gvZSutQLHKYQkFtyguZFxzxA2k=
X-Received: by 2002:a2e:8812:0:b0:26e:98ee:7274 with SMTP id
 x18-20020a2e8812000000b0026e98ee7274mr705402ljh.354.1665697300983; Thu, 13
 Oct 2022 14:41:40 -0700 (PDT)
MIME-Version: 1.0
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Fri, 14 Oct 2022 00:41:29 +0300
Message-ID: <CA+PPyiH0VqXdO1LfXP7CaM=HnBPWqvHd4DTE5EOMEcb58DCPCA@mail.gmail.com>
Subject: [outreachy] sent in my first patch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,
I have been able to submit a patch for a microproject. Many thanks
Johannes Schindelin for /allow. My CI tests were failing and I had no
idea why they were failing.

I am an outreachy applicant and I will be happy to have your reviews
and advice. thanks
The PR is https://github.com/git/git/pull/1362
wilberforce
