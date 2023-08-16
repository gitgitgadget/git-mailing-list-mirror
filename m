Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA9DC04FE0
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 07:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbjHPHPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbjHPHO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 03:14:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69762112
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692170091; x=1692774891; i=johannes.schindelin@gmx.de;
 bh=bCPrBERX7at4WuBOMuQ+YY4M3HkEE1ekcUlC3Wu/ijk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=ajHScTFXb2c/AnVV4sKnLah4VrKMPjYOZGYrEs+7UpgEaQ7EzJrfbLaHfBgXEZd/d9pIl1o
 UqevZHqle+n3inpmEBOVXf2u5/Ec6b5yyMqY4a7iHy7pqlUdQIwj8hEFLhRrUSBgOGGLp/8fS
 ol0TZSj0cWvx9q+wg8U1k7+tS9Je6czdVJd8xl6r0yxUCwIP27oTWV0hWJuivQmsQeqHdR//9
 cuonrICXH5zfOda2KQTBMSmtOQT4IRNkkSrFkt088qOeEW4yHbAx5iT2hs3KNH2rKhlRWUDdb
 K/SViJYTOe+g21VZFE7XfAEldRB60xx8zFGLbpW2GmJX9WQ+9hpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1102-863.ghvsf53df5vutddeto4bu05etf.jx.internal.cloudapp.net
 ([40.84.178.208]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MQMuX-1qAMTC0QKH-00MNwL; Wed, 16 Aug 2023 09:14:51 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.42.0-rc2
Date:   Wed, 16 Aug 2023 07:14:48 +0000
Message-ID: <20230816071448.4166-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:vycukdWqV8MihWjB09215ew2tT0QRDeJZWh/4O04J9fWGBhBMti
 9ip/2eBPwdjCxSdWIghSxgrSJ2Pgj4Mtq+vYuRecyyxy67GH2+bAw/fNFDHWUCS2KonIiQ0
 PIMU5hZMAwxcY+2ndooq7CiI1Trc+rKY5Wc7gaPN9+wF2TUmLSpesFcDAOOVSiDgV1zxdA/
 x6QrBFJGLnx3Xe5E+uV1A==
UI-OutboundReport: notjunk:1;M01:P0:Hqna7HSLOew=;zR7o+Xoa809zLefFrdsiK+3RyWj
 /SaJF2xzGL5P9xBKH+wlhEPD+KqCoN8A315oaA5LCi2WDa+Q4FPSZU2a9FDri00fo9ZDuHT0Y
 m8hHdfGOLaP8c7tWyji+KKavHXxkmr4WypO9HTIeqJh9Q9Knuy/vspOv7rm2G1WAkTT+7H8OC
 EgGhVYcL8tdpir9Y3CwbW9CjqPh2iym0SjvIczFcbj2VNS4Mlt1mFZzrBytqrHpMn/QpMn2Gy
 1NGON9kIIRloXjDDd43VX7QqLDUPNqgY/TF6NxuD880UeDLM10r15kMOqifq/cXQTu62OdPLD
 CGEgav8jJZWaR5pmmi4J9bilFwUiNbfRPTjSKaPi0DM5MTdpF/qtGk9RyD8wqSJY2chFFwsu2
 wQqmouVRfvKS0IeH3Oz4baGaXJcQdYMNo3gUx02A49AFXUvENL8t0fExWnswv9ut5w1fyjfB4
 YttdjDztUB/DBGawlGnbu1P93BGlDx8gwnVFDY/0oseO9wMPVDe70Q8c2JPfHMV+LS57OKYHI
 angcJYwSBichRzqyspr0MLyMp3MF7MdOhUPW1TPDoQTvEsNavaAfu2G+L+8k41Rhm5qSnn6bs
 jGq7s+JNZO3YcZt5ZcP8aI69MVfytcyGmBBaK3rPqci/dVnG4xWO2G2nMWqJ3+BwQIJNuAqmH
 jF6Wqyonyymh2NKU4I47p7NN0auVQUFJHW/I88S0rOSP81a9a16YKYRR+KPm2VA9d0brBEld7
 YmVXMEIsP6wsheCbvuz+aX04BGW0WRfhZGS4LMs02eX+0ARi17algFKpZsJ2mBf+GL/7qbUgY
 NvhHqPeMplvTqUyHmjquXO9W/ftW1pQSBMcto69hcEpc0VjAIbFtgHOGxO01gjZD8eQKV/o0o
 KbfRQ+WeqXjtdqocrnrqDmDYLrTHHGc2uLti20yMlJ7SPdOvQlggo/fPRj1Fe1om983+5H8SM
 3G6jQQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.42.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.42.0-rc2.windows.1

Changes since Git for Windows v2.41.0(3) (July 13th 2023)

New Features

  * Comes with Git v2.42.0-rc2.
  * Comes with cURL v8.2.1.
  * Comes with Git LFS v3.4.0.
  * Comes with OpenSSL v3.1.2.
  * Comes with OpenSSH v9.4.P1.
  * Comes with Git Credential Manager v2.3.1.

Bug Fixes

  * When init.defaultBranch is changed manually in the system config,
    subsequent Git for Windows upgrades would overwrite that change.
    This has been fixed.
  * When running on a remote APFS share, Git would fail, which has been
    fixed.

Git-2.42.0-rc2-64-bit.exe | 6d7772323a683772cbc221596dfff66710c8ca3cbacc58283d0faf42f246691d
Git-2.42.0-rc2-32-bit.exe | ed993c5396f1d656b94fbc4aeed60f568167cc14532746117cb25b0dda90668f
PortableGit-2.42.0-rc2-64-bit.7z.exe | 22a120b2ac59a9379ea462267cde9d8aaaf5f399ecf160cd4853a6b8247925e6
PortableGit-2.42.0-rc2-32-bit.7z.exe | 17083a0ecd7539876099a938d2843e5029be05a027280d7463dcda602701beff
MinGit-2.42.0-rc2-64-bit.zip | c92688495a1c2b4ea760b32070b3ea6ff4313b5095d40958006aea61764fadd1
MinGit-2.42.0-rc2-32-bit.zip | 5b54762906e8c18f6129496b4971fa6082e97dfb30a02e2a4174ce99ce181eee
MinGit-2.42.0-rc2-busybox-64-bit.zip | 19c76cb4f3cfabd26522ef45841d4053fb57b1e76c585ad957393e0504828fad
MinGit-2.42.0-rc2-busybox-32-bit.zip | 6f3696fd214776cfeb251a04fe618e8cbfe7c454160777df4e2e79ce7d400853
Git-2.42.0-rc2-64-bit.tar.bz2 | cdea6633fa5a914bc3f00f476e067ca768319cf7f69867c307488d2c72f8173f
Git-2.42.0-rc2-32-bit.tar.bz2 | 34129e2fb5440f12e9c5099cc21a0159da9b4134c461014953ba6edcd4b00cec

Ciao,
Johannes
