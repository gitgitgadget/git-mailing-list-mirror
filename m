Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDCEC433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 10:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiFRKTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiFRKTa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 06:19:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07D925C69
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655547566;
        bh=7+x4aNmVYG8yI9T6NB6iEVJhZBZXLEXSJ0FC/bxpkPQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WqPC5S/Gw3DDxlgzXu0L2vsXKr3Km+Ap9AFmQhZs/9a8dE7+wlMCi5opVEibAh9ta
         Rnu0ppOWWRdeRr6h1sNhdJwq2K/+gYrLN+xYr7gSqDC06f413iwqCX5Td8K0lGdZyu
         HdeETDLBcBa0bfZDYLXe2UG1rJqI3af8/eejQlRg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az71-490.54gadnqkfkfezo4rfhga4mummb.dx.internal.cloudapp.net
 ([20.245.201.29]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MxDp4-1nn48D3vT6-00xXbz; Sat, 18 Jun 2022 12:19:26 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.37.0-rc1
Date:   Sat, 18 Jun 2022 10:19:22 +0000
Message-Id: <20220618101922.4422-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.36.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:D/ZtCn33gOQLBHyImGbfBsM10Ybr6a6LtAipt6WiLMJWocuDbKW
 MApeqLVHiscZBraJvEMO+EVFkcs0HKNWBAEknSBi7+YBPtfWVxjMP4RO4BJALFi1T3xW42s
 R7kYWFn+axqOPpB6xdWL0HqGEaMbmYsUDmFm9GOkg1aueGLHFN+YlOeKvnfDKPE7VWCWJN2
 cuCzyyWuDzmoB6F75Af7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t99FGDKXi8E=:KpuqviuKkDY8o04UxNpLWU
 bS1ZDgJbobpgmEiNMXVZafPrVQbu0IVDyjbG6WKOpev8Ya5sh3bjCP5OYE5/+T2peLVW77pK8
 e1q4fPVmziihKIOGgh45IQg1YXozvAme5j9AHgYPnodwQHTiM9HcuLMjZT0oiEmXgBMNpyNjs
 MuCbaUJM/6FJv2MXrfV43wyQwuOwaLdl6pPJes15Tr6RjGEw1NFPFSd3SEnjrrwHS/DjihVPF
 aycQwK0eutbt2Bw9SSFshMBd0UZmVRLCmfhvwPwbFHrenPwUari7ALxsao/EYLihHbxNdnR8w
 qTdOamUF+b+LWf5wuA33OBP5Q4LtCawdTpdtPbE8oxUUrgAMlS5vjT0WCx7pvYx2YmMyYL8nP
 DcUSJ5LF53jetahhaC/mT7arcKF1P7wNjWBh9Omlf8fBd5TJEQ6P/HOgpuc7Q8jTvBe4gphdY
 DFBZMQGejBLvRhxjt4phqD3wiHZwgJjfDYeMui/pFm5enJ0ZUg7N8BSFXOh1CschqQT8+G9vg
 bzajwpgi1JTuH6oazpvjQtn9DMFDOEg682zc2EXPnbP3rR9e58XMzfIfbAffJ6TSExz7KaCDg
 RQoKCxOtBiHoLG7n4FWayPl1DrL5HSqIReW7d3Ry+R9a2Dfq88rmzrbexRIjreyGFZTFW7o05
 BLz54xxgerTF8+6CBUPvSlO5w2tWLq0GOfeCxoowMb1y8uvycs9cKW64ne7QEMSltVJ7ixiEN
 TW2a/ANs1mkO5eMCrYyM1ZfjaxUEvwde9h/Rw+wfI2BTE0Z0d+Q+7vhoWDke/D+A/s+u5M0cq
 24hsfhRIl1I6VOhUO78jViw7xIJKhhy2jeYEvQTjw9crWYuhiSG7bd3yFJPw2urecV45FwDPe
 nKmGD/sdvtvB6MSyNtsbR2Sh3ttr34frayekxKcy6+F5Dr/fsm3IyONpt6gDRKSj1ehMoBjLl
 MsodjS7FVa+H5jyBSfTylmYtgHxcmCNbqzybo/Oa1T92AcGn6KkCMqC3KASIG4GuRjP9RHacj
 qNd/SWPvKV2S6f/h1yb9uiL+1z0pwPj3UmOIcHCuOvT8Djtl4/YCjm6LZ0vTBHnWAJgqfQqLk
 8o/Tlkj2DxY3zABUDh9Zo6V0PCWTL0PP0yxkjgQLi9T6Bbo8QMPwjxBTw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.37.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.37.0-rc1.windows.1

Changes since Git for Windows v2.36.1 (May 9th 2022)

New Features

  * Comes with Git v2.37.0-rc1.
  * Comes with cURL v7.83.1.
  * Many anti-malware products seem to have problems with our MSYS2
    runtime, leading to problems running e.g. git subtree. We added a
    workaround that hopefully helps in most of these scenarios.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.3.5.
  * Comes with PCRE2 v10.40.
  * Comes with Git LFS v3.2.0.
  * Comes with GNU TLS v3.7.6.
  * SSH's CBC ciphers, which were re-enabled in 2017 to better support
    Azure Repos have again been disabled by default because Azure Repos
    does not require them any longer.

Bug Fixes

  * The Git for Windows-only --show-ignored-directory option of git
    status, which was deprecated a long time ago, was finally removed.
  * A crash when running Git for Windows in Wine was fixed.

Git-2.37.0-rc1-64-bit.exe | 17464d2f53954dff9ea8fddcd4fc8f5940d97a5bd3be206d16fdd557ab1bbe43
Git-2.37.0-rc1-32-bit.exe | b8c29b1e7fe3b15eddaa7b348d1ca3512595ea70fd6957a8bde06c289b0fc94e
PortableGit-2.37.0-rc1-64-bit.7z.exe | f27a636a8fd43451f5992844706a77b4c9aa63ac92c764beab1a0db94c064cd0
PortableGit-2.37.0-rc1-32-bit.7z.exe | df22f33cb565492e0705e5c244539575f67e37baac9b4977708424a1f04cc77c
MinGit-2.37.0-rc1-64-bit.zip | 8b8ef568f6b43a5fed35d03812eba8f3a21a70ec9d0a34965b325d671c23dac0
MinGit-2.37.0-rc1-32-bit.zip | 1f94bf3c3a3f0aef09c64b677d26ee406576edeac520eff5f3e425785ec452b5
MinGit-2.37.0-rc1-busybox-64-bit.zip | 8d9f78877176196c33ebf275048f113014151dd91a5ee405f808729c86507133
MinGit-2.37.0-rc1-busybox-32-bit.zip | 7c2bfa32acfeb188f1fdb9ae799904a1e308de8d7e8648a91e5967a6f66eb0dd
Git-2.37.0-rc1-64-bit.tar.bz2 | 9e34c37c5000d678e02bf3876cd9f272721f31b43b78c845a26ffaacfb2f7c77
Git-2.37.0-rc1-32-bit.tar.bz2 | bff36d15a5c9a3644e1bb9435498814959350e9a39d87d93a6e5f9bbfb0f1b29

Ciao,
Johannes
