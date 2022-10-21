Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA351C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 06:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJUGKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJUGKH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 02:10:07 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F49AE31AB
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 23:10:01 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id y14so4632911ejd.9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 23:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejk3tNbZ6iewaWDYCpuM6wtdacDKfKJCjdkCU7RX4bI=;
        b=ufH1mFSCXpuuSIInAOiNajZvVs9SQQQ9ms5kxVi2uUqT2ClCsNZbtTk0RDO4+ndVV0
         zpUXemqZqhp0breNxPzE73QR8rO2mWj3orwwLt/0Wh0VwOt2NQ2h0r52TytgdIP2T7lg
         rYgFDvtcfockyEcCTNatUZYVFPIEHYPb8PsSDgNxUU1PflQU/iADmRquKpBiYEXC2C2K
         6vMK3jpvVODvr/3yqqeUbLslwLDPzdS2qTwNwaTTWXh/qSHuXoDWICBf4MSkyKxiUzeq
         OL1jS7enQSPUusZTraLZtc+lPQVzIyO3qYxh75Nheox4XP1w0tbN8EHvChs2eaIsoDzH
         Tukg==
X-Gm-Message-State: ACrzQf3ptmnZtWTTD6SJXksUF2i6DhECRdD0yeyzlc6v0duRp4VXONsx
        KMCV+AiF4DDHBhGs8/jmvbgkttZxQsaRH1Dl+qE=
X-Google-Smtp-Source: AMsMyM71C2uhGkFSIzXTMt/O/QqX/T+JrT/rFPmyWm5fRMP1y6VK3zv1rg4H4RmBmYZMO/c2WD96ES9MVWAuZZPNXvs=
X-Received: by 2002:a17:907:60c7:b0:78e:1cc:57de with SMTP id
 hv7-20020a17090760c700b0078e01cc57demr14089356ejc.33.1666332600084; Thu, 20
 Oct 2022 23:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <5E2E10BE-6EEB-4C78-A489-5899400DA937@gmail.com>
 <CA+JQ7M-NA9UYafMurb9MAo5bp6djdzRP7ChAbdmzU+nmrkXTNw@mail.gmail.com>
 <DB5611E0-6B1C-4711-BB9F-72F6E8F39506@gmail.com> <CA+JQ7M92x03FPWM6qWjG=FYPxCYs8xcC_HRWLnkwj4iqA9KK=w@mail.gmail.com>
 <46A1CB40-BBEE-43FC-9626-588718518B4A@gmail.com>
In-Reply-To: <46A1CB40-BBEE-43FC-9626-588718518B4A@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 21 Oct 2022 08:09:23 +0200
Message-ID: <CA+JQ7M-Brkq1xwcNhQ+rTvtbtR-XpHspTPJ8kXA63fLxarez_g@mail.gmail.com>
Subject: Re: Cloning remotely under git for Windows not working
To:     "W. Ekkehard Blanz" <ekkehard.blanz@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 12:00 AM W. Ekkehard Blanz
<ekkehard.blanz@gmail.com> wrote:
>
> Regarding your suggestion re. Powershell, I can start the cloning command in a power shell window on a different (or the same) Windows box, no problem, but this gives me the same result.

Sorry maybe I should have been clearer but the powershell part is only
relevant on the remote. ie, the remote shell. CMD and windows OpenSSH
on the remote are the culprit in the issue I've mentioned
