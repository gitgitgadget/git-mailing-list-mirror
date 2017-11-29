Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E5D20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 13:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbdK2N5d (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 08:57:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:56733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751486AbdK2N5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 08:57:32 -0500
Received: from localhost.localdomain ([65.55.188.220]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LyEUz-1fEICC2VZF-015ZDP; Wed, 29 Nov 2017 14:57:30 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.15.1
Date:   Wed, 29 Nov 2017 13:57:23 +0000
Message-Id: <20171129135723.11664-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.15.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:gNt0MQKpkgXUxP2WDOTzImQsDUUNVcsM4TBq3+8bCpcZtPtFunJ
 exqi8YlFLDyCevnewTaA8qWTxtnjXJb+v235mdDYKkWw2dzBv7KlbWzKejnzZe/97J7UUr0
 WKx9wHaJssb01Du9szmJ/rjLUh4SCwSeOHj4wn4KbPxZeVEEEn1dp5oaoEkFKsnWP6LpzDo
 423oOEIc7CO81KP/wKLOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dG0U9v65/VA=:onmRJBknyTWeb+eyD+2xmN
 MuXQHHhPVw+APJQf8PwGVt0zw7/SKYt6DLTI84tK2xU46uxuyMiOgcq1S8uO3zFqowI8JGmwA
 /IaJy2MvapGgjA6qQ3Te/0VbmKzmLeeVcip6WEO0yBZuRba+de6h5668xtARoafZRG/KFF8Mj
 fTdkO9yC20zsYj3wmrpNUC57daOuBYz7SchQYI4OLmLAf1zQnW7tN8+bptVJoHFFMoq0ZhVYQ
 LG5x7e/5y2i8LJOE9mAFqbJnvF48BdCHfsV9OEqPIAGpbj77XNby3MyRQS/YWthfcFgoeuhgR
 xM3skvQaVK4VwnvRWjbjA5nThDY+jdhW03079tbGuaCn8u55Q9cIk4kjT4A2EXDgEkc5vXYQb
 71t6NGg5xpSbC3EeuEq8BfhtlQYW0rDn5IcEzvwHMCpL05RuUuNyIi/WyG42DI6pJWrT+49y3
 OulmQvCkNJKVOUoZKtltTqtzO9twjvC+vLg3r07F0bcPTAamZkiczKao0oPkq4M89HvRoyYo/
 EqYQxATVVY8t1pWbwuX/vXyUx/aw3TLwKBqfC+bHEblgaNk8MvTB4YXNo0Pf9qAE9HMEC7rId
 87IOC0rai4Ia45CHIPDUp0QUOjM1rISazeKHAMmMryLWI4AeHcW1p2cYNM/ZCRquLF22ZSETa
 hxaO2JpK17HPmnUwDJzAP7npDZq/HHCAelcTOYvbq5O/O1yulXERIAunZHa7O1X8nieCvBJfx
 tpfouQJOs9x61+TSOIdFmZXXBV6dkPx2duTtfzIoWooWcAESx/yp+XZ7VAhOyTtiufRwNsezs
 IKX6SAiruOjwZ3uSetVMPz9Fox8HgkNSqjZDZkDHDdxUVr6LDA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.15.1 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.15.0 (October 30th 2017)

New Features

  * Comes with Git v2.15.1.
  * Operations in massively-sparse worktrees are now much faster if
    core.fscache = true.
  * It is now possible to configure nano or Notepad++ as Git's default
    editor instead of vim.
  * Comes with OpenSSL v1.0.2m.
  * Git for Windows' updater now uses non-intrusive toast notifications
    on Windows 8, 8.1 and 10.
  * Running git fetch in a repository with lots of refs is now
    considerably faster.
  * Comes with cURL v7.57.0.

Bug Fixes

  * The experimental --show-ignored-directory option of git status
    which was removed in Git for Windows v2.15.0 without warning has
    been reintroduced as a deprecated option.
  * The git update command (to auto-update Git for Windows) will now
    work also work behind proxies.

Filename | SHA-256
-------- | -------
Git-2.15.1-64-bit.exe | a2ba53197db79b361502836eecf97f09881703148774f9b4e9e6749d41d4ff71
Git-2.15.1-32-bit.exe | 73154bdfd1ad4ced8612d97b95603ff2b2383db9d46b4c308827fb5233d52592
PortableGit-2.15.1-64-bit.7z.exe | 94d485454af33a32d08680950aaf38f0825a189ef8b617054b81b2c48d817699
PortableGit-2.15.1-32-bit.7z.exe | 7d804748a7de735133d78c5420d9b338379123734509415035593e106b03515a
MinGit-2.15.1-64-bit.zip | 5e38d13241b0742e6673bc5116ac82e851dd1fad01c660c943017f4549b6afea
MinGit-2.15.1-32-bit.zip | 2fc85f67cabe3c13aceb6868b4bb6bda28ddfecd6f32d7e0da9ddce8cee9b940
MinGit-2.15.1-busybox-64-bit.zip | 02611486e3c8c427f09d2c4639484cd604ea812471248ae928960f1e0dc59633
MinGit-2.15.1-busybox-32-bit.zip | a6dfb770f5cfa7b120ba49922d3434577b8601c5d322ad473dd2e2adc91e92b3
Git-2.15.1-64-bit.tar.bz2 | bb630e5f3d7b650db67134b0187cf0cb8f5ed75990838ee65fed85e21777f08a
Git-2.15.1-32-bit.tar.bz2 | ec3938e161ac1bbcf2b4f5d41fae1c05ea229fa0276b4db8530ec50b69131832

Ciao,
Johannes
