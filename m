Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3087AC4332F
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 15:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244017AbiAKPCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 10:02:32 -0500
Received: from mout.gmx.net ([212.227.17.22]:44895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243677AbiAKPC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 10:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641913347;
        bh=+G3O3kS2c2Lz31b5ZmrLjfEazxVxd6fjwJL20oKOaQc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=I7GS0QfbJEm51nH+tezfPzbYt1o9oJ6c7VD40JkE6hoecMspkcjgpJafUhImpJxsk
         CRM0jqmtr+D8LjyWNGhp+rs1Mvt2aXaEZuZ++eya5wyTb4tlXX7n8t67BMFyZnr0P7
         IjuXNk845WqKUT9nWEmrB6xX5upJ4BFMWWHE7R1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az92-203.nbrkuvepa5puroylvvx1wzp50h.ex.internal.cloudapp.net
 ([20.88.13.196]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MSKy8-1mwOb43Srw-00Sgr8; Tue, 11 Jan 2022 16:02:27 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.35.0-rc0
Date:   Tue, 11 Jan 2022 15:02:23 +0000
Message-Id: <20220111150224.4092-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:ZWzEuypRQqF8StTxMpARGz84MZiEAGy0gSsvf8pZGdv6NZJ2Xbl
 cSjwQsr3lW27t56aTFZCC86F0pt7Iv2juOJYfsdUpsy3J0DH8OzTw+xKw8zKCCJxDcn+uyH
 7/vvTR6x2UuCqMl5+Xw2VCEQh6Zi07svtmyl4syDdL64mN7cCghOihTUmSVG9td3jkb1U8V
 C4Q0LPkVF31bb5JKfOMBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4F9Bv3Lqs8w=:zVtuSlWxU8JretGGuIBlMI
 3H/cet3sOu8Dbq5ntP1mtr5jJ0X5hIexorlp1ptbmtelSLpW3VR74vFB4nmUgeXRvWaO0Vxj+
 DY/BOIAnKTa5I+rlNefg9TWMe6X74xTL3Vs/ZKiTP3TmdC5qHZkVWuxiANCgPK4I+Wu4xyPw8
 2cz3/jDhPmRThS/WV0AhCXq09oGf5iCaFhQbZyEcLJBZZPWT435SPIfYZnCnW5ZCbmNi2tG5u
 WeYhREPLGNrmwHe3nfp7Lrk9wmReutK0C5Ts+5C51JI5CjGUkX1NG6U92X3tRFJgKx/HMVd0l
 bgyxh3X6CeROkKlenI95lqNujcOmZXC4EXCZ6Q10uv/QNzIckD5e+0bmnjwpjAPdnhhfEqP2e
 dyQgIF3Ny6bRbDeU3cnl4yfzFXAv66m0HNgQvIuqebeJjGnBUavosiCerlZ5ZJHlOmrIz/ayW
 xefoc1oo6zuq042zTA/VPdrAp1do9f1NSlk7SxM1QmeKFBQ/ovdUW1PTShgcU3SY4anx2VoUX
 2XDpc4QpPNI9ANk3RtUCiwJOzc766wjRjtlhfBOvydW7yLzzpl7Pju0CS681XWQUQU0C3eAZ+
 QmGNaPflauoCntocU3XNdVAnQxkypv2qgGAuqkGiQxC5xKQzlXcpnHvhV+Kv4dQHBdj87ylYI
 k1VfHR81q9gRfXuaVL8jnMF0E5f9Lkc32TV1xT9AIkOXvgMnOFmOIG/YnJjxLxfJG7JwHw1GX
 +a/OSsb6m2cNrXDUcLw4bOzM3GLwe0+C8Hb9cGJ1xvzF+pcgg8aSFU88yL7NtdRTtnjL65k0l
 tjVwGROBR63rybT6yDIh2uMJp+o6SxFM2fwdxU1VhpuMuU3jyU2aqDCbbV4P67ikNBOEPPyNI
 OJVFi5JPQCPTAKVvNCGQFYdYmNtK9zqFFnxmlWlrknVXKWbdh8s+EsavHNzbAuRqer0VLR8IK
 ZPzr0usMDfwUjjNpIZNKLGG7gF6EUsWgWZ51uoLUl4t8qkJNelnq9s7U13/25pyVarDtokGle
 XTemAfc+LEggva5wfce6SIuMgwZm+0W7heZkn086hzTyfzXLuKsUBJ0yaovGYlDeGHYpuJMOT
 xmHV1/w7P7gqfo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.35.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.35.0-rc0.windows.1

Changes since Git for Windows v2.34.1 (November 25th 2021)

Upcoming breaking changes

We plan to update the included bash to version 5.1 (currently 4.4) soon
after Git for Windows 2.35.0 is released. Please check your shell
scripts for potential compatibility issues.

New Features

  * Comes with Git v2.35.0-rc0.
  * Comes with a version of the MSYS2 runtime (Git for Windows flavor)
    based on Cygwin 3.3.3.
  * Comes with OpenSSL v1.1.1m.
  * Comes with Git Credential Manager Core v2.0.632.34631.
  * Comes with cURL v7.81.0.

Git-2.35.0-rc0-64-bit.exe | bd9ad68aeaaff14338a800d52d27bf66f73397aa1624936809cc1efb0b4dd7cf
Git-2.35.0-rc0-32-bit.exe | d2e84c6a8281654a210376e63aeb239b0d42d67e831b63294251920c504bd8ce
PortableGit-2.35.0-rc0-64-bit.7z.exe | 56dae5167c5eb289eb98216b23340d3917d137893d139aa3ecd45e0f7b98505e
PortableGit-2.35.0-rc0-32-bit.7z.exe | a205ce6ac5dbd25d9081caa15aa2039ea20238cc30ec5121adb1a941358f2868
MinGit-2.35.0-rc0-64-bit.zip | eeb41b855e7930485d4e81174e9c2398f2eee7e02296a2f247758454a6b7acc1
MinGit-2.35.0-rc0-32-bit.zip | ee583e9137b4056caa490cd33b00a4bb2e692a708682e2ac6065a830d3992fce
MinGit-2.35.0-rc0-busybox-64-bit.zip | de4eea585d0ce42d3b23bd0fa27fa1bc452de5de4867163fbf7fcf7f50e054ce
MinGit-2.35.0-rc0-busybox-32-bit.zip | 89b618733a302d3033fc1f0d24efe0599d9292806fc6c5d6fca1aba7d6d7f754
Git-2.35.0-rc0-64-bit.tar.bz2 | f4f9f1927325b2626aaabf446bce5e94d45a27cafc473c821494f69037431828
Git-2.35.0-rc0-32-bit.tar.bz2 | 04bf5a56ef4ef54bb4818253b65cbe17864dd5923dc0cb6505268b8759c626d6

Ciao,
Johannes
