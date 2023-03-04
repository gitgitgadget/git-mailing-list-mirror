Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E5C678DB
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 22:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCDWVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 17:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDWVP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 17:21:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A7812F1E
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 14:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677968470; i=johannes.schindelin@gmx.de;
        bh=UeMCSpZ5oQCDw/pW/okqD3p4Y9AooyRb3HZtUTmSJW4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kLPTv2ai6QTLq0BrMpQ4vko7obvsZkPUnFYL8NbPxoZSddcwzBDg+hNB/BG+v6qtn
         NnFMWIStV7sGRsJxXugERaqNkAqF3BgHz6mVr7CXDLSu237dVyJgF0FwXkyQiFfdGv
         fEyfDV3Ed+/exo+V5YIWGICT7/2oj8gOIXQT6ZfXioKarLWu5Y8bmd5+jDPnzK+Az8
         yUuTJywGQQNTHlHC5r8LYK0yxBhKEiZRdGmuDIz3Obj+6B1KD366a/3M0heyQhyNY+
         RcwTgi6YE9YBicC8szsZPEUKFm5bD2EKjJqUuNZ4U5EjiFj41Mid/qULLY2Tg3Yvwm
         fvdyVluA3CRfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az193-883.nrc2ynj0rd0exph0lb1os4zsqh.jx.internal.cloudapp.net
 ([104.210.132.80]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Mlw7V-1qFemE3bPP-00iyOM; Sat, 04 Mar 2023 23:21:10 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.40.0-rc1
Date:   Sat,  4 Mar 2023 22:21:07 +0000
Message-Id: <20230304222107.3524-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:tYVnMb2HoopN8IYpFGQDQJVYugLAHafBq3qKXd65mN56mY26K/h
 V+75nsZS0qtKuiTaeAvW5DFucZSLUXSTwyc8rNsGU9Z0XMbYikMVIFoqpSuUVv+zZn262EZ
 xRRTNBL72ZK+OyM8McCk7g2eAdUwSHJVjrnfLQwV7miMKQeBKs87zw9HCwNE0hwSYopzi9T
 FG8bbFUVl70yWSwxKfxfA==
UI-OutboundReport: notjunk:1;M01:P0:idlK12GzQuw=;pS6H63Sjt1KOHQcwD9jF5kwcAD2
 ReDwP2ukdvUnmdY1bj7pBf4Ul0wALh9InVRk61SZv5U7ic9boU1MEl5/Ejg8YLjJOPTOWF8Nk
 Pfco0ZQOt+a1aVtGLAHiOIiTwta1XGsL3xItWNikV7JUfCb/myNqX6kwz3vUxqK796FFZ18Av
 FtyYFndf8wPHDknyps8doY9xVG6POREpt6Qv6D6fvla+p3+696FQ2HJbhUujQHTWgiF7dT1Av
 DvhSl1m9wCIiP5/evvJ6JxZQT6Ngmsr7wu9e1mG3H48b8HRqM9rU1jztWM9LqwK/+wFH0fvS/
 UW7n89ojKn+AUOnCJaGl423h7KNRMDWAWTI0Bqb6TbL8T7DHz7nYDcjaTzW4+hmna/YIf7xRw
 x/Hlcaqt/xa88uKw+twSveTOz7B5IPuDksCpZWGoOOqMFQoDd6psIJ/d3SnrT3ZZPkOKLHOjJ
 9kNLZ5PLS7Zq55jXJBDqDDg2kXtSiWAwu1V3Bn8bbxIk4GgO5tNGmUkUGDzCBVqw5QMadbYKh
 NyeHWTldXoyrYJ27i2g1UOPSD4AB77oqXSjellaoWvanPP7FWyxRhSkBP+KhWV4j7PliFowyA
 AytQeJnpiLOQRy8ruwze6ICh2r0WTaMpXQE6odDMip3tSFVft2MFraxY6y2AAFLWth1ilxO+C
 cuiHDC9Zr/C/t9PY9Qyr1NsIoiNCNv2inFtfnTM/l4ELcuz4bAUNxtW0vzWqclH8+SgphzfTP
 UImcOT9YOQzSbL91SIxT9hczAco3Xd2BHMnVMHTEURm9e0fM3C4mDXXR8/b91PfgdJWxuMQ3K
 2mABXnKplPqudv3jQad8URYxMkAhRZdvW2Zm1L35b475I0h57TApvlZsU494xpANec+PNK6l7
 hr5k6UWkVpW9Pk2M5nCGiG534QUSNsYM76vPsxCI1iqw56+zBoFf1u4CTBt8UA6iAP+v32tOT
 Nkl8adj0rHOwxnrjn33+xofPOg0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.40.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.40.0-rc1.windows.1

Changes since Git for Windows v2.39.2 (February 14th 2023)

As announced previously, Git for Windows will drop support for Windows
7 and for Windows 8 in one of the next versions, following Cygwin's and
MSYS2's lead (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Also following the footsteps of the MSYS2 and Cygwin projects on which
Git for Windows depends, the 32-bit variant of Git for Windows is
nearing its end of support.

New Features

  * Comes with Git v2.40.0-rc1.
  * In the olden Git days, there were "dashed" Git commands (e.g.
    git-commit instead of git commit). These haven't been supported for
    interactive use in a really, really long time. But they still
    worked in Git aliases and hooks ("scripts"). Since Git v1.5.4
    (released on February 2nd, 2008), it was discouraged/deprecated to
    use dashed Git commands even in scripts. As of this version, Git
    for Windows no longer supports these dashed commands.
  * Comes with tig v2.5.8.
  * Comes with Bash v5.2 patchlevel 15.
  * Comes with OpenSSL v1.1.1t.
  * Comes with GNU TLS v3.8.0.
  * Comes with cURL v7.88.1.
  * Comes with libfido2 v1.13.0.
  * Comes with Git Credential Manager v2.0.935.

Bug Fixes

  * Some commands mishandled absolute paths near the drive root (e.g.
    scalar unregister C:/foo), which has been fixed.
  * When trying to call Cygwin (or for that matter, MSYS2) programs
    from Git Bash, users would frequently be greeted with cryptic error
    messages about a "cygheap" or even just an even more puzzling exit
    code 127. Many of these calls now succeed, allowing basic
    interactions. While it is still not possible for, say, Cygwin's
    vim.exe to interact with the Git Bash's terminal window, it is now
    possible for Cygwin's zstd.exe in conjuction with Git for Windows'
    tar.exe to handle .tar.zst archives.

Git-2.40.0-rc1-64-bit.exe | 69dfa0bfbec9e5836561968421adb60133ce3aaba6acc01ddb45e2e042a59d5f
Git-2.40.0-rc1-32-bit.exe | 6cd10560bdf090d920e4a15c23070b469a5a9e35b277a0a6e6fd69e8e7be9efe
PortableGit-2.40.0-rc1-64-bit.7z.exe | 37233d2e767c43b0d3b65bb3fb2151dd600fdf5d61db83db048bd5f6d1d6aade
PortableGit-2.40.0-rc1-32-bit.7z.exe | fb40cfff8e435843b0fff724c03a89cac973cf5f1844b322a75718ee23d01a65
MinGit-2.40.0-rc1-64-bit.zip | 96977c7cca2278878f155c7f50ba1b3e46102442606beab8a15d5aa813dbe762
MinGit-2.40.0-rc1-32-bit.zip | 3ab0bee7839a1e2228c09b31229ea1da74971e76207973c1ee6151037d723207
MinGit-2.40.0-rc1-busybox-64-bit.zip | 0f2c7622658ceda02012e0c038a762fd46135a60cef4f823b7b0ae2fc66cb58c
MinGit-2.40.0-rc1-busybox-32-bit.zip | f98139fff494e405a125702dd6c4a3127246ecafce4db7dc85325dc0a668d8f8
Git-2.40.0-rc1-64-bit.tar.bz2 | d22ab790bf89228e25fbd661076cd40a1ac59109f9ab7d2eb9d25eaf883a3ab5
Git-2.40.0-rc1-32-bit.tar.bz2 | 6117a414bc1e24f3b0b995c695cbb795eb431ed40648474eef77dc83ba374eeb

Ciao,
Johannes
