Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E04920899
	for <e@80x24.org>; Sat,  5 Aug 2017 23:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbdHEXAU (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 19:00:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:54204 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdHEXAT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 19:00:19 -0400
Received: from localhost.localdomain ([37.201.192.198]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MSp1l-1e3fIS0qIv-00RpIT; Sun, 06 Aug 2017 01:00:17 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.14.0
Date:   Sun,  6 Aug 2017 01:00:01 +0200
Message-Id: <20170805230001.3232-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.12.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:CPIeGoWFdBU+J6oQcVrPToRoxdl/iNFFOs7NHyyV5R0q0aHZ7Ek
 XQ+qE3Bgog2pmoXu1WEriwPlXmkIpAi3BOSOlQt7wmi2mkz9h0ZrrWfJiiipmSPrQcilVKq
 S9C2wVRN9wF+iXBNkl7Hk4zRPF62iWdg2qchcAcNeT+f2NJbXdqwJoebPgOjLLIHlaxFoN+
 Pc+bB+DEqw8uYzZ/Ste2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0zZnzVwHmuw=:mkgpUeN+LmtEScHV9Qu4i2
 WhCIBnEpJPk6qwE8o8IyIdpOYgpIw438sdRho6cpLlXp291h6sAD3W/uoAJ8jp5HRCamCCv1X
 UOe4cj+e5hLoG5+X/zb6lKdPTutr2OWBEZ721MHEqcUacqEbKML+MIbs4uBWOmveyj3gL9L4G
 ei9cI0i6c4dQTGrphs10aVfKJFMinkvlUB9HBJycsyDw0QWD/zgImxVYs/FwqOEzEWpm+bIQy
 pKSJxnyjTOgVkFai5m43YBlxx6EnDPUeBc4SX/ZcXpuSyx1O/z1CjWfII/0KUqJ65WD8CaBG/
 dWl6Wqma8OVpuOjdeaDpRx+zhb7OO7QpeJA2O+pTqxTL4Wg+2QeyKac5Jq67z1LoDAQgC7V7W
 slnWITFHKeNJYt8dW/oyYZ45QOwDoCUSNUMN9daUhZ4sQGabPzJ6LShziAypvQJUIhBPmZGsF
 BuR/JizOMRaX7XP7c7xcA1MRN+ZRagC1q6O2dxZSmgxJyY286RCOUTvh9z3mzWeGuYiihJxCh
 Ey27EMM9AtLN5Nk7QL+zUuxy0Ko9YyRWFxQvZwyfv2ovvjy67VU6PlYfV1o5wIc0xqrSg7b0/
 B+YiVIXctKSM5cgX7PcUo9/fytctVnpdtwbORkPAO4SDnE9SIxc+vMDOlATPkv1ld8S9fG6/k
 laYcrkuD3Z5MrmWlqV5D7HNFH/VHPXg5qTMd5vGkfmrIR8/VUnJtyIYldHSbdg+T3Rr+u3LsM
 vNV4gp5q8996BaHYNyyO8X7yKg7G6tztzQdDJcECTrr39JdLIWuezj9G7Gbc63bimwwt0KAHm
 jGTDcsM25EKJLyLQ/Z1bO8244gci/eKYd1/zGlx8tgZpI/448A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.14.0 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.13.3 (July 13th 2017)

New Features

  * Comes with Git v2.14.0.
  * Comes with [BusyBox v1.28.0pre.15857.9480dca7c](https://github.com/
    git-for-windows/busybox-w32/commit/9480dca7c].
  * Comes with Git Credential Manager v1.12.0.
  * It is now possible to switch between Secure Channel and OpenSSL for
    Git's HTTPS transport by setting the http.sslBackend config
    variable to "openssl" or "schannel"; This is now also the method
    used by the installer (rather than copying libcurl-4.dll files
    around).
  * The experimental option --show-ignored-directory was added to git
    status to show only the name of ignored directories when the option
    --untracked=all is used.
  * Git for Windows releases now also include an experimental
    BusyBox-based MinGit.

Bug Fixes

  * Repository-local aliases are now resolved again in worktrees.
  * CamelCased aliases were broken in v2.13.3; This has been fixed
    again.
  * The 32-bit Git binaries are now built against the same dependencies
    that are shipped with Git for Windows.

Filename | SHA-256
-------- | -------
Git-2.14.0-64-bit.exe | 89799b4474bb62b2a266ed52fbe2f1e5d78598af61a7ef62c1ef94e2ac8de863
Git-2.14.0-32-bit.exe | 74e5d76e6297fe1243d9a3e015b659bba032eecc1e538735b47e48325428e156
PortableGit-2.14.0-64-bit.7z.exe | 7188ac81c9c48c8219355a0dae68461f99bab1976e9a5ab81b10bd994a83334e
PortableGit-2.14.0-32-bit.7z.exe | 02e5d5f1bf611b6e0049743d4adf5ea7f4fb060e29809068cbba3b410632e01d
MinGit-2.14.0-64-bit.zip | 56fab49a484bec42b733b2ed6335803fd2c9aa2a4cc24ab99863f543b764f507
MinGit-2.14.0-32-bit.zip | a886cbe1d2c9cb5e1aa3e4ea92ab34878e101de3a3e2bed7f25059d376ec4eaa
MinGit-2.14.0-busybox-64-bit.zip | 6102ac14721b79d5f950924cd6938b9d57d8cabd6b29e5209074c98b9ff1698f
MinGit-2.14.0-busybox-32-bit.zip | 28fb513ad3891fb5d8f751370adf0e63b7c0d1f7b400260e07957b9d32767330
Git-2.14.0-64-bit.tar.bz2 | 5a25702165218491fd6fc13e19016ecf0a7b703554194d14e817295c93b80be2
Git-2.14.0-32-bit.tar.bz2 | 64baf1e284ecbbab38bc287747c6b4d76c5ef70f48def03044b440d24188a919

Ciao,
Johannes
