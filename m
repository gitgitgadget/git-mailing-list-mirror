Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77143C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B4861076
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhKDN6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 09:58:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:48519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDN6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 09:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636034144;
        bh=NlgXWgkzu7mJo1ZqE/hLBfHqO6U+d+BOfGdiQ1ezQCo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZKuUcMzxvF+eh6AtzCDsmmDzo/vq38nXQ0XSNDoGLe/cCcmri4vApcBl9ma43ZE/d
         D2qh6uubvWDFWUP2oaNNakbv7+SzPdcUJVCPd5tU6SzDNB48IHvXloJNgZKUXQO0NC
         +2iw8VUPqLOiU9Kn4Ynbg5vO14rbt5pUzShYTcGc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az30-490.nwfnsqwsw4julhrdclvecef41g.jx.internal.cloudapp.net
 ([13.84.210.207]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MpDJd-1mOxO42tOZ-00qm8l; Thu, 04 Nov 2021 14:55:44 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.34.0-rc1
Date:   Thu,  4 Nov 2021 13:55:40 +0000
Message-Id: <20211104135541.4902-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:1++oiAU7V1hDIJhx94TkloLlrUItvfZZMFaDg0rjwMPAcWCR+xF
 hSRZrjcH/OsQNOYa6or5S9Szy2yfcYsDAU2wh7p/OKbv8D+p0RTTSDMGDm2W7nRcRfYnxf7
 FTJFu6kuw9zVXoQMpmYkLq1nBflF1NNyqzEeQY1rMwfW/n8XerR2GOgRLt05WbFEVqgvEqf
 Aw+KmApNNx/71uNNOZe8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eJIE0CAFEoQ=:2deV54s7leeLPWJKYtFC/X
 DmZZAF8OR0/LfcdyZca4r8ct99sXGQUGTp1Li5zKw0bfTH7e8qxvP7pcTyV+vApL7bV9bORgP
 5mesl5t5BQzTs4wIvOUd8MJewK8FL1/mdJS9xxGwqs0JM19RLywZk3RnyAKYj9sOAZqLCqKfr
 nF3XIxRnQoPjjNPuLVmzRYRJq03X4PapH7wO7h19l++l9MviJ+4GVxfHsSH+sArbj1FuTABRF
 83UAHRZrIzh5NLf4cKbYSW4WYS6zJ/2Ez/VHoc7MkYUI1EDhsr+DK2h5GZDYmhM87KMlDjKDU
 GzrZK0IRuNJT5FnxzZWeZJYryMhrgyz6wKJGtLWAEifK6/PFdYo9d+bdUI4Xhar5jhoIvKFzG
 UiKuGrwxwsur1W0B8raABtyoSEEz8X89rkuWiHqyyyIex2pQ6BZvdTGaKEpAAOwtvR4QH76+s
 F1Mpxxk4/5VP0ugPINm8/ttNEC9rim03JhNJPLayzWYKzAtY/FOmjVSaGTN+jaqoo3eRSfRsw
 4q389EDi5MSkYZ1HWO9HurHZFF9WG6JbW9G3X2gUxw5pZvTxsoDBs5JcNKe5UEYTxAPSjcz3a
 wsz9Vg/hsJXpQWKGug7zt01fHWqUkbanWQrJ7a+ym7FEU4XE8sBVqqs9Zpz2Xqghioi6xGIAV
 Fk19WmDVLDgdZ6AjSROkuEq3jwBvLTQrblqPkE+T/au+wzECAHg9ZbPT+of+IVYSOm0mUXjqR
 KIKRoCLeGg2wK0WhpUxgDcPJwvgwRDUhq/NYHO/k+AOSScBudJjmiCws37JmMC/oU2VYC8CWq
 NhiFASTVS1qfoFtNBehUntkRvXCXwseV+tKzo/M3s++cCVkvrHmQWcChXh91oJ/hjFBYzTMul
 fhBpzzuDrdI+qJqzCV4nOsSYNS5PeOgV6oPesywJJwbmOjdWNKZSMybBAeKtJL79vZEZPkKsq
 RHvnLrP6pO7LWT5TUu/RkWsQRFDZIZEK9kyPtzlutkDOJCmn3G7XfPwrNcBDj+MAyruuob2cS
 GEtjo03ZFZQMzeIIfM8SOF3e1QgJVumI8xkMv/nQSzbk0Lf78bg76KC/F5kdWbb1d2OojnAOw
 343I+82X6HUCx8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.34.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.34.0-rc1.windows.1

Changes since Git for Windows v2.33.1 (October 13th 2021)

New Features

  * Comes with Git v2.34.0-rc1.
  * Config settings referring to paths relative to where Git is
    installed now have to be marked via %(prefix)/ instead of the
    now-deprecated leading slash.
  * Comes with Git LFS v3.0.2.
  * Contains new, experimental support for core.fsyncObjectFiles=batch.

Bug Fixes

  * Configuring a system-wide VS Code as Git's editor was broken, which
    has been fixed.
  * It is now possible to clone files larger than 4GB as long as they
    are transferred via Git LFS.
  * Git now works around an issue with vi and incorrect line breaks in
    the Windows Terminal.

Git-2.34.0-rc1-64-bit.exe | accea106d3da55dfcf638970371b429f84e35e076d2d2a35c1092f282f83fe0c
Git-2.34.0-rc1-32-bit.exe | 7701b03b209c4ea784303ececb1d3b6885a971989ed35b4322d3df0c353c9f15
PortableGit-2.34.0-rc1-64-bit.7z.exe | 6f2ad8d09d4a57e7f7b244044b127a3bce92d68fa0d8fd8dcb45e46cff53c3e5
PortableGit-2.34.0-rc1-32-bit.7z.exe | c61bd63a2d10188fc7547cc0e5f66f5c29b5fe6b23111f2d8b7c94f1db38b8f0
MinGit-2.34.0-rc1-64-bit.zip | 5865c94a9264d22cd4e99912f6359a7834e232578eee7de8b6ab5ee5a0a422dd
MinGit-2.34.0-rc1-32-bit.zip | 43da6248745dc8c342362719d8d5dd2c8eebc0342fb05bb3d89eeec9dd670e6b
MinGit-2.34.0-rc1-busybox-64-bit.zip | 6730c02e10e632367fd686d21c3664d7f0b467a9c7c7477e97d3646c674e4e9c
MinGit-2.34.0-rc1-busybox-32-bit.zip | 33ff05478a19a4303408f4d5ea53355a3d71d3520be56d390ab6c403f3114c9b
Git-2.34.0-rc1-64-bit.tar.bz2 | e66e8e07d6e4e95260eff30d10b8561461b1e1415ff28d1ab381ad1c556fd71d
Git-2.34.0-rc1-32-bit.tar.bz2 | 5fb3e3bebd6696e40f758c88cfea33c67690504eb6a03d35c06821c0795e37be

Ciao,
Johannes
