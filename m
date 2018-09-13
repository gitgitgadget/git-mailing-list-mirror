Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929F41F404
	for <e@80x24.org>; Thu, 13 Sep 2018 02:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeIMHbM (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 03:31:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:58295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeIMHbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 03:31:12 -0400
Received: from localhost.localdomain ([65.55.188.218]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MLOMM-1g0pG93HFq-000YQx; Thu, 13 Sep 2018 04:23:52 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.19.0
Date:   Thu, 13 Sep 2018 02:23:44 +0000
Message-Id: <20180913022344.1348-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.19.0.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Yk8c+9gHZmseWWRuqg+PzHUmu2agkvlyc2XYB4vD/oaJylvbxUo
 0GjGyrump6Q/Tl6CikYcnqxQNK9SkIDsM+bpRLc+gU6RWV+WKrVMXyEjYtOo3nxsXR+BrQg
 WyR/NJipFkm4Y188mOGv24zDTEM4PrEPORvg9UPzsXWZEpfLu6tWzy+YPCKt1lgnvqldx1v
 6b/FR7XDTdbZvMDhR/9Sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d7wjA1SlQ8s=:EKGDTEy8qWmIQ5k8I37ogD
 m78EUdxuzeoE+vgN6tj3Buv/qmzS7AgaVZaYhDwd8Wmd8hqgP7dehPf6UIuuY3pFIOUoA1PaX
 LWs1UOEQ2eNGeTlxPVfdIsm0wOrXlb30VqXcHr0e5OjsZe8q2d3B5Q2B1Z6x9uwHVInbo1QK5
 KIStzjsXBcpTdDRjt+49+Mm55ZEyrMGpI6sMXScHyi853l2UL/CYJOinYaFKhVdYUKIwY2m3g
 VafpTUJvIpOmbMHBEbL92a3rrl3ZNyYmIw6a0GpSBDbbDoHsdpsDNwtVPtv4kEXTiZ2hJ/aIM
 dvFokUNgukgVdFTD8uvS8QiWTRwSGJnGcNW1naEEd60FNNVZ7X0Vrl14IlEvq9B0AVeXTxexW
 5I3b8u3cgDLP4FTzk/TnXpXxnWdPAdkzK4Y1HXxhSg8lD0XBCTCQgHEPeg7LNV0aPQusAAA7P
 XjBKyp3g69C8/s/iv/Zgk0HlnsyO3n71QbCXTud3xWbAp3zkl3+pJQn32a6PodBlPIPPrr0Yl
 sbjqoqyFd5VKpqNjRejf9iEYHjiURhVPjG23QkbXNwsPtHzCkA/tVMAjcMaoZDF3bL6Dxf7ii
 SkUlCShTwvkvIZ6/Ia/FIwCwYztr6v7AEu43JAx0HBWmqf3tcJyskLaYmeRy1pHRj5rdnvHKH
 rExY+FAiKRI7mkDySv42PNaUM4ePoK3JRi2y0VjWZPHJhUa3bG878N5r8W/OX9YKghjO8LyfQ
 jcI5nwzqQ9kp0xI2cmagSPyqL61eeH7rSkTIRd47JOtDu7EjvR33jlZTFDnlM89JXlkHqXHMl
 W6meB/Pzy64IrKxVLTcKRkowb2iC3JbN/1CcLnfpzOvvIhy420=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.19.0 is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.18.0 (June 22nd 2018)

New Features

  * Comes with Git v2.19.0.
  * There are now fast, built-in versions of git stash and git rebase,
    available as experimental options.
  * The included OpenSSH client now enables modern ciphers.
  * The gitweb component was removed because it is highly unlikely to
    be used on Windows.
  * The git archimport tool (which was probably used by exactly 0
    users) is no longer included in Git for Windows.
  * Comes with tig v2.4.0.
  * Comes with Git LFS v2.5.1.
  * Comes with Git Credential Manager v1.17.1.
  * Comes with OpenSSL v1.0.2p.
  * Comes with cURL v7.61.1.
  * Comes with mingw-w64-nodejs v8.12.0.

Bug Fixes

  * The http.schannel.checkRevoke setting (which never worked) was
    renamed to http.schannelCheckRevoke. In the same run,
    http.schannel.useSSLCAInfo (which also did not work, for the same
    reason) was renamed to http.schannelUseSSLCAInfo.
  * Avoids a stack overflow with recent Windows Insider versions.
  * Git GUI now handles hooks correctly in worktrees other than the
    main one.
  * When using core.autocrlf, the bogus "LF will be replaced by CRLF"
    warning is now suppressed.
  * The funny fatal error -cmalloc would have returned NULL problems
    should be gone.

Filename | SHA-256
-------- | -------
Git-2.19.0-64-bit.exe | 2dd5824e29ca44e86016cdb3dae8446cb5b80b77f596b67e3d8754451fa4bbcb
Git-2.19.0-32-bit.exe | 66b29edc994838586e141b07394900426d59d86a3126cddc04d9ab26032eb7b4
PortableGit-2.19.0-64-bit.7z.exe | 1b8761ae57f589890a83995d0da7891efbddfee14e9f0c3ffda91f6add5b9351
PortableGit-2.19.0-32-bit.7z.exe | edaeb1962b7620bff33d45889eb4bcb6e4ac95021042910871b6025515785c16
MinGit-2.19.0-64-bit.zip | 424d24b5fc185a9c5488d7872262464f2facab4f1d4693ea8008196f14a3c19b
MinGit-2.19.0-32-bit.zip | 83cf018bd6f5c24e2b3088539bbeef9067fd632087d094d447a3a0ff676e7bd7
MinGit-2.19.0-busybox-64-bit.zip | 128b355e4321dbaf699ff4994ddbb6cde92783f4930be50aad507f6d8dbec0d0
MinGit-2.19.0-busybox-32-bit.zip | 2695578e2c53f32194986456ce714388149d051041f638e9ed43dd8342465fb2
Git-2.19.0-64-bit.tar.bz2 | c3ca6f9f2b6b800ade80ee4973cdaed9869b8c2c684c9a6a0940d5fb1e18bef7
Git-2.19.0-32-bit.tar.bz2 | 6f8426646e68ea2689b6a1cfc09ba221805f21540e7dc7af00335f27d3b333b8
pdbs-for-git-64-bit-2.19.0.1.d96bb8bc6c-1.zip | 5f4417ab5b362823b416ead4960e8050682349b603af9ef653bacbbb7eea408a
pdbs-for-git-32-bit-2.19.0.1.d96bb8bc6c-1.zip | 157f78f63d8df39b1ae6dedfcafbe1a9093a1fcc4768b123dae12ee2ae8c82c5

Ciao,
Johannes
