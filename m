Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E84EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 17:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjF3REE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjF3RDn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 13:03:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463E8422C
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 10:03:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-401d1d967beso11311cf.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688144539; x=1690736539;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MSR+sXNf2qgGMoXknIbReCpTPFnRkS3ZTE4ndRzYT28=;
        b=XD4ifZBPpHXg07yVnBv+02CSN7I0+aulbasOB5f9ImbUHzMjcu4j2YspKRGlUG2AJZ
         4dj0cpar3QIz0cn3O7/5qnbrf6MxiHRl2hB1oMo4h8uOcSnopc861unMGxWdiWJP4JYV
         EEZB4Zl/ZsHhvdSwzvVFO21kvFaDOEsP8YuckH04Nyg1+8yHr2A01vkbmLDuk2tewaGD
         C5b/IudMlaEYblde3pJ8yO+s5xuuY7LgFCj76TLRPcHlmt5qK/WR+Ln0B16C6EqsluZ1
         K2Z/r/7Zp66w6HU4zce91ALNYrCqOo803cnfP3evIAdKdYbsvurCM1T1cqc8U0NvaOCB
         tG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144539; x=1690736539;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSR+sXNf2qgGMoXknIbReCpTPFnRkS3ZTE4ndRzYT28=;
        b=hQhb6fpsq2RQDAgiXMFAJh2EqCri+dh+SbqYKXzxUoOqs00VrF6pXHFG34PT6OCRb9
         GxxqPP+GTe8onZaaB7nV9m30ssQVOz1oqVStUjVwrovvmGkloISRv3GT1vSHXs2+71Dr
         GSH7WiNSLopI/Qcz6iytk20hWzppbr8hBzi3FrKsiMbvYLO43DF1a8GpL5GmfNtV1Uq+
         nbG0lpy0AbQv3VR92fk2/0ZGLfJUIodQWt021H4ZOntULpgbYf23VaFaDy8Yf/nArU5U
         GE62V1z1m4mmVHGZPJiQydsWfV+c+5RXcDiP1TUYJDPB+YkG+pgbB4VdGr8bdGbKy8YD
         +Aag==
X-Gm-Message-State: AC+VfDyUbXtKuHuwjujiupL1HrTcbnmmCGpsOz1PIGqJpEBeSQIS2PdL
        gMXEM2Ry708xxi/rd1lglm0TUVPIhy7TFLBUdU4Dz2rnW2z4+XgyBUA=
X-Google-Smtp-Source: ACHHUZ6/vGU97iEbWrEcxL4FNdA99u6rmXaN+VZAWQfhUiogSHwkeEYiVIOI4RBEyEOgEADPJz29HGhMkKs+fAsudl8=
X-Received: by 2002:ac8:5791:0:b0:3e3:8c75:461 with SMTP id
 v17-20020ac85791000000b003e38c750461mr944117qta.6.1688144539249; Fri, 30 Jun
 2023 10:02:19 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Fri, 30 Jun 2023 10:02:08 -0700
Message-ID: <CAFySSZC6OjTNkiDGRA_Z7dPBVssPWSENqatzGuxCEGQO4eqgCA@mail.gmail.com>
Subject: Review Club cancelled next Wednesday
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our team will be off next Monday and Tuesday for a holiday! See
everyone at the next session on June 19.

- Calvin
