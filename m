Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0241F404
	for <e@80x24.org>; Tue,  3 Apr 2018 12:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932165AbeDCMeV (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 08:34:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:59331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932245AbeDCMeT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 08:34:19 -0400
Received: from localhost.localdomain ([65.55.188.218]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MY86C-1eyotU3224-00UrwF; Tue, 03 Apr 2018 14:34:17 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.17.0
Date:   Tue,  3 Apr 2018 12:34:09 +0000
Message-Id: <20180403123410.13300-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kY8lssVZLfbm0ZCqa3OaoINPDVEw7FAXAmNj+Eurp0n3CQ5mvTb
 ACP0FvjQmJTSuFQPfDVn/4Uim2RgmS0xOLMB7ejFm8pZhr+Zzl6YSuF61Q1PP0PMF7jKNdA
 LCFVLwAQEm42b6o5Z6lcH3OCdn4y1UBUNuwHG8X7yi+qGTI+f44AKZ8NL+0mn32CL4IiIoA
 v45Jh7OrXo6MF+K8BmawA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8oWrPNUCKVE=:81I0Y6s0boYcRXMoi3OV/k
 lkJkhwW5gshhLGqQrgslrY18hAcJMP/JTbWgOCsS/fEpqFwllG2GCndyVhgLyEXUPH6G0Izsb
 SXYGopnjt5v9sV412pmlzSSsBk1O+LBf7gtG9wPQpgWwfTOKoLABe/PSG60Ofj6C9Pb0YvKu0
 NhrtlBQCYuP9+tZkrHkCFo/0FqfFwjVgEWcSKj19qVd6FyigQSUJIwJrlF/QU+C/hOJ1xGX6i
 U19xUfrXOm7+vvGRJrpEO5YSEfJXRIo/NtT3XIoJtJc35/y9KJ162WpUprjzHUAUkea3qo0fg
 egJjiXWt9EBeE2GeA5hb20tLF7vsGGgsn700LhDLB6KJqkj624hg7lX+T6FYKC9G/rqEIr8V9
 FwLX6OiRG1YjvL0wnxupoV42+uwXrqaJueGekFA9nSR5y3JS2JI8VHj9gIQN7ivzH4ZhCLj/W
 +a8PBSefGEbQd5gqaJswofLj/uTIsHv/AXeCNhr1y5ilzDIN6HnEnSblq8lS3fNQ30hsmNPlx
 /pU6mbeE266r2qxHoBsyx1wL+j2IVjEB4bCnuRVBGSDSpXcZMo0zilewjLimCsqCOIW+tDgKt
 H1DEFFx4xK95XrhrqBq8MyDe8P3j0TB+xc5WSp8a/UbbGKlG5ZX4pIDcwRAr2zuTLO7A0qlY0
 Q8QsI5ZfL717469mxI5kdNh8y4hv+g4mu3D9ofbiBtaPYnarJmX3IYWHR0cQJnnonWOIu7vPl
 u161Tl2jLUR+lMb5+km5pS4OrUbCOskyNh7XukIrk44N+ytQd5flKkxOzDnkHOzwRZWFJeGkh
 t4JKBzlPS1IOgIURcaWbidXfexFOxkWeO5+ybQJQ2oS51ClQ+A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.17.0 is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.16.3 (March 23rd 2018)

New Features

  * Comes with Git v2.17.0.
  * Comes with OpenSSL v1.0.2o.
  * Comes with Git Credential Manager v1.15.2.
  * Comes with OpenSSH v7.7p1.

Bug Fixes

  * When git.exe is called with an invalid subcommand, it no longer
    complains about file handles.

Filename | SHA-256
-------- | -------
Git-2.17.0-64-bit.exe | 39b3da8be4f1cf396663dc892cbf818cb4cfddb5bf08c13f13f5b784f6654496
Git-2.17.0-32-bit.exe | 65b710e39db3d83b04a8a4bd56f54e929fb0abbab728c0a9abbc0dace8e361d2
PortableGit-2.17.0-64-bit.7z.exe | 9625365ccb67d1c7c52f14824c5dd68af4cca2a1b83a2ba998ba9ba45b708551
PortableGit-2.17.0-32-bit.7z.exe | f2344ec1bb2d87a1ab7b05bd2e7bcbbbbf4de6ae8a6b1dc034b9de4b3a1f0ec9
MinGit-2.17.0-64-bit.zip | 14c780bfc7af2bb85f6860fd1927402c87393201b7639e5bc3ce0fdc5688931e
MinGit-2.17.0-32-bit.zip | b1896b23d0d7ab7c1ad6705ce760763ae9802cff2d2e0aaee141806a2a319c4c
MinGit-2.17.0-busybox-64-bit.zip | 6f4599f367f784087e96f5c7689b2807718d7f75296e2beb4280a0fc2fdfdc1c
MinGit-2.17.0-busybox-32-bit.zip | 3ded3fc7245fd026cab3ef05e9cc867c138e3e858aea42f68369a0e0aad1067f
Git-2.17.0-64-bit.tar.bz2 | e5faf8e26de8dcc57b3848793e754fa1d16253c0ce66b12bc3afa1091284e6a3
Git-2.17.0-32-bit.tar.bz2 | d589200952debd3848602ee1287075428c096a8d94776090641645a858d020ec
pdbs-for-git-64-bit-2.17.0.1.e7621d891d-1.zip | dc387ca23b94170832a9894d5812e4ad31c56552e4f68de154491dfe3d471a3c
pdbs-for-git-32-bit-2.17.0.1.e7621d891d-1.zip | e1c4478b2874560df3a669f15b36360fffe556e8de3885d3cdb96202947dba7b

Ciao,
Johannes
