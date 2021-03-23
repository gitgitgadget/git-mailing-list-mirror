Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF32C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D8261972
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCWGVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 02:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhCWGUh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 02:20:37 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226F7C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 23:20:37 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j11so17117367ilu.13
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 23:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rkkvog5CsjQIvEViQCVDulVxoN+9V3nK/mI2JsecMmo=;
        b=RXLrRlG3V7e3FTcvFSYBdsvjOf2IokU4n7tta+or08w9yi3erewQmStQ+/FqgvAo6D
         VkITPRkwtq/cJDvN3F8SyChjsdWdbp87QLo8r0cLxFx/oukc+32f5DOm+Db7xkFjJm1f
         Yt83Ph/pvWTBoKuBiv0BVSPRfkgqW2fIScydjjfkCLYQoUcmT6JS01WNhgR/oDfg5cT4
         BidHwaRT2LWHGtAJZ8ZIwQJDGj5NuOKw3qsCG8vrbdDuQyUxwjHGaQp2go9joGszexFu
         irmrYf429iBAbd8x9vekWxPP0C36PZgkJSsNrPC+q0cxvrP08pmnbZjrI4LtCZbGZiho
         ZtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rkkvog5CsjQIvEViQCVDulVxoN+9V3nK/mI2JsecMmo=;
        b=d4Juys6FeEq1DwkWudqVsrzw+1bAeCvgUbNQmME8qM2xQBYDUh8jcDMTaKQPEtxdYX
         hqPpfZmDrTVZ9jgLdix0jfdvasPOXNsnSbyH87C14ULaaFeDEa8r9TK1aqatZLim6VC4
         tVyIzgtgRhPhF4hkh2lDcJj/7ZkF4CstbKU1dGk1OmknJ1UnRsP4mdg0/BSsrFhJ/V6/
         6VyPXeIy+5pYsOUqFP81bMYLHSwiDx/2fDMkKw0cM5AS/4fJPwSuE7SMgNo9/J7P13L9
         b3/DXj5h0lNIWhGV3iFJVHq6KY8/XDmR/MFDddoegHqh1BF2Ge0w8+9OUjsD3Q+m/s3D
         44+w==
X-Gm-Message-State: AOAM530YNVeFLkfr98BVDge5fwJaRIBauJFQquWQSVc6KQM095nbvzfg
        zx4PxhYr1P2aljlknzUD2JbsL8sx6nVbMfkTD0FMpidIDqQSfQ==
X-Google-Smtp-Source: ABdhPJx3LB8rEnZ7N0Gv9nofG5qdeTBlzOkSbXLyvws7hrY3jCTAdigPuu62J7dSjCCIucB7O5D7Anih/iPJSP1AoKo=
X-Received: by 2002:a05:6e02:1a89:: with SMTP id k9mr3478666ilv.29.1616480436164;
 Mon, 22 Mar 2021 23:20:36 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5byg5Y2a5bmz?= <boping2010@gmail.com>
Date:   Tue, 23 Mar 2021 14:20:25 +0800
Message-ID: <CA+cd+tU8AMDoAdDNMP4cwgRFN+YP_PfGzDwHHzS3DOhQvUhpkg@mail.gmail.com>
Subject: [MacOS 10.11]uninstall git client
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How to uninstall git client in MacOS 10.11?

I installed git client to /usr/bin/git, but I can't uninstall it.

run 'sudo rm /usr/bin/git', NOPE.

disabled 'csrutil' and remove again, NOPE.

Do you have any shell script or some tools to uninstall it?
