Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8423C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 18:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8933F20787
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 18:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Tw7rU/kK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504098AbgDNShb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:37:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:34325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504083AbgDNShX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 14:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586889439;
        bh=HE5u945Fc9wCs8xIOsYpO5DAB0zWHCwAEuFxUAHFC/o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Tw7rU/kKC4S1B5VaBR6b4VBXkQ3Zt9slbEJgQnW0jyjbpeFp06ARZOuHVCyR+hYW9
         8uI/+MPMQxEwDH6yu2p/lpBMVhBfIXhB9JNLym5APYxNd6Z/Md2nYN0wE8T3VP3CMf
         fcVeQleF8ryCWwC/5N6+6LXAqeFQjy+T8EjPGgco=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az725.lwdobp4kyyzefppsfilnr0bctb.fx.internal.cloudapp.net
 ([137.135.164.58]) by mail.gmx.com (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MGQj7-1jUGWY02Xt-00GoVg; Tue, 14 Apr 2020 20:37:19 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.26.1
Date:   Tue, 14 Apr 2020 18:37:18 +0000
Message-Id: <20200414183718.6432-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.26.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:Efhgx5oM6JR/zi5QMl4uh+ClW3p5RwNGbgCf4Ia2nTVFXqX0Imz
 9t62z0Aaw9vgt/h0KItCQ+3tk1dpZTMBwaM7DWj2Q/XKZJpbrqBUsSlBrP3AoX8FaSa4Sa6
 iFD/I9ghhH0wlQw4tN3CD3s3egjtWQLzgc+ZXYzLc6b1RIry+Jk+i5vIEIJ36VYlkzJ5ACA
 2yA3wzbmDHtTYVSWT2RRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GE32OuzbIGM=:8hW31BwIieWavNGeP1ZMG/
 +AP95CtGOeElr7MB4iBZMdR/nKO44SGYLREbvs5s7Ams6/j0VTt7RRaAIf00Dwg2aBhSbYXix
 NMBc7sYdhX/RE32Zbsvxq4e+4jtO4Ad+HPitfbp2YLXYIjgfAKrGTe/IpqUlTNe5wVZ8N+Pn3
 /AyvZxe+e1onUFdZj1iCttGqZp71YvxnOaZ+uaKKpe7Qs4x7WXrj2TL7W/uaDy80wKdvfhIi5
 8xzOTdDjrG+7aoxo1dBsj1CRoofcEo9hGtRR0naDXhpWvNzpLL7cFGrPBOhE4wvUz+JiII6Dj
 a73stTdHPTotL2xo1jE8kTa6QgWYo8y5+N4JKBlhKxHERDJ1ruFsj1gxOGU/0lXRzMu8l0zGY
 3TBmuHcEnrD5TDrPPx6vHrsDyqqeMLrZyjiLJH+GfcmVbJWY3LZhaE8d7fPcvXX34NuiiUcOg
 OrPSjjb/AuidExRjdqfOIZDIKbsacm9ABuFVh6qom4Gp2Up2J2zUR2LXekDx1dJ6uQiqiNtS3
 HQnFsikz3w1DfGiidUlgu0scjXtfXQRRX9JccjysfpZ29XHZ3tatkgPkc8gJR1qa2uCORT8ba
 SpYeb9t1COWvT3FTJErFvXGc2cIun7Ao96Axl4ltjH4Wcvl1RL/6Ko5vvkyef+td7Beh653Iy
 9ccdeFBscMXRIFCh7DdrzvqdmfwsRs95l136mjTz0IANpWoCChsRM/nxW5jcxvSn4aIkvSLbq
 i66Q8GiSrs6fUzhCJ9D2yJuDVlSzSl3udUA+savmCJoqWvGiexpPgaNztSOSSpFolbey/2CVk
 AEUauNnzc5sJH5KJzBSsa6LCFE2tzJHWsMGvr4zZW2n7Uc2KpeudK4ehR4zlpRnAkougvqHAP
 McT+XnifR31seJNPdW+7vEF+17hvM3oEpivKo0WtLhZiK+SP4eFi672ewHIHEc80XHnTNtUin
 2lrnkGPFNsRL+JM0EuV0LpIpoFT+kY4WYtnSkXKCuIdCbUUOjjUffHSF9Yx/zWu88fvlj/Mn7
 wla3Ia3vWjaIVf828dY5NhCCzvDyQI1XeGlg2HyAKDCxDiQV7snjWHaw931pHlaBpJS+W8qQN
 14psKK4zkk/qeQ/Gsbp3fq/AKgaQbuEIaQyA6AmBB9kP8uehMq8QUp9ZbkTzC8nmBzvlJqeJq
 OM6eZOq8b0c0zVR79LdzbuGURQr3TxNqMf/2gp9shOWTNRmJUcDcQI3ExZt5trm7WqO5Az1eb
 iDMdupDCfqQPDObo0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.26.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.26.0 (March 23rd 2020)

New Features

  * Comes with Git v2.26.1.
  * Comes with OpenSSL v1.1.1f.

Bug Fixes

  * Git now accepts more date formats such as %g and %V.

Git-2.26.1-64-bit.exe | 2f4595973f188d24a585e70e1cd77749dda05f6429f38ba37e5c4ca6b52fdb30
Git-2.26.1-32-bit.exe | d2994836b3648d4cd8605dffd90ecaebe4b71e9f05b19f742b0ba3cc208a10cb
PortableGit-2.26.1-64-bit.7z.exe | db66a766eb6e832c840ac6f966e95c4eb6a06fb71db7a63117662850efeee648
PortableGit-2.26.1-32-bit.7z.exe | 862fa87cb4c00872055efbdbf3ed0d5e87838605bb0c3024bed3b32acf43cc0c
MinGit-2.26.1-64-bit.zip | ddc2d4a19fab641b144b5ea30845d9b8ef070ba418f2b5a959f47118e1961274
MinGit-2.26.1-32-bit.zip | 127c71b53c1855e7290b1e803ed4d2ff9b80af8e3c13ea2f073523ac5413f8c5
MinGit-2.26.1-busybox-64-bit.zip | a0b1cf280b4b3dd135bda5d65a03eb7a26426838b0f528255ac1ebf201474066
MinGit-2.26.1-busybox-32-bit.zip | 212bfdaa5724f50e68fadf9a06d6c1e90bac8ca6138c3e28a7e3a0a945da691e
Git-2.26.1-64-bit.tar.bz2 | 066c2e88c32d942e32d78aa888559b76ec1785e642b498c6710900026dc05310
Git-2.26.1-32-bit.tar.bz2 | 7c9bf2b200d1f65ae0d038c6801efa410760da880eb1f5e683ea8e1efd288c38

Ciao,
Johannes
