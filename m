Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9561F516
	for <e@80x24.org>; Fri, 22 Jun 2018 11:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751206AbeFVL7X (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 07:59:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:43823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbeFVL7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 07:59:22 -0400
Received: from localhost.localdomain ([65.55.188.218]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lck9X-1fwHcd1yVz-00k5ze; Fri, 22 Jun 2018 13:59:21 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.18.0
Date:   Fri, 22 Jun 2018 11:59:13 +0000
Message-Id: <20180622115913.14184-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.18.0.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RIv+/FbAaFoqY37MtRXl5iOfcEbMlbDmz0xe1nIDuoQR4INGN6T
 KcvJlZsBTa7MGOu0hdA+hMWB/Seaxib7pi1jzNGAOsFB3jLrWZ8xaFPnUfXqzwRFs3adaSB
 +gzrRat3jSjjO/mI74vFCox/Ty+ClvU/V9dRmJ8UklEHXKUNkWuS4gBC50LIPwM75Y+A2So
 p3afJifdLGF2hGLr/fl1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SXs946iiw0g=:MuXcbWsw5ATe88r5Y7z6Bz
 +Nr2b6iyr3sYn569Eai0qRMeRGt8lFajeRY6nZtY05/FV+9QPPMweMZ3XpUhgfBn0w1H7I5o3
 82v2vWUH16eXm80+guxtX9Wz/bhJ01YVnpgp06UCD4Y/AIk8I3LUxk1+mYXkFmpsdVjQKtZd2
 i7dERT69GpP4s0LjwHcC3r1zF1jEBIQYAN27cj7sZm7K/TEplX4IasClBOCwh09JzYCyS1CfA
 s7S0tXI14gZvxWuEVUo8lf6m/WtCaBiwS3vm11kv1YZg8W4O9WtJj26RxPyPWU+JAdDNN9+UE
 WS6LQaEsXofHe84H136yJKMP34F1mHheJX7a5w4EWuO5+vAhd4fH4QddmgnXUjqabWevNW3yv
 belxp5OwWlj7AWhildjSu4Bjvs/J4GHce658tUKfA6vQ6WNC+el2/s3YjxHhEJrEB4Zlylvd+
 Yjnga41kGzUTczYfpRKoMUA8Ip7hEzFew5jGjCt2eMb8d5yoyZ8keSOhY1oB4LQ5IYM1QlBvg
 Y6kKCG9ChP3LDT9HU4jthvphzfiq7Um0dNsRZ7PUgjeYVkLVWiCWXhyNkLpkgMUwdZFcnkB0x
 S+6I/a9OdTr5SD3U/q5P2N7SKLH+ORbBnbHBuM8wPQcmxeC87eIgg4YqnRZMvLSi4vxqz759Q
 12cnDr39f8QqxcQ3Sz3M87Zc8hPQJWdcmxXOgCUlNSsQinwMTLVNpnsjxCmfbJRMcb53NhPx+
 PIyXgBNSpkE6rlLdcKdxbgDVYLqH0ls64Z43HgkYT993f0yM4Eq/Gyx0OWRmBM6wwAbATC5ZT
 kppyh9Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.18.0 is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.17.1(2) (May 29th 2018)

New Features

  * Comes with Git v2.18.0.
  * Comes with Git Credential Manager v1.16.2.

Bug Fixes

  * The diff filter for .pdf files was fixed.
  * The start-ssh-agent.cmd script no longer overrides the HOME
    variable.
  * Fixes an issue where passing an argument with a trailing slash from
    Git Bash to git.exe was dropping that trailing slash.
  * The http.schannel.checkRevoke setting now really works.

Filename | SHA-256
-------- | -------
Git-2.18.0-64-bit.exe | aa81c9f2a81fd07ba0582095474365821880fd787b1cbe03abaf71d9aa69d359
Git-2.18.0-32-bit.exe | f4e910eb5182aefada20226a5a0a64b5b528ad1439c28a47c25252ee27f71af0
PortableGit-2.18.0-64-bit.7z.exe | cd84a13b6c7aac0e924cb4db2476e2f4379aab4b8e60246992a6c5eebeac360c
PortableGit-2.18.0-32-bit.7z.exe | 28e68a781a78009913fef3d6c1074a6c91b05e4010bfd9efaff7b8398c87e017
MinGit-2.18.0-64-bit.zip | 1dfd05de1320d57f448ed08a07c0b9de2de8976c83840f553440689b5db6a1cf
MinGit-2.18.0-32-bit.zip | c2f59c121d0f5aac31c959e5ba2878542b6cbca6604778566061d45585e70895
MinGit-2.18.0-busybox-64-bit.zip | 1a34608fbb82f607924d21ac2737c189a250fd9c6f4255a939e55c7fc3b10a0d
MinGit-2.18.0-busybox-32-bit.zip | 6a667b03bacbcd2627e4e9a29a222c1ccb01c340bc721352afd6427f3621945c
Git-2.18.0-64-bit.tar.bz2 | 120b7501b5563212f1ecbcd8fadac257e510067e0297ff844bc3b18d90eefb96
Git-2.18.0-32-bit.tar.bz2 | 3eab2705622b7fc5b49e4195e30fa92162ad4924072d01ca52abf0d7134d356c
pdbs-for-git-64-bit-2.18.0.1.cd1a74fc9d-1.zip | 20fa4809b19a346e70d76066e98b76ca42f8364fb2997f3922abdb14d6321c56
pdbs-for-git-32-bit-2.18.0.1.cd1a74fc9d-1.zip | b410397e237277e2ae1c22207190d11ee2f137e986baa15dfdb8dd92f0285120

Ciao,
Johannes
