Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E7C43331
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0092222B48
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgL1Wzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:38613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbgL1Tn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609184543;
        bh=tdYJCClMVVdOMl7KOIiNljSQsIjcpq5Y964COvSW88o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ydw8Nrmtmq4cOMM+bTe1W6RMmynGcuTofP8NnwYeRmzcERAbdrljQc2SEpzeF54W0
         Lv3PGK17eJQTYp6Auo4CPeM7MeT1NYWnrCSH8BlC+z3yBoB9XRCHozMvniNgop7AQT
         SU0xN3LekqgClNjCpD2mj0xQyUoc+gFzbhjLvyYM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az773-375.h4twa5wwla0u5nzfhsp3ljudpe.bx.internal.cloudapp.net
 ([137.135.127.85]) by mail.gmx.com (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MDQic-1klggT1TVu-00AUrP; Mon, 28 Dec 2020 20:42:23 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.30.0
Date:   Mon, 28 Dec 2020 19:42:21 +0000
Message-Id: <20201228194221.6050-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:vNzVeYMwLNB0C723B8dy3owQKDXqYgultz4nmt7bnabCtMpCXi/
 9LGn64u8tiWwh99/w04jqCUXVI1QndFx8FV7KcwUYPy+jVJUud3qKq4TfSuUcINZIYKFsfm
 CqVoCQCMYvCOvx4dxZuOPX9RlU/zRMGefx29nvWpIJdzoHAGxp1Swan9x0CrBoMK3aqaIey
 Lboym4tqefr2IMVrKQoIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JHcNIrJV4Bk=:cy3EDkWrvr+c7mtH6yVYD8
 c4X2kWDMp5mKNcXX/lx/5SG/NzlmA6jDdcO/dmnWy664whV8OCpLQdqpod0a24YIepRUzAzGT
 J68SqZ5JoRRfAC7sTuVR8eEf6Kjrgv4qrDUM1jLG0WhMxDkpAf8KYvRM8XOdgV5PIs1mZA1H9
 CwfX1z6/KgV5m5atgvQJiU/N70Bwnm2kK2c25gPgflewPyppzOPCCMSUASD/gD418NFumWzWK
 XGHFC1m1brIZfKEerAyGv8XDIgOUCwsefc0gJL/GNw7vfvpkfPUNj49yd4SyUKYM1+cDUKyxD
 m81TYNHylVNEWf06hs1VR0GKQqgjO1m6d/l/oKLSUuuWP5RNJBu9gt4SmuWcmN+K5VdxYEyTM
 D14TUtbQ5Q3W+v8ifqb7UekPhAtqPgJEM7alpicz4F0FW3DhzQ02vIovETty0iPYTP2fKG2JY
 NwawFyviOgOMQL8ZsWLilgYwtA8I62YqNOHcMC2HHiqnBSJ5s5p1+Uk9vWDMgPN00lxz7UaQe
 rPFetcsLQZYBRp2vePUS4MOZ8tZ++IpHd8gHLU99JroZiYvbEtQBhdnOXc3SXkRgZgVQPmdGE
 FlvegZjvt8cZMhphrca3iq/Vzgyql/CamUWhIPhGeKDkrVWUUPCzCAg29uFa71TB1aOsLhk52
 z+UsurI2//BVqB0NeMcR2oqH+LbADquWQp/ptwhXAA3chFspk4WJlxCV0Hn4KCkEgWauCvKVJ
 CESK7lUoHSOaNT+NQMYs5smv23SPhECquSIJkLrhPdZ4Aj/LnTDZhzeydDt1Ijd0/Lbl8VFFP
 CYu4Yixur331fihnNch91ORmB9ziux9L//bCBEFEWLFhs/t2yg6gkOcKWMkjyqp6mM6qDOeYV
 88AkH09XVkjRiC4HAdmSDUb0mpGl+7/6VN2SMyFe8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.30.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.29.2(3) (December 8th 2020)

New Features

  * Comes with Git v2.30.0.
  * Comes with OpenSSL v1.1.1i.
  * Comes with cURL v7.74.0.
  * Comes with Git LFS v2.13.1.

Bug Fixes

  * The auto-updater now shows the progress while installing.
  * The credential-helper selector (which is the default credential
    helper in the Portable version of Git for Windows) now handles
    paths with spaces correctly.

Git-2.30.0-64-bit.exe | 1f38fd19d5f36f1e3dffdf5b233c883cea4fb418a44cc1d980c9f14d284385c9
Git-2.30.0-32-bit.exe | e41b7d0e1c88a023ecd42a1e7339c39a8e906cd51ea9ae9aefdb42c513103f57
PortableGit-2.30.0-64-bit.7z.exe | 6497e30fc6141e3c27af6cc3a081861043a7666dd54f395d47184e8eb75f5d61
PortableGit-2.30.0-32-bit.7z.exe | b3768c64b6afa082043659c56acb4c3483df6b6e884fdc7e3c769f7e7e99a3a8
MinGit-2.30.0-64-bit.zip | 3f1f5e04ac0207a4a0ff3004a221d2122ab495ad0757256c635462d4177b51a7
MinGit-2.30.0-32-bit.zip | ab5342db45a2d1570dd17af330fb830da5cf8304fa83fe0dbbf191cf2e5e2bc9
MinGit-2.30.0-busybox-64-bit.zip | 8c670275422c79789cdc81ae460da532dd7e69c6c9048420a74a38892deeb880
MinGit-2.30.0-busybox-32-bit.zip | baf1d930d0116e66bc367a2cd14a3aacfab1584da4092efc95f39c45e785cd7a
Git-2.30.0-64-bit.tar.bz2 | 52a3a976c01df2f1d9b3bb6d8b9637fce6a30975bf968312dab3febacc3192e5
Git-2.30.0-32-bit.tar.bz2 | 9e59e6fc2f6a5ddb25d170bc52684fde03139fb52fd83271861b36356a6cd31e

Ciao,
Johannes
