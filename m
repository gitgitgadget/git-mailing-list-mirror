Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E99C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 11:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhKVLFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhKVLFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 06:05:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C7C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 03:02:12 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso13270639wmf.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 03:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SjbgWvs7xZm+kBxDQFClq0PRHZ5st11D0L4ZY6y+O5k=;
        b=RmCiBLkuDVnd3U6w167+FwIS8fG+mFvxhP89lzV4aXYr4IiJFaFvhkLpdMovScmrm5
         sUexFImKgDSqZeFaWPz0Cbh55tN64aN5E79FvYtLGyofwqnMi/sHSotJkmDtTpCEr6HD
         QG3Ct6oHF3DwS34bp8apSEGS31XYMWhRJIBIeVdAdow9PutU51aaIHQw71tWLAQs1aVr
         4UyyL2eP3dsbBJSs1L/D2xLXP0p9xsw8SJy0xheeOn5wktEgz28LWTT1XHvBSuf3cN9E
         13dudKStYLAP9njDy3otpuQiC/QHFMugoT7MaeDtE3GYa8u3n8tbMB46Gc1NB8WD1CTN
         LXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SjbgWvs7xZm+kBxDQFClq0PRHZ5st11D0L4ZY6y+O5k=;
        b=YZTLxTcJuTxKsaO+j4WkXBJ/didJ0D2yufsxF4jVk1uGvgRIhWiBN0sq6wD164tNMH
         vSwleopC8OxHNMZUJzAp7ivEsRjNjCuASw5vGhrMwlae0k3uoP1QbP5AJeQH+1R9CUcB
         T25S0e3jNOaNRZKWMC4d6Yr4InA/2+SHP1OtDxJpdfZ5gHi0gYdLMPiCFTiHpnB1XoyD
         CXeth/INIan3ofhtIDWSiwsgA9rQ2ZohuAZbwqdK/h1d2mR2B/zSaXcFXKkHmWF6i59m
         H9oFHKqDgMm5BSSJlXY1MTbzA7LgV4a7kjfytMuRh8GWzbL2Iqn7ECVR1Yb96C5c5CNd
         iQqQ==
X-Gm-Message-State: AOAM530p2Jqb4RCGZfJ4kzFScuryfoiG910ygMSSbVbUVoe0B7IobD0b
        kMGqW+k2kZqc05I7p7DfH90zXrjc+IY=
X-Google-Smtp-Source: ABdhPJwBKjwE/mTI4/K5M628BOI1V/sBDf7jZoY6ZGOCJeGXYwnlRPv+YzJOPZA9WCzaTzixYOKKCg==
X-Received: by 2002:a05:600c:1d9b:: with SMTP id p27mr28646342wms.123.1637578931373;
        Mon, 22 Nov 2021 03:02:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2sm20963758wml.15.2021.11.22.03.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 03:02:11 -0800 (PST)
Message-Id: <pull.1081.git.1637578930464.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 11:02:10 +0000
Subject: [PATCH] fixup??? Merge branch 'ab/ci-updates' into seen
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The merge of the `ab/ci-updates` patches needs this fix-up to avoid
breaking the Scalar tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    fixup??? Merge branch 'ab/ci-updates' into seen
    
    This fixes the CI breakage introduced with ab/ci-updates. It is based on
    the current version of seen: 89513b853be (Merge branch 'en/keep-cwd'
    into seen, 2021-11-21).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1081%2Fdscho%2Ffix-ci-updates-merge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1081/dscho/fix-ci-updates-merge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1081

 ci/run-build-and-tests.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index c0bae709b3b..c508c18ad44 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -45,9 +45,8 @@ linux-gcc-4.8)
 	export MAKE_TARGETS=all
 	;;
 esac
-make -C contrib/scalar test
-
 make $MAKE_TARGETS
+make -C contrib/scalar test
 
 check_unignored_build_artifacts
 

base-commit: 89513b853be400c439e19e479ed14e9e8de44722
-- 
gitgitgadget
