Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A9EC43457
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 17:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD4022256
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 17:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XjXp8HSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbgJIRZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 13:25:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:43125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732515AbgJIRYy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 13:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602264292;
        bh=tFIQrQyuERMP+x0FLUp8B5QS3QXvlQ4JnE08MxeHpsU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=XjXp8HSUeHUXNI32TMk2i/84bVB73oACWp/hTvqQOueiurydih1NNbrTMC37oAtUx
         0tbmBwTCqPv74kaYk3zoToEtG+xO46J11IK58SL3UDVg6RrqpLVM6dIQIXTggcz0A9
         230XahUt3CrleilfNK6ELiM1ZzRkQVrsSwJiC2e0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az773.0kh3nbpurmsexhfal0r3fkdi4d.bx.internal.cloudapp.net
 ([52.150.12.252]) by mail.gmx.com (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MRTNF-1koMHB1xpN-00NQ1l; Fri, 09 Oct 2020 19:24:52 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.29.0-rc1
Date:   Fri,  9 Oct 2020 17:24:50 +0000
Message-Id: <20201009172450.6345-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:ikYVYJ0Y0VTQ66JorwPAVuKlpOqXIOSeOtvBHpO9fsxJZlLJDaE
 0xtU3RWnsne48DjBo2saK7hlM783oPZJDp0v58/GaQOdxJvFHmnHgWRg7rc3RayUZ/Zh0y+
 BPTLxAYs16fjVZopx6E0+zmtlvwQzR/ZgKiRkyURW56ylGQnWtvoghCSQiwmAgHNSs9jbdD
 QYNeC5mH69tql9GYdUMOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yg3QhoEGK10=:bm9Pbm8CUf0W78GeO0aIp2
 QieA1NVPZ92yD6yZa/jINgAV09D3qm7euMIEG4+7JawYtBAMB0tRw6aVvylqCjQEZwBYs3SiL
 tN0vjG6NSJxmm+HG641FDR6RiDRhlXHlFyFpv+JZn/72Npy1OTIQKDYnfpwafwFLROAM8zJzk
 GHhpgc2p9qE9X+Tkg6KoeyFITvyRYPMuAXUlHycrlrDtiZZgUZTgdDxo+E/Kq0WR8SM05U380
 DB+5/WoAZ3Eo1FLbb5aS9f5+PwP4YP9qQSUhM3QKdodgvDknq9WBnmJDN37aYhJc/3eWXIwGk
 fli0oeUx7QT0TGfKaeH7+5017RJwDY/rmZYq+5ImNdkcx6Tj3Bmt1xVJsX4ktVZxYrIRg/nWv
 yI8TMv/nB9ZQDImR728eFVjHKhKs8arcpDAcgxaR446Zg+XWeOFM7XyHNQUsrgc5PptjEbaHW
 EJCr78nSK3xnlaqRUpMMwqgAakwcdM6tA+1uZUFoD2ZxmQgeH1JjOz3pHgX3gzzMpNV18JrZu
 12ADYTPaHKg7psqcb1YnGuE8UfG8/ZNLrOmMlYPhw3hTJ2e8IJ4kG7Y9re0wBv/ihuI6MAy5J
 U65Abn5J+5Eht1n52yBP2IvBadd9sas9sXdPSAMEGqq+LmMdDPqDrIysnDH9DRehojPK2lJ6J
 YINy9YB6xWmux2NwCYLgLUAwLk/rhfGsQ06Pv+oc4L+DOPcOHkvy/de36eCv04LVp3a/6Juzf
 Vh3+CdiaQbKdDPAwGJbZM3XcvjfT0cEgRYZf963O2WCuOlpEXOXTjtb+1+lvfjuyN2UP7VoHd
 FENP0V7tXP07+CeNUFuVPjHQHM6CzcPWIvVqLu7F/tjrz7urzcxxkNFOadVeYQ9gOtumh2rue
 WB+zLdh/cpVh/JaZqEcGqVaOYnYnIDEaPg1ysOQiYef09V7+C8nD3KDIFOuav0JKi1ZaLMlOH
 JEXuNG6YmJw/4vzHgmtNcZd7Kv/btiApzwzaHzn7Nsl0C5jaJnOO8FABzJ27CS7SEtc0gnCo4
 Fhs4Op0PLHRx7L+uERzgHtwbm5MZvMZZ4S+H/tTAArxFIbs4E6jq3BAtmhzdmKE/gDc8C5WIW
 2f3TxfKd3qUnOTBoRE7dSn6bK9gaDQMw/PkQkqqR7zjSnp+t7tY8JYNgKZePdFdIDlnULBxxC
 SkLWRNga7KEhVWux3EWFGncdiBADqKut5PtvGYdeYNGNyOxZ9bTPWk7ofSHTMSJsaEA4FYQfR
 gBpcUnJMXUf6Knzu2/h1wJYh3C+wEvTv1v64+nA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.29.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.29.0-rc1.windows.1

Changes since Git for Windows v2.28.0 (July 28th 2020)

This version upgrades existing users of Git Credential Manager for
Windows (which was just deprecated) to Git Credential Manager Core
("GCM Core", which is the designated successor of the former). This is
necessary because GitHub deprecated password-based authentication and
intends to remove support for it soon, and GCM Core is prepared for
this change.

Also, the option to override the branch name used by git init for the
initial branch is now featured prominently in the installer.

New Features

  * Comes with Git v2.29.0-rc1.
  * Comes with cURL v7.72.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.1.7.
  * Comes with Git LFS v2.12.0.
  * Comes with GNU Privacy Guard v2.2.23.
  * Comes with OpenSSL v1.1.1h.
  * Comes with libcbor v0.8.0.
  * Comes with libfido2 v1.5.0.
  * Comes with OpenSSH v8.4p1.
  * Comes with Git Credential Manager Core v2.0.252.766.
  * Existing Git Credential Manager for Windows users are now
    automatically upgraded to Git Credential Manager Core.
  * Git for Windows' installer learned to let users override the
    default branch used by git init.
  * The installer size was reduced by dropping a couple unneeded .dll
    files.

Bug Fixes

  * The credential helper selector (used as default credential helper
    in the Portable Git) now persists the users choice correctly again.
  * The full command-lines of MSYS2 processes (such as cp.exe) spawned
    from Git's Bash can now be seen in sysmon, wmic etc by default.
  * A bug preventing Unicode characters from being used in the window
    title of Git Bash was fixed.
  * OpenSSH was patched to no longer warn about an "invalid format"
    when private and public keys are stored separately.
  * Non-ASCII output of paged Git commands is now rendered correctly in
    Windows Terminal.
  * It is now possible to use wordpad.exe as Git's editor of choice.
  * When using Git via the "Run As..." function, it now uses the
    correct home directory.
  * The Git Bash prompt now works even after calling set -u.
  * Git for Windows can now be installed even with stale AutoRun
    registry entries (e.g. left-overs from a Miniconda installation).

Git-2.29.0-rc1-64-bit.exe | fbf5f1417554aad85581717aa706ae3576af133f201259624ead248f12fc76ff
Git-2.29.0-rc1-32-bit.exe | 36a1d5258876acdeb4c6eca4a80fdf707ddebbef253f8979d8c7252935bc77f5
PortableGit-2.29.0-rc1-64-bit.7z.exe | 9df5265d082e07b39b86d65530fc545987ac1ea7cb24794ab04444c5129aa597
PortableGit-2.29.0-rc1-32-bit.7z.exe | 08fbb7c1df62da5237bf72af6201b51fd03f8311af9ff8029964e2f21bc1d7fb
MinGit-2.29.0-rc1-64-bit.zip | f5746f9c4f5a9658439c7017b8c38ff272c52f6c6738ac094fc60e1910f19af4
MinGit-2.29.0-rc1-32-bit.zip | 02e44aec2181dfefdec464b51c245092a19e5b44b8d5a1fcfb0fd476d255965b
MinGit-2.29.0-rc1-busybox-64-bit.zip | 936b908c3e96247af686e231171919047ebc619b01d2225225ca2c5a85316780
MinGit-2.29.0-rc1-busybox-32-bit.zip | f39162ab626c4114d25c64c5b4d43977de7cbe76501c79ebc8b8acea36a7e837
Git-2.29.0-rc1-64-bit.tar.bz2 | 873c42a8424f6c148f772dc1949b839822bdb16e2f615edc12b3211fc4a24ac6
Git-2.29.0-rc1-32-bit.tar.bz2 | cd5608154fcdf0198e2d8c8b1e83e76d9e878f75424e58bf9b130e772f93cdd7

Ciao,
Johannes
