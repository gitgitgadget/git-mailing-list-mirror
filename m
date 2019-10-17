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
	by dcvr.yhbt.net (Postfix) with ESMTP id D98491F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502539AbfJQMri (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 08:47:38 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41330 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394076AbfJQMrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 08:47:37 -0400
Received: by mail-wr1-f43.google.com with SMTP id p4so2194097wrm.8
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uhfZQGA+ibzUn8wTKSPUbfCa0QLzzZ2b6b2P0kJ/7Dc=;
        b=FfO9QqfN4EefXqxpnWYt1dSP8DL8QFkFDIMZS88ydkoD1Wdgupg8x2x37AutplWmZ6
         /k29Lsp2+f+IRGPsYk+qPrqVbIxomniwwHUzcuyux63ftWaaQzcV1dHsO90eTjxlNYN7
         h5dLYbmjVjrFZVuPBSGjHZBQEEJbId9RClOROV4bL1dDopKcz86ZaGO4Kt600kOFa6jY
         vPv0bh2REvyZotHHcMenlxpBCA4P85cSRtRpYda9Bo/VLu1IgI9ZPlpimj+J2I+YiVNP
         ZdFQL/gaYll/mhtVgORwLxSGmQOZ8xKfkQ5MRM2V7zFtXarf/tX11QysYGji52/6+9Ia
         Qq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uhfZQGA+ibzUn8wTKSPUbfCa0QLzzZ2b6b2P0kJ/7Dc=;
        b=MTEeZFseVsIYX2637iV7mD1fKMLh5Vpg56CdQUrUVioFQKzEOCqzqrJetdDm5iw7Nz
         Yns6r8ZVAWpbWa0sHek4nIS/tlYkrB6i4BRZIkv3kMbdxmTik5L/lcDpKQtDEa7PVXx1
         vc2mXU5cJg1P6AMZcEQ4XZBCk8vuJTI13yFTxC+2W3jO4DMMhpRnJLoW/hS47rl5NRYU
         Gnv/8ZsiY+V/ORToS/QYA5qo8d9in8CvtHSbnx6BEMPoyx9B78lnXEP9Qrd7XDBlwTq/
         zP7QvNjUH/k9El338gP/7fvpZ+N/Gj4PZbNhbCRtnuea5CV5Rb0yDYiFcHPSsgG4/wBY
         VGjQ==
X-Gm-Message-State: APjAAAWbrY2w5GV3XIYyEMUiADX7z90OLAmioMb149qtU4vJf6kIqZda
        9Ky/q+Hau82ARMIvUL9591XhI+l1
X-Google-Smtp-Source: APXvYqxLKU7U+X3l5/ezpMkngKedSM4IEG1iYbRKWi0SK2o003KVDNwNWGtsVKhJ48PN1vOk4CBDcA==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr2817581wrn.261.1571316455600;
        Thu, 17 Oct 2019 05:47:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm2088649wrt.17.2019.10.17.05.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 05:47:35 -0700 (PDT)
Message-Id: <372ab24acffbc956407cd93ed34135f83156e10d.1571316454.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
References: <pull.400.git.1571160721.gitgitgadget@gmail.com>
        <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Oct 2019 12:47:33 +0000
Subject: [PATCH v2 1/1] ci(osx): use new location of the `perforce` cask
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

So let's try to call `brew cask install perforce` first (which is what
that error message suggests, in a most round-about way).

The "caskroom" way was added in 672f51cb (travis-ci:
fix Perforce install on macOS, 2017-01-22) and the justification
is that the call "brew cask install perforce" can fail due to a checksum
mismatch: the recipe simply downloads the official Perforce distro, and
whenever that is updated, the recipe needs to be updated, too.

CI servers are typically fresh virtual machines, but not always. To
accommodate for that, let's try harder if `brew cask install perforce`
fails, by specifically pulling the latest `master` of the
`homebrew-cask` repository.

This will still fail, of course, when `homebrew-cask` falls behind
Perforce's release schedule. But once it is updated, we can now simply
re-run the failed jobs and they will pick up that update.

As for updating `homebrew-cask`: the beginnings of automating this in
https://dev.azure.com/gitgitgadget/git/_build?definitionId=11&_a=summary
will be finished once the next Perforce upgrade comes around.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 ci/install-dependencies.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 85a9d6b15c..ce149ed39c 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -40,6 +40,11 @@ osx-clang|osx-gcc)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
+	brew cask install perforce || {
+		# Update the definitions and try again
+		git -C "$(brew --repository)"/Library/Taps/homebrew/homebrew-cask pull &&
+		brew cask install perforce
+	} ||
 	brew install caskroom/cask/perforce
 	case "$jobname" in
 	osx-gcc)
-- 
gitgitgadget
