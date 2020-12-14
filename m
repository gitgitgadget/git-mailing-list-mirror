Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B68C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 22:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38FB224F9
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 22:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440920AbgLNWcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 17:32:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:35233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438762AbgLNWcs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 17:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607985074;
        bh=uYlfbjs0+K76Z9OG2Kt84pPjKQW8hii8MQD0MPbKiVI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZnbSxRVUtEj0Y82M7yKCKmV/DaM0pcF1r/ECkY1rEmlD8Zbqt0W4J4qiEzdQXoDdf
         xbszc28wYTnMbvofqboCs+DdkeMA/KUx6GBdSerj4ljFnwLpPSVBUl06WowPadjPXB
         hy9+OR6WtQEBv1hpkz5bW6JKd83ndwZmwbWaewGY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az764-8.ahgcmg1qrdqujhq32x33etjafb.dx.internal.cloudapp.net
 ([13.64.105.188]) by mail.gmx.com (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MmDEm-1kOMyo18V6-00iELa; Mon, 14 Dec 2020 23:31:14 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.30.0-rc0
Date:   Mon, 14 Dec 2020 22:31:10 +0000
Message-Id: <20201214223110.6121-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:mAcqiBUuNPjJeEfylkJGPZs36mlcoY9J6TonCZvPORLOesvcFx1
 HvcmZjkj2RlsC5bmJB0/BQIxPl84yLm9W2CFUFCl8ww837k95lGhmSPX8E11hb3dLn4KUeI
 zP45Muoks63kkRkSUi8eAMZ3pR9Qj8UrzqHJ5w8O2sgWrcMH6wKx0f/d+rjNkhgcIRcE8lk
 8VARxewMHLgbDIpaahu4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/QmQBHX9pUc=:64PMbXC76HPmB4TKsbjBjz
 dPFBrGWA4pFGc/WpLoEeHXrBOUwnfjK4h+yZM7wSfQxIbjt2/6w1ShDII7YhdvxyxXCTFVgyx
 LQrW1YLQ+xbGWt05X+6s/labBV5WiTXMJupTHfj2wz9bS1qatoDbhblDwN6V+c7GFpAMT0N32
 OSJEMf7gJ9YKfsgz7/3OWfDn9Rz1Jmp/a8TI1mu+Apwh68xmiRrdnPvXTL3t7KWxSB6Yp/5im
 p0JDAx6Xpig4QR+oJfzEey3udqe2oHjIXLBJhaksPviaGQ2TjTP2hKhTcvkj54Ko++s7IN/BZ
 EY7+Fpz1ikDDBB4m0DHYP9HjziPZIO2N7/6tCcDnPdPB6msLeGfZyNPFsmNjFehMkNyvlvMY4
 ZxnMvvWDvlFooVjA+kFWINwnQCxnpSfcOWH/wGJYBmWY+VWsZGhdHa7l+Vy9YwWdpoOORY5ev
 6DSGwmhpMRFMfLOQ5EnleVB84MvjItrCauoO7n+1AiiU08oElId64pmdsQI8DyI9+ky/ikzhM
 QYSdsKmXmTxB22A1YnjUjCViqrNH1qbRSe+zmYNnJHdKG7LjXhve2+Uu5DEzeThil5ZsUAl4r
 OwdvqXJ1whL/RKZkxxaZX887DDNq5X80saioYW3aOLaVZmndiZ6s0jIVH5NiOd5++JjtcvzNR
 zldGCkpmBE+DzLbVx2agw7y5tpKwHsdOzXWzeyBraSwJYY9Y7hLWJP215UF6mSS7KWGozp8sS
 /40kZmxx2KOgadV4IfxDsKSI5LQWu54fS6J/pSQz95ixD7SbpwWkij8ecFWSKCkgYqhTB1tU5
 NzpuQVTzMmGQAdW0QDgWfx/w6e1edYM69IieLxXonxbTDQ6bCCs+nQhYOBC09RJf1ao8isvYy
 xswgDdHKotNNWU1wRXY6jnvG9At89IoCssyP21oLo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.30.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.30.0-rc0.windows.1

Changes since Git for Windows v2.29.2(3) (December 8th 2020)

New Features

  * Comes with Git v2.30.0-rc0.
  * Comes with OpenSSL v1.1.1i.
  * Comes with cURL v7.74.0.
  * Comes with Git LFS v2.13.1.

Bug Fixes

  * The auto-updater now shows the progress while installing.
  * The credential-helper selector (which is the default credential
    helper in the Portable version of Git for Windows) now handles
    paths with spaces correctly.

Git-2.30.0-rc0-64-bit.exe | 3553a38d833e3710e72c0f47e0f3c88e29dc9e44f36755c6e7e9fc2948f9e6d4
Git-2.30.0-rc0-32-bit.exe | 26a852536de851a97d0744e639a25b03ee229b42ac5fc650d41a2dcb1693bbac
PortableGit-2.30.0-rc0-64-bit.7z.exe | 51cbc961ff05c12b72205220c7a5b4f5eba9e807b83a01b722250de783fa0136
PortableGit-2.30.0-rc0-32-bit.7z.exe | 1ff6e083f583c81ebb35d954ee39bd6076eb0d64e7c2a43434e59efa76641f93
MinGit-2.30.0-rc0-64-bit.zip | a2bd449ba4ac2537540f98a7cfd5716bffb2abd25c142c8a8c98fc85893772a1
MinGit-2.30.0-rc0-32-bit.zip | 7406ffee301caa1eedbd4ffb25021fae1631cf0b18249cfda40af5eb4c84ade1
MinGit-2.30.0-rc0-busybox-64-bit.zip | 987c9bebf0cbef64e6a08ad0edb09bde8206ecd6f0259f121d9287eaeb1d4c2d
MinGit-2.30.0-rc0-busybox-32-bit.zip | e75318a33f91d9e9a25e2b74b8be659eae926f89a11ba41253323abee0844492
Git-2.30.0-rc0-64-bit.tar.bz2 | f9f5ddc208538c02c473ad468edf2c7dc56bf1a6e9c0fce841352762d787a7a3
Git-2.30.0-rc0-32-bit.tar.bz2 | 02018265aa07447ccef82a18276375c5922f49a94c7aef10e115ec9b80aa51f2

Ciao,
Johannes
