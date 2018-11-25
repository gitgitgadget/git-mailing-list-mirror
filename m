Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A781F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 11:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeKYV5x (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 16:57:53 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:42425 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYV5x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 16:57:53 -0500
Received: by mail-pf1-f180.google.com with SMTP id 64so5183207pfr.9
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 03:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//bi7/L2XmoUk1seI4tLj06vkx3YOzo8l/8GSPHI5HU=;
        b=HB+16UOevFUM7makyd8G4Re7Bnftef2Vjl0EdO+bukutTCMKELIh7uCN7uaapqWGFd
         E76BQ61mDsY1sXp2pGo2oo+OiizT7cfByJ0T4fpn5BkBVHW62GXyYwB2NjBpm3snBP4D
         Y7UWvk+FqyqqTh+eBxQ4xLRAHRpM6Q5vDieXQ3ll3K16qbqDiNuG+sp+7a74cvCf9/U9
         tt0PTIpXai+ZabbWqUV295NY6HBr42wZ98ejNrgu/sP9zNaLlz70plYbo/PPSjISm2Wy
         pV0bpZMP2A1Xim2wSzJM5mWbRjfePJn8GL9ng/KO1s2CiVF5HhvWp3YMhY9AfvB9JVsP
         lQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//bi7/L2XmoUk1seI4tLj06vkx3YOzo8l/8GSPHI5HU=;
        b=ZBv3r1SD/lXH7WqidPEJOHWKW9CRROAxOYsluro2Lrd/slqk8OzBGKbJ6C1tqrWosB
         dy2buGUvQ1QO/cBgHtm/gF8Uyt60q/on2wE4qzRGR1V7QT7nAtnnCwkvYfBVcW/6ny+Z
         ock+91orThLh0abtMyCwRdlBW32XTY/FT/E4JO5ERAXhBbaDbB9za6xJTYi2DHlWovJw
         WZa2ELoVYCApWLE6AE6ldQd0t3kGYhAomGcnDy2p91ij8ZH2VgAatMqYcYLWKxqk3jOM
         k/EzWCFj/u6+5lvYvalgjnZqvMyPQHiBPuOdxbLH5njmCVZZuFIAUJgFZsrKL5CYLdbu
         ukXA==
X-Gm-Message-State: AA+aEWZsQrP8vpTbbP4OSNahlgnHA1F4/rJ1Nfy6X3BpTsus1fSTj3go
        +UEuju/im/HNaWmXrZqwAxP5TpLe
X-Google-Smtp-Source: AFSGD/Vynrjw+gUBE5zvE9iBhLxHSt+jNHYjbzwxOutwarWUhayL8hr8v1xcvmVVO36bU5yfulbgag==
X-Received: by 2002:a63:1321:: with SMTP id i33mr20937297pgl.380.1543144023473;
        Sun, 25 Nov 2018 03:07:03 -0800 (PST)
Received: from localhost.localdomain ([136.179.21.64])
        by smtp.gmail.com with ESMTPSA id h15sm21154301pgl.43.2018.11.25.03.07.02
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Nov 2018 03:07:03 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 0/7] test: NetBSD support
Date:   Sun, 25 Nov 2018 03:06:43 -0800
Message-Id: <cover.1543143503.git.carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Likely still missing changes as it only completes a run with a minimal
number of dependencies but open for feedback

Requires pkgsrc packages for gmake, perl, bash and curl and completes a run

  $ gmake SHELL_PATH=/usr/pkg/bin/bash NO_PYTHON=1 CURL_DIR=/usr/pkg test

Carlo Marcelo Arenas Belón (7):
  Documentation: update INSTALL for NetBSD
  t0301: remove trailing / for dir creation
  config.mak.uname: NetBSD uses BSD semantics with fread for directories
  config.mak.uname: NetBSD uses old iconv interface
  test-lib: use pkgsrc provided unzip for NetBSD
  t5004: use GNU tar to avoid known issues with BSD tar
  config.mak.uname: use pkgsrc perl for NetBSD

 INSTALL                         | 6 +++---
 config.mak.uname                | 3 +++
 t/t0301-credential-cache.sh     | 8 ++++----
 t/t5004-archive-corner-cases.sh | 2 ++
 t/test-lib.sh                   | 1 +
 5 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.20.0.rc1

