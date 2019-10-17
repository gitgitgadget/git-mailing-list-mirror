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
	by dcvr.yhbt.net (Postfix) with ESMTP id 97FFC1F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502515AbfJQMrh (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 08:47:37 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33725 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389259AbfJQMrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 08:47:37 -0400
Received: by mail-wr1-f42.google.com with SMTP id b9so2224949wrs.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Gxe6042L1YkYDNvtM6jwFdP7Dz7VG8DgRfoJQnQJ7c=;
        b=rYBXqD/wuAOTGBv/+xWfRWDvVDAXwY9BFYKH1BxzwQUs5+R70MGQ3B+5uXJyOAqwmy
         tKHzXjDeXbrLG03nuBt1i1FtU1qP78ibXXgOnq4M0jMQ2MLo8Nw0KX6OTsdyAfJwCALT
         l3lp9vpR3DQvpIjyfAjwxQgq5v4M96LonrBzzsHa7/v7pfmF6aNXk8pZyMXR/O8ub3vd
         k/DhSS06nk7Y270cQc/tEpoN48XDXWSnNlI6VL8kz/328xcHfRsTr8XgekqK99HpQXNf
         i/DFmYv2FsolKRIVc9MN5Mn/ssbCKitA9opfbUEM9NkyE02FgZi6DDtOOLPKAosB/t9J
         YcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Gxe6042L1YkYDNvtM6jwFdP7Dz7VG8DgRfoJQnQJ7c=;
        b=ni0SdB2ttGzBpP6eZaYx62LinrQnXxOxk3SIPRSeNt3Orcsm+Xa6VMGJwlfFbBYj1q
         IZ08L3FttZkwHw5QgelBYCC2RSwabkWMZnH3ugQxCjn/FMZ6tlqBMe5QX9wx6u1KuMIL
         GCmQy4R+n5KnEgZw0e3mS2GAYB0aOxrOlazTcwqg336QrXa3xFsF/3g01473xmKm0Qc+
         yIOqWRzbYAPeXEE8kea9YPvOk3OslX3N611uvEjlixbS38Wm3u0MJNPLGryYJVtTCqQV
         EWLZo4tcIRVjLu2dUy6Wt3nSvL8yo1ZZB2bAlnzIJh93dfZumtYX4oNd36Eh2jyhXvYV
         bVyA==
X-Gm-Message-State: APjAAAVVa08eXi4ioWtw9Fsii/WUCIqPO8/nrtxL2qImPMGCfrcwx2CB
        d4z4Dep0DH5p3mFhE+bI0aeBfU2+
X-Google-Smtp-Source: APXvYqxTWgegrMUqdaNdSvKm6rSfyeVrmaaebP7ukUyiVbPOsRoKhGHrEPnfFImmEQol+LFwvtwFww==
X-Received: by 2002:a05:6000:1621:: with SMTP id v1mr3087201wrb.62.1571316454878;
        Thu, 17 Oct 2019 05:47:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm2084485wrq.51.2019.10.17.05.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 05:47:34 -0700 (PDT)
Message-Id: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
In-Reply-To: <pull.400.git.1571160721.gitgitgadget@gmail.com>
References: <pull.400.git.1571160721.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Oct 2019 12:47:32 +0000
Subject: [PATCH v2 0/1] ci: update caskroom/cask/perforce to new location
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running CI on Mac OS X in Azure Pipelines is currently broken due to a moved
homebrew package.

Updates in V2: Johannes helped to make the step even more robust.

Thanks, -Stolee

Johannes Schindelin (1):
  ci(osx): use new location of the `perforce` cask

 ci/install-dependencies.sh | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-400%2Fderrickstolee%2Fci-caskroom-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-400/derrickstolee/ci-caskroom-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/400

Range-diff vs v1:

 1:  84830d89eb ! 1:  372ab24acf ci(osx): use new location of the `perforce` cask
     @@ -9,21 +9,27 @@
              + brew install caskroom/cask/perforce
              Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.
      
     -    Preface the "brew install caskroom/cask/perforce" with the old
     -    way of installing perforce, and only try this method if the
     -    "brew install perforce" fails.
     +    So let's try to call `brew cask install perforce` first (which is what
     +    that error message suggests, in a most round-about way).
      
     -    The existing way to use caskroom was added in 672f51cb (travis-ci:
     +    The "caskroom" way was added in 672f51cb (travis-ci:
          fix Perforce install on macOS, 2017-01-22) and the justification
     -    is that the "brew install perforce" can fail due to a hash
     -    mis-match. The mismatch is due to the official Perforce distro
     -    updating the published binaries without updating the version
     -    string. CI servers are typically fresh virtual machines, so that
     -    issue should not arise in automated builds.
     +    is that the call "brew cask install perforce" can fail due to a checksum
     +    mismatch: the recipe simply downloads the official Perforce distro, and
     +    whenever that is updated, the recipe needs to be updated, too.
      
     -    Even if a build server is re-used and hits the hash mis-match,
     -    it will fall back to the "new" mechanism which is currently
     -    failing, but may be fixed independently of this change.
     +    CI servers are typically fresh virtual machines, but not always. To
     +    accommodate for that, let's try harder if `brew cask install perforce`
     +    fails, by specifically pulling the latest `master` of the
     +    `homebrew-cask` repository.
     +
     +    This will still fail, of course, when `homebrew-cask` falls behind
     +    Perforce's release schedule. But once it is updated, we can now simply
     +    re-run the failed jobs and they will pick up that update.
     +
     +    As for updating `homebrew-cask`: the beginnings of automating this in
     +    https://dev.azure.com/gitgitgadget/git/_build?definitionId=11&_a=summary
     +    will be finished once the next Perforce upgrade comes around.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ -35,7 +41,11 @@
       	test -z "$BREW_INSTALL_PACKAGES" ||
       	brew install $BREW_INSTALL_PACKAGES
       	brew link --force gettext
     -+	brew cask install perforce ||
     ++	brew cask install perforce || {
     ++		# Update the definitions and try again
     ++		git -C "$(brew --repository)"/Library/Taps/homebrew/homebrew-cask pull &&
     ++		brew cask install perforce
     ++	} ||
       	brew install caskroom/cask/perforce
       	case "$jobname" in
       	osx-gcc)

-- 
gitgitgadget
