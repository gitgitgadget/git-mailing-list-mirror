Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6427EEE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjHUUHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjHUUHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:07:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694FCA8
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692648430; x=1693253230; i=johannes.schindelin@gmx.de;
 bh=TSzVQesyuZGDtXJ2yYJfWdugKYPg0FEEw3Ca0APm23g=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Xf4cL/eVfXTNykmnSqpOYFXByxaOREhGmcggm14EjC96OT0vcTYSxA22dwKjU+BbGnLzK8s
 tw3VI8pK9xH2S5FKy8sCeYwPSKo5et8YVeR7bG0TTMT8tCUirvKt3W4p6p+YqYtg4qA077Ck0
 XE0iFjRZ6Dq0k4KmlRwpfEh3VV7TLzlfSufWgfc8UHvaJto8rKZGlhMh07pwbcFnVJ9xef1Uo
 cS9d6RhFsPqLi/0za+lsQdrg/lWOu+Aun2Q0dUGeAVWWClW3t4FJFllH2XbQB66yv6UFzChJw
 4roCaWsd6ny8Tp/YOfFwQg32YqmBxB35vI91Bp9e6sMW4o1TXS9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az629-918.1soobpoi4aruxfwmxrgofy2soh.cx.internal.cloudapp.net
 ([20.57.69.50]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1Mo6qp-1pvsLW3ijz-00pYlL; Mon, 21 Aug 2023 22:07:10 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.42.0
Date:   Mon, 21 Aug 2023 20:07:07 +0000
Message-ID: <20230821200707.3593-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:kc7Vans7FZvq1cclrFPAzmxe6pJ5GT7VXZpV+5Al8NrZ5/9CHPW
 qUy3yMKSObI1ypDKiLF6dPiED9GZjfRKEtTem1ytFvKMDNLtifxBGrsRk/FenW6a7VMDW1V
 wsKOZzwS9LYGDUM9dsc1rO0ihmtptt4n0Lb2Rce35yyuvC9IjPnhjCmv+iYThheNmCKf7qf
 vGKgT/IXScbi+ajxxyVBA==
UI-OutboundReport: notjunk:1;M01:P0:QpCMxR8u1RM=;CZ6cza9cRoVA6bCZEKhNL18v3ru
 weqpuhEKuS/ypsy63cuXCjf9aSJK/VN899yMKTffcyMwfnj3/DbV44wK6XxU7GyKUbXl8sYD+
 NqpBSvQxFaoarpp7T2gPGDKBHwD8MK+T9L+d/meJLpVHkPSN05yuESrs1vsejppkGi7VRfQvZ
 0mZawfYi5oCkOVDMfhijWq7kNGFbxW7m0ICEA4LEgegGH2fY7T+zUuDGOUyR7Vg/1yEJdTYsU
 futNwq1WWyDcPrMuVqmYe7IvzzpfcigjNqK6UL1zmNljD912qTeEUYTUPWBrc7UmiIzAbsKFN
 SfU6PMA4oKRsR5wCC98qo9vkcx7U7QaOHSnsIzGExm5SU8E034E1BXY5elxs9Kez/0gfdwqTC
 fDfFUdVDd6y8i/CfIk7FLoOqLwg66TSguQweq/p+/QZfuug6l7UcE2+aNe/as26OPBpJEPhii
 LPVzBiqQy5h791B4MIo0kglyqRcXnsS82C3xgPggwBzhV8auJddpv8xZmNmYrFEjijM+UIBwI
 XpGfuyzFx0/OQiaPsmtvTBvd394quYlmIrKXzT9ceSAINN+kcv4LVmvh7hdETBGxneSjdJCSV
 qsu/CXhnCprAlxgJ3lamiv1ebEKVZ0KKNGl8Jcl+Vdf9Cnx74poDT4uREggC1A5TQzjU8lcAC
 kgLkjdcMZQfQwoeCjzTQ1WRjTpZSNiJp1MLr2/OMXIp+ymjelK1cEunEaAR9NpvPiHAOzNp+O
 PD+xjl0uzPmvzwFc9v9iCY893XaDL6I6vq/X5aZtqHSG4J27ks5YSM+3KhVBXAyt6ztBjlVXf
 vJYvck1E6UrEXQrKyx2KZ0gtPkJ0/N5ngeNOalDjmhNjYQz0ttbZtI8EtAEau5vN7L85uM/Du
 XCTvI0lZw9JHk+Yb2mQWdkLRocY9JuXDS6LcW+oMlP1B1mI0BGPulIEDOp8lNnW6W/true87z
 NCkBcK4+iOsTmXoV8GY6IOtPaI0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.42.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.41.0(3) (July 13th 2023)

New Features

  * Comes with Git v2.42.0.
  * Comes with cURL v8.2.1.
  * Comes with Git LFS v3.4.0.
  * Comes with OpenSSL v3.1.2.
  * Comes with OpenSSH v9.4.P1.
  * Comes with Git Credential Manager v2.3.2.

Bug Fixes

  * When init.defaultBranch is changed manually in the system config,
    subsequent Git for Windows upgrades would overwrite that change.
    This has been fixed.
  * When running on a remote APFS share, Git would fail, which has been
    fixed.

Git-2.42.0-64-bit.exe | ce95be32ae58fee3ada7b997c519b60d60c6fb1bda7a305336103881de724902
Git-2.42.0-32-bit.exe | da3871a93b629348db08304d8a1a3edc8644c7403d31e99048092cb8c2d4adab
PortableGit-2.42.0-64-bit.7z.exe | d394800e5eafa11814ff15f8631bd6f5379f7fbef347cf23a6d76cdbc42e23bd
PortableGit-2.42.0-32-bit.7z.exe | e7d7da5ecd0e5eaa13efd2f8464e92fb58743552a21c3f2d2c630d678bc40e2a
MinGit-2.42.0-64-bit.zip | b945e6df773fd8013f12e26b65b6815122be62a241d3ef4b9ed2d5ae67ae0aa1
MinGit-2.42.0-32-bit.zip | 3b3c1e50958f8d03ada4dc11ee1dfd5198a512935a1bab77d6b12c968d363491
MinGit-2.42.0-busybox-64-bit.zip | 0f321d093e405049ec8d4c0a3f6c564a767bd760cc85f46920a9d5b9bdcaf58e
MinGit-2.42.0-busybox-32-bit.zip | e40151765772db868626b20129e1399e123229ae218d168b00eafe9899869624
Git-2.42.0-64-bit.tar.bz2 | 077ba0669103a7b9347c26f9fffaef11e8d0c3f5a31548dc1df0e30253f1a9be
Git-2.42.0-32-bit.tar.bz2 | fa90a8c40d4f2449d685d1ba314fba9794169873ff19f1c5f46e8debca34de13

Ciao,
Johannes
