Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B121F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfH0KKQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:10:16 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:44877 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfH0KKP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:10:15 -0400
Received: by mail-io1-f44.google.com with SMTP id j4so36606942iog.11
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZY9dASqdyd+hLChhLAknQBzvNnWQrZfhsAAvJ7c7vyg=;
        b=cJJ6f8JK19uLi0XR67sqxcbXJHlWINs/1V8jPiNow1boxcBYZDWi3N38aoA6Bmjs8F
         zgQ3ZR3J94RMVglXaP61yoURHQU/q/tN5ltF9BdGKsvrU2dbJocpHsiOsCR2DwXZVGCb
         0khy3zzBSPqLvFez+dPWAHh2MCp1RrmL7RuL4Mc0oEanUcSPxA7n+7SdDehMBE0TkZp1
         ASOG6sHEQVjdubO2tXiAYpWO5o79uRJj7lKuH7AtEvdAFVLohxYIM7RjEKBJ5FfO3Xc8
         MYZjD6R1Wnt9gPZJomeDCxqePNJ3XIe41NjdM3bFYXawQ61eWckcIAo615QNup1uTqQW
         vTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZY9dASqdyd+hLChhLAknQBzvNnWQrZfhsAAvJ7c7vyg=;
        b=mmng9INDJrhfLZ2SpWLGhg1S5d/tpSB2pFYwbId4A09SlkRghfWXmeTx5ZFIiUgMGk
         +Dl9O21Ai+cucdKcJQargbU0z2CMVXE+/poHbD9DLQZ5J5pDAqwyFWNT88EbIxGW1ytz
         P/ronUIPH4EhTYKQAsyE3QmuTnHe6YimWmaaWdtE2XK0oJBZeNFPjp6ExDiGDyvqTDcW
         o9UIFiTqnFC1sZ7M8KpVoUFAhKYa7azdj2c739tuFJl/AM7OhZKxbe3Ci/SHWZnx8io8
         zn2/WqTSH/a3Vg32UyhhPXBUvXAqd398GDm2xNOTtMZ3BTg0bZcFS8YAdRLw7yU+ZOcy
         iN9w==
X-Gm-Message-State: APjAAAVncy8JtkETNOzj4VEwo8SyCJIYGJlNLazj7axfgJW7Fm0vK8uY
        zITPfeivLfCK6ByuMxW1MGGQ2ZnV3x00MkXhFmbfssiH
X-Google-Smtp-Source: APXvYqxrTCxLBvkX1/9oxhwCsZS8ube27YfMkD2SKPk2MEszqU/YIxysOBfjdSqwmSfk/fkz3acqZvaunfy9Jqca+fw=
X-Received: by 2002:a6b:ee14:: with SMTP id i20mr6406653ioh.241.1566900613810;
 Tue, 27 Aug 2019 03:10:13 -0700 (PDT)
MIME-Version: 1.0
From:   Konstantin <kostix87@gmail.com>
Date:   Tue, 27 Aug 2019 13:10:02 +0300
Message-ID: <CAObSod2jhDjq=Fw2JtNMsK53HxXSf3n6K5XacHQBH00L49mNpQ@mail.gmail.com>
Subject: How to split file with its history?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

currently we have one code file with deep history.
As code file grown it is necessary to split it.
but this action will drop history for the new extracted file.
how can i split one big code file to small files and save its history
for the "blame" action?

-- 
Best regards,
Konstantin K
