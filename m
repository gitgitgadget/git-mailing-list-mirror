Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C911F404
	for <e@80x24.org>; Mon, 22 Jan 2018 17:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbeAVRKK (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 12:10:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:50924 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeAVRKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 12:10:09 -0500
Received: from localhost.localdomain ([65.55.188.220]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M9ra4-1eX61O0tcO-00B0cm; Mon, 22 Jan 2018 18:10:06 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.16.1
Date:   Mon, 22 Jan 2018 17:09:59 +0000
Message-Id: <20180122170959.12528-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.16.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:smqyPGMDnCaxs2HClhMbfkAptCgrF6+Trzu6SN+E8eibNZMNDAC
 ne+jvG44av/Zq5wmgYzfh5p/vBKzccDw5wAP7ib/vdOxZe/5Q/90TZfBlMjLFn43nfRnkno
 S/fl+20vvQULlOo4iG6ob8Hgy4lEhNrjZ1XkBtKJo7QkMDMxicXvQ/6/Z2z2Kl01oBSnAyz
 nVW3Y2El+fxN027S9LXJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uokQj6W2yVY=:5jHU4VqsJVUKkJ3Nn4u0Yk
 lL9jeGkIODYR0F6qzzpt5U6BZUO2yhyFJSUT+Xzko1qER04Y+tr4JMGZammylHCDXDJdVoviA
 2EI3Tnni30DTQ1b3eGtOvhD5qF2P2SHNI0zzAh3Uh16Vt4+QwWJIOfEKextBqY0kQbft1xaKI
 zQBElf8OA/cOHO7GcaSZE7PsjzKrHSC/W2W3NyuZYSN4Uv6W0oZrt8Kmn52c/dnntD+D2P3eV
 tm5yindB6w6thSfOylKAgqagG0rEPNSn3FbwmgGyh6jnosWAdx0xncTX7GGzrCxfNxjiIZlDQ
 5CCN2p3HbyXHpNbjrcwmRBGH6eFH4rk1oXdM8C6W4XOOWOEffcLy4xGwlE+Cr9wrZ9ydYkaER
 g+kMPKKIks9EniEAE8GVh4SMDdKHW9LRGN2X5vfvIl5SUAgWiB48Ho16K0+RWsseryjMjt/Pp
 z4i747YiAMZlEEYLo4YpYmQ0QCFCxn5CeA4cAalOPuzL33r2o9oIsguxpWZA0FK1VDoDZ8nOw
 1JZukA510Bhgr2dysxbOvGj07SMOW/4wMMM/uybSh8Ubf6Dcy/q9v1p/2NKby9Ofk8CcKNP0U
 q9ZJxDJpfr7Un/qR5yQS4EQ5cWItpNXPUMLNUJb7kRrv8paKvw4RVOfTVsg2QKdPTfYCCN6zg
 sY94+LlGpnOu5BYj24MpjrdhQyqlfKZ0zYFYzTIHlJyQL/NUIQz7rv/KqoQ3BhmncsQwrz7D0
 /x+jWtHGweDScX1NOwNNAjp5Eg2jL35z2yXi29uovf9jjoBlJ0zc28N8Ah/SR0ImPjXg3u5uY
 IFxhKISOGR/Y+tUGRs8KgVYwzJ66vQa5b44Ln2vlmVAozHf4kA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.16.1 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.16.0(2) (January 18th 2018)

This is a hotfix release, based on upstream Git's hotfix to address a
possible segmentation fault associated with case-insensitive file
systems.

Note: another hotfix might be coming the day after tomorrow, as cURL
announced a new version addressing security advisories that might
affect how Git talks via HTTP/HTTPS, too.

New Features

  * Comes with Git v2.16.1.

Bug Fixes

  * A set of regressions introduced by patches intended to speed up
    reset and checkout was fixed (issues #1437, #1438, #1440 and #1442.

Filename | SHA-256
-------- | -------
Git-2.16.1-64-bit.exe | 45ef5c5bd4b89c7d1a0126ecb37cd49f8d7f176458c1084149315bfc3af0eccd
Git-2.16.1-32-bit.exe | 559886de7e5e4edcc3e4c5b1cb766ab90b37d4b7564a61770abdfd3cc84d53fc
PortableGit-2.16.1-64-bit.7z.exe | 657296d33adceb1d7dabb17847dbd9ee5a45c4ef9d8d8aade2bfb42e57682baf
PortableGit-2.16.1-32-bit.7z.exe | bc8cf57a206ca63d92aad649322bcec6600a41b91be61229d9282f61e42834ed
MinGit-2.16.1-64-bit.zip | 14fde7abfa14f505605517b00c8b1bf09eec78e3653516f30dc43084d8df7ede
MinGit-2.16.1-32-bit.zip | 9a37a9dd89add49caee6967e7f6d54182b2f27de7bd4e63e3bd006394ca56e69
MinGit-2.16.1-busybox-64-bit.zip | 21ac64a8876f96af8375b4ab655e669be99c341c1fe5c762485d720886f31b48
MinGit-2.16.1-busybox-32-bit.zip | 158eac07dbd90555afcfb73709a33feffa070db5ae3ff6602bf400d26f326d37
Git-2.16.1-64-bit.tar.bz2 | 7c81ae1be97362a39cafe9377cbb1c681343c24a23c1fe1e3c20fb77d98de557
Git-2.16.1-32-bit.tar.bz2 | 654e88c5a07aa553353cbefd1f1adacff1d8c3caec7ecfbedf3ff7d8bbea708b

Ciao,
Johannes
