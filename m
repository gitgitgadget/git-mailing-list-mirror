Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BA0C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 11:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbhKYLzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:55:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:60295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238134AbhKYLxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 06:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637841032;
        bh=c/QXqSFg/WOdoGLaNwkJzuapGxdCjZNy8X7mBoc6ypM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DS7a/xlkmwpuvZQijaAQqVO0Yi/x/eWK46w1pre2v2K80W2dPdv/f8o8UP3359l/P
         hX2dD+71fHv1rimRJz9HcVul4f6VFjIKPROwxRX0whYHtBRcX9YPtosOD/zFkoy15V
         BvAQcIXs6pFW/89xUblReqKcXNX0Yjhd8KuS7/YU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az94-61.4g44ktyaxzeuxfnuq3afdkdpfe.ex.internal.cloudapp.net
 ([52.159.85.136]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MMGN2-1n66GM14HW-00JI9Z; Thu, 25 Nov 2021 12:50:32 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.34.1
Date:   Thu, 25 Nov 2021 11:50:29 +0000
Message-Id: <20211125115029.5502-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:ftVKtASSNS8EnZNttVjS1GcdDH/0TqmHozNDG7Imxh7mouaBMXH
 z5ouQfukpyiyu8npLinVG+XaozpAGnvJUV8Sh5bjaG9gmja9CglVGHObMcjFVxABN6S6jjz
 u2VqpgaCncnw/6UwMI5/6g7facG2a3Sx67YNNLIPl5OAxbT96K+48FvbQVPL2WLPhFKG/H/
 E3vxwoX9IUNQNZVwDmbdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FsMfAWmKtmo=:QKqYL0Baw1ttCew0c6f4sh
 nd2DueouCKzxJ87M5Yuepbsk6pVQ69mAG33lqxdDqkpJHtH6LOylG8mY/PgZ1Gx3PpDl25Sim
 CC3Sof5+s5mtzRFXOyG+8m+zcXsNZ6BURopIgsjNox11yOPIGuqOIdG2svhfCh4TMDFuvmpDo
 S4a9hFpdhiHT9UXZ/JxMxg6M6WigRDkXQFq6kXJCO5wKtlzgZqxOoU4ua1290Tzu+jDfGEOmH
 /h5zbKA82RzgUK/McCP6qrGJ8Opp5Es4ktd11quusmB0E3uCRDOvvBzWv03E5p5oboX2Qtejd
 CSBY0Iyw6TVqiFgBCjbcFQfOuOXVM94h6B+SDF42Q4Py4XYXmYMQ7zOkrmrPOUj0uXlQllC0J
 SJDU1pYkTxjN2l3+YEaeWDfGdyhZs0UQLhOoa6eGY6ueJXg49mKDB9OEuza0DmnC0JJ1M/4yV
 tWXLQjmpqYmgqfYJXNe2HeK7LveDB1cDe3S/HlgSBzqgqtIuie5jVoNd0H9MkM/3M9dcKE6Ro
 d8yALQhUxzehPH16mAw3UB61EPyLtJXhABaTxqLteF9u3mnIZGAd42ZJQH07MXgT4X9KZ46uW
 UgP3g0jy7kE94Jp9+Mhz0Qxpv3lpyluWfjAdoY3EJ9xVFL4JU1fmy9YSibmcwoHPIArzz3m3d
 8qHv3u/687u8s3u2zenMO+4t539hzMrbnpnri/j4tcatEphkyNFhiWWYWgPTkrhkL7MX7D0AT
 qrC8zL7pZCXMHoL4VA0ZI1kNo/AAzgDj8CCpQTErg29zdcD2fQJZR5iEMuZBmMSFwJ6f9tiHa
 gaV0U20mDfbobLUWiGRD0H2saBfzfIrBxMAJHVau6v6hMQRRRt1Zay0ms8yH2zUrDZV0o7nx7
 MOGbd+Lwh3o3rHboEvHuRFg47Flcury6wQvsUEuQA1h47cJ8xSDTJDUtjzZ+23n6AHaYgHYlz
 hy6YnIfYN0TTQGPwoXBltPyameXHA8le0VFyi2/kOspkHUyCAjocc6wm+7qZtNr9MDJcdUCwe
 Pqc97DeTLBfVO9QQciBTRVjBgYimY+FpQujLwS0/XZX2NGo9okjA/jKnfN5LpWEOz4k7YCfxi
 YfaNn+nVEbVAlc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.34.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.34.0 (November 15th 2021)

New Features

  * Comes with Git v2.34.1.
  * Comes with Git Credential Manager Core v2.0.605.12951.
  * Comes with cURL v7.80.0.

Git-2.34.1-64-bit.exe | d8769a1d90b2f1f7d85ae91e724c8dad16f340c5b130d49368a308dd086a5f52
Git-2.34.1-32-bit.exe | 8d584e3c975fb665618c0dec0ffc80b07e8504538f8b9f73edbb67ffb7a7c8b9
PortableGit-2.34.1-64-bit.7z.exe | dbf63703f7a37a374591450f1b1466b83ceccb724067521786bf8c5f69ed3ced
PortableGit-2.34.1-32-bit.7z.exe | 95e198aaf6e6455910facfc522f7981934822fb362f6605375751b8a9c62db55
MinGit-2.34.1-64-bit.zip | f9007b9fc3fabd5af824269eb4ac27401f632170b66b265045d05780beafe14e
MinGit-2.34.1-32-bit.zip | 43cfb79be29640beda05b50456fe7ddcad2f8723d3c40ffff2d27bec2a476d17
MinGit-2.34.1-busybox-64-bit.zip | 4d3ab5d2bd990e2b4d305998059fe21c031f4fa84b0683765184083e2bd720d6
MinGit-2.34.1-busybox-32-bit.zip | 56ceec251954039f8c202d8949591e99dd919d738208bf4fe4dcf8d472840c17
Git-2.34.1-64-bit.tar.bz2 | 0d962f5894b94b93a966a2c12f77330e5f68aacae775059fb30dd61f2c08ef00
Git-2.34.1-32-bit.tar.bz2 | 109d69b92e5383d40765064bcd25183af05b12c64a95597419a703004a7c8521

Ciao,
Johannes
