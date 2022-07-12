Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B3EC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 17:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiGLRUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 13:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiGLRUb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 13:20:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729B59CE20
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657646427;
        bh=H5vlmWIU2tXXq/pMzyWbqcZzZiLzlfAT7fvL9lV3pcY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NPJ/bKzz/7ZuWU4b0mQSh+oCa3W6XwHgMJMvpKB6OoLc2WFOw6zCSV5FsPJ0PpuVF
         2AF6ykI4GASipcLvG2ZUmmOM2/+TgHGj58Md6MpInVg78cD9r/HCB4K3Y4p9rGQwhz
         OYsqz+T44QnTjrZ1Y2gANsueB/4JjUrhsIssEVs0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az34-685.2uswmx05xn2u1ig3nhkucl3ete.jx.internal.cloudapp.net
 ([13.65.30.6]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Mlw7V-1nl1Mf3K1j-00ixqD; Tue, 12 Jul 2022 19:20:27 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.37.1
Date:   Tue, 12 Jul 2022 17:20:23 +0000
Message-Id: <20220712172024.4735-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.37.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:QqP184k+mLut9ST+ldKsRm+clrqObQnYGzAyPCYZw9652k71VPi
 0MVhFFuxTOauOr3AjQcNnSexZHOxGP4SkbrIjpJQrtwbZkEJeViVsfIdVW3ZwZArG6xp+yu
 pTToClR2ZIDLIZuBuWd+RH2nwMk923nZ2OE+EDKJ6ac9V9/7lLLbpvlTdhID/Eej74FtdXf
 1eT2/FjnO0lw0/pKI6M6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LBo6GCSunGU=:AEnlM2knAFb1RtRf0R3MoZ
 gKRpuoe/AqmhwQ+CcyJ7VvhVBIuqz5cjuOBSuhHg3z+2feTQi3x59gABsQmc8WCG4F43uveKq
 xOUDi7irQlVidWgaEea9EetzlLhVg9ooslUDmJuWW9dKO5dowebpQ6hjQSRkb1jzJKtLldrBj
 PT5qkF84Vc0PbMGchvjkLsMqP1G5vAHC/WoNMPM12ja0epwMEb0C2zUcwaaCJKz7A68nGYEcC
 89r9lY+ctYDA+IQatExlzXR+tzKklZb4vq9YioFa8hFhZOwEQAuUTfSRtVhfcdYuwebvsVfsq
 NNZc6tYA17WJnBbdP6XUkDOZeUCrcW0h8yqTyqsL+cXt36CKdwRbP/vAz9nsv01IH999iNK+c
 F6yp8RP94vVm34IQFDogIR+0DvocGMXtCdgCkCL5ulRFQJqelaM9B5YksdM7zOOfzgeAXzWdZ
 Vx7p1h9SW2y84YrugIgHz6fJlUJDsX5LGMOxS7vy+2Dy5XqT19gErGghZvl8NHpT+/cxyvGki
 CHCctepa8hM0Tf4cjJPtQtf/4tfQXr+f214WJte6J9dxT2SIYQh6eSSpOk1N2pjRCRZ6bCYtx
 SJq2dwE9BNK9AtAN40+rrdxID3RVMTixF9MUsmlSJ+CP+w2F32O6u5FsBpUkYd/Q0U/xLVFZo
 kYDCndIa644wJFTZ/9+29nXGiVuqyxaDkIXBvoNHAHmMKukMTlq1gzZtyOedVg9WFJVoOW+Cn
 2gUlrZ6872Zn8NoJxxnFDcBv4btqhkEHPgcgQUA/IUCUP8c6mSR+KQo2bU7Gxr5ebFEN8zvdE
 dL/tbjww87GMGJ+DRgzwAS//JLaEDPowDw6B15q8jwnJfFSDFa5dq3ngWmc0vEgRgqlYJNYT2
 S+QX+CIqnuh25v5VABVpilAyLwUSWRaMRwLdwWfxH9MfWRWrhWFM8Ygm+UGOSuDb7U8ZSCtUV
 x1c+pbGda3i2+kENIUwf1eSV3SM2OaCHB1H9d5xbr/j3Khlt01fh5lZGHmz0CoD9RT1QbrnRK
 fZel58M/JozG9AlQq48pr5VngtDkB4wplRc/y0NhESxu73samGjcdWAtb9QteUD5RFPtXcobX
 aLvXtMmAW4837puBNrEzL42jiSOoH3jSMTERAgnbR5M6w8p947Ul4xV3A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.37.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.37.0 (June 27th 2022)

This release addresses CVE-2022-31012 and CVE-2022-29187.

New Features

  * Comes with Git v2.37.1.
  * Comes with OpenSSL v1.1.1q.
  * Comes with Git Credential Manager Core v2.0.785.
  * Comes with tig v2.5.5.

Bug Fixes

  * Pasting large amounts of text in Git for Windows' Bash when running
    inside Windows Terminal often resulted in garbled text, which has
    been fixed.
  * The Perl module perl-Clone which linked to a non-existing DLL was
    rebuilt to fix the issue.
  * The Git for Windows installer can no longer be tricked into running
    an untrusted git.exe in elevated mode (CVE-2022-31012).
  * When running Git in a world-writable directory owned by the current
    user (think C:\Windows\Temp, when running under the SYSTEM
    account), the checks for dubious ownership of the .git directory
    now detect this situation properly (CVE-2022-29187).

Git-2.37.1-64-bit.exe | 1966761ad2c9e4cbd38f9e583b1125949b011a5a250a99d65e9bb21958e6ef8b
Git-2.37.1-32-bit.exe | 714069fe4291c4ca7a51f7e7e81b0c94038590294f3b9e0981456a664c92966b
PortableGit-2.37.1-64-bit.7z.exe | b0bc403bb03326b835e239b3bf7c0af277f43eba5421132dc8531204c78b6b25
PortableGit-2.37.1-32-bit.7z.exe | 1a32f1de26d52ef866f27db395d8ab6bd9dc4c53bfc0161937b20f8749b4d96b
MinGit-2.37.1-64-bit.zip | edacf2d5c39555c25a396e0b9d27182ab5587259dc2e824b4490996b373f9300
MinGit-2.37.1-32-bit.zip | b336137fb286552c5c2616af50c54e9aca7d16a24ec1b00189a6c221a81af14c
MinGit-2.37.1-busybox-64-bit.zip | 1fb7db2cb181ef962e06b1b99c4b254b3ace6f6dce73740bd498d3948189ca42
MinGit-2.37.1-busybox-32-bit.zip | 7470ec55d4ac0ddc3738614dbfe6642770a001b0bae9d3c944e22e25019bf16d
Git-2.37.1-64-bit.tar.bz2 | b1c87e136947102ce32f75ef880ebee79b547f8ef33bb1b5010c3455ac83a655
Git-2.37.1-32-bit.tar.bz2 | b0fef8f618e5e5cdad200571211fb6b42be595ef55bf8b648b8211c8bd5e02ea

Ciao,
Johannes
