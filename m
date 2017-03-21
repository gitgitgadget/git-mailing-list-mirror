Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3442095B
	for <e@80x24.org>; Tue, 21 Mar 2017 16:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932926AbdCUQJF (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 12:09:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:64403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932478AbdCUQHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 12:07:38 -0400
Received: from localhost.localdomain ([37.201.193.73]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MOwbP-1cnLNo1TRX-006MKc; Tue, 21 Mar 2017 17:07:35 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.12.1
Date:   Tue, 21 Mar 2017 17:07:21 +0100
Message-Id: <20170321160721.7968-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.11.0.windows.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:HCsIHDb7HKqqjrPC8cZipJyF0LDnacGXXWfriUxtPrgRqcAMQ4Q
 rTSIpNtMTkjPegnKTgvQghXJsQz1u5w23SCYrQXPkPVUxvUi4yYOuDyR/CqH8WreTb01uKY
 /UBhxXgSe6jB4N12nIiD3/Q1VNhDw5KyWTlZAJMeb6lH6t/yHc9sAjcbHcqeLGc1TJU507J
 bG6sew5BJGRc/bJYwrGnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9CWU0qCTjhY=:wyqmgn/xAAWYrr4bjvNOFv
 XW/Gd7SzvhDErkpxM/xdA6MyfAA+vhXVgPlblN/LxoWEDl6EWrlil3+RgRwUWB5YxgheerI8L
 FeZCoyh8vXDMEruabJktmf318s/79X6Kwh1ymOwKWIY7wizvH2puyyDkNpwkUFQhZinrYxb0K
 D+FmngL0kGxQZO/kzY2VBbTjLkwhTPqb1Yfwh4c4Keu9cFBab1PP+Y2HpR8B/oDUts95UQ+3t
 vcMi4nG2s/hLCtLSdbhJAxluPmPBwYz64rtBN4hEI/Rps9pzC+L3xdsIE1+CZN4THKJwMOp13
 q4En2+4SeCWVfv1hAagQJIN9myhrU96tiLC53wN1zEYzmn80Gazw9kcEr5nl8QuGQtJsYUkbG
 yre1nFsyo9pvOe78dtH0/wuF/9l24vG8miql6otbOhjMZXOa9usAOy4mWZrQ/8kyTckPRgdcJ
 Ux0AaUf2huVfqhiyoj5YJ2ePNKGr1OTp+JpxKeOeOf8miN2S0CJT5kopV1kTjC9cD2Uw7k+P+
 /Uz89yhNUq7FB3QghoriFSULhtYEJVnLIsfMOQ2mudP8+FS9XvP2g6wgib5e1PhCwOFT/vjLB
 WCqYTpH+07yztNmH1LduOLXh08DroZCaGUhyezM82AnSJ7VQk5JTvLB1do5bgSp5mUYqC1lg8
 rUYLravEhHcGv41vS8lqFNM0Q089TgtO4U5oAzBlWlXoow31fYd3uP6Zpa6wfS6XITowta6RN
 gbb4L5PpiEHinDL2MPuZjDCPCzyyaCZ43ewo+l4FL/ZSqEeJ33mDskv6L5/k/N64f8TN8zJ7j
 J3k/ZWCNVTWgqc8yXVuXA7FffXXjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MIME-Version: 1.0

Fcc: Sent

Dear Git users,

It is my pleasure to announce that Git for Windows 2.12.1 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.12.0 (February 25th 2017)

A MinGit-only v2.12.0(2) was released in the meantime.

New Features

  * Comes with Git v2.12.1.
  * In addition to the GitForWindows NuGet package, we now also publish
    MinGit as a NuGet package.
  * Git for Windows now bundles Git LFS.
  * Comes with Git Credential Manager v1.9.0.
  * Git can now be configured to use Secure Channel to use the Windows
    Credential Store when fetching/pushing via HTTPS.
  * Updates Git-Flow to v1.10.2 (addressing #1092).
  * Git for Windows' fork of the MSYS2 runtime was rebased to a preview
    of the Cygwin runtime version 2.8.0 (due soon) to fix fork: child
    <n> - forked process <pid> died unexpectedly, retry 0, exit code
    0xC0000142, errno 11 problems.

Bug Fixes

  * MinGit no longer gets distracted by incompatible libeay32.dll
    versions in C:\Windows\system32.
  * Long paths between 248 and 260 characters were not handled
    correctly since Git for Windows v2.11.1, which is now fixed.
  * The awk.exe shipped with MinGit now ships with a previously missing
    a dependency (this fixes git mergetool).
  * Git for Windows does not ship with localized messages to save on
    bandwidth, and the gettext initialization can be skipped when the
    directory with said messages is missing, saving us up to 150ms on
    every git.exe startup.
  * A possible crash when running git log --pickaxe-regex -S<regex> was
    fixed.
  * The ORIGINAL_PATH variable, recently introduced by the MSYS2
    project to allow for special "PATH modes", is now handled in the
    same manner as the PATH variable when jumping the Windows<->MSYS2
    boundary, fixing issues when ORIGINAL_PATH is converted to Windows
    format and back again.
Filename | SHA-256
-------- | -------
Git-2.12.1-64-bit.exe | 101232d5aadbe4521efec58b8b7f3629775bbc5e1f3949ffc8160033dd2ecf90
Git-2.12.1-32-bit.exe | 077085ebedae37c9cfaeac5a4f021503627e0a9f14f7bc618dadf382ca9bc688
PortableGit-2.12.1-64-bit.7z.exe | 8b0000297c9501de2cbb007f97c69e7541869137a757bba81673685665b7de28
PortableGit-2.12.1-32-bit.7z.exe | 2f9d2bdf52a7a3855d97a8551162436d7b8d153ea2b823d6be67997aad7a1d23
MinGit-2.12.1-64-bit.zip | 28ec1229d344acc773379aa57161fefc4a0834814b09485446bca13b6e9bef1c
MinGit-2.12.1-32-bit.zip | 20d69ec27a10060e9762e85b500dac8b34b55639de08ea617d4ec0937452e2f1
Git-2.12.1-64-bit.tar.bz2 | f9484b49463dde1baf36abc8456dd5cfacb99cbc76977b2bb7abfe173720b09e
Git-2.12.1-32-bit.tar.bz2 | 576d0d5b0f7642015fdebba019bb0a5c3fd03cc04fd0c4ffc1033a96dca26cbf
Ciao,
Johannes














