Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2B8C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349A8224B8
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 19:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbhAQTI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 14:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbhAQTHI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 14:07:08 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87705C061574
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 11:06:22 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id f6so4968048ots.9
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 11:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mBeQiUBKAOoYsEvxTVrJwNrKSbCxzLx3h+BF3878SII=;
        b=S4ypDV1fQbY5B8rQwvcRchSBr05jHWzGygqRJF8v/fbAmT34GQ5p1l0FcUCpXDwu6M
         EUb8pIQa4pzM8S8G89UJxc07dyMOSuv4o4h2RhuZGh825GBef146ZXbYgcr0jhl/9kDy
         fuVRVetQuJ/FLnWZ08Jic1+unRTlarlFTUEzfOD+0wUbJqTqbqECbGrMwbVGpWE4S3I6
         0kGYQEA/He2ki6NiNp0Irp1YnA0WdFFKX22kDKl3zMhrZLNmZuchmjQW8hW7QrDYwPqi
         ZjvasK4h03jyHukIG1f1MVJ3F0UBn/bbXugQJ0Lul6wfYivpyU1t68gg7eE/9tMdlUG9
         w71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mBeQiUBKAOoYsEvxTVrJwNrKSbCxzLx3h+BF3878SII=;
        b=Xdxw4Yel4/KxJWtUgZdiyykwaxKGZGM123WzPRre5sLhL39E7MYQIvFru7A29lBJnm
         KmooIS6YfYJwUsLlY+YfQBQdaslk7jKrUCqnEeZI0ImM3jXrWS11v/rqShnUtNl+ANvk
         bj5M/VnIBeRs5j7bWBnPY57bqKh2yRt70YpKtA7gg6tccf31+Gq7dgD3ioEucPBrt4xq
         qE2lGqfkWukahV6tPVRa/R3Pg8nfVcFEypmP0Vmdj+GZ18OQRVhE4qBfShirROuysRYk
         jKofthJpsTzJe8LIOvvzHUvSnZSsnS/GTHZ9sv7q3MYUAOlQbrjBRkbu2eC++DfX0Gcs
         YMLg==
X-Gm-Message-State: AOAM530c7m/2Qq60rZwsHDHCA3Y70exZgl8XwfRovMVvx1TURQ3ViQsc
        hQ0i9E3+In0iw4GDVJviEvAYX9/Z+/9FDVPtespH8nbSIF8b1g==
X-Google-Smtp-Source: ABdhPJynwt8DjXPtkCXl8EfBs8mPnxsdL6huIc1j83yUMygblhxH9mecltoneNkG/b4wiDOli4l+NhYpMwuadSjCgbY=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr8056572otk.210.1610910381901;
 Sun, 17 Jan 2021 11:06:21 -0800 (PST)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 18 Jan 2021 00:36:10 +0530
Message-ID: <CAPSFM5edf-oFyTZXeKdJCfBNu2K_VQUOWxrDxo5MmZ-P4wVZCQ@mail.gmail.com>
Subject: [Outreachy] Project blog - 5
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Here is the next blog regarding updates on the project:
https://charvi-077.github.io/week6-progress/

I appreciate any suggestions or feedback.

Thanks and Regards,
Charvi
