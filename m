Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC762C433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 18:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2F364EB7
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 18:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhCMSfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 13:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCMSfT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 13:35:19 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862FDC061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 10:35:19 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id u7so6405946qtq.12
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 10:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=a0PCrYSyetCdfaIVlVMsRKthHwgFqr7RJFYMebagA8g=;
        b=RkdKQyEM/laI/w+IVhMTzS3vlsTabcaq3VzuTUv8uZvrk6OwkwkG8y5UtizLfQCY6p
         5KyRyOoxeWeoOZ/5Om/k4HoeTvto1P5XbEVivCQQB9Vvl9ztdp5YS/EbbsLpmuA/Cy6R
         gHMGs3E98plJWlPKCBdSREGuOeIEUaQCZSm2+FyUqmQcm7ylX6SvvqWRC1upMRlxEX4d
         q7TfDRsRNo9+jn7a9AtMOe9CT+5Za6QQqEWuEDQav8Q86VJaxFQM5i24Peq96CmzYA/g
         KRBXL/vvGwtKbLNivJfdXWv429vKayjq9h7HeaI/Xbd3z+ocmnMcO/IsywbLqlPhoxL2
         AJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=a0PCrYSyetCdfaIVlVMsRKthHwgFqr7RJFYMebagA8g=;
        b=iS7MsOMv6S1T61xy5TXOhq9WOLNvUimBw9FZZbRxOUwfd3ZETLtNe+AmYebQoapLRY
         kFg8MVEc6eIZxJ/WXzFH6Jo0dw9eRR/mogwZFNg4ISvq55SgTKrSJxle7rlwk+FlUFxp
         Q51e1m3lqts2i8bKwPXN31KTetBIuLeOt6SJOSAVxXi82CcG4sWOXKssVaxxh0SIld2o
         eTmw4YrJ/xa9EoiO54fgg5paIWQDrUzKi0T41V87mt2qWMlBi4LkVQQj3NwS5ieq3TkQ
         lcC88f2C+gFzUg+UitCqDmrX66f2QdMGQ6dCydLHrgePNp/t4VKWW9NIFASupzbsIokx
         9C+g==
X-Gm-Message-State: AOAM530WbPzpQb8qkHI9zAXfnM4Yz15aczYKtHai07z70YIQ9xe6SX91
        duL8teRZP/5EqhrjN32ByWxFsnb1XXd16MLgj3o+VkCgpvZjlw==
X-Google-Smtp-Source: ABdhPJw5Rv1apASZMaeHjR7ohLpxKiJi0TrP6r4iDXP7tlAYbI9ThfNZCCzD931QoKQ1LNa461qnbdttl80IGU48cnw=
X-Received: by 2002:aed:3a83:: with SMTP id o3mr16755514qte.349.1615660518151;
 Sat, 13 Mar 2021 10:35:18 -0800 (PST)
MIME-Version: 1.0
From:   Shubham Verma <shubhunic@gmail.com>
Date:   Sun, 14 Mar 2021 00:05:06 +0530
Message-ID: <CAD=kLpvn_-HZvHNt1WhrHCmOjyrvy_3cdCYPjCGHowo77_MRYw@mail.gmail.com>
Subject: Regarding GSoC Project 2021
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Everyone,

I am interested in working on the project "Use ref-filter formats in
git cat-file" this summer as a GSoC student.

But I saw ZheNing Hu already started contributing to this project. So,
it is possible that more than one student can work on the same project
or I have to choose another project?

Otherwise, I will start working on the project "Finish convert git
submodule script to builtin".

Thank You! & Regards,
Shubham
