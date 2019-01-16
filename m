Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDCAC211B4
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393248AbfAPNgr (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43450 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390489AbfAPNgS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:18 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so5395350eds.10
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lCqeYJ5kfLqoi2oIKKtYTdsgfR0s8LiDnVTc/mVzstc=;
        b=tawbc5JknGk1rrz5XREzH99okPiMB/82XTuhdu+TabsmK7oloCJCnfiuZhaINMYPGa
         E5LBQGm+kFluEdpmUmm8ZensEZw8j8nY6GWdkWypi3d9tE6WF0DU4sieL3JHWSId2BQm
         JFWNOEPvWcsKsMC6c3avisCBrXw1fZG/CSJIPuWJO9YdjvS5xZ5j0kSOTS2A2XoO/hoR
         J6vmOFNOFdsG2j6uiPtv9oO1ziBq9Z82UIonRIwwjGyMH7g9wITHqPBuT59/P3z7bqH7
         ed098PieH6fK8MZkBkPIFZ2zwpdWGIjiFrdb/Dh5cluapRXFQIoLMnRfuyb4P/DM7dV7
         fzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lCqeYJ5kfLqoi2oIKKtYTdsgfR0s8LiDnVTc/mVzstc=;
        b=AQp8i7vKW+X01spm9Sjl3STsHJhlBXpaTW9z8rZkR0Od8ohkkUpnK8VhOHxjLNu6M1
         wuT1dUyJvTBG9oRSIlFfW3aLrbvJRW8cg5EhmpUY2n5TGcSOjFt81Fk18lf0nQn8wCa+
         zMoldyoWnsnyEdGMI8RaUGvYyunwONz5f4auhuJuP+QUYVQ7fvsUxjkfPbvRfI7+l+MA
         x4YMIpD6j/rY/9vMPivfPP3ppy0EecqVHthA5iU3QJYFMmkW2kEVyDSG22bSVwnRfuSC
         3V1kyIN/Mg791TNw56DuEKC7Tx0vxVpbxzPrFw4PiUWqibGTkYKzt2QIsTwCJ4VQxCBb
         lpjA==
X-Gm-Message-State: AJcUukffBtDrBAsVEeU0cAQhiwhJaNR2ZSfaIHz7w1mR+z7Wrc4DWzbs
        7MF5EJFoKgRyj+A7FStKrgSWtMVO
X-Google-Smtp-Source: ALg8bN6r4pzdurv2NytyLW8I6fHd8ZbZWgczUo6u8QeW2uwn8tqav+6tZ02LEVLKfMjbzkQnuCB5Lg==
X-Received: by 2002:aa7:d88c:: with SMTP id u12mr7158149edq.237.1547645776129;
        Wed, 16 Jan 2019 05:36:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g40sm5504564edg.39.2019.01.16.05.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:15 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:15 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:35:53 GMT
Message-Id: <a35bc43a04b0251f6f5a3976e062b606b50b6009.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 05/21] ci: use a junction on Windows instead of a symlink
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

