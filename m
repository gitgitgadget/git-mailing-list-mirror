Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81741C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C40123107
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgLSO5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 09:57:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:50633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgLSO5k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 09:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608389767;
        bh=jSIP08LvxJpmAy9GHOfdmIBS0sd85gRVdROhJRLGkbg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=EnZ0vWy79v/m0a+HGAoZYDKlT6i47L+Acu4Yx+DHEJeLp4GffXODZnBEQpqukcIyk
         9Mf/I2ev9wC7t/aDGjG0MqQN9C/TY2RCT7hn1cE+ZfeQSiQ+oyEIAoQOqk4NO6zEdI
         jmN8ajPXZpHfOICtMBA41IwM0JNss4e9Kyfrzmpw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az767-492.win2iadty13evphfa0g0fnw2kb.bx.internal.cloudapp.net
 ([13.82.229.20]) by mail.gmx.com (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MhU9j-1kCtBk1viF-00efza; Sat, 19 Dec 2020 15:56:07 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.30.0-rc1
Date:   Sat, 19 Dec 2020 14:56:05 +0000
Message-Id: <20201219145605.6272-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:38bQ7k2SFOErhRVqAkzypHbOUEhigSfJYfAAuTbiOsVvCrGK7+s
 uLDFDJw+i40Yc2/5ikLfMdPm9QilkiQl6+Gwmsh29ZJhF7Kt6uUvc0J7rtdI3XQBl6kOdZB
 lPomkOgpbIu7LosSP/LzNCi3+/r4O8XS8HTwPboPVIIZQtxflkENwl9e1/jd2n97QO3XLOX
 6EhlQPhMIRkDcFmmC7eEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gaLPF48wvMc=:LwTGEyrjow2WlfpwszaDP/
 jMmnwsQXxLGtPZJcaVlLNiN66RRrQd8MSvZII1sah/RomDBvcjDiIOJhtLQORHOv2zxDVSNpQ
 h6Wa3qX/Coe6ou4NCX+9jeB1d+840K9oH6T9K61nY41bYzRfAX1Y+8Byim/SEU3pXeQZ22TZn
 r818nqQAhGRNEmVHxnVFmbLZIoDQsunB1M5d2GSINL2okI7PBpplv0rjARefr6VAij3C9OOXL
 oWFPl24qxH6s76RurrL3k+n82RTtYJfyBA0bOh68l9crs5EhQ3UVtg0l8Gtm8PhRF05FYHdib
 1C4yNQ4AJlDGQdKhAaLjvIp0/GtgKyFbRU5SIv50lb6srW3GJZfmDeasCsT54PTAwg5ALh7Je
 6CZFr20WwSa3lLDKL/qk7JjCvkHecMIRi7VgUu/jMOoqoIMQf+cdt5dstDNAogOevw7nSO580
 JipYWCwAMs6sCWjrxZnlsMza5ZxTz6eYWHRICXAIgjo0RwX5GU/hYaZil5JKtHbFtaffVizyV
 O3/kr5YR+/e0BBxoX9GxXToDreI8GRdLCO2TjaMutxio+m6kqK5d7lFpV0NGcd1Ayh6jT1WJU
 F64rJH4hj5uphNrBbBzW4QTHwzPcK9LZBPmtRUgBCurcv73uuzWVTk6GS3bT39/HRs0rgkFiW
 Ok6LBKXhkzUObynaRnandWPmYJ5JuqUm/QwLEewvRLizF/UOuGjEbe7gy4L+59K5E5+L1efth
 Y8qDP0cwZZi1wCZdLJTCir/GESJrQYcGGOTxdS2RXDVAGugga9gXLLiATTwKdSU9Qby4bwZvN
 JI8E6ruAcKdEMNJYxBZ7smlsxe7yhutgqw1rn+L+9FDtfob7d2yMsvWySW0S7nZkws8wA6KUw
 +/Ubu4atB2/MA910XNwj6V8bk86OH+t5ES9Z2DRQE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.30.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.30.0-rc1.windows.1

Changes since Git for Windows v2.29.2(3) (December 8th 2020)

New Features

  * Comes with Git v2.30.0-rc1.
  * Comes with OpenSSL v1.1.1i.
  * Comes with cURL v7.74.0.
  * Comes with Git LFS v2.13.1.

Bug Fixes

  * The auto-updater now shows the progress while installing.
  * The credential-helper selector (which is the default credential
    helper in the Portable version of Git for Windows) now handles
    paths with spaces correctly.

Git-2.30.0-rc1-64-bit.exe | 14430c3a485cb82f70477193267368220aef05a4f10a55d5863393d30cd91bd2
Git-2.30.0-rc1-32-bit.exe | bb8f18ae3fe0f15b779d5bda4bf645fb60552f33827c0ee2e99ebd350dfe96b8
PortableGit-2.30.0-rc1-64-bit.7z.exe | 7543997e29e49454691608e6100615812c6c19e945efc9924049f857523e64b7
PortableGit-2.30.0-rc1-32-bit.7z.exe | fd57c45c0f6645e18ba688c1fa05010687d13f85c8388c20213f17168a63b781
MinGit-2.30.0-rc1-64-bit.zip | 4044633f44ebda10259cb6518b1f51b665064cc9cf00f2ed4a25fba9f4194b84
MinGit-2.30.0-rc1-32-bit.zip | 1cfd59e8cf4767a0957a0d4dba5ca719495165d927d50f0683faa8f4e8811b1d
MinGit-2.30.0-rc1-busybox-64-bit.zip | e4fa351738ec0b3da595daca1322de9323c0cad9f8a0669e3fcfdcee87428c76
MinGit-2.30.0-rc1-busybox-32-bit.zip | 46d3f54e83cab21e4b6f0dffe87cee6ab05f243546f48c110065541c23e111dd
Git-2.30.0-rc1-64-bit.tar.bz2 | 6bde9df69a51f9aa55be301d391a20e6c3fa37b69e700f5905bee6f98f78468d
Git-2.30.0-rc1-32-bit.tar.bz2 | 0a75a23f8b3745f8289bd417ade3aa733b2c9becae70a825970b1fd72eacf1d0

Ciao,
Johannes
