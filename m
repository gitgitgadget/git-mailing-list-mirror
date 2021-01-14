Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F66C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 11:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8703823A34
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 11:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhANL1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 06:27:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:59919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbhANL1y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 06:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610623581;
        bh=ANdbtZjf5XsSLzCocOH+N/aituc10nfP6kkXG+HWoMk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=VAozZo0Jcg12VNk+HTt4/QUWOAvQN0bOf4zG9VbYqg8w8dZ36qcT2v73qEZZ+avea
         hZ8ZVVdHGO2sLPvJEHkNbNev5kG27w4uLrXyWe6Mo6bN8TWBQVbTezAhRuK6kOW4Qg
         mOXNeahCFjyj8v/X2LvEWFEJsooCmxQNdbLc3G8Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az761-118.dfyo2lqf05yebd3onpscyswl1h.ex.internal.cloudapp.net
 ([23.96.231.63]) by mail.gmx.com (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1Mxm3K-1lzH5W3WpS-00zJC5; Thu, 14 Jan 2021 12:26:21 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.30.0(2)
Date:   Thu, 14 Jan 2021 11:26:18 +0000
Message-Id: <20210114112618.6179-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.30.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:5xktlrR10kUh9D2H8Wimg96lteT2nigEPF8TFXQdK6njCiE9bNJ
 Rw6slCqSsWvcdIfXOVJcgefXAgTkkiUPjbUAKQNl0W2luax7DdNlsgfk91ahreEWpfDHrAl
 xMyMlPl8qhnYUkGqyXXSMlfx7Alw/VeoTmu4qPjzK54nZS9fspbP4zNMAflvrGNfFvK7N60
 vu/sjybRzxiJieqMJD+bA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8BCy5H8jUKo=:Fb59nILvTbGarGWqFzzjnf
 9kaY2aj24+vYCRX4vhto15QXpe0FMsS3F1Mxm+lLOel8FsApU2vIE6pd+FLC0bEsdEY5M2aph
 uek0rnc8uyZVFKZ9AVEHC91x6kdgnA4prKB5/6Bv7Nt03yb5PrHwXhck02ayCMdLnqZzPyidP
 V8SY+LF5GYiB7g+L0LR/neBfApQ2DY4zFeTGgbmxo+JSQdk9oSsE2gigPp+hidPt7vspJnTih
 ft68eUQ8XHwR6FDB0g4Kw74pjDsHfVFQGpY59Fc2sfHeoaDOs0e9PGc3enWBaRRQVq/mqhVYg
 MoO7ldOb8e1pYRgy1Oj24u5CUf60Y/GaO8pDI4C/GTgZ3sbkqxNx68gX+9hutwoU+yg404VwZ
 Cwm+LaX99wf0CQBa/KgL0SYGUuWpplKBdwvxXIT0Ac1RDbWDdPIopLeDMaWYQwjw1PsVTHZML
 GKCgmSBNtXAKl6P71Xv3hDI4opqqG4L02BdngeSbEj2VEB+CbycJqwvgi/eSeJmpOPCwIFfJg
 owdvLB4t4W8sepT1JDe6sNeBHL8VKPIp7MUE00j+YhiNLhk16WZdJvEn53R3XuYM6PeFzBCvK
 F1dZ2iIYAgzsscPq5heQP6/ssvPTkBOZjwKDcWYqiKPa+kbRwvaQ/PIzX3mJrRflA37qVMKpY
 sCKa2xD3hucauJMCbb0NDXZgAvz4s8N/XxTTJTjaOed40yLUb5w+YrZtm0SkDGbzEVtQ4Yfl6
 xzZWu5hsjtFs9ezDdfeBrMJ7cSQYnS6hgcNi4HmXtx9eVZtyBNxtSosuR1R6trIp7fDTLqu/e
 E8OtEN+UP0tfmsMpbXvmLLiTjhh9ljceOFU0f6gTmwvkkv4ZKsqHW5OxhqZGQCADAr15uBUG+
 hI37zq7p3BGr0Pa9jp9+9T6nufsUbT5PBM6u7TN4I=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.30.0(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.30.0 (December 28th 2020)

This version includes Git LFS v2.13.2, addressing CVE-2021-21237.

New Features

  * Comes with Git Credential Manager Core v2.0.318.44100.
  * Comes with Git LFS v2.13.2.

Git-2.30.0.2-64-bit.exe | 895b93ab5230cf15d9f7a268285767c52a452d5b4332a889d9b18eb62c2c0dfe
Git-2.30.0.2-32-bit.exe | 831ccce8abd7b00f2c3e15e7408673c612a5b13a202be81ce96d7ab9de13e8c4
PortableGit-2.30.0.2-64-bit.7z.exe | 90cbde9a51eb459a7ec1653c62f008160e9b7cfd67aac3628f15dc7370aa85d9
PortableGit-2.30.0.2-32-bit.7z.exe | e7289b23b6f28415c24d5db7a6821d3723f31214e1d03ce55929cb30d093f6f8
MinGit-2.30.0.2-64-bit.zip | 2a80a4c57e13a2673861d7a3b11472e92839c5c67eba381452eb1ebb33351ccc
MinGit-2.30.0.2-32-bit.zip | 862fa7f185133ddb966a1cd04bb4856906a746776ec558428d44eb5f826e4f64
MinGit-2.30.0.2-busybox-64-bit.zip | d8aae417d7a2a69437b8ad6f517a58a1c1719548554822988d3ec53468719525
MinGit-2.30.0.2-busybox-32-bit.zip | b029c8709d452d6f8c074988dc354251ba8db6a54da7384493ad585446403724
Git-2.30.0.2-64-bit.tar.bz2 | 1c00e297bbebacaa39b35529b24c60367395c6948d612d96000969ea491ca0a0
Git-2.30.0.2-32-bit.tar.bz2 | 05bf205fb2711d959edf3496f2cffd8a02c63cc6ed85afd5aa53ecba78fb5777

Ciao,
Johannes
