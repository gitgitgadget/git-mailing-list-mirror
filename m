Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD6E1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfJORcF (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 13:32:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44131 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfJORcF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 13:32:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so24860641wrl.11
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zv0muuJnujFyjXHe2NdqHS74fBg7jStix6HxpChMmsU=;
        b=HTm/y9SuIfZyDJvzIEjC9R6m0Ypdr/lqSNx3b7fN62/hlaLvPI3ujrXC0C68I8f+XL
         RiBGxc0Et9dAgBTRqVsR2Ebzi83FhdxOF3LGT/xOSR+RTCNYIpzLJYQS93BNLXQzzxik
         zzTO3DjWr2NSS2WqJOuRgrG2PZGrgtSww2zvtsgxcO+sng2AU+k/iSbrfPa6nky0GgIp
         IlOGlXc9umBFW8fb/wmRTLfTcV7Rs0LQW5WFCZEBplYYjx0K+8oT05amHdeS0v/JbctB
         uqPaZ/tszEtZ5D7BwK4OjGEAtgGpK6HMjezjdJryrAog9hbbpy66yhLm5csxzwi5DPO6
         6Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zv0muuJnujFyjXHe2NdqHS74fBg7jStix6HxpChMmsU=;
        b=T6q+NAdNIjy4PQdFjf0VVY4N82X3Uwa12wYWaINc6EyWRa8RvBBbOqHnjId9nXy7eo
         1B+/uNokaE2ipzbOlXNjHYHDEd61z6Wf/ddYh/sj7WF2grAHbKdWEYqnk/P0xLtnAmOX
         QOykMo5WnGIdEmRho6i5WSDU2EqcXnebDbSDUnuRvCggb0NlEaQy9JDW+gHsQ/pRGjA6
         2ImHUu9CeXNdxkV9xp/CDOTAdJEsA2ibv3PFq7aQDn760ad9G+aQfrSaO2JUuRCbTJu4
         Hpkl/l5PM5ybdRpUfYa3iSE8Duw29Sm+eFTlC2KseHCsZrmSm1dvh1xzws4wtzZ4I1E+
         aGpw==
X-Gm-Message-State: APjAAAWViUn5vUBFUVeb66ijM/cEGFPkybiPcXMmn0PTAkh+2huidN8T
        VhLUoZSXm/M9augJdD+SLOpc3SXy
X-Google-Smtp-Source: APXvYqz2YUz+qvKe0UVM7MiPDrfmmrglE3jp/hEyavm08xxztKxz6MOkwqqt8JPICBXokWSK3/ryCw==
X-Received: by 2002:a5d:658e:: with SMTP id q14mr34443554wru.380.1571160723412;
        Tue, 15 Oct 2019 10:32:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm24627776wra.82.2019.10.15.10.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 10:32:03 -0700 (PDT)
Message-Id: <84830d89eb330f256b3802e0c1b63ff32030ff79.1571160721.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.400.git.1571160721.gitgitgadget@gmail.com>
References: <pull.400.git.1571160721.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 17:32:01 +0000
Subject: [PATCH 1/1] ci(osx): use new location of the `perforce` cask
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The CI builds are failing for Mac OS X due to a change in the
location of the perforce cask. The command outputs the following
error:

    + brew install caskroom/cask/perforce
    Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.

Preface the "brew install caskroom/cask/perforce" with the old
way of installing perforce, and only try this method if the
"brew install perforce" fails.

The existing way to use caskroom was added in 672f51cb (travis-ci:
fix Perforce install on macOS, 2017-01-22) and the justification
is that the "brew install perforce" can fail due to a hash
mis-match. The mismatch is due to the official Perforce distro
updating the published binaries without updating the version
string. CI servers are typically fresh virtual machines, so that
issue should not arise in automated builds.

Even if a build server is re-used and hits the hash mis-match,
it will fall back to the "new" mechanism which is currently
failing, but may be fixed independently of this change.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 ci/install-dependencies.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 85a9d6b15c..489b5dcf17 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -40,6 +40,7 @@ osx-clang|osx-gcc)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
+	brew cask install perforce ||
 	brew install caskroom/cask/perforce
 	case "$jobname" in
 	osx-gcc)
-- 
gitgitgadget
