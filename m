Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E07A20136
	for <e@80x24.org>; Fri, 17 Feb 2017 17:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934325AbdBQRLX (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 12:11:23 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33793 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934122AbdBQRLW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 12:11:22 -0500
Received: by mail-qk0-f194.google.com with SMTP id s186so302550qkb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 09:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=P+nf80GT8rZgsoaZlHBPRDe/nvXt8mrftRzyn9iRblc=;
        b=YxAdql14FbhXzXjiZCBLE4BNeqV7ZuxY+sOo5ToCLZlQZku3UK+yqHUoTD4x9TJfAK
         cvezBckF7fMkq6IGA0GVJ1+H5EzYh1uyBuX4Dmm4lfCg3qm8t99qlFMTC9nA4zGaJKDC
         q0tdESTPj+GtXYBvWBr4lRY6myWUGALDngYF6K7TLeeX5/3AYxdsNW+UVBuWIZWCKn+i
         K7L38vmSfRcz7ppghFjF5INecwHUIXmVu89gf+qJ1yv1g9D1j8C9YTUL9y0r5y3b/vYG
         7pO1jT3m9HgAzABR+HVR2ZOtxHP7PvfBsdcvoTAL9/rOKHqGvHmQL/ccZFyeUwVzg8CI
         Rhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=P+nf80GT8rZgsoaZlHBPRDe/nvXt8mrftRzyn9iRblc=;
        b=MefeAxX7JZ1oNpsXMvurpqCi6pGhgMCR8/ZmkXaTfoUCec0x9Hae08z0+Qq2QA9ekT
         S9Vj/lDtbo98RtrW2oO4ou/F6Tm1ijP8PhLSEFz+v+S+pvuJQPlqyt/7KYMFekvc4N6H
         RwpuNDpQn3S3c4t2k/fvP8cVHj5fa/nsgrPz9M54WDKB+drMkp01A0Hv5KXEqcF0+gc0
         mdCBESS4YE23lD9K9TDKV8oohKOztgeSI785xEHLOe1l6QFwvpzkOAPPObl76CvxqSWl
         XKz1JubzukiOsbjub9E0A7h7klVOJRA0oDTRIen/pL6mbjB5kwjLb7K8SbIibNrTS0ev
         sNLA==
X-Gm-Message-State: AMke39mUp35TaLjlHu2GD60BannAL+hmUeGH9HG1ufyJ0gsYoZsnNRV7KdGW34oQsw78sFO+gaWD6B2aJkBpnQ==
X-Received: by 10.55.139.67 with SMTP id n64mr5654369qkd.157.1487351481503;
 Fri, 17 Feb 2017 09:11:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.40 with HTTP; Fri, 17 Feb 2017 09:11:20 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 18 Feb 2017 01:11:20 +0800
Message-ID: <CANYiYbFQ=Oz3VQL+YM5xp5-58wROL-7J=7rFshVzwQAtGDk2cQ@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.12.0 l10n round 2
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,

Git v2.12.0-rc1 introduced another two new messages need to be translated,
so let's start l10n for Git 2.12.0 round 2:

    l10n: git.pot: v2.12.0 round 2 (2 new)

    Generate po/git.pot from v2.12.0-rc1 for git v2.12.0 l10n round 2.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
