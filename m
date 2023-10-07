Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2FBE95A61
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 09:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343641AbjJGJFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Oct 2023 05:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJGJFo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2023 05:05:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6CCB9
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 02:05:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27762a19386so1951909a91.2
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 02:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696669542; x=1697274342; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JEgblcC5Ef1E7ZPYl93LkLYHF5wpNYBuVEWSu/w9p/Q=;
        b=STnHuBb65rg6/PkDAH16wFaY0LNJXLELPPvN5fKSWGjLSLf8DNY0apJA1tS342eTwQ
         DsdQkbmIM1lzDJMCs9Ehp70DGonnzkKNu5q4+QRP3GKD+WK49FMwR9nfm7Mls49nvYP9
         BrR8Zg6ms0sgi/cMFaSlH/yQH1vjF9Fbn9XyvJtrKm8VzdZxh/b2UcBwZHbrnfltF/im
         az3R1Qrxklac2Adif4AIbajgZqbFsYVMSuhD4GmhN0EfUBSkdu+lzS0MpkEv2b+UgqPv
         AUM759gvTSBwEi8RIZQ2mkVTg01CSDZSVWXyEGx1HTGoxRM6hrJtwKc8DoLqzB0/55Wc
         ao4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696669542; x=1697274342;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEgblcC5Ef1E7ZPYl93LkLYHF5wpNYBuVEWSu/w9p/Q=;
        b=L7UdVYucg2STuWtrdhXarXsEyy/IVJ8kZr0b6G73or9Po/+1J/EflTmQCrXiln7vOz
         IspXwrnjcMu1SdMDZzRZlF5VQFvFpuz2QiLLSop9M9h+nhnUDRQUxu1KkOoEfO6AFX6d
         bdi2zrp1oSq5WqCLUozLzK8G+6F2e3u7iRszQvzqBmp0QPPHpvh0E/L6clhLQB516Jnn
         4087mJHxbeU1s6+ptP0bPS+8wvpYy/fdmxJdL4cOG15oxBn+Em1w4cuH3/yuFeBgJcHe
         1oP+/OAyz41oqv212AtxGv8RNL9tfpWNE/mxja1aYeLp49GKy+JVm7HLGGf70jpQZN2h
         peKA==
X-Gm-Message-State: AOJu0YznaS04samMHIRnT0I2m21PpgW4qtmdsBKoi+KQWzyOKMjdGrHS
        X90Atbr5GRt+yhB7DCZ3GMvEIcVuP+z2UUaqxHarYXUeJ5YXMVQQ
X-Google-Smtp-Source: AGHT+IHNUdNbk76Dh9OfaFfQZxjab7EcEF4yWJta+a+G2VinSs9vyp8M9ikuHKSpWSd9nXLZJ05+wRfdItKdEik5l20=
X-Received: by 2002:a17:90b:1bc7:b0:274:589f:ba35 with SMTP id
 oa7-20020a17090b1bc700b00274589fba35mr10225301pjb.8.1696669542233; Sat, 07
 Oct 2023 02:05:42 -0700 (PDT)
MIME-Version: 1.0
From:   Isoken Ibizugbe <isokenjune@gmail.com>
Date:   Sat, 7 Oct 2023 10:04:17 +0100
Message-ID: <CAJHH8bE0g1N6a2jTeHYiUCzsR1-VnAp5dWu-9RMJEP0ixt=NRA@mail.gmail.com>
Subject: [Outreachy] Good first issue/micro project
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day,
i am interested in working on this issue
https://github.com/gitgitgadget/git/issues/1555 as a micro project is
it worth doing and appropriate for a micro project.
