Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC41C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 06:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjHKG4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 02:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjHKG4I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 02:56:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDC26B2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 23:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691736964; x=1692341764; i=johannes.schindelin@gmx.de;
 bh=d4hSRnOeQf5oS4XTU6g3a2Pm5Fzon8nYBbbPkWQrURc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Ula0Nid63dOrt634eGmnFg/BZTmOXt2p57vr11FuFM/ZixnyN1IN27lgcBe7OVThyJaFbJo
 r/BP+Lyhzra0up+8WjvqvPQ8qKZ/FOmWFuSamDPJsF7l1MgdQWS2nmPfAXjrWkCC+z8eit5bu
 RNzugISqpc/FkRwKsvkT+LJKeXq5HJ3rE4MIU+BNvf43VkitFHw0tQsqFTNle8FTTmVBSXzbi
 OmsnVXgwoXgC8a0aPiSVE5PcA8OqAchoRWZY9jZpEX5eY9LBMkZPnf1owiglhE2C2ldffl6Ky
 NtdkOoS143Ny7d7kEGe7TmGkIptfN/8HGojDwAanDQdc1OCNE90Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1025-129.u4c4nzxa0llelhrnhprvwb0fvg.cx.internal.cloudapp.net
 ([20.57.76.113]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Mz9Un-1pZCsK417z-00wGsT; Fri, 11 Aug 2023 08:56:04 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.42.0-rc1
Date:   Fri, 11 Aug 2023 06:56:01 +0000
Message-ID: <20230811065601.4115-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:W3NabEJhqNFs6dOf2W1YSLm6gLhsIQLNkVVom8jAa3UJ50CgkeX
 IDQYg3NT/KFjxBgG2dtwfcEdHpkOyas2iUmebiT72U2ttjyQ944xADOvK5eLbRVDBjlPsq8
 BYTl/Q1WKoLueD+v+WznexJ9EEAtop5PyFxLG6ZG9DwqfYojWSjEM0kORFx9I3XrXfBn79J
 le/FzhtwuEqLIVTnPCwtA==
UI-OutboundReport: notjunk:1;M01:P0:R1m+4iATY6w=;lKaMyy3BwTdlvG/pNI88uTTR1c2
 TAZKEIg9B0arjwGsp6YPD2MfwIu1I9SgM1drmarSrC9RMsfp4eP3EJSQRzykRYToNIzazSbZJ
 Rr8LE84aHr9WMDG6On9fUBF8spxXlWFBZoq9fW1UKIxPytvHEjUCvHibY5J7gUVovChZGarU1
 H1Dl8gtsqjt2HuyOcK6LUb1CQGORsRY8tdKCXMm1842RsVjQkpQ49M1FDaLLk54NkMaso98lW
 6GcIjRDKlX0nC/PJjJKTc8hKJg/jCxmPRRB7xn5mxuXQrVvh73u/wAityMRua6Cs/9KH4SAdL
 ZpsTOCZI3rEhQWFST7R8eOR78rTbDbfpOV3OMLi3Co28j5zwZ9i3WfXZ/KA/4oIgolcNAb71+
 0Z4C8U4cWJelbl1Pf6+TDMYh4Z1zmcMdWuZSc2D3mu89HOhhmRQaaKnumV3gZByFDO8fmmbhp
 fLgKxVbBUzHSAM1UmVE0kh+Z2Tn0Re0GHfuUWbOI97Bmz4Q1pVGBYbq6aK3ZSRS8zFLY+EC1+
 t+h+32iDKdWEuBYHL8LtuUFNu60PbvIToRYNibPCk1NvE4j3aGpiJz7ufJuJzgqsl6EXJN689
 MSp5h0cmZ/GxgKKgm8mpnIcmWinK95VgJCQYBvvDkINCHzmcThDn31OvTuVmPzjVCpEVQi6LA
 tSl6lDYNkumBiFZ07qCBMq23cLrVBJqyEWqbsRlbLca4bM/fh1ZEsuoQ7y4g3uTaBmO/JNpqZ
 NbcvHDnYMT4BzwdKEdIVx7h/HdGImghHX+vwvvIslIoW8bhE+mPz9BhPtCmbsrAPdkzeTtvE+
 jd0xP632/XP/7RSCKHz2k2Fakbiq2INpaoMeaQaO7lfICzm6l28uqKmnk2b9bxIh6pR9zmlSf
 utICXEZoXote03TE2umX76DC87CQxzHbXlD1At5H2tBFt8uyH2X9TzSLzexaLpaQYodGo7fY3
 TuV8sA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.42.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.42.0-rc1.windows.1

Changes since Git for Windows v2.41.0(3) (July 13th 2023)

New Features

  * Comes with Git v2.42.0-rc1.
  * Comes with cURL v8.2.1.
  * Comes with Git LFS v3.4.0.
  * Comes with OpenSSL v3.1.2.
  * Comes with Git Credential Manager v2.3.0.
  * Comes with OpenSSH v9.4.P1.

Bug Fixes

  * When init.defaultBranch is changed manually in the system config,
    subsequent Git for Windows upgrades would overwrite that change.
    This has been fixed.
  * When running on a remote APFS share, Git would fail, which has been
    fixed.

Git-2.42.0-rc1-64-bit.exe | 994b21a82f3589ab236a4015c17ba726c4e88d13e0a2d7c0f64c8707b7963f53
Git-2.42.0-rc1-32-bit.exe | 528ea5006d88c741b9420dc25f585bb260fd4eaad25ca79517959c3f41a4d060
PortableGit-2.42.0-rc1-64-bit.7z.exe | 812545fef82b298667fe9bf16265dfa81cfe5837552fc12adade21478069154d
PortableGit-2.42.0-rc1-32-bit.7z.exe | c3112a975750214d62295a031d6d130b3eccab4a6867c9f333424e316c66e70a
MinGit-2.42.0-rc1-64-bit.zip | 68ffdb6473814d393e0ebf8b3c3661fab92c9da27b22a37225fc22e4b0913176
MinGit-2.42.0-rc1-32-bit.zip | 848b9e93e69feafbc7d3ef213357de658eddc424e39e27945ee80340b21718b6
MinGit-2.42.0-rc1-busybox-64-bit.zip | 46af4ca35887c86952831b9ca6e0575c2f90e8e7039691cc15dde6cf9bb12bae
MinGit-2.42.0-rc1-busybox-32-bit.zip | 2eb98594673d5211de7f85f0438e63912c6271ef8b3ea610253219628a0e61ec
Git-2.42.0-rc1-64-bit.tar.bz2 | 53c2175cffc569227d54db263ea417f290a70d36a764ab6c5613ca8e1f32f385
Git-2.42.0-rc1-32-bit.tar.bz2 | 95f99c3e9e8d681cfe11d1eda9654bdffc087a79c2232e90f6ea38b40ed4d491

Ciao,
Johannes
