Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD03C433E9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBFB64ED7
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhBINpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:45:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:33921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbhBINnd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 08:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612878118;
        bh=w2LVkmNInaBJ5IkOk/X2RjmGnr3eqt1+wCfVe3wrSew=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=br4EatTsPfxSDKeK47aiEYgiFSW3zvi2Wo7KostNCddJAJiptYWcDne/2MHsn00Ow
         DDlrEqJxg/9OrFvLQtN90N6NbOU+pUOJaHvEZOGOKicBsj0fKbOsqNyFxbHJQPxUBs
         ozcCU+toH8c2Wewlzbe3R4BvXd/+BH301/vWsPE8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az53-677.nwdgkkx1u4zu5dacgxidvoho3a.cx.internal.cloudapp.net
 ([20.186.6.204]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1N33ET-1lv1Ng3kkf-013NPW; Tue, 09 Feb 2021 14:41:58 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.30.1
Date:   Tue,  9 Feb 2021 13:41:55 +0000
Message-Id: <20210209134155.6350-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.30.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:ymb+FP3YzX58cWZbz8IDwPP4mrXYspj+XbkZ8ehrAiwdQT/Wn/D
 4bW2tmxRdVc9FO33J3+fMaQeJrHGZDGDftCrYohd3hFKJ75S3QopQrW6TGQ0LIbExwpdYuQ
 BE6IkNiqvRJsGESGp4dJfBBhI68Npt0vTIaFw3RsafMzmL6Ons8xW6ypj1WoiLdWUVEBC1u
 Ha27igsFOeIF0XYF2l9QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MBA67t4kJZI=:B75hW4DmNqd2mLnfPe9UlW
 ECkabMJq9Ob8zFGCtdmx4gNXYqbpW1gYULUWHhkEwo/7WnU87jclXA0F/iobgNzxDdKK+/NSz
 xi89qYkvAYZ/ID9Qe+flSdLRbl6BXcgk1iNTo/r1h8FP6jNHjpweY0wdmwuTGKvUnN5X8Mi+i
 jk9R8HEbBN7iRsEypz0sjbser7Xlyod67DRxlWowUPvlcCYh5zYAxx67aOS5cm1YKPMlvEkyt
 qeJhsXSciyIjQTHL6VJuhAAfLq+R3AxsnsYtRmSSJ3Pg80a/W9lIF0pAhLTzry7oxawrKZvTq
 Cj+TIzrHA3YHGNHGQn4X8HNgqRzb4tN+vBSRaZIlhGnMgzl0Jlc8Atl16Lg/l9thMpxdUaPQM
 HT9hDBpTPMmg0rzg5Yb4Jza8rBIsOZssKpBxf4NvOeOzPzyKfbtVFh2c/LgT6mDLoxLImPB1A
 7Fhp5nUgdSsmirTSNU3ITfnpy2AUFIJJy+SxiYlDszF/aM//y2XNLNi0d/WwyRpDLOrmTV3M1
 8XqspuN/DsMLAEFaX62aQHQkdGy+KYZ+m3/cmAtkxaugWZDy0wGofuaI2a+1Srzq9C/ZronZh
 Cq2fsEDQjeTxu3sJbK0nGj9uktGejX3+Ufkh7HWKLYMKM1HqMj1eGIdPKdggy0u3Oz2aps3QC
 +iJINqLwHWDzwZiIp9tJy8cvwMC/nozJPGHrhOdr9OAxgaRSidfMgC/UhuYdMYhtyMlSBpstR
 9APFLdUREhnP/4u68YUZK5wBGxov1V8DM2W1HO+ReE80HUCX6TSsR6r/mrOc96bbgB9SIz9vQ
 sf+cgRCwkzNv3UiYHP0FB9HLOBPWckblF6Ns7eLD+/aRtK2AK8z8lMZKC7sJfl7AQloQhwAQ5
 KpPdE4BA1FnXH3piiL3MWTUdAY0ZBxQLrxBdzVW+c=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.30.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.30.0(2) (January 14th 2021)

New Features

  * Comes with Git v2.30.1.
  * Comes with Perl v5.32.1.
  * Comes with cURL v7.75.0.

Git-2.30.1-64-bit.exe | f1358ec93e8975fb4eaacbb71e010fadcb097fb00b8af9ab6d003ba69c08367d
Git-2.30.1-32-bit.exe | cd0e3b2f468be76fbf0f1e8b233c97a299726fc20f8122fd992e00097a76b17e
PortableGit-2.30.1-64-bit.7z.exe | 54bb3a0035bad71148fb6c771942a880d46a8dc6f3a0cb42eda88ca1374f1570
PortableGit-2.30.1-32-bit.7z.exe | 931dc2f5495cd41c714c9cfb69288ff9f1026469c291912bfa789165ce9eeed6
MinGit-2.30.1-64-bit.zip | 3c2642fd874c4057267b10161f0c23289afcdd339f7f89a6362a3d2a6397a91e
MinGit-2.30.1-32-bit.zip | 6956ff9418016ee55e822a10a935a430752913fd1ce60efa4fd8ead227ccf702
MinGit-2.30.1-busybox-64-bit.zip | 8ce8ed8d56bcecb9f59acde4396b360ac2459414e9a00dfec0f012ca6db54b84
MinGit-2.30.1-busybox-32-bit.zip | f8b1675e50a9761ee4661ea2c6d4f30e8375b8500c192ba544ea9594b6b82c42
Git-2.30.1-64-bit.tar.bz2 | 1a0ee557fb63b0841e967cf374556eeb95efa0e983f1d03a6f202e98091dfcc2
Git-2.30.1-32-bit.tar.bz2 | 9beae44fdba41ca49f99a5106979e595c89c3ef40587154a2485adc3209e29b6

Ciao,
Johannes
