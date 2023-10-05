Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FDFE92FC9
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 22:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjJEWS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 18:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJEWS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 18:18:28 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B5D9
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 15:18:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d81b42a3108so1742000276.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696544305; x=1697149105; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6EJh8UCkwgmVCu9fDQxwow3z6l4KOwglnrLDHYejc7I=;
        b=UAnoymegCUDdiJQD8Wk77ck5Nm7gMeHVYLsGDpNXbvwdZr2ZZWzWodyzUAameqJ790
         LfhNgcO3yKABubTgDDMjlM+wxirxjGgjzFLPh0Xcb0Y8PrXe92dd5PKtSQPSts9SJRzz
         umgOQNSVmCerWHoqG0j43AOJF9JJFS7gC3hYyTzUu7TbVhWcfwHPs59i/RfCzxYW+Nfn
         epbdOb0cULeo5Bx5fLRITSCSEFWkaLUoY6BVJDX/4RbyC6OCATA1UKz+/H93ILeuVh29
         FmoNL0+Az0TFJ3oSF3sWAxiQP6FxJ2Q/mUXujeI6/2ti28zkV1roDykS8vrLYC+pT+mf
         UxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696544305; x=1697149105;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EJh8UCkwgmVCu9fDQxwow3z6l4KOwglnrLDHYejc7I=;
        b=IL1DHxvbBrPTap1xniHTq2XGNPHv15q35cpuC17StDGqSnI3QHvuyhT6MFJ3hf2z9d
         WggSdMV6pZGzbhtCq4iMGv8kUqVHcmwNqpC0mNXG6wPawlD9c2S7NHQBm8mWG/3OjOn4
         zGkkMblrdqCBfP4j+YC0PHeemnNNoOlwcmv0Dwf9RrH4g+OPhwxCOe/jeEpIH5WMWapH
         QEPHGvumAiz/VfP4nBnKCJodvfYFv3OX9ycXRxaeRLWu6kmvcQR/zT2skezaExqcdwX+
         eP1h5BUBQef6VR63/eCijcDlbNH/nIghWGT6RH3ZsD8WKxk0GdrrOB/YxCoJYEgNHDnW
         XOqw==
X-Gm-Message-State: AOJu0YzRJ1DAHHGsNmWD9y0W399W6vWEIn6Q/UYeKub4pFXURUTOvgAJ
        szpSjKzHvCBTeOW3+drrWFCTDZHwH7Hjz0LiRU3wpyA+W0jnErE=
X-Google-Smtp-Source: AGHT+IHhOdS3DSsQiiGGyO+4uvVHfgHJR2zYuSP0xoIBO0k2Js0iQ5R+kajjGAcRbFtFjH6qVsow8VGEcpqP6obpdWY=
X-Received: by 2002:a25:1502:0:b0:d81:5d5a:25a3 with SMTP id
 2-20020a251502000000b00d815d5a25a3mr5443973ybv.43.1696544305067; Thu, 05 Oct
 2023 15:18:25 -0700 (PDT)
MIME-Version: 1.0
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Thu, 5 Oct 2023 23:14:50 +0100
Message-ID: <CACS=G2z84_-WkWa-BnK8bNNqb9z_o37BC3-kb_NkrjzAL=r4Sg@mail.gmail.com>
Subject: How To Pick And Work On A Microproject
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have gone through this link
https://git.github.io/General-Microproject-Information/  and I am not
really clear with it especially this line
"Select a microproject and check that it has not yet been taken or
discussed by searching the mailing list. Public Inbox is your friend."
 On the mailing list I see messages with the [PATCH] keyword in front
of them, am I expected to pick one and reply to it? How do I reply
directly under the thread which contains the issue? Please, how do I
find the issue on the Git repository? I checked the repo and could not
find the "issues" section also .
Please HELP!!! Any explanations would be very much appreciated, as I
would prefer to start working on it as early as possible.
Thank you.
