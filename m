Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8241F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfA0X04 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:26:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42193 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfA0X0z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:26:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so11587454edw.9
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lCqeYJ5kfLqoi2oIKKtYTdsgfR0s8LiDnVTc/mVzstc=;
        b=B8QIYEwIufQVnROqJNIFItY759s7R42Cu77TeoYOn9zN77VtE2XZQVe+IGvq17Gybu
         aCLQmEywRkR3y201xGLegQ8C4x45toqVn+6lo7GZd6njn0eE6mdnwAI58vqWqQyYPPPD
         FaeR3CWHlINzyS+i8cLvcDVQNbxhVM610VvOhXZvMjQBJjkLBcB+NfK7UZH1A/TFi7cy
         I+TQIqHNpGiINrNNfrMyFyudCmNcrjqoDHG2TzCCEwvpyVmvTb+0cPD0R0uxg7HPkVeW
         yvXNdJkBFZiKxYYQbaylkAHe5Oni724XKs+zUhgHJhgAKrOtm1lShNQ85Kxk1sJkR7eY
         vnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lCqeYJ5kfLqoi2oIKKtYTdsgfR0s8LiDnVTc/mVzstc=;
        b=V17R0veiAdZWPJgyOmwbnXBF7/lV1bvuuGZqmv0u76PVe3WqATxujqXddhRmTw5a6J
         2OFDun1tdvcaQy1YTlo8xP4p6at8n5t1GF5wZApqEKZG3D7UudQ6hBba3FQHoTvzvQCZ
         5HKoOvbJQGHzcn3HR2qcU5B/QTPzbIaGUqZ7WfypK9za+LujcbcnCBiqRlY0cPa3cEI5
         A5H6ZnqUVvlwbEha7f1yklTqoZSi+5ADNhnialXbwO0uzUlgbH66ddkgAsVJ/4zkbACe
         f14JSbPMAmWzTUwVI3dAhX1/6cR1PUpjTrpVw8fEvX2O2BxX86gE6IDnNNDh3iPOCyd6
         8+6A==
X-Gm-Message-State: AJcUukc4MkPJ8bZvmUiFCSfzyAh2WAwECXk6ar6iMUhiV4ZofGayN6Pz
        uVPn3w6rZ7Ry5N3I1lKDkM3VdFSA
X-Google-Smtp-Source: ALg8bN7dFT10ggn2MTCPZlOrG2ULImHq8ytmBQYysl4ZM2OjV3mN/oqlgcEXTtl6dCkztljKisedsg==
X-Received: by 2002:a50:c408:: with SMTP id v8mr19277725edf.144.1548631613743;
        Sun, 27 Jan 2019 15:26:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g21sm13637807edc.63.2019.01.27.15.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:53 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:53 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:31 GMT
Message-Id: <681f8e65b4d3cf82a5920840aa8dc88bde812964.1548631607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 05/21] ci: use a junction on Windows instead of a symlink
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

