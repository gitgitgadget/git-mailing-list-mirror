Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC27C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 18:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjAQSrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 13:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjAQShy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 13:37:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1438023
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 10:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673978933; bh=naatufBJLXc1Thuaq9A4GIoSSulfg9Ck3QmV6CBjUfo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=jpVwasvE3tv0Bjjmu5GvTWxPCZfCSnIrXWLavfQ3wHl/9nOIUa6CRPyLCwkHqPOdr
         v6tLcJFNI+vKEvWO777Tz2tQmEYUFb9Zzun9z+c94xuLH+ZGK2YMCQkbhbOtHUU954
         MV3wWTxrS/OEy4easL0AFho/PEKrLrXVJTaMkr6vX5gYOtdHP2f6ekCLO3gQemqZds
         1yETi2oJAHoL20RPNAseSjKfSwmhsPm6nCaApE1268Il60WZByeeQnIU8kPSxMwuml
         52fSjq1wVoOk6RHAbQjm85mx/v2vMh6w2ZcZWfNwIW3TtG1rjvenAO6w4+NJChz1wP
         RoR4o0Jz++q9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az242-789.30y45kzjdhxebl3rnllq33u0kc.cx.internal.cloudapp.net
 ([172.176.194.114]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MLiCu-1p0B0u3Xv6-00HgNu; Tue, 17 Jan 2023 19:08:53 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.39.1
Date:   Tue, 17 Jan 2023 18:08:50 +0000
Message-Id: <20230117180850.3664-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:yMVOBlqLGBchQz/tJyRgJLpu92K+GONlkP1Xq9hyPQlnF/SbBz9
 pV+R1NMnuaB6yngZr5lKZ807SueNXhWFsBpTQ5XhdcLN+QeDkW9Vy//z37yGI9wQJV1SuyI
 hZKujZ0nwbhmSHkC8F6l1gl56dMa5Frp8/MBa7SJPFPeiDAHXJcsiiTNWyGOqCE2JmwFFMQ
 PlUdhMWEsU6qyAR5VH5Vg==
UI-OutboundReport: notjunk:1;M01:P0:X6htXW4ZjPs=;h82ZmILDWDGOci7d/NQZk8X0WT4
 EbeNGGRBf6WZHDrpCgR9NG/am33m2VWXf/0p2wiWEanIxj7K4rVs+OI6o5UA4ZFtYY679GWId
 HD2+HP/8TASJtITgvDs/oHrovTjWLL6KwBCF086dmPw+A2Bb0pHNKOwPiJoED8tCxeKuBcJpG
 Hu3blwx3aY620pt04h/y35KOeRkzchFvjIyeC3tWP+/avAxaUhz7BC3Ag7IY4F1NYdQ8MghbO
 Se2HZeau1W2cEdnGkRgZyO5txiyHSAFoPv4ww14OaMtMZt3BSEqJZoY+iLNmz69WabC5JZHGO
 HmeCJYylaAR84RMgdyGnAhWRWoVif4DAPoUwEcyg2obLhkcMWWSe0kplXAAqpOcrOyO9mWjOo
 KBJcoPLBzTX/8Gg8M8v8lX+FBiS1Cv5dHrbpOf9PoEenfuKnWZZYCd4w//m16mw4m0IJEZl7W
 zu2F83wwxY1Cs1mL5SLpe4BX96DvggSYKtRgMrMxBvXkVZzwdMglWDPbuIhSY81VTNJDn0Dn+
 Qs/PFBZ2bqgY9MeD0ACJaOoYG5OHXYyMBdk0oQr5vML74Ay3NMBLv4o9DAU6cxKvWCh3V5AVe
 BMK7kDn6RJJw8kJRdoDXqGxi6mcSewd0/J1FPiJldkzeRNzRz1uzfRA13AaXyDkF0qstDFCub
 GEQ3jLSi4WrOWO7nRxQyg5MJIsFpDN09FEq3e1sigUWh7We1ApA4fvMvrZqPhRZ7pKyP2+tsw
 z780+yElsMJfT91Lu1SymqDYP4TSiCvYXOG98MS0VnDCEEJIxKTggMCzpLC5GolRNoinfFdWG
 c6ulxocFji1USCFttUrnYPuzv3cpi9nytDchjC2DH3cdCnMYYlTaXV5HUVnK1TkQVaLLrGlAB
 DQ7U16JBfD/RCvUdj5UurkgZnmMuQXnobPWRic6t2I26Xl7WqJbxOwI89383a6i4rQ/zkpEbg
 MllODoOgRWXBYeTNGjh8xbGxBdE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.39.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.39.0(2) (December 21st 2022)

This is a security release, addressing CVE-2022-41903, CVE-2022-23521
and CVE-2022-41953.

New Features

  * Comes with Git v2.39.1.

Bug Fixes

  * Addresses CVE-2022-23521, a critical vulnerability in the
    .gitattributes parsing that potentially allows malicious code to be
    executed while cloning.
  * Addresses CVE-2022-41953, a vulnerability that makes Git GUI's
    Clone function susceptible to Remote Code Execution attacks.
  * Addresses CVE-2022-41903, a vulnerability that may allow heap
    overflows and code to be executed inadvertently during a git
    archive invocation.
  * A regression introduced in Git for Windows v2.39.0(2) that
    prevented cloning from Bitbucket was fixed.

Git-2.39.1-64-bit.exe | 82d088233144054d14d8cc890870544f1ac6ac73aebade87c4d96c97b55d8508
Git-2.39.1-32-bit.exe | b9ac2863b42eb60ee6cbb0663378bb119cb976a52985d4bbe92ad00b073ffed2
PortableGit-2.39.1-64-bit.7z.exe | b898306a44084b5fa13b9a52e06408d97234389d07ae41d9409bdf58cad3d227
PortableGit-2.39.1-32-bit.7z.exe | 2cb1a83f30f0c2948c97d3dc683c8b058c808f89b51bfb813de67253d17caa15
MinGit-2.39.1-64-bit.zip | 000649846ec6e28e8f76d4a0d02f02b3dd1ba19914385f7dead1c5cde25b3bad
MinGit-2.39.1-32-bit.zip | e36dc71d97359f584d25efbdabb4122fb71514bcba5a99df1b82a83cee9472e3
MinGit-2.39.1-busybox-64-bit.zip | c2b54edf2f5b3c7a7bb65640d49f8d7a953145b989125c8749e673d03e2a80f1
MinGit-2.39.1-busybox-32-bit.zip | 4a28a9bd4e49d260ae3c35bf9a2cdb91f12d4a4cf081f21b3df278e76f401262
Git-2.39.1-64-bit.tar.bz2 | 2a33c6fef5ed9d2794013fe965066b80c24b556168aca28c0252c1e11859f4ad
Git-2.39.1-32-bit.tar.bz2 | fdbbd5bcbe00f8981df11cdff87f74440b1a64f40898740559f68e4565555a44

Ciao,
Johannes
