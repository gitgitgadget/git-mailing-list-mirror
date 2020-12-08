Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0478C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633D123A77
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 14:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgLHOhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:37:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:59873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgLHOhK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 09:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607438138;
        bh=KeRlKgqx3P7TnizPQM0ohED5rtpkoKaTGaRHg+CcpTo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WsHxjyJcuA8zJ8dU8RINc/OflEPk+Bzm8T3yyxzHAhrf+S7ONTPMFmpT7L91p675O
         fcbp3qxOXurM/SPsHjBn1UH1gexjLW4iIY3WGaY9tVvNUjkzp+WiKxa5ij8xJo/eXE
         de7iwDPkZ1bbjsHIm6ZkSf6VJLF1bBzq5JI4Cauo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az695-550.vev0twvh13zurclhlao2lrt01g.fx.internal.cloudapp.net
 ([13.79.24.140]) by mail.gmx.com (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MQvCv-1kXbH30p2F-00O0UC; Tue, 08 Dec 2020 15:35:38 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.29.2(3)
Date:   Tue,  8 Dec 2020 14:35:37 +0000
Message-Id: <20201208143537.6352-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:VQBTPHlv6k2X5LsBP1KshLODfOgR3ISVyZMYMANpT+7p2RbKvE7
 ZvGqC1g7j5cEJqeJIhFFn0M+6i2DjS0SNzWlUTEXdLcIeI7Zc2HHgRguMyMC7RVdITk3sJP
 VS2jLbTAN5vmuvElSdO9Bm+ZEYIi3WbzPBHrd8WnrVGAxNXMOUwqNcB6uohPW2hztEMY7d4
 GbU8njomf0JqV6ZH4ys/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7TAj+duCGrQ=:huiUnrkgvYZXrRQrZXMyoS
 Js3aSL9RT0C5aYHbjmVDcM/NxBx7uo7NxWk1fBGETlYcozSWPprI7sVWynVEM/84fAoDiErql
 wrUQ17W/TjFufhoNqz89FHOMKsAkiRmXHMFMTle0fPWk/qz1Xfdp04XMin7C2pk3RWUs8UdZb
 V9evVQCDK0RGRplUQUObgrwA//YCDoDUaAu6KADFJ4YdQlwPIu2DmkOmlkaR+NHoMjN9iCxZg
 DE+T38NBO4sd2NZVQ5mOk3JrRpi8Z8Tf+oPDjR4Ayq82Mbcunsifi6l99kWsFDuc3GJaCy7Wc
 8oIxjJGi+C27OI2gnvLENIFYI7Vxcl32IbpsZpACGhoNz7UIc4iNgGHfB2RNWmphjTX+dZ/8C
 DB/wMupOb2K/PCxQpK5JEsECHvVNs2PD6lu155dWRr3b6ycLhhA860s0GhInyGlwvy9lG5iLD
 aVLWJL74yKzgnGxRAYQYpTELiFqtShBiIw4a+xOmj5HhLfd3lR3bfY523QedZn+Fths3dzevm
 w/YWcPHBGHLxwj3Px58uAgfFRUrYeZ7D1ngBl5H3tp/mQxX36BZXVu2DWyIhXkjEQTdYsIP9t
 jFM/PX6qsUVjMBE8lbUs5EqyhEzGAyrM9+xPhNDnW3V8EjfiKIgQDm9P+Sl3ciHNJ2nieZ6AR
 DT6YOI7AMqqmbJEdibtqsfTkW+BUDVijQ61JrDGJHdQLF9c2zN2P6j6o4Ms2/y+/knVc4Qgkl
 H26Uzy5TBbIg0dDq9H2+237Tft4owV25+FKyobPW3gQ4A/Q1zQwVPPQFXkZnlpTd9jPY7FbYH
 /+xRkaH/nWQ+WYrUa+Y2P+SiZG/SlSkKA269UjB7pTTdPkLkhJc6ZoQ1um8PnjOuCwGkWUEyo
 1DqfF3+7F7dFiInIIv5mHC1bOZQ2THbLQaoOCZTdo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.29.2(3) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.29.2(2) (November 4th 2020)

This version updates Git Credential Manager Core to address
CVE-2020-26233.

New Features

  * Comes with GNU Privacy Guard v2.2.25.
  * Comes with Git Credential Manager Core v2.0.289.48418.

Bug Fixes

  * Beyond Compare 4 can be configured as difftool bc4 again.

Git-2.29.2.3-64-bit.exe | 7ea2cd77818faae28ba401d1e7d9467da00e97bbd5e7fbb6788ce0cefdd24d2d
Git-2.29.2.3-32-bit.exe | 6a753eac3ccf41b3edf577f3c8b7e5299bc78455552304e60e197f2d1fa117de
PortableGit-2.29.2.3-64-bit.7z.exe | 47334810d3cc063d1111fac55e4645893bc8f758d3ebf571883749d90b3cd7b4
PortableGit-2.29.2.3-32-bit.7z.exe | 6a9ad809842c3fd34caa1737f0dc6dcd3bb721072b3f3c50bb9529a754ed9f52
MinGit-2.29.2.3-64-bit.zip | 2f154719def1d48a06d292fca6c9c8af2df0ae82797a155e35754b2ffd374f8c
MinGit-2.29.2.3-32-bit.zip | e2b7302b2cb013a27984ba65aeff11030b32b7e19deb228304e3e5b85b31befd
MinGit-2.29.2.3-busybox-64-bit.zip | 1c9619e0e8b69c38a013f2c4e1bb07cdf82000a1090c4edcc955f7f2edb7a296
MinGit-2.29.2.3-busybox-32-bit.zip | e0516e87701d3390a7102c6dc55d1e65aaa68c6c9fc2a471dec9ff02c6d182d5
Git-2.29.2.3-64-bit.tar.bz2 | 400a78a8e59d860bb1b49325b642b529185b84fe5fc3edd65ae1863eda534b23
Git-2.29.2.3-32-bit.tar.bz2 | abd219e70e7319da9e459456a1ff9d36b64b897495cbf91fcabc40beac987337

Ciao,
Johannes
