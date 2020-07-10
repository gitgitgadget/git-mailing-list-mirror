Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7224C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 13:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866EB207BB
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 13:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GBz/hF+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGJN7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:59:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:58011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgGJN7k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 09:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594389578;
        bh=jNuXTENwaE83F4WHd4gb2ODfJT25/BdlzmdjGw0L2Bs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GBz/hF+9BAWI9AZM2F9bzFy5z0wUUSWCN9i7orONBnXnMzNbpq5tK1GYy4zlw9tvV
         wvPAkzBafoGCtFW70Zh0KB9nTRg2+584O4dOeSUaIBStq7TQHblod58D3plHAOxNtZ
         vQIV9ZOeqxpksiICBwOWPZWtXhB+McfLmSsQ0eV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az767.2v3qcgtimfge5nm2f3tgtiwy1c.bx.internal.cloudapp.net
 ([168.62.182.251]) by mail.gmx.com (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MDhhX-1k4aHW3SNz-00Aqqp; Fri, 10 Jul 2020 15:59:38 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.28.0-rc0
Date:   Fri, 10 Jul 2020 13:59:35 +0000
Message-Id: <20200710135935.6416-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:Pc6IHO5LIbVw41KFv0takV1TmI+GUyOJxzulO5gnPMaO4mrfUVP
 0clvQRl/cgCvGPrTWpP2XeTOGe+5HmjiINieCTUJelSKrA4FMQfPbB0pcLfbwCNF8lxFQ8V
 d01/l9Q0uD87OL5TBntX+HsgXCa/oqFrPmJGdOQFinz7MZZtBJ1JCLDX3vc24WOMnPLFWci
 gEdxbpi0xDbzc61hQSpNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0UBifjqdLG8=:5h2Bgs8okCvueQtPbwmdJX
 EGkw/ds5f2QfScJd4HCxcqiG6aZvU8R0nhKuhuVPEL6iXrbFFoVSY+FGimo7WUa6z45c/0bil
 ZSGpz0DFz1TAhhbM4WLaQUmgqPu7AszR1T37PtRj1dXwLilxYqGc/4Z1Kd/bgkSl9C79yO/Wd
 JOWVXw6T+WsY8OCPH+79mJBPejqV5VCsZU3BPq9sCYEUfSfFhCjrvrFKApBVgwfBbnPxcEEN+
 tMWOiC3kJGQDU3nBS/1jvBSDK24nW7+5fxfBorWuXqKy2IA32Ln25mprqNn53BfT4lWDzC2hA
 j+FQmVATmcl/R71eZzbX2ay4QepNpEPAumIu2Vqi7a6esAE6731syJiZo6wNdoM9r6yqmc62c
 78nq2Iam6ci3BS/s/ptG5NArD1llMlU9Fatkye9S8OB54+XCvqY4Cm2ZICMM+0Fgsi8RyHKmW
 gqe8SHMeYdox+Jrc3SLY+E3ke9c0HkoiLICNnMDa7v/ZqHPZzrUHZVnRM9rTRqvzwih7VZDMQ
 juElGh6RIXqckvRM5o8YlnFNdMVUveZDXOVYUriOObOgyDQUeBP4hp7ewMjmsZKAAcZk7y6XR
 d4d4s0wzvY6UCYFAiOPSa/df3VtQivCRFBfeOqgteFsdlxjUc8s/65bOV1sGTWLzj/Q/zzM5z
 g9ssyYE5+JueXChSKC3FEyzfp0Yaua3cfft+7dBudnkx8YCBeXMpLUX9Ap1hFsQhex0EECwqX
 zGNxsIRKmvUuqEcFyMEEgp3mwJ4bX3H6uWKJakn/1qtLqYLEsKFKOd1ORe1wINSLYJmlOgSjb
 qhNj/nNFACVyN5pmO/CNnbrV+UkYyuC3uKQg+W8ouXAQD4mMgM7QTbPEskW9CwjaXwkb+p7R3
 1/J6e3ykRpn173S1cs09qP13385MuwYo9dabB+jjFO+9Q0K9IQgHgUgvGkD9onhfxxcLPlecQ
 guHGpCNXYVodSloj5ebhod3wx5gpRHfGkWigaQndqRZXP1nmCq8Xu370Z8W51kGYbrUBu3gqp
 fgMjxWhUv1eHtRTcuyq7jonoxwqOqPJC7X5rwTq6CNaic3+AJmIxZC3RXijVO9keDUT4CidK1
 CReIsrEeWkYUEfAbSnUVlI0Cdi19UU7i6NnBonv1XZBbMOnQ5StXwNLp7MYyPFIl06+UYJxIn
 AeEXm6yROqxacbsQgXY2u0tuYvhevC2J6UOFAaozyol36HyEZ33gbEjPkQ+E4WymeJgmRBABQ
 QgXX5O1VT0XPDl7TN2IwHVzGxILIS2W09ObySXw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.28.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.28.0-rc0.windows.1

Changes since Git for Windows v2.27.0 (June 1st 2020)

New Features

  * Comes with Git v2.28.0-rc0.
  * Comes with subversion v1.14.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.1.5.
  * Comes with the designated successor of Git Credential Manager for
    Windows (GCM for Windows), the cross-platform Git Credential
    Manager Core. For now, this is opt-in, with the idea of eventually
    retiring GCM for Windows.
  * Comes with cURL v7.71.1.
  * Comes with Perl v5.32.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.1.6.
  * Comes with GNU Privacy Guard v2.2.21.

Bug Fixes

  * A typo was fixed in the installer.
  * The new git pull behavior option now records the fast-forward
    choice correctly.
  * In v2.27.0, git svn was broken completely, which has been fixed.
  * Some Git operations could end up with bogus modified symbolic links
    (where git status would report changes but git diff would not),
    which is now fixed.
  * When reinstalling (or upgrading) Git for Windows, the "Pseudo
    Console Support" choice is now remembered correctly.
  * Under certain circumstances, the Git Bash window (MinTTY) would
    crash frequently, which has been addressed.
  * When pseudo console support is enabled, the VIM editor sometimes
    had troubles accepting certain keystrokes, which was fixed.
  * Due to a bug, it was not possible to disable Pseudo Console support
    by reinstalling with the checkbox turned off, which has been fixed.
  * A bug with enabled Pseudo Console support, where git add -i would
    not quit the file selection mode upon an empty input, has been
    fixed.
  * The cleanup mode called "scissors" in git commit now handles CR/LF
    line endings correctly.
  * When cloning into an existing directory, under certain
    circumstances, the core.worktree option was set unnecessarily. This
    has been fixed.

Git-2.28.0-rc0-64-bit.exe | 11373dd9d740ede0e5f54776eddb1591578fc5917422d656187e9b37b3960b94
Git-2.28.0-rc0-32-bit.exe | b238446edfee249c59c57143cfd69baf83d8bdedda31c5e93fd4b9092bf41cbb
PortableGit-2.28.0-rc0-64-bit.7z.exe | 8d09850454bf8812c944b746ebcdaa86489c3f843f19d64bf23caeaac7572b2a
PortableGit-2.28.0-rc0-32-bit.7z.exe | ad4c123c88a0789c00a8a825022a6eb850ce1292b5f3d17b6f9445d81a819474
MinGit-2.28.0-rc0-64-bit.zip | cae926ba5e2d2ed5a09bb0ea78470f856800ed62b7c330e4bab89b0044724762
MinGit-2.28.0-rc0-32-bit.zip | 80c7b58d1ad819de3d9d4aa95624c4ec2880d3d19b74b41969b34e905d245b40
MinGit-2.28.0-rc0-busybox-64-bit.zip | 0a0ef355a90d31c57bfed86547306076e7a825eb21e325990687e1d030c50c8c
MinGit-2.28.0-rc0-busybox-32-bit.zip | 097a3cc7d70345fea42ab4801d438b882a5e1cf5d8431e00f52af7569acd6e27
Git-2.28.0-rc0-64-bit.tar.bz2 | 220bf0b98bedaf9ef5710a40c5d7ab13c0c979760971332221d38255f3ad8e92
Git-2.28.0-rc0-32-bit.tar.bz2 | e97222bae9c5a4736b9a28a8812917a9a20c160786c0ec624dde3037db0568c5

Ciao,
Johannes
