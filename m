Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55C6F1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 13:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbdCXN6K (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 09:58:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35905 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdCXN6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 09:58:08 -0400
Received: by mail-lf0-f65.google.com with SMTP id n78so382533lfi.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=IM7f58BY44nHhL7D5f/UWCvHpULEnNk9xmVPIpWGyOg=;
        b=aY/Z3JA602SGShq01Wh1oFf+JVgK1bMwu1Zs/Lm/xSdr9/tPakg6u9wm4d4lH+jYvK
         0c48bvzxhsmyqi0b+Tmoc1uXwkP7/BF41YaUu8fV7G5KqjXVZQnAb3Vy3SiaG3cn0afB
         stSokSUutGDnFrgZbbeRth6P3LjFiGW468vEJNENs9pHP91jHBP5aj0wpQmCVleUZlp5
         K1WesuoeLrly+jPBrh0UXalk0281Y8nW1Qy/vr/lvjMA3sNXaQ6h2fBUv4UKmTQHZA/p
         PnqUcQhz9DOCudXBKbSfyI+qR1cWI0g5EA5m3yQz101574OM3/c0fm05k7qhJnxzZ3zI
         KpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=IM7f58BY44nHhL7D5f/UWCvHpULEnNk9xmVPIpWGyOg=;
        b=H5j/R43qXNqDeYyW3qWFbz49zjz8OK5O2U/BglRZfaUhKN0JE7blTbKlgH/Cw2c023
         Ghz463rmDBpM02n7UfROCMN3mJZZkbmI2Uo7Pgd8dS0SbV/eQ3UEIR+YphJVeWOzCyC9
         TA9WTsHC84zB3OJ0Iq2gf6TFymDo3d7FzO0dhqYOC1i8RSgpkSLy2L7qSpMaNvKRv/44
         dWuAXhZ8xOjZUQBS233i1nLDbj2vZ8VxVurzb9wAkidxwQ8XrLw4IeFjWFZQwT1lXYDz
         UDfKI3FE/E4SObt14bfTtlIpoyzb7+26GWOtBKOCknjO488BSjVPmvYn38qfQX6dvY1w
         zg/A==
X-Gm-Message-State: AFeK/H06ao8jlBIVs/AKD8dbqFtnGsXwvBftEHPmMmwoeobtbwxwc2i47OL4eRJWjGSobQ==
X-Received: by 10.25.17.153 with SMTP id 25mr4589053lfr.39.1490363885603;
        Fri, 24 Mar 2017 06:58:05 -0700 (PDT)
Received: from [192.168.100.2] ([178.121.253.81])
        by smtp.gmail.com with ESMTPSA id t30sm368366ljd.39.2017.03.24.06.58.04
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 06:58:04 -0700 (PDT)
From:   Nikita Kunevich <nik.kunevich@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: [GSoC] Git CI Improvements 5 microproject
Message-Id: <B7AD8170-0742-4B22-9C6B-EC2A5DA12929@gmail.com>
Date:   Fri, 24 Mar 2017 16:58:02 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, git team. My name is Nikita Kunevich. I=E2=80=99m student of =
Belarusian State University of Informatics and Radioelectronics. I=E2=80=99=
d like to particapate in Google Summer of Code 2017 under git =
organization.
I=E2=80=99m working on =E2=80=9CGit CI Improvements 5=E2=80=9D =
microproject which is creating web page for analyzing most frequently =
failing test using data from Travis CI.
I=E2=80=99ll write my full application as soon as I finish microproject.=20=


