Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A159CC3F2CE
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 08:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770BF20663
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 08:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KY2ZnltO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgCQI3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:29:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:59707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgCQI3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 04:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584433762;
        bh=/WCbDiyPkQVmkZDh8DrskPLwPPqgnXjJPnMDce1SDnE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KY2ZnltOLFOIpKziA4RA0OsJ7hNwWaw5XGkSd6dLwr7E6DEOwMx6qdrWZScA7dVxW
         6UhsaeE8YwQlyEKX9HRWBWAV/t9RQHs2OTbJjyeojY/BwdfYoiKnh4Fdp7klQp/CLd
         idM0LjM/3bwbGO4EpslsRyU1kubIDqEl2vxWai/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az767.52a3e0o0yoxe1o1qdwrbqunwid.bx.internal.cloudapp.net
 ([52.255.167.45]) by mail.gmx.com (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MVNAr-1ipkog3AM3-00SM3t; Tue, 17 Mar 2020 09:29:22 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.26.0-rc2
Date:   Tue, 17 Mar 2020 08:29:19 +0000
Message-Id: <20200317082919.6464-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:eUZsmzlfTYzLwA90ydaY62sbuthWUK28bMa0WKs2RTlpp3wUJd6
 rytirnZhaKmfGY5yPzcHEMFT8cE8+935341+ZsmniEcho2I5IsqXoti92aWq14j6+C6v87Y
 moApxKVmIuedqPDs8UIKotAQmuB7ZFaC9p9hipMTAfN9N1yEV1OrDO8q0d9QbFRzu4lXoLR
 Q6J72QYnE5pGWkXWURZTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NI15J2Pv6q8=:ZIeVEM9P0ITwPBYDT1hQr+
 2oTUj8NVl/DqHiyhdmkNPai9QGSyXXl/LDx73yQGeFgD8hOmqFt8vgXAV45Q9TNyK4RUgf5lU
 lbc73bjw21cMPNlcC28e+kCy+DrZUWXVeE47Ksx5zt/9vmZo/XN8cPEqxsOKTgIn/TYlN2+Ub
 Q/5TEaVZ8x19Oiu36cKwccYEZ2bYuYCMynPw+BkCk3xknjSFU8ySmlCXCtsQTSeAX609IhmUA
 YLY1TrcrpHGBgjr4pi6x7E4VKlPm8bx23gP7jCFB+EzGjlINQ2y3yR2J9ZCy64fZxPK/h9Vqn
 bKWGXUUP6PdM7KqIaHuuVwKMXcOXBenJu0bGyU8EpM4kGDCtd8wG1d7VDBGpBpvBXUoYTJDf9
 gOIL15p0XHSbv4YRczLS6GWhj4e3zklKbOHDToHs6CtfnF8+wyCRU5gnDxJ7LygrgOtkCIS/h
 n1NUYHwKHz3yqMx8QPubOwI1TUdPmVymeBAtnYEw0O0kwPZPFxtFMB2g/06lveI66QAvvbd35
 NbstXOYJcFAjAvBIQqayd4uVYUK2s01aFrxIAZDtRBfzQ1lMhhWy/JaoMecNdlKhAAvN5ur75
 bn6vqdouvIzYZd3zDYk2nmms5wOJHbiZ/sJlw9maAZdXLUWQ081SeTuOI08YSQogvAYVUK/5+
 ZFc9NQ5g7i7xXiNmq8HeHs7Qm2H7MM1UbybU1YNvWR+AVdtXUKaqSKQef25Cg0W2G+bXzruTe
 j0/qEpznL3JU3aaLHWlGAfQa95eWy9tIT48UrqLa20QSDazqDNbU+lI1Qvoyqho+7zKtlilcF
 25ALeuQCs9kYzaVz2XFUfNV29Qde3XADYxl5SKwSL/lo4CMdNn2xtvpa1S6CfnhUbi457vyiQ
 G6cG697T+WWEKxdAO57h2dn7EkcG1EE8zwA303s5DYuwTm39tqxGIdW3tveusbb/cTjYlL211
 gU2prExp6jwlWCRolkb7/1WnfTsqMsKi0oJH0tpCiHfuIam7zl+RUyRfFgkuFSI+SU1U/eUnl
 +bVw2eJwsX8cpBkVbvGsxSFN0BUKRip7d+teKff38sOOIGFQmrApKhTsyFPVxwsy/tP8vxvDZ
 5cYOFFuI2DAmMvzyX02y+4lWqN87JD9l6HQDqGxqIh/n0WJZ39PHg6vQSnbv37brgl4eTrHS9
 eq1StzYg05juKGuMXqHdWTAmJaKTRqMidmnXLmFLN5csnIzJaC0Q3ctz0dejKOXdF6W39ZC36
 IlSmbtx6iDxuBSWfT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.26.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.26.0-rc2.windows.1

Changes since Git for Windows v2.25.1 (February 19th 2020)

New Features

  * Comes with Git v2.26.0-rc2.
  * Git for Windows' OpenSSH now can use USB security tokens (e.g.
    Yubikeys).
  * The native Windows HTTPS backend (Secure Channel) has learned to
    work gracefully with Fiddler and corporate proxies.
  * Git for Windows' release notes have been made a bit easier to read/
    navigate.
  * The Free/Libre VSCodium version of Visual Studio Code is now also
    detected as an option for the default Git editor.
  * Comes with cURL v7.69.1.

Bug Fixes

  * Git for Windows can now clone into directories the current user can
    write to, even if they lack permission to even read the parent
    directory.
  * When asking for a password via Git GUI, non-ASCII characters are
    now handled correctly.

Git-2.26.0-rc2-64-bit.exe | f87da4e30cc9dead2a8e71d47c7f14f79ea10d29fb0ef359ced938bc7e98edde
Git-2.26.0-rc2-32-bit.exe | e97398c35a6b7c3d8aeb2cbc6bf7bb9f562d26f31367ac543c961916e9cac1e3
PortableGit-2.26.0-rc2-64-bit.7z.exe | 8db82cfafbca14afa41d80e1e80c5b70195f068a270d3dc08949c95e17291e25
PortableGit-2.26.0-rc2-32-bit.7z.exe | ac74a5cb60da0a2affd08234fa61c18c9031ea11f99de8d1de7879381a5e0a7b
MinGit-2.26.0-rc2-64-bit.zip | a3ec72f37746f934c5c000e069b84deafcfdfa97378f079c7c429e3d7f551d2f
MinGit-2.26.0-rc2-32-bit.zip | caff1918d70bd962d02ad05c238773d34d0227127a461405edf529d588d9a35b
MinGit-2.26.0-rc2-busybox-64-bit.zip | 9a9bfb2dbc21cc436bdb921e7d4602020d907bca3a108bdb05aa2d989debd48d
MinGit-2.26.0-rc2-busybox-32-bit.zip | 17ad25e807a596a9e84af41f102bd8f3dae1664c39da748d15fbfa04294708a2
Git-2.26.0-rc2-64-bit.tar.bz2 | 115da49f588c0ff68bdf4c77e47fac66e4a350e37a34cb0bf98f1ee8d30687e7
Git-2.26.0-rc2-32-bit.tar.bz2 | c1886bd9357759e57842cc6f32e26eff021825c02274124f247c40036ce89d25

Ciao,
Johannes
