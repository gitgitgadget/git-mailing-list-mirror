Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF52C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 23:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601E6610FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 23:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhJMXp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 19:45:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:33373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhJMXpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 19:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634168600;
        bh=uyPV/bixtE9AB/b6WiEawyAxTNov7UfhRHNqrA9i0oI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hl70YnT+23+qy3st/hf89eCesbGsmR6Iy4871jZbboADquG5m+X17LC3E2fYSkQrw
         rB5E+deOqRbGB+0vpv9Sh02rJW/sOxWvsn6NhzrRbQledBUHS24KVeSzpdS51mV6a9
         ls8tswvNRDD6MzoRBA64x97S/oJzG2a90pvnwiZ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az130-190.jopw5mwjxage1n2fsbb4uktgcg.xx.internal.cloudapp.net
 ([52.229.35.137]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1M9o1v-1mdqAU1ysP-005rOF; Thu, 14 Oct 2021 01:43:19 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.33.1
Date:   Wed, 13 Oct 2021 23:43:15 +0000
Message-Id: <20211013234316.5647-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:q3Jnzy25aMHP4esAvgjHQwuPcCocD9Kc3hN+l8lvF38kPBj1XJv
 W4R4mL1EzRRI7Mh1jHYqtdfj1tliWpiLNT+zE+tKRfwJQDOmYaJK+btHjWBv/h/eaM6aVzL
 U6O9ZN9nq/dGbG2a+IJC2rwkaXhAinlVMgB8l+o+VRUvrbiDNOEIFcKcI6BWsUSZzsKhTzN
 e1Q8BYr3bMoyMloxiTWuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ng5hmVDI3tM=:vwr0K/YgPPf/u+etZU6C3f
 RAEjw0Y2IkLjy+8D28NhIR5BrORptlSerpOCxo3Y30bCkVBfIsUqlBtONr44lgc5EFRmrfrl9
 3/bjaCme7UZOxKmtGovhccze62NPMOnSGiia3nk1oK/0sjlUIlCEAqjHOqnnANW9lVkpezgqh
 314WEJNcB/Uuz+rCktlAeDCq9K0D+Sr0jsi6E0CqZ7dZJU/V1uE12rW1Is71TWVJWQRp8Gkvh
 E6ggF3Eq+k3d/EI+LV9b0DSNPT2ePrvqbbfV3T8cKrvl4FeyV5eJqV23gJ+rpjng2h4Qk2gjB
 WcEgJZ823J9ixpiTMST3xqhaORQNcA7IyoaCu1FUnPKoJzYUdCfwHXU2JgxKaWFh0v4DZSX30
 1eyfedjuglnRu8KW7b3XZjrHkCUCGxlfc9xsqvZk8DlieHZyGoBdMj2UKEUpMSkMODiYoQNBy
 ux3EQWwfmy+Va+gzGEGDuoDELKQ6j37QM68ZDchvq+K5zOxc7N7M3HeJTjubRYDSSCSW8QUDy
 A4XWPhvRsjsUrrOGRhXl+z5wC1LdQhmGKH8qCfIxi81+CGPynlSz4UGVUXvlA8eskVr6rBOTX
 Wb5o31rkprk3PD5aYE2FW39MUB+qiW80zDnAySKmJZ5Yv8ahkB5SRwUDA2BSeB87cfWaQOfVk
 1V0/cRESxJ6wo0msvrvNDCj9wmu+hpgCjQUrm2OzvwIrlpHu2Idklr3WifVMQrI+3TZZqo5C0
 XvtrN5qWMdmEGZOQzxJqVujEtan0GefE1zoEsL5pgbRhs0a8qxcxurwKg2c39MfH/olJdIqVN
 OfejuqNwTlGMlkGvPdWTBcx8qaXEf+xLU+i1iQBKue/cMEK3K8N4PoEPeFFdpRxJVA/gwCCHw
 qdRtamG+FgcJkB2h5zhXofus66ULjfjHd0tOhkUwhMhuc8j1JLt34VAlg7EklWx1v8AfEdgr9
 bPGd9MuP/wkelJ8u+hVUJun4VCUr+NgWqe3/v0GBikmhIhUHY3EmaDJvqxeHDQsCJsA60GCFY
 lT204knnYpO7HdX2QJcZ1jqXBCzwLuryO9UakZgv99JJC2GOHHx4ifI1V8nE6BVp0Vf7A8Pqh
 2WtLiifA/EpWik=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.33.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.33.0(2) (August 24th 2021)

New Features

  * Comes with Git v2.33.1.
  * Comes with OpenSSL v1.1.1l.
  * The included git svn now uses subversion v1.14.1 internally.
  * Git Credential Manager for Windows (which was superseded by Git
    Credential Manager Core, and was deprecated for a long time now,
    and no longer succeeds to authenticate with GitHub) is no longer
    included in Git for Windows.
  * Comes with cURL v7.79.1.
  * Comes with OpenSSH v8.8p1.
  * Comes with Git LFS v3.0.1.
  * The built-in filesystem watcher ("FSMonitor") has been updated to
    the latest version.
  * Comes with Git Credential Manager Core v2.0.567.18224.

Bug Fixes

  * Wordpad can be configured as Git's preferred editor again.
  * A bug where Git's garbage collection during a git pull failed to
    delete obsolete files was fixed.
  * The git svn command, which was broken in Git for Windows v2.33.0(2)
    , has been fixed.
  * The password prompt when cloning via SSH works again.
  * The MSYS2 runtime no longer complains about FAST_CWD on Windows/
    ARM64.
  * When VS Code is configured as editor, it no longer needs the window
    to be closed, just the tab.
  * The 32-bit versions of Git for Windows included outdated versions
    of ca-certificates and less, which has been rectified.

Git-2.33.1-64-bit.exe | b1b69fcf56d50199536f7e6fc79b75ab16734d4d9a4b85c8e931596f02dd0688
Git-2.33.1-32-bit.exe | bc2ca8f6ffcc6914ed04cfb13b2d0b6b994bd2437283cb3b43188b969bd5ef8b
PortableGit-2.33.1-64-bit.7z.exe | 723c879eb447583b893aa3234eae8caaa77d9d3ecf90883271fba98e8b2d99ac
PortableGit-2.33.1-32-bit.7z.exe | fad2f32a3ca6e39cfbf7258c485a5601b0bfb620f44c582c1ba22784dd3faad3
MinGit-2.33.1-64-bit.zip | 8c28cde02668bfa3b117a49fe85728c1c8244d21701d5ab675668fc4677c4c7f
MinGit-2.33.1-32-bit.zip | f340a3433c2c782ff8724707b87769d15519030d1a0e1c1314255f98eaa4f42f
MinGit-2.33.1-busybox-64-bit.zip | 96e2e9c8561eb20a3982fe292d4795bd4c09705f93cc03cf45a2f6b880fba181
MinGit-2.33.1-busybox-32-bit.zip | 3cd68aa4691202f2a182f8e0bf5a8eda2b795fbc6074de3e3c55548efdf28d15
Git-2.33.1-64-bit.tar.bz2 | 1a002a49bc25e51b4571d35d5470a373fa7e0d2c7a6de81573c2d485063f066d
Git-2.33.1-32-bit.tar.bz2 | 712a23a9c153402a75b88ec8ca5f51f4a75be6af3ef6ef965d9ed508d3a9a205

Ciao,
Johannes
