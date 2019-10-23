Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631F61F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 00:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbfJWATm (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 20:19:42 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37390 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732940AbfJWATm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 20:19:42 -0400
Received: by mail-wr1-f47.google.com with SMTP id e11so11272930wrv.4
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 17:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=t1BTT4NLQknx51JaF436I2yETE5wTqe6zbHfP9u5DvU=;
        b=KRx92ArbPEb4Yy3B7QU+CBCbeqWGE+MeCHWz/btcuW6ov2iKus2DnDiW0SFCL7xQdl
         RShwMW2QQkhkukiLgY1ToPz02HQJUxcDHOUlAVzjopxb6veP8IbGVTcnRIH8mKAREa3d
         EItOfdDUV4rZidVQxBml/A73DG2QtWYndq/0h+fg1lyhzmiVIo71cVM2XNtU2zd1c1ZC
         SLXZQlE5KMXVMPju/0HSIaBCarIxX4aN4WxhpGvn1IifV5UrlkJDOtSejeFm6PX9d7/9
         AIgnEgSvJlmiyZ1dRxFn8XlYpHZeH5RSCU68yX7QOFHEARZHzx/JUoLFpzE99WbIjykJ
         C7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=t1BTT4NLQknx51JaF436I2yETE5wTqe6zbHfP9u5DvU=;
        b=JGjqAzltmaLc6Im3q3tOpl4YLzxKG6N/B1Ilq9ZEPP0LzH5W8PDjFdf0kyjaCbvCaM
         JTDzqco8XQBNP1inlskeUh0Z7LP2rJiXYNAHITBL+jgNZkKCrLhocfsMjPEYma1xsW9y
         GZYfspMIUAEod19SP0OoKzlzc+AhXHT5ZLi4yvJWR1WTJNYxM4Sw0uNGi1MNbmxsShG6
         sMB13/kmJpyygOhOJ9kbXNdrUZvDwiAukKdotTp9FF7R6cVdpVAqeLeqC2jZwiEEwpHH
         g8EcX1aMG45hzLAexcndFq6tlt7do6OnKaR920z0XEvNR39zqoA6bA0XyLx5Z1Aotj2q
         Qyvw==
X-Gm-Message-State: APjAAAWOITi2+EtzPCUbXVdyIxBm6a5VRP3YPgN5JRvwjzbP1CzcJm/1
        Ne7gzv56aKdzeMX+no2+VOKBRciP
X-Google-Smtp-Source: APXvYqxV9bV8ZAAN/z2zzrE9s/5nprUaJczYbO7swSfiad/YqHXqlrkZHK8Hy07s2gu4ugHZ7KNvDw==
X-Received: by 2002:a5d:4ace:: with SMTP id y14mr5838697wrs.131.1571789979999;
        Tue, 22 Oct 2019 17:19:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t23sm9115234wmi.15.2019.10.22.17.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 17:19:39 -0700 (PDT)
Message-Id: <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.400.v3.git.1571789978.gitgitgadget@gmail.com>
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
        <pull.400.v3.git.1571789978.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 00:19:38 +0000
Subject: [PATCH v3 1/1] ci(osx): use new location of the `perforce` cask
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Azure Pipelines builds are failing for macOS due to a change in the
location of the perforce cask. The command outputs the following error:

    + brew install caskroom/cask/perforce
    Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.

So let's try to call `brew cask install perforce` first (which is what
that error message suggests, in a most round-about way).

Prior to 672f51cb we used to install the 'perforce' package with 'brew
install perforce' (note: no 'cask' in there). The justification for
672f51cb was that the command 'brew install perforce' simply stopped
working, after Homebrew folks decided that it's better to move the
'perforce' package to a "cask". Their justification for this move was
that 'brew install perforce' "can fail due to a checksum mismatch ...",
and casks can be installed without checksum verification. And indeed,
both 'brew cask install perforce' and 'brew install
caskroom/cask/perforce' printed something along the lines of:

  ==> No checksum defined for Cask perforce, skipping verification

It is unclear why 672f51cb used 'brew install caskroom/cask/perforce'
instead of 'brew cask install perforce'. It appears (by running both
commands on old Travis CI macOS images) that both commands worked all
the same already back then.

In any case, as the error message at the top of this commit message
shows, 'brew install caskroom/cask/perforce' has stopped working
recently, but 'brew cask install perforce' still does, so let's use
that.

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

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
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
