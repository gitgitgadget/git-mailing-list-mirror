Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3DC20281
	for <e@80x24.org>; Tue, 26 Sep 2017 18:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965399AbdIZSO5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 14:14:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:50073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936202AbdIZSOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 14:14:55 -0400
Received: from localhost.localdomain ([37.201.193.73]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LdHqj-1dWgJh2wqn-00iX7F; Tue, 26 Sep 2017 20:14:52 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.14.2
Date:   Tue, 26 Sep 2017 20:14:37 +0200
Message-Id: <20170926181437.5244-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.14.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:1NPDLQTTYx08m6PyQ9lFgMr7UcwYn0VNHvWm1C+zoyw1EzJ8d4A
 pH6NYxKN9pkGYPD5JSarxsfIGV0NnpAHMqO5ReUs6nTPYOyc6EmkpOx7yduq3q0c9EiAnSJ
 EtQItkGkVE5HTPykDPUgDiXFGWHtdREoOpg/agod+CxyRhN30vAA5H/QeKm0YS7m55d057r
 HpCYshcTvwSztQH839/hQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AoNtZ6REWzc=:I3GgplpPIsTbeACyNOgNjd
 8+LeyX06d/oMNR3sNuYyTK5xdEQVsxmdedXGqmauX4aYYgMwuyjIn4vdP0PXOvDynibYrcNZK
 YxbVCF8dA9a0C9j7Vp3uCr1kpBIZ8IuXQoOdxpXUmxrK1Lop7WLarkv3YSDJ4PDm/fLbILoHu
 Ki9eNUCvZyIkLofsZUVe7WF7JsaBE8Md5uGPQWy0h11WQ+vnfv5uIyNVmEoygSzICqZfASzVt
 LmECfj7WZmnON9Inne8VylGXQvv1RMfJ8XKc7K/1xr1i4pL14OkFLrONWtJFg60OaENCkSg1A
 J0n8dRHcUWiLL1T6bZ+/d9wKbQYdbuvrbLLM60FUErKPcuX96j+GfCpLw4x6cCHVNAAN3MsUp
 my7K/143nHl07FwUkPDl/2mVt35kDyj0PaZYrPWCHIs9irHiG8cHJGqoUu+ewD2qiSlE0f0vq
 FiXRsX48aJwRvRJaV/HuwHcHxgi/k96jntqoSxnsKDsqIYMX1QfWkrUjzbdfmAJEbFDBhuksw
 5qUi76cDVg5P93udJpRWZalgOo6flSrESrJ57ErRZGFPbOyxAx6uNh4L1Szl2taCfy13IfaHE
 LccuhQ8d8mEmWoT1W3cZQrM/sQT6XHFNevIitsdko8+sTXmoIPMNBXfCmwtVaRGKZ5KWOKnwP
 c8gwLlUPeUeo8kPvjoLDbclo+nJzgl6mdKbPFBBZK9p5vvGbvcoTmROzeN3j4QkzyTQsjfaFj
 GDgc54qOYgsmMpBMtMQomKTEJEl7m9fDAVLf9FPR1yuwgJL+/rYRVooBSnQh3+RkBC3osxnZz
 JJ9F9uJTsMsIVJoP5CKpe8tQiwAhdajdW7VeVQZ/6DMMAhDA2Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.14.2 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.14.1 (August 10th 2017)

New Features

  * Comes with Git v2.14.2.
  * Comes with cURL v7.55.1.
  * The XP-compatibility layer emulating pthreads (which is no longer
    needed) was dropped in favor of modern Windows threading APIs; This
    should make threaded operations slightly faster and more robust.
  * On Windows, UNC paths can now be accessed via file://host/share/
    repo.git-style paths.
  * Comes with a new custom Git command git update to help keeping Git
    up-to-date on your machine.
  * The Git installer now offers an option to keep Git up-to-date by
    calling git update regularly.
  * Comes with BusyBox v1.28.0pre.16353.2739df917.
  * As is common elsewhere, Ctrl+Left and Ctrl+Right now move word-wise
    in Git Bash, too.
  * Comes with patch level 2 of the MSYS2 runtime (Git for Windows
    flavor) based on Cygwin 2.9.0.
  * Comes with Git LFS v2.3.0.
  * The vs/master branch can now be built in Visual Studio 2017, too
  * As requested by the same user who implemented the change, Git for
    Windows now comes with tig, a text-mode interface for Git.

Bug Fixes

  * It is now possible to override http.sslBackend on the command-line.
  * The installer now detects correctly whether symbolic links can be
    created by regular users.
  * Git Bash now renders non-ASCII directories nicely.
  * A regression that caused the fetch operation with lots of refs to
    be a lot slower than before was fixed.
  * The git-gui.exe and gitk.exe wrappers intended to be used in Git
    CMD now handle command-line parameters correctly.
  * The core.longPaths setting is now heeded when packing refs, and
    other previously forgotten Git commands.
  * Pressing Ctrl+Z in Git Bash no longer kills Win32 processes (e.g.
    git.exe) anymore, because POSIX job control is only available with
    MSYS2 processes.
  * Git for Windows now sets core.fsyncObjectFiles = true by default
    which makes it a lot more fault-tolerant, say, when power is lost.
  * A bug has been fixed where Git for Windows could run into an
    infinite loop trying to rename a file.
  * Before installing Git for Windows, we already verified that no Git
    Bash instance is active (which would prevent files from being
    overwritten). We now also verify that no git.exe processes are
    active, either.

Filename | SHA-256
-------- | -------
Git-2.14.2-64-bit.exe | ef144a5dbb74518b56727f6c228993b9e7f5aedec7bbf7d680dcffb5d36ce354
Git-2.14.2-32-bit.exe | 0c7cf5f1bd6532c3720920b953da6b5c563acab35e3caee0b6f337975e284f35
PortableGit-2.14.2-64-bit.7z.exe | 3d451383519379dfe2f160c4c3a49e4b9e39a666698f3eea2534593cc3fb5a4e
PortableGit-2.14.2-32-bit.7z.exe | 6acd886bb1cebee7b5b607599c8327453110c28ddd8c4f976d14050ab0a17e11
MinGit-2.14.2-64-bit.zip | 9638733b8d749c43d59c34a714d582b2352356ee7d13c4acf919c18f307387f5
MinGit-2.14.2-32-bit.zip | 1c8ed7f54a8d50c84fbc767d97cf35992de42463d9852c56a1f3a3c1ac80c965
MinGit-2.14.2-busybox-64-bit.zip | e6a75e75378b89c4d2e9c89a7cd0b0995ea0b8c2bcd3a93c42d0ffadd17ccd75
MinGit-2.14.2-busybox-32-bit.zip | b0b4d2135ad63347dfd787aa8046a625272764d0a6ea73f4ebd793105d6d9545
Git-2.14.2-64-bit.tar.bz2 | cf2d4ccce3dbdd42755e2e89830a406b9cf5cef6305dc7bf176a4ef5d55cb47e
Git-2.14.2-32-bit.tar.bz2 | 8901421656b6e5215cf4a2f3872de3e6d89aa1177ea3c3ffbed54af292957023

Ciao,
Johannes
