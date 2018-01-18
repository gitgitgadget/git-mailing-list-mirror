Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327B21FAE2
	for <e@80x24.org>; Thu, 18 Jan 2018 22:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbeARWWG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:22:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:65064 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbeARWWF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:22:05 -0500
Received: from localhost.localdomain ([65.55.188.220]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MXEs5-1eHCxj1ST7-00WClH; Thu, 18 Jan 2018 23:22:02 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.16.0(2)
Date:   Thu, 18 Jan 2018 22:21:54 +0000
Message-Id: <20180118222154.15784-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.16.0.windows.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:GCfmKgQreH5Balvof+WdfcGFM1l7UtfKfoXDOWrUvs5X3Y/guQl
 +s1cJxP3y2oruSE6Qb7hhsXSTQyAdDo11i83rJzzASfyu40YyX/1iaM7/ZWEYTirOu8ij8v
 krwSe2RJNc9qqJZqnVkrOfqyPKIfQ3zJ39FTfIXiKED5qaQeop3Len/9+BSgxI/dOeI/nFi
 HMXrBqqYunG5rdBy+NGlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FkFAewRkId4=:bR9OmWS340fU6nj5/J6JTi
 op2kEDvO4/gV5LMVh0AZKvuA+GsqzV1wzYdJURsECBrcM2b4IE0jmHAJLd3qBTPa8mztfEWlc
 30q+K4WdsPcYp1Cb/ALc4pfpmIY3DfLM10IeQRzMqFv6mK9FY3CMPq/eBB+9eb3AjZ3T0ILO3
 DBGEhl+R99AqIGuw6tsZeXpeLG9wRWDzE1IQuhB4VH0bucXOvSvR+rKCzxy6rsNqAyf3Kn6w5
 4Tmn5BEhuQ1zpljyoIq6TnQHTNPz2cztVNL2BvdzofBZY+aBbMerOFIZTBd5VnJ6MMX5zgxTS
 OtPV53otxgsTbw03x3MaUSTWcPxE5gKnTsuy+o0DmqlOJHbUmL91826tIOd21pKv6aTCTWVrN
 iOoUZcWTUffAnrVpKmLFVPmhWQTxRnCy2L39CEVT8lBOfzN3HWldy85GlaNNsmHi0U6vBBbnZ
 EDcLNIqSRpQ2DmOAMBWr0aOfmfWjidcZxIwrEhrJ0JesOT4Cp7rXRy/PTOXhdVZZho06zI0zu
 9BOshVCJd6MN99UHl6GtLCSnT7oHgsaOKw7skPMfxonOXMFpYrGX2P/cQOSkvuUTlNW3Milqg
 Q9d9/bjz+zi+9PmRw8a/EAIJovLdlbPA8djWjcNwCA45ZLhs3DSMXNgmMCM/2FJFCDzMYsYps
 vCQEMUQx+K5mU/kPEcIZvt2evfBi6yTieWeJTHiUiiTp4BpD8TIDbdg6+eE1ZD5alCHAoDmB4
 +kpko0ESatHSTUEQi8SqKPGWNSwDWC7paR/0Vd9UtZQfL7b+yuHdYXOBW3nYrzN39WzetqNcl
 DljbTt08k5pU9ZcHbLWiHbVQoDS1A8saUqerqGz5U92BOs+YpQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.16.0(2) is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.15.1(2) (November 30th 2017)

Git for Windows now has a new homepage: https://gitforwindows.org/ (it
is still graciously hosted by GitHub, but now much quicker to type).

New Features

  * Comes with Git Credential Manager v1.14.0.
  * The Git for Windows installer now offers to configure Visual Studio
    Code as default editor for Git.
  * Comes with OpenSSL v1.0.2n.
  * git checkout is now a lot faster when checking out a lot of files.
  * The core.excludesfile can now reference a symbolic link.
  * Comes with patch level 7 of the MSYS2 runtime (Git for Windows
    flavor) based on Cygwin 2.9.0.
  * With lots of files, git reset --hard is now a lot faster when the
    FSCache feature is in effect.

Bug Fixes

  * When cloning into an existing (empty) directory fails, Git no
    longer removes said directory.
  * Interrupting processes (and their children) using Control+C is now
    a lot more robust.

Filename | SHA-256
-------- | -------
Git-2.16.0.2-64-bit.exe | dda9c9eacdec5bb1369351b48d84c7ba947c85cf5f6285e369eebc89075f8bb7
Git-2.16.0.2-32-bit.exe | f595b9245f387aa6e4e1dbf7eda7c963b80d3ded05fafa16f09dbac582fa3e6a
PortableGit-2.16.0.2-64-bit.7z.exe | 967f65c6e014e543109e9bca1a7cffbe192eae82c349ea1639eefdfe087e44e8
PortableGit-2.16.0.2-32-bit.7z.exe | b5d0699f9720cfba62e61d8c54bc4a4696323273a4ae9273c82829f16d5a2af9
MinGit-2.16.0.2-64-bit.zip | fb028d2a18c7ec18f8febecafc95e9dad0dd583ab8fe376c95a06eff62058bbd
MinGit-2.16.0.2-32-bit.zip | 1c49443bddde815b5ef551f692a44fd9f681c1cfb8cf9457461690c924d2352a
MinGit-2.16.0.2-busybox-64-bit.zip | 63b08dc7a583e843e796c2f92036d40cc42e51096812dd38be1433453bb49f61
MinGit-2.16.0.2-busybox-32-bit.zip | 84bcfe30841f490cd2d20677be217854221a1ca4a7691f27b95c60034b498010
Git-2.16.0.2-64-bit.tar.bz2 | 2685b9d2dce7be83a2f8528ef55498c5938216680d4d1b4d3c4fa5907d7eac04
Git-2.16.0.2-32-bit.tar.bz2 | 18899b6b9738565c7d5d49e385c67bd5130e110f0f9269c3a051af481b1ce55a

Ciao,
Johannes
