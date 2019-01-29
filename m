Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA941F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfA2OTv (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36774 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfA2OT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so16104245edb.3
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lCqeYJ5kfLqoi2oIKKtYTdsgfR0s8LiDnVTc/mVzstc=;
        b=qsEUc1Bw3McuDPqCiTpAVrYRQrdkBSOuGoOtZA2n/CYi5tTErlfx/mu/pUGFkHlPUY
         HZ/fbvPvWNaDdoLq9WBw0FD7KkKriCvS9vXtxop+KyQTZrQ/vlzCV+FjyzsiFHxbJZtH
         MJDr5yRDUOhsjUQwJW97v9BRZd81vYvoJEOAKJr2SbrS1maLMdCnlKT1X+IJmQgZPyRC
         /EGwFn4Dr8TOwLQNRpUwojSNnT2gx2m6Gi+45NBA4r6oUXfa8HD5pG4ezJyTG9wgHM3L
         kRYAqHzADHhkGu8bMuH2ZfAMlUQyhVbwEwx77fzmrfXDYjqFfa5+bir86oW1m6Bmybam
         DoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lCqeYJ5kfLqoi2oIKKtYTdsgfR0s8LiDnVTc/mVzstc=;
        b=q3VM5XPBxoOxZhqUytZWq75aP1Uli00w8d2XsO0JCy8lyQqJh9aKItKxbxMhExwuug
         Px15DszdgILwMuQyGFmYeoFmBwizeyxEq3vDxAKwg22h2VC/7LvjWij0N76LXiXR8/Ab
         VGobZ0NJ8wCcRFaM+D8EgYwP7PXlR17CYsjuesFpyux1nbqQHvBRl7bmgYJxcYdVPhCr
         +Igq64LFDyMaCg7c9V6i/0PVt9rVxujOgNIMlgqIiffpk5FtYTxx6hN6tR/qzPxaF6rh
         JPXmU8bT/xTYouF/pkro2FmZPtMN9mcozXzNl73FWHwAmppvJqJlbKH3aKLewMPpwUYk
         aHWw==
X-Gm-Message-State: AJcUukfhIYiUM2xcVJMmHJXMsXAaXPuthdeBLC5TYBeV2BQWbWUkVgeX
        +eDGsCdwER0QVfr/beTK0cXMfV74
X-Google-Smtp-Source: ALg8bN40RLopjX8GPjzrnw+N81m+xsr0n58mDMtFPMjn9WJ3rbMG5DJy61VVf8AD9dLfOBvVumg59Q==
X-Received: by 2002:a50:ca86:: with SMTP id x6mr24889850edh.287.1548771566755;
        Tue, 29 Jan 2019 06:19:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b19-v6sm8429778ejp.77.2019.01.29.06.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:26 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:26 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:04 GMT
Message-Id: <681f8e65b4d3cf82a5920840aa8dc88bde812964.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 05/21] ci: use a junction on Windows instead of a symlink
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Symbolic links are still not quite as easy to use on Windows as on Linux
(for example, on versions older than Windows 10, only administrators can
create symlinks, and on Windows 10 you still need to be in developer
mode for regular users to have permission), but NTFS junctions can give
us a way out.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 80d72d120f..74d838ea01 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,7 +5,10 @@
 
 . ${0%/*}/lib.sh
 
-ln -s "$cache_dir/.prove" t/.prove
+case "$CI_OS_NAME" in
+windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
+*) ln -s "$cache_dir/.prove" t/.prove;;
+esac
 
 make
 make --quiet test
-- 
gitgitgadget

