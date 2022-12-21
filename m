Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96107C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 14:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiLUOpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 09:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiLUOpR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 09:45:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8C81EEFB
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 06:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671633913; bh=FEiHyR9lNxVwiZDYoA/h0q7Lr6TI/kgsveXzCWAbcy4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WuiV4Fn9+LKpTGKE21vNxuEmYAGtGqaWc01lMLPlwDfy8zx7DFjfZZrTCAHwz7LVy
         e+jLK841EHoHU1SuNrn4+e4sNJxe/DbenmIcjkYmqsqYfvCQGvAMKahRyChy+Xlxf4
         8BGK5sxZ89Fr/oG6Fru43C1JHfz90LmM6jBSl3XlrR5q1eOrc7xcDSfCFsiQItmU//
         9b3py4KgSi3RrP5+aZGTbSAi4qF6QA4lSyMV3CEaut4PmuoaQMcgS1HW+cRruNB8oN
         7x6pFSsL2HPzV4Ynd23JlD3EXB6te4DHVO6nHQ2Q0Nx/muoKZvoBSjHamRwvHrXPWD
         e4vjSfLzdF9Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az409-160.fqimjijds1pedmrz30dwrfecbe.dx.internal.cloudapp.net
 ([13.83.14.208]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MJVHe-1pRrZg2Nrc-00JoEL; Wed, 21 Dec 2022 15:45:13 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.39.0(2)
Date:   Wed, 21 Dec 2022 14:45:09 +0000
Message-Id: <20221221144509.3421-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:xi+zhUPKGExVG5jjsUSg1UQt+7cYnfx+HEOx8u9TxDWsgKUzqmw
 eg4S1S5UvLxkW4eG4GYGFfDIMg0pEYUKrE1ylIvYUKIGDqhvLo1VcmP+y0XA2nrbU6lBsFV
 rH9C+L/kJ+Xc/xnnZqADfDhM4EDXLsEmTuxLd/DZ/++qKmF/nRrVol4xiFeAFWPFPC154QO
 7gJEOKHNf8m2354D2zeJA==
UI-OutboundReport: notjunk:1;M01:P0:w8QvJhhzizA=;0/MukdjVn/+2YwrnifQEY+qI288
 fMTFfvrm4TOeNDxkh3Ihv08R5bFo4wbXmNPNhFM9ATRSjlyGdAwcw32B2VLfGZCMpWNT/8+bH
 HI4+UOAd9/ZW0s4mWBXaGytKdtEV3aGvskw9OyLDbYFD0yKi/kn7nG0dXPUiircUvSLXzalLa
 DLmx58qtqm670QOM9y/U6Su3aEeWX1kG0f92Uy8yijlbCyChuQqDk7O5TOvLQy7qKp4WX4eFz
 3M2X/LQD7mRdea1Te8TDciLcEsRXd2BP2TDSt9+d5mkuJcEygHspAydXkG6ImAGh0ymVtIpjX
 9IUxMrpicJRidkGtch288Sk3viINHEIGV71yS0GF3to0jr5Sy1MAq0mM10CgVod2KGiZ+hmuX
 JXk/G8Lgo9Cbfny0MxSD6B+5iV+I3uDcby9hOlA7MeF7nFEApE0qm08TE14OZo7JrrDTEXAmQ
 D2WlKpEEnCiZ4sqQeoJYucUjbkN7SIe7uUxdnG5IXs82H60L/ewDqLwcbQ1O1Tm5s+tbG/jPm
 CdpqIySdx95WqGuu4Oq/DeypQcvT8gfl9kXzVF659sd14J1L2rO+EjfKXD9CLUT74mpekWrXc
 P38pw6MWTb6u+Zgd/o9kK2/ZWh1g9MGMB8RyRDQ1RNv3vE0CdmZzUHuMDhZ+6nJRZQAVv6ni3
 oIZxVir7GnPtJa50y5YIjnhpDDfByYYMHr96fDR0Em9IF5RXkqkgEVg2C/DuJCzJMxTJHUY0H
 1X4mL1NBEI4iy+uizy+xFcimSEvs6T16Osx+ZmdOkTpO8PGITZ4OLqnjCQUolQMYumUQ2QePI
 0Q5+AsK0fFMU0AlsKMmyYKHsvjjB7xDDa7t+uv9RnYrEkS4veYWr68tb1fLqrN6t9bh+Wa0yN
 njyEFuS7QbDgMhlNH2wYdG8drrPRNgYm/qD0ZV5flfvbrNRDWY8FzuVxf2NZW1nOO5PRkA5Om
 g9zArA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.39.0(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.39.0 (December 12th 2022)

New Features

  * Comes with PCRE2 v10.42.
  * Comes with Git Credential Manager v2.0.886.
  * Comes with MinTTY v3.6.3.
  * Comes with cURL v7.87.0.

Bug Fixes

  * The installer is expected to stop GPG agents automatically, but
    there was a bug that prevented that from working, which has been
    fixed.
  * A regression that caused no_proxy to be ignored was fixed by
    upgrading libcurl.
  * The Git Credential Manager version shipped with Git for Windows
    v2.39.0 could not always find its UI helper which was fixed by
    upgrading to a fixed version.
  * A bug in MinTTY caused it to throw a Critical Error when the
    printer spool service was not started, which was fixed by upgrading
    MinTTY.

Git-2.39.0.2-64-bit.exe | 8cf0ee3efaabe8a9b9b6b6889ae0ed369d9f1c85696ad637e715959921ed71c3
Git-2.39.0.2-32-bit.exe | eb5a8bd17995117a3bcdb0b9fcec74141ae6b1a74fe960fd0c9192a2b1d9c903
PortableGit-2.39.0.2-64-bit.7z.exe | 0a58c7b062a29bc44fb573c9afc5323011d01237dd94c74e6c833929cfe25436
PortableGit-2.39.0.2-32-bit.7z.exe | 042de3e9f87e529ee53ed31385bc76b39a9794c32c18ea7c62e3e6445dd8484d
MinGit-2.39.0.2-64-bit.zip | 771e7bef1b672e3f63b18b8c4a62d626c8f47c41390a745f313758c0b6ae4d63
MinGit-2.39.0.2-32-bit.zip | a5ac14121bb0fe879355f58db15aae41205046b7cd1832df40d1e784aa8e1c70
MinGit-2.39.0.2-busybox-64-bit.zip | 4337be32536f6840da4ef67ef93996a3808b774c4f61e3a2a585f5d968d1b1d3
MinGit-2.39.0.2-busybox-32-bit.zip | f68c4c5dce5cda8743d8a134174d1cbf0e0af725791bbc3c4062f3fdf93094b2
Git-2.39.0.2-64-bit.tar.bz2 | 1e81e8b0026cfa71050f81abf10669733a7b66b44c68e5a9448ace15cf521030
Git-2.39.0.2-32-bit.tar.bz2 | bf5e3281378e8ed23f6bff3f3e1ef7d84932050c2f590f75e4f19d419b7387ec

Ciao,
Johannes
