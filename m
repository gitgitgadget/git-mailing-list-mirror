Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBFFE7E63F
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 14:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjIZOsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjIZOse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 10:48:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2B7E6
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 07:48:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50337b43ee6so14959414e87.3
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695739704; x=1696344504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2FcS0qRSR5zmI14e7znEiNwMhWtPLCt7DUEy/SDgB30=;
        b=EGoizSRDs+tDqX2tAy7n9C9XxtQhy7q/3IrKgEf654CsfdysI12PtyxxmUrdk67GLo
         +IPAowQg5fE19HK6umQG0ilT0MY3zBiLytjYK4ta6l8K2+Fvh4UMBy2Z8qK2hoA9YVXB
         FJCmmJ/WGif+BWyo7LbeohMAvEiddzBARcamm6T2EwLVDufPIks9TVXfbCCBLLBr4EXE
         w1jY9DH/XVopl28TmUQ0ItkW784TkgI5maSwK8sJlarzKjJM+DCxHfBra4mXC3KaCeqE
         nyXbf/U5MlLMdFVbP78dd6uObGl7JacpCVeD8xSRvCBEfgIrImk4U7PLsvB9K4HIXUV8
         zsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695739704; x=1696344504;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FcS0qRSR5zmI14e7znEiNwMhWtPLCt7DUEy/SDgB30=;
        b=Xqesf72Ld6Tkr+kj6vJsIj8nM75VuD8MkrVPAv5efJTUHZ1Eg2Vn1/fu2eFUZx6TQF
         A518o2Qwnh4HtBO7iCOhBfxO66u+8iNs472t9G13NmywDjqXI5PJ7hg/DlJBgYheAnpu
         g6hmF0uilcyG3m8wPRqKMX6qDx+p6El3xhKA5+PMyZOrs32+RCixoMZh2sAwCkbWobHf
         9rEn03DrBijRmq+WxLu94RUHzRSE0W/StF/PUgStITMtixiKnr5bTpdwbhN0xU1aqiRj
         svXGlwiYzohyfuocBrYhmwRNm/ePgkWrRkjRsI4mX5mYeElKNBeWj3fQyYWgJuA67syY
         oQDQ==
X-Gm-Message-State: AOJu0YxntY/AG73nPe9B/EtKuzXjze6de8ufgBrbYnTJJYs/E5x2rcMa
        LDOpJAPwh+psFzidejTk1UCouq7+3wXW1tuZejN694yY2Zg=
X-Google-Smtp-Source: AGHT+IEgTv0EjqhVbFwRUbSQTQfvsdbB1EmThwcGf+4HMhTdUeoOlFiYPYlQP3kHhbngGlQdB/0F2uYqrUG+yJ2ouPU=
X-Received: by 2002:a05:6512:708:b0:4fe:8ba9:4c4 with SMTP id
 b8-20020a056512070800b004fe8ba904c4mr7534413lfs.59.1695739704256; Tue, 26 Sep
 2023 07:48:24 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 Sep 2023 16:48:12 +0200
Message-ID: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
Subject: Projects for the next Outreachy round
To:     git <git@vger.kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone, especially Shuqi and Kousik,

September 29 is the deadline for proposing Outreachy projects. As we
have at least one mentor for now (me), we should propose at least one
project though.

All ideas for projects are welcome, don't hesitate to suggest one! But
the simplest would be to continue one of the projects we proposed for
this year's GSoC which is just over. By the way, congrats to Shuqi and
Kousik for successfully completing their projects!

So Shuqi and Kousik, please tell us if you would like to continue
working on your projects or if it's Ok if we propose them for
Outreachy.

About "Unifying the pretty and ref-filter formats", I don't think
there are a lot more atoms to work on, but maybe that would be enough
work if Kousik stopped working on it after his current work on mailmap
options for some atom is merged (which might happen soon).

About the "More Sparse Index Integrations" Shuqi worked on, mentored
by Victoria, I am likely not the best person to mentor it, but I think
I could manage. It would be nice though if I got an idea about what
should be done next and how much work is left in general in this area.
(Shuqi's GSoC final report at
https://cheskaqiqi.github.io/2023/08/22/Final/ doesn't talk much about
this.) Perhaps even if Shuqi is continuing to work on the project,
there is still work that could be done in parallel on other commands
than the ones he is working on.

Sorry for the late request, but please let me know soon about this.

Thanks,
Christian.
