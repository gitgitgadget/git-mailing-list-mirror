Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B795C07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427086023F
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGGBJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 21:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGBJT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 21:09:19 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D576C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 18:06:39 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 62so558007pgf.1
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 18:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lfGJBVWK5h27YKOOkQy5OonV1OI8bkCXsflbwpQgYs8=;
        b=Nt92L8cCgrXmIFoXucQaRIwQ2C8c7+eP4pO7+JKAvFUu2FFi20duFkF5ILz1h2MH/o
         HrKT9S/LeSVeS//pfmaw97JyZ657TPsfq7KM4rdLTV0xgPakrBlSNfdyTWdk5Ceu/BVb
         iuwzg5mIEv1YqZe3dUyB+1QBKqGsWiMFfdI/ySajwD4MXWvOPijPREdg6u5V5RwOtozY
         swlKToAay98S2qbeg5sufDvaYKZw24dDOoaofWswaGhmSp+7TkS+vG1VVzlRIXNnnN74
         jM0LZHbyk5+Nz9ClWshYNb7PhL0isVlkWQqIHoEyQFFgaZbwy2Ih+fyIic1h9+w/zY/E
         KdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lfGJBVWK5h27YKOOkQy5OonV1OI8bkCXsflbwpQgYs8=;
        b=ngMKPLgyVNvwRMfw21L8SMK61VOdRn74S6PABz9VCQvecKYkPz3TtPFZXE+PLmbTmq
         8R0yp5uQ4VCV7Mtmcy8c+dxTLWJh0A/U0QRByP+Wvu3ltSCiUgnK+dDrLGqN+lxsDztx
         M5v1s4Ee7iFERlrYNUrOFSrrV5cozW+AppL7M44VjoWzJBWbgTTNkWg2ld3RF4nwz4sV
         2ybSWvtN2OBi9Ag6NjkV7MbeBIpy48s3vodCdl3DyGgiW96YDWedgFZlsDMoOAQqio5o
         r30UXwM+ARcjVmtJ4hOZsukMch4jU8FESFJ2awMVcQ2Ndlvk797Nh04ZpTJ9jusgsB1o
         dzOg==
X-Gm-Message-State: AOAM533YjnYFcRyB6ZfjsgqFCpokFr7YWpVFBJQiHrAMRwTakKNn21ne
        sNoVmLZj5DlLBalh8oF6ADYagbPxgtq3DV5ktU7F6szf
X-Google-Smtp-Source: ABdhPJwqUr7xiONNHRgLZHpFmOYQs47Y9tLd802fQhKUyGnMigQVBAhQcq8Uw9SiU14HHm5jn6uD/C+lrjtUb4jch68=
X-Received: by 2002:a63:1c1f:: with SMTP id c31mr23258977pgc.380.1625619998593;
 Tue, 06 Jul 2021 18:06:38 -0700 (PDT)
MIME-Version: 1.0
From:   Aaron Hall <aaronchallmba@gmail.com>
Date:   Tue, 6 Jul 2021 21:06:02 -0400
Message-ID: <CADrEZfEJdDHb+Ejhhn9fHcPX-ESiCD33VV4JsNEqXZ2FOkB7vw@mail.gmail.com>
Subject: git subscribe
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git subscribe
