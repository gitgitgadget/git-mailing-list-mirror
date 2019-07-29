Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,EMPTY_MESSAGE,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MISSING_SUBJECT,PI_EMPTY_SUBJ,PYZOR_CHECK,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239451F462
	for <e@80x24.org>; Mon, 29 Jul 2019 02:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfG2CuK (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 22:50:10 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:39428 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfG2CuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 22:50:10 -0400
Received: by mail-io1-f46.google.com with SMTP id f4so116837703ioh.6
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 19:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:mime-version;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ONODbISpW5ScYxmBC9aorAgPP5/hv5DWgezaKh5Je6VtOVktPqM1aqUu8s1ipVuWV3
         Sq1GhJQDffN2djk5b6bcaFzu43TgKhyNwyPU4dgTGZJ00sKKrsmWfWoA073qvEC0mYCH
         KG6B1/aFwp5kHtbC0mkiQaBlfiumKCqSom1pLyHkuY9qo5Y5JcdlvpS2girXIdU5WazG
         M/Hoj+Qpu/5rWzLXAJlXTOaQ8yEltwYL/xWcuUHG0+9w5c9KLpkzma68dnZhBFprRZge
         8rvpYDiPAWVL52RMevXvxBSKcdUGdy05IDYOcS5j8mHcfLyhwWcYWAUgI0gjKMf/a/xZ
         Oatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:mime-version;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Tgi3c3DssEQAef4/NC4zhBqQdw4sYDJDwjJEl1Io1AOwE/L+Db5Yf+wm/7eSeC//BP
         7q91orOM/+OGd1/YOGKRupQx8wCXxdcsmvhJ6UQG+bffZ3jzwTebRUTwW2k1/P9oqP1i
         mebUUYJAeWxMBzDyBOud+SPqSb+2a05Qcrr+wFXQ/G8v1tsw2Sw4knqKnRrpiLoxl3Jv
         ormGfvcvf5LiIJABdhuncu7kClKxy3Sve4d9foVk2+MAaP14zIDzhlKV1JFmq3Wb7cSI
         57y5u/5IAJvo6gafUkrxQNV4mNsSnYxu/UjvfnaTAlVzmMSP2QcUpoUNSZ4g7cgo5HNT
         XtRg==
X-Gm-Message-State: APjAAAVfqxbqCP5m5sMtp+7qMhyBjT9UienqvWzv549U7lPOUBVPixVk
        t5OTcGoTZZm24KTB6t1cmNoejZ9hBsY=
X-Google-Smtp-Source: APXvYqx7s5NHCmf0yPDPtDtgBu7iDD1679KSythcAHx+vOYUjjRGHBgbtZM6fPXipXXeTep7g6HDVg==
X-Received: by 2002:a5d:87c6:: with SMTP id q6mr29724122ios.115.1564368609122;
        Sun, 28 Jul 2019 19:50:09 -0700 (PDT)
Received: from [192.168.254.28] (184-15-183-12.dsl2.chtn.wv.frontiernet.net. [184.15.183.12])
        by smtp.gmail.com with ESMTPSA id z26sm59836535ioi.85.2019.07.28.19.50.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 19:50:08 -0700 (PDT)
Date:   Sun, 28 Jul 2019 21:50:05 -0500
Message-ID: <3etpo82nv4a0hcwn8w3a7u6s.1564368605100@email.android.com>
From:   Michael Anthony Rush <realrush81@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

