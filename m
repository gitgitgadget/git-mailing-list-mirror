Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0BA1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 15:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBFPiN (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 10:38:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:39845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752185AbeBFPiL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 10:38:11 -0500
Received: from localhost.localdomain ([65.55.188.220]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MCPhl-1ea2lM0dEX-0095QU; Tue, 06 Feb 2018 16:38:09 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.16.1(3)
Date:   Tue,  6 Feb 2018 15:38:02 +0000
Message-Id: <20180206153802.14064-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.16.1.windows.3
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:SLSzTtAmAxWO1oXHW46jWTA6ipbpiWhoIKttKGDl05yCss93sSu
 xjZLRgyeILgJ6uOZvqirtxpY+4IffBve80kuECDhm1iYXsHYVy1XtMzyjc+dgJ2UeKbXY1Y
 9D907WsgD6LKtEzD8RRfi5GE8zv9+ZsT8cowEmcpPRu+OyUoZegWo0Mx2agpdwRFtsMqk+z
 J+E3mVipbbJKjT3wKGaDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9ndKGrHjsGk=:sscGkryK1VNi7XJFhA6sAI
 UssdfjPthDIDirKhw5YY87bv26kBUkg84yBlvdrPYgcoHJiMOZUWMkOpVk7O0w3nh4bci8cAK
 uYAxqbN7Iu10D899KA5MeN8ZBumYWqUYwdQymTQuhtcJPiksVDvOIEOLx7Z/w82MaFB5ufa3U
 aW1ptbYmgED4orDS4iM9m//VcpOb6dr8s7sGrK1zmgicex/sRSZ6yIgdWpUPNB8Rns/dvIWtu
 o8w/QLMpOh8HAZV+KtKc7mFR/RP9AGMjDWtYu337G1YbmI2nfwCgzPV+ukeBkU1cWee+X63PN
 U9Wo6MxxgZrohLnsjnKTBeh969GsCskGJ5i+IJUYI7L2o1a9916RxoRJ28dIocU84QK8+3af8
 /qzZaxLy0etLUU6H+PYfp5AhZyiawdq3TFfZu+A1PhRwISbdGwYv7fjeUBw6owzuJVTpbxg3g
 a68eKB3b1Y+7EagX/MzIhcPk+gzTbeUY38UsxiXUJJRajigipowEfVLNfsXRPbfaUndlRcpJ7
 IB9PhzXhAw1q2JvOjCQrU9i+D9vDxmg9lQtLquKRBr00iCz+5YZ+7PFaN9XmaC8+NG3/098pL
 69eRu5DVT6TkGEMMV4wb/yJMCYGxgk/NN9sBWjiWjgn9JsWtqMVQC/j82/Ay70nHkbcA80Zp0
 zRShF5j4xR+EcYYWW+Fc7ZWHAi4otGnuELGA9K+48UCoisbvWFGaDG5uw0O/vuy2k643aCoXw
 x8gStXpg0Y+DWW3POE4Qdj7g3UOEQldLEUELrYyfv1EKF4g+fuLqgKuWQFoUBV4FEPliSoUkF
 P9sH38PSxQETZWc8TtdJqbrAUXi1y66vovyvIOt5eQC5bU5UE8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.16.1(3) is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.16.1(2) (February 2nd 2018)

New Features

  * Git for Windows' SDK packages are now hosted on Azure Blobs, fixing
    part of issue #1479.
  * Comes with perl-Net-SSLeay v1.84.

Bug Fixes

  * When http.sslBackend is not configured (e.g. in portable Git or
    MinGit), fetch/push operations no longer crash.
  * On Windows 7 and older, Git for Windows v2.16.1(2) was no longer
    able to spawn any processes (e.g. during fetch/clone). This
    regression has been fixed.
  * The Perl upgrade in v2.16.1(2) broke git send-email; This has been
    fixed by updating the Net-SSLeay Perl module.

Filename | SHA-256
-------- | -------
Git-2.16.1.3-64-bit.exe | 27cec5113e2572d22336150afec337fc94627b330ebeec2a61b8bb447a6301ea
Git-2.16.1.3-32-bit.exe | ad1fca7ac33326378b8be187d4595f50c72bd8ad00b277807fc091c16bd9796c
PortableGit-2.16.1.3-64-bit.7z.exe | bcb3ca27ae151313ab369d9f39b018129035d7fa018fa0df364424b6e22be4d3
PortableGit-2.16.1.3-32-bit.7z.exe | ae4cf93c391c66698856b8b38ba3a42e7fcc7141f61531562134f72b1c014f36
MinGit-2.16.1.3-64-bit.zip | a3ee17301ef563349f9936e68beb996c747079afc883e4e40615931e032905fd
MinGit-2.16.1.3-32-bit.zip | c46c6697906a1a85f784c7cf6e0385689ae3105bc8fe99b20c3a70ac73ab8e9e
MinGit-2.16.1.3-busybox-64-bit.zip | 630bb6d79c9b0f64c81046208d00a41edb2540bd99a2626c5fdaf0550cdb1a9e
MinGit-2.16.1.3-busybox-32-bit.zip | 3ff6f9e936d837d6f319bdb1ea4f0fcc9ff6bc203f9de1987538313686574f1b
Git-2.16.1.3-64-bit.tar.bz2 | c7c4f9a9205e85977475698732484c6524d8b381f03ceaf04f35bd6f89bce389
Git-2.16.1.3-32-bit.tar.bz2 | 8ed49c8008728c70e82436d8c1cafb23cb2ee1f7b01d2e97a7e626d2438a0cd1

Ciao,
Johannes
