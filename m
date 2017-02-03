Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56E51F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 09:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbdBCJTo (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 04:19:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:58261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbdBCJTm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 04:19:42 -0500
Received: from localhost.localdomain ([217.64.244.213]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lug4m-1cQstl2pCy-00zkMP; Fri, 03 Feb 2017 10:19:37 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.11.1
Date:   Fri,  3 Feb 2017 10:19:21 +0100
Message-Id: <20170203091921.4520-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.11.0.windows.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:U3p5TRHGS/sANQG1cCfBjp0iyEl4R37f+1vVZihMnKNmWanwPA6
 EW4x5eXxrgssXetM5q4vbyXFAF/vGj6ovnqOpERd0kfijW1M2J2gA3dLVt51GeCRzZZy/qa
 dSeXqgpjNBv0ZFArmVRJ3YPEJh+KlSJAa5BEKieV9iIaCf9mwULeWzzeavctOZdkVjY2rlZ
 fRJIgQcHQq/ufE0C8vrwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QbqRJ+Hpsc8=:JJ7xFblLgR1avy4diXcWNu
 bF/x542/6xQPPwU4fVNFmjvssCP5dx4N2gZraxw0FNTOqFbXt21I+1YaDxKVP9H+WI53XEgl+
 urkyAAKvRp6m5aoaerguRuzfPpyDgIFVEYAE2fdHUSQwVcvWAV7zuN2aCYbLLquOs1glBaVuF
 pmU8WfcazCbiDYMN7df43kRbqajV9csCckV7Lk2Fw4PEWXlDaqGweIsI1g9qMQ4HACU84XIky
 2x8ySk+3HU6SjmBogaWoriDn9IbQ4VQ0dzGoWtIiKVPqxnjT3HGCNVlUd9cEMPmr7WKx+qFgw
 qaxD7ST48ONE9mURN+3gziETxsz6UjNBfd0rVFVqHOiQSDWkVR0FP+v05mcWk6nPIFP/M5fpw
 JPZLWtao8N9ZastIBFLr7F9tjpcCMt0ZcoTEGGrvNTvG1MyVrTaN5bXoxo1wMFj/qsx+rsnvC
 75jRBni8jijpFCUeQI0TvYswuAMgk2XSUnMsPD1HkzUV7aD0t04tUhJTFrWHHm9f7ZacaE/rG
 Ztj5huqI9IiPOZ/VYNZKg6wZRuxI4aLgwkDhhHQ/0+vrlRx1wkXuFdZ4YdqTR6dDF2DkkByE0
 /qh5Zwkapg3AC9MdJm7n082rYdeDwmEIOr1aZadKYVh7kz3GX9St9LAF7uqE0wdtMeLwAPopm
 NHnXolr1lawJgIIPtYHsgZeBuKaR4K2HCTbiPJ7/n/iyMNMC5+M8gfIFFRhZlYJLE4RXT6OSL
 dbHi0yN+8zslPseKel8HDdcghGo2lnfyvCOofWVfYd4GUIrV1b1OkRv1zTyKQQmKnZeMBTA45
 h6l4kGx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MIME-Version: 1.0

Fcc: Sent

Dear Git users,

It is my pleasure to announce that Git for Windows 2.11.1 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.11.0(3) (January 14th 2017)

New Features

  • Comes with Git v2.11.1.
  • Performance was enhanced when using fscache in a massively sparse
    checkout.
  • Git hooks can now be .exe files.

Bug Fixes

  • Git GUI will no longer set GIT_DIR when calling Git Bash after
    visualizing the commit history.
  • When the PATH contains UNC entries, Git Bash will no longer error
    out with a "Bad address" error message.
Filename | SHA-256
-------- | -------
Git-2.11.1-64-bit.exe | 2c6408f98297b8f4ad0df36f3aabab67164b3b3d7bb3d91d49f237aba566f8ac
Git-2.11.1-32-bit.exe | a556c6f65c13f54dcce64df96bbc94a156bb7c9025a27cf0caa329648adaac06
PortableGit-2.11.1-64-bit.7z.exe | 47058bbfb815ec3e9247b96aedcaea21df58db59c3a73594ffcbd4171ac2cb11
PortableGit-2.11.1-32-bit.7z.exe | 2f76bed9b649d990cf6999674e11e6cf5d502d25b89072b34c984f6aa86dafbb
MinGit-2.11.1-64-bit.zip | 668d16a799dd721ed126cc91bed49eb2c072ba1b25b50048280a4e2c5ed56e59
MinGit-2.11.1-32-bit.zip | 6ca79af09015625f350ef4ad74a75cfb001b340aec095b6963be9d45becb3bba
Git-2.11.1-64-bit.tar.bz2 | 06b066c7a3f1934d96f2a838b64cbf1aced8578e5321bf6ff0e7bd65e6c34988
Git-2.11.1-32-bit.tar.bz2 | f06e3d78ca25ae8def8dac3e584912c74d0d819966772dfb965d78e1e462f0b0
Ciao,
Johannes














