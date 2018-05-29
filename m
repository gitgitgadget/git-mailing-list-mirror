Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890FB1F42D
	for <e@80x24.org>; Tue, 29 May 2018 20:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966716AbeE2Ua1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 16:30:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:51211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966480AbeE2UaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 16:30:25 -0400
Received: from MININT-8E55E86.fareast.corp.microsoft.com ([37.201.195.106]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MRXVc-1flz9T29YO-00Sfx2; Tue, 29 May 2018 22:30:23 +0200
Date:   Tue, 29 May 2018 22:30:22 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.17.1(2)
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <0MbOrg-1feKhn2Xv2-00Io4C@mail.gmx.com>
X-Provags-ID: V03:K1:7MAlUwAhN9ac9vQKrUq07EZ13EtQ+u7H6lTdmFTtmsEvDSMJZ7B
 LTQPFBlB97AcTV6mB3/rj3UFJ8RJX2avpm+bOwMh0ay0nLMJng7qUkGNEninrazK3Gwiqam
 TWiwDS9yJY0TDbVi5fJZdEkEeIExtdT5WuICBPlMxuX+ZsCTszehyBkHQQul2YDgl5jnIDl
 pht9UruKhgIvdP1fOQIag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e0nXUF1HkCk=:X95Hxgiw/f6dN9g267Lb8y
 ff+fLRLxjgurVLg6863CytWx3ngy+bJelxmYMZIhFQCQ83eK3FXfWad0nY5DcDg1rtSa455Iu
 AC/SZ5qv2k+/D3991vQRz4TJYV2TaPYLN56mWsYnBrWcnBS/NBVg3p5aYssr306A50TNAVutU
 lQ2Ii0EhRHl+xOxoIW5U6FMk6kDuboq6+ZK91GZ2r/b/hjEz26UG+By3JbbYo9x5gTVV8t99K
 0Ihulvx/cIzsvR3dQl5Qkiniz2ZYdb0GS3x6ofaIznhitgr3gwP+zfjLUOxqu2FzKLnn88Kb4
 GymotGTjISqI6brxdOigFskrixzCrvNRLlnWe3Wv3G2pK5W+GP0pM51UtqfcDFmFOB9AA9Qep
 YoKbWdr6Fi0ezTBgzIK0GUz+67g1K6jImQae4aj9+0OR2sxR2eAl9RAFDXZdVXWaebXuSgKc6
 vPVxrNReKM02SyYeMEViVc6/FDkXnKWbzdDZZ2Lh82/jM5JVhIMLLuO/JtuBrUc/+6bnwet5G
 fO9ZUrjqrJUx702w2MvN611gtQa21kyKLJ+ISMKMxz/Xvai6FN4KRh0DRc5jjolM13rg8N2Db
 hgoxtbXwl0HfR+l0kVGxcfIseqD2JkXvnD8PIumeE/As6bxxL6vZ+APAQZFsNhsatsyHAXTJd
 ikdxFEALnm/qZiN7U/5LjT39RJUVakscWPs0FMAT5Fm/eZbCzI6iai4m7va0CtK98DJNalyaG
 jzIXUiEbjaVcAWClN7W7+kypCNp4PfGScDmimRMCDDcG4IhQEh5B3qr1I2a9yp4w1CgqqO6i6
 1xoAuyc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.17.1(2) is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.17.0 (April 3rd 2018)

New Features

  * Comes with Git v2.17.1.
  * Comes with Perl v5.26.2.
  * The installer now offers VS Code Insiders as option for Git's
    default editor if it is installed.
  * The vim configuration was modernized.
  * Certain errors, e.g. when pushing failed due to a
    non-fast-forwarding change, are now colorful.
  * Comes with cURL v7.60.0.
  * Comes with Git Credential Manager v1.16.1.
  * Comes with Git LFS v2.4.2.

Bug Fixes

  * Fixed an issue with recursive clone (CVE 2018-11235).
  * This release really contains Git v2.17.1 (due to a bug in the release
    automation, Git for Windows v2.17.1 did not actually include Git v2.17.1).
  * Aliases that expand to shell commands can now take arguments
    containing curly brackets.
  * Ctrl+C is now handled in Git Bash in a sophisticated way: it
    emulates the way Ctrl+C is handled in Git CMD, but in a
    fine-grained way.
  * Based on the the new Ctrl+C handling in Git Bash, pressing Ctrl+C
    while git log is running will only stop Git from traversing the
    commit history, but keep the pager running.
  * Git was fixed to work correctly in Docker volumes inside Windows
    containers.
  * Tab completion of git status -- <partial-path> is now a lot faster.
  * Git for Windows now creates directory symlinks correctly when asked
    to.
  * The option to disable revocation checks with Secure Channel which
    was introduced in v2.16.1(2) now really works.
  * Git no longer enters an infinite loop when misspelling git status
    as, say, git Status.'

Filename | SHA-256
-------- | -------
Git-2.17.1.2-64-bit.exe | 64a44bf936dfb1af0ca8b84d5e9accb138452f1fa40030706964c3bbd9e1c69b
Git-2.17.1.2-32-bit.exe | 5dca054b53a2b38fbfc35f7b2390462d81f9ee62fa38b6f47d2d77365ab7f84a
PortableGit-2.17.1.2-64-bit.7z.exe | 5664ee470caf44743be1514c71f77cb8ac360dd69a667e6dd668cc6531acb8ba
PortableGit-2.17.1.2-32-bit.7z.exe | 74ef9dce2a185535dc5cbe7d53076df8558d739f29721be33b894d21b653f194
MinGit-2.17.1.2-64-bit.zip | 52e611a411cd58eaaab8218bb917cb4410b0c5733f234be6e581c6a9821b30ea
MinGit-2.17.1.2-32-bit.zip | 8ab37946bef8955a65f907d82483cb8a457f7404061ca59b8399d3623e9e691b
MinGit-2.17.1.2-busybox-64-bit.zip | f3aa489a67a600aefa8f20ee55f8977319bd3da568afaaadcd1b2e2cf21c575c
MinGit-2.17.1.2-busybox-32-bit.zip | 7c335e5ecd340a2980c9003bf8fefd73eb9553636c41ff1f9eae5dbb29bf6dde
Git-2.17.1.2-64-bit.tar.bz2 | b88192b92653df7bac19c87b18954ee5e1f513176633aca5ba0deaf51ad6e6f8
Git-2.17.1.2-32-bit.tar.bz2 | 4b284737e18d84b8a12b5138068f4fda7f9df93fa18ff5cde02d2b321cd943e5
pdbs-for-git-64-bit-2.17.1.2.a60968cf43-1.zip | b0e9961eab08a57a8a0f08620ea50cd4984c6f6f8bb48d66f3cfb872d9fea078
pdbs-for-git-32-bit-2.17.1.2.a60968cf43-1.zip | d902b96c155b243f4c8fa41056304ab6bc77763a1adef520a41cee97ca5f98c7

Ciao,
Johannes
